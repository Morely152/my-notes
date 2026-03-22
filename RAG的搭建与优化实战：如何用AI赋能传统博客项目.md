---

---
---
> 前言：在搭建自己的AI助手时，我们经常会遇到这样的情景——AI会一本正经地胡说八道，对于超出其训练数据的问题，会编造虚假信息；或者对我们的资料库不够了解，回答“这个网站有哪些内容？”这样具体化的问题时会不知所措。想要让AI基于我们自己的真实内容来回答问题，就需要用到RAG（检索增强生成）技术。本文将记录我搭建AI RAG系统的过程，分享踩过的坑和总结的优化经验，帮助大家在项目中更好地应用RAG技术。
---
# 一、什么是RAG？

在正式开始之前，先来简单介绍一下RAG的概念。

通常我们在网站中引入AI助手，通过后端调用LLM回答用户的问题时，是这样的流程：

```
用户提问 → 后端调用AI API → LLM生成 → 返回结果 → 后端发送响应消息到前端
```

问题是LLM处在系统之外，无法了解网站系统中的具体信息，也就无法回答“网站中有哪些资料？”、“怎么报名参加比赛？”这样具体化、专业化的问题。

**RAG（Retrieval-Augmented Generation，检索增强生成）** 是一种让AI能够基于外部知识库回答问题的技术方案。它的核心思想是：当用户提问时，先从**向量数据库**中检索相关的内容，然后将这些内容作为上下文附加到提示词中，最后让LLM基于检索到的内容生成回答。

```
用户提问 → 后端调用AI API → 向量检索 → 上下文增强 → LLM生成 → 返回结果 → 后端发送响应消息到前端
```

![](20260317121703339.png)

这样做的好处显而易见：

- **真实可靠**：基于真实内容回答，减少AI"胡说八道"
- **时效性强**：可以及时更新知识库，无需重新训练模型
- **可控性好**：可以控制AI的回答范围和风格

需要注意的是，虽然使用"用户提问 -> 网站后端在关系型数据库中搜索相关文章 -> 将文章和用户问题发送给LLM -> 获取LLM回答信息发送回用户"这样的流程也可以算作RAG，但是目前在RAG领域大展拳脚的，是关系型数据库的邻居**向量数据库**。关系型数据库擅长管理结构化数据，解决“是什么”的问题；而向量数据库专为处理非结构化数据设计，解决“像什么”的问题。下表是两种数据库的对照：

| 维度   | 关系型数据库                                      | 向量数据库                                            |
| ---- | ------------------------------------------- | ------------------------------------------------ |
| 数据模型 | 表格形式，有严格的预定义模式（行与列）。                        | 向量形式，即通过AI模型从文本、图片中提取的数学“指纹”（高维数组）。              |
| 查询逻辑 | 精确匹配。通过SQL查找“价格 > 100”的记录，结果唯一且确定。          | 相似性搜索。基于余弦相似度等算法，找出语义上最相近的Top-K个结果，结果按相似度排序。     |
| 索引技术 | B树、哈希索引，专为精确查询和范围查询优化。                      | 近似最近邻（ANN） 索引（如HNSW、IVF），通过牺牲微小精度，实现从海量数据中毫秒级响应。 |
| 核心优势 | 数据完整性，严格遵循ACID（原子性、一致性、隔离性、持久性）事务特性，确保数据可靠。 | 海量数据下的高性能，专为非结构化数据的语义检索设计，吞吐量高、可水平扩展。            |
# 二、技术选型与架构设计

## 1. 技术栈选择

最近打算给我的个人博客网站"码驿随想"加入AI助手，也来尝试做一下大名鼎鼎的RAG。我选择了这样的技术方案：

| 组件    | 技术选型                  | 理由                 |
| ----- | --------------------- | ------------------ |
| 前端    | Vue 3 + Element Plus  | 项目现有技术栈            |
| 后端    | Django REST Framework | 项目现有技术栈            |
| 关系数据库 | MySQL                 | 项目现有技术栈            |
| LLM   | DeepSeek API          | 量大管饱，性价比高          |
| RAG编排 | LangChain             | 技术成熟，组件生态丰富        |
| 嵌入模型  | text2vec-base-chinese | 中文优化、本地部署无额外成本     |
| 向量数据库 | ChromaDB              | 轻量级、易部署、Python生态友好 |

核心的工作流程如下：

1. **文章数据向量化**：使用LangChain + text2vec-base-chinese模型(通过HuggingFace引入)，将MySQL中的关系型文章数据转化为向量数据存储到ChromaDB中；
2. **AI RAG**：用户提问时，在ChromaDB中匹配相关度高的一些数据，和用户的提问一起发送给AI，等待LLM回复后发送给用户。

## 2. 核心架构设计

RAG服务的核心是**AIRagService类**，它负责协调向量检索和LLM生成：

```python
class AIRagService:
    def __init__(self):
        # 复用现有向量服务
        self.vector_service = ArticleVectorService()

    def retrieve_relevant_context(self, query, top_k=3):
        """检索相关上下文信息"""
        results = self.vector_service.search_similar_articles(
            query=query, top_k=top_k
        )
        # 格式化检索结果
        return relevant_docs, formatted_context
```

关键设计原则：
1. **正确的工作流程**：检索 → 增强 → 生成 → 返回
2. **性能优化**：避免重复加载模型，控制响应时间
3. **智能路由**：根据问题类型选择不同处理策略

# 三、RAG工作流程实现

## 1. 基础RAG流程

![](20260317121834072.png)

最基础的RAG实现包含以下步骤：

```python
# 步骤1: 检索相关内容
retrieved_docs, rag_context = rag_service.retrieve_relevant_context(
    query=latest_user_message, top_k=3
)

# 步骤2: 构建增强提示词
final_system_prompt = f"""你是AI助手，已检索到相关博客文章：

{simplified_context}

【关键规则】：
1. 基于检索内容回答用户问题
2. 如果检索内容不足，诚实告知用户
"""

# 步骤3: 调用LLM生成回答
api_messages = convert_messages_to_api_format(messages, final_system_prompt)
response = requests.post(api_url, json={'messages': api_messages})
```

## 2. 意图路由系统

这个基础的RAG有一个问题：无论什么问题都会进行向量检索，即使只是一个简单的"你好"也要去数据库里面查个半天，既浪费时间又消耗token。为此，需要使用**意图路由系统**，先让LLM评估是否需要进行RAG检索，然后再决定是直接回答还是RAG之后再回答。同时，通过预设一些问题和相关资料，可以显著提高AI回复内容的准确度和相关度（有点像Agent Skill中的渐进式披露原则，通过按需加载资料来提升效率和节省Token）：

```python
# 预设问题库
PRESET_ANSWERS = {
    "网站介绍": "码驿随想是一个专注于编程、计算机技术和...",
    "联系方式": "邮箱：******@***.com...",
    # ...
}

def _ai_intent_routing(self, query):
    """使用AI判断是否需要RAG检索"""
    # 调用LLM判断问题类型
    # 预设问题 → 直接回答
    # 技术问题 → 使用RAG
    # 通用闲聊 → 直接回答
```

这样，简单问候和常见问题可以快速响应，只有真正需要检索的问题才会触发RAG流程。

![](20260317122208852.png)

> 涉及到关键信息的传输时，最好还是使用JSON等比较规范的格式。一开始使用Vibe Coding时，AI写的逻辑是查看LLM的响应，包含“需要”就进行RAG检索，包含“不需要”就跳过；结果“不需要”也包含了“需要”，导致LLM提出了不需要RAG检索，后端程序仍然执行了检索的逻辑，这个BUG就有点啼笑皆非了……

## 3. 相似度阈值过滤

向量检索返回的结果中，有些可能相关性很低。如果强行使用这些低质量内容，反而会影响AI的回答质量。例如我问它“什么是码驿随想（我的博客网站名称）？”，由于知识库中没有强相关的内容，在RAG检索时或许是匹配到了“驿站 - 堆栈 - 数据结构”的相似度，返回了多条数据结构方向的文章，这与问题无关。

解决方案是加入**相似度阈值过滤**：

```python
RAG_SIMILARITY_THRESHOLD = 0.65  # 相似度阈值

def retrieve_relevant_context(self, query, top_k=3, similarity_threshold=0.65):
    results = self.vector_service.search_similar_articles(query, top_k)

    relevant_docs = []
    for doc, score in results:
        relevance = float(score)
        # 只保留相似度高于阈值的文档
        if relevance < similarity_threshold:
            continue
        relevant_docs.append(doc_info)

    return relevant_docs, formatted_context
```

# 四、性能优化实战

在初步实现后，遇到了一个严重的性能问题：每次请求需要9-19秒，前端经常在后端响应返回之前就超时断开了：

```text
为用户 *** 启用RAG检索增强，查询: 这个网站中有哪些文章？
执行语义搜索: query='这个网站中有哪些文章？', top_k=3
语义搜索完成，返回 3 个结果
检索到3个相关文档，查询: 这个网站中有哪些文章？
RAG检索成功，找到3个相关文档
用户 *** AI聊天成功，RAG模式: True
[15/Mar/2026 21:31:13,549] - Broken pipe from ('127.0.0.1', 53061)
```

## 1. 问题分析

性能瓶颈主要来自三个方面：
1. **向量模型重复加载**：每次请求都重新加载HuggingFace模型（5-10秒）
2. **前端超时设置**：默认10秒超时太短
3. **多次API调用**：意图判断和回答生成分别调用LLM

## 2. 优化方案

### 向量服务缓存

```python
# 优化前：每次重新加载
self.embeddings = HuggingFaceEmbeddings(...)

# 优化后：使用缓存
if not hasattr(self, 'embeddings') or self.embeddings is None:
    self.embeddings = HuggingFaceEmbeddings(...)
else:
    logger.info("使用缓存的嵌入模型")
```

### LLM统一意图识别

将两次API调用优化为一次：让LLM在判断意图的同时，如果是预设问题就直接生成回答。

![](20260317123125804.png)

```python
def analyze_with_llm(self, query):
    """一次调用完成意图识别和回答生成"""
    response = requests.post(
        self.api_url,
        json={
            'model': 'deepseek-chat',
            'messages': [
                {'role': 'system', 'content': system_prompt},
                {'role': 'user', 'content': query}
            ],
            'response_format': {'type': 'json_object'}
        }
    )
    # 返回意图类型 + 直接回答（如有）
    return intent_data
```

### 前端超时延长配置

```javascript
// 创建AI专用API实例，60秒超时
const aiApi = axios.create({
  baseURL: API_BASE_URL,
  timeout: 60000,  // 从10秒延长到60秒
  headers: {'Content-Type': 'application/json'}
});
```

# 五、架构安全问题

在实现功能的同时，安全问题同样重要。起初由前端直接调用AI API，很容易导致API key泄露，且调用权限和频率不可控，安全风险极高。

## 解决方案：后端托管

将所有AI请求完全托管到后端：

```
优化前：前端 → 直接调用DeepSeek API
优化后：前端 → 后端API → DeepSeek API
```

## 后端安全实现

```python
@api_view(['POST'])
@permission_classes([IsAuthenticated])  # JWT认证
def ai_chat(request):
    """AI聊天接口 - 需要登录认证"""
    # 频率限制
    throttle = AiChatRateThrottle()
    if not throttle.allow_request(request):
        return Response({'error': '请求过于频繁'}, status=429)

    # 使用后端配置的密钥调用API
    response = requests.post(
        Config.DEEPSEEK_API_URL,
        headers={'Authorization': f'Bearer {Config.DEEPSEEK_API_KEY}'},
        json={'messages': api_messages}
    )
```

## 前端简化

```javascript
// 前端只负责发送请求
export async function sendChatMessage(messages) {
  const response = await api.post('/ai/chat/', {messages});
  return response.data.reply;
}
```

## 3. 多层安全防护

- **JWT认证**：未登录用户返回401错误
- **频率限制**：每用户每分钟最多10次请求
- **API密钥保护**：写在在后端的配置文件中保护，前端不可见
- **系统提示词管理**：统一在后端构建规则，防止前端篡改JS

# 六、功能增强

在解决了性能和安全问题后，还实现了一些增强功能。

## 1. 前端Markdown渲染

使用`marked`库解析AI返回的Markdown内容：

```javascript
import { marked } from 'marked'

marked.setOptions({
  breaks: true,        // 支持换行
  gfm: true,          // GitHub风格
})

// 在Vue模板中渲染
<div v-html="parseMarkdown(message.text)"></div>
```

## 2. 相关文章展示

RAG响应中包含检索到的文章信息，在对话气泡下方显示跳转按钮：

```vue
<div class="related-articles">
  <span class="rag-badge">RAG参考文章</span>
  <a v-for="doc in message.retrievedDocs"
     :href="`/article/${doc.article_id}`">
    {{ doc.title }}
  </a>
</div>
```

# 七、总结与思考

经过这番从零搭建和优化，RAG系统已经可以稳定运行。回顾整个过程，有一些值得分享的经验：

## 1. 核心成果

![](20260317124112703.png)

- **本系统适用的的RAG工作流程**：

```text
用户提问 → LLM决策 → 是专业问题，需要RAG → 后端做向量检索，进行上下文增强 → LLM生成 → 返回结果
              ├----> 是预设问题 -> 直接回答
              └----> 是简单问题 -> 直接回答  
```

- **性能优化体系**：缓存、超时、专用API的多维度优化

- **安全架构**：JWT认证 + 频率限制 + API密钥保护
## 2. 一些思考

- **性能优化很关键**。向量检索 + LLM调用链路较长，每个环节的延迟都会累积。缓存、异步处理、合理的超时设置都是必要的。
- **安全不能忽视**。API密钥、用户认证、频率控制，这些在生产环境中都是必须考虑的问题。

RAG技术让AI从"聊天机器人"变成了真正的"知识助手"。它不是要替代AI的创造力，而是让AI在需要的时候能够"查资料"——这恰恰是人类智能的体现。**AI的灵活决策与程序的固定规则相辅相成，刚柔并济，在实现从传统博客的静态内容展示到动态可交互的创新转型方向大有可为。**

---
# 参考资料

[^1]: ChromaDB官方文档 - https://docs.trychroma.com/
[^2]: LangChain RAG教程 - https://python.langchain.com/docs/tutorials/rag/
[^3]: DeepSeek API文档 - https://platform.deepseek.com/api-docs/

