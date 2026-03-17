---

---
---
> 前言：在使用AI助手时，我们经常会遇到这样的情景——AI会一本正经地胡说八道，对于超出其训练数据的问题开始编造虚假信息；或者回答的问题与我们的实际需求南辕北辙，仿佛它活在自己的世界里。想要让AI"跟上时代"、基于我们自己的真实内容来回答问题，就需要用到RAG（检索增强生成）技术。本文将记录我从零搭建AI RAG系统的完整过程，分享踩过的坑和总结的优化经验，帮助大家在项目中更好地应用RAG技术。
---

# 一、什么是RAG？

在正式开始之前，先来简单介绍一下RAG的概念。

RAG（Retrieval-Augmented Generation，检索增强生成）是一种让AI能够基于外部知识库回答问题的技术方案。它的核心思想是：当用户提问时，先从向量数据库中检索相关的内容，然后将这些内容作为上下文附加到提示词中，最后让LLM基于检索到的内容生成回答。

```
用户提问 → 向量检索 → 上下文增强 → LLM生成 → 返回结果
```

这样做的好处显而易见：
- **真实可靠**：基于真实内容回答，减少AI"胡说八道"
- **时效性强**：可以及时更新知识库，无需重新训练模型
- **可控性好**：可以控制AI的回答范围和风格

# 二、技术选型与架构设计

## 1. 技术栈选择

对于个人博客网站"码驿随想"的AI助手改造，我选择了这样的技术方案：

| 组件 | 技术选型 | 理由 |
|------|----------|------|
| 向量数据库 | ChromaDB | 轻量级、易部署、Python生态友好 |
| 嵌入模型 | text2vec-base-chinese | 中文优化、本地部署无额外成本 |
| AI模型 | DeepSeek API | 性价比高、中文友好 |
| 后端框架 | Django REST Framework | 项目现有技术栈 |
| 前端 | Vue 3 + Element Plus | 项目现有技术栈 |

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

基础RAG有一个问题：无论什么问题都会进行向量检索，即使只是一个简单的"你好"。为此，我设计了一套**意图路由系统**：

```python
# 预设问题库
PRESET_ANSWERS = {
    "网站介绍": "码驿随想是一个专注于编程、计算机技术和...",
    "联系方式": "邮箱：h2892197119@foxmail.com...",
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

## 3. 相似度阈值过滤

向量检索返回的结果中，有些可能相关性很低。如果强行使用这些低质量内容，反而会影响AI的回答质量。

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

在初步实现后，遇到了一个严重的性能问题：每次请求需要9-19秒，前端经常超时断开。

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

### 前端超时配置

```javascript
// 创建AI专用API实例，60秒超时
const aiApi = axios.create({
  baseURL: API_BASE_URL,
  timeout: 60000,  // 从10秒延长到60秒
  headers: {'Content-Type': 'application/json'}
});
```

## 3. 优化成果

| 指标 | 优化前 | 优化后 | 提升 |
|------|--------|--------|------|
| 首次请求 | 9-19秒 | 5-10秒 | **47%** |
| 后续请求 | 9-19秒 | 3-7秒 | **63%** |
| API调用次数 | 2次 | 1次（预设问题） | **50%** |

# 五、安全架构重构

在实现功能的同时，安全问题同样重要。

## 1. 问题：API密钥暴露

最初的实现将DeepSeek的API密钥配置在前端，这带来了严重的安全隐患——任何人都可以通过浏览器开发者工具获取密钥。

## 2. 解决方案：后端托管

将所有AI请求完全托管到后端：

```
优化前：前端 → 直接调用DeepSeek API
优化后：前端 → 后端API → DeepSeek API
```

### 后端安全实现

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

### 前端简化

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
- **API密钥保护**：敏感信息完全不暴露给前端
- **系统提示词管理**：统一在后端构建规则

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
  <span class="rag-badge">RAG</span>
  <a v-for="doc in message.retrievedDocs"
     :href="`/article/${doc.article_id}`">
    {{ doc.title }}
  </a>
</div>
```

# 七、总结与思考

经过这番从零搭建和优化，RAG系统已经可以稳定运行。回顾整个过程，有一些值得分享的经验：

## 1. 核心成果

✅ **正确的RAG工作流程**：用户提问 → 向量检索 → 上下文增强 → LLM生成 → 返回结果

✅ **智能问题处理**：
- 简单问候 → 直接回答
- 预设问题 → 直接回答
- 技术问题 → RAG检索 + 增强回答

✅ **性能优化体系**：缓存、超时、专用API的多维度优化

✅ **安全架构**：JWT认证 + 频率限制 + API密钥保护

## 2. RAG适用的场景

| 场景 | 适合RAG | 原因 |
|------|---------|------|
| 企业知识库 | ✅ | 基于真实文档回答，减少幻觉 |
| 产品客服 | ✅ | 可以控制回答范围和风格 |
| 个人博客助手 | ✅ | 基于作者真实内容互动 |
| 创意写作 | ❌ | 需要AI的创造力，而非检索 |
| 通用聊天 | ❌ | 检索反而会限制回答 |

## 3. 一些思考

**RAG不是万能的**。它适合那些需要基于真实、特定内容回答问题的场景。如果你的需求是让AI进行创造性工作、或者需要处理超出知识库范围的问题，RAG反而会成为限制。

**性能优化很关键**。向量检索 + LLM调用链路较长，每个环节的延迟都会累积。缓存、异步处理、合理的超时设置都是必要的。

**安全不能忽视**。API密钥、用户认证、频率控制，这些在生产环境中都是必须考虑的问题。

RAG技术让AI从"聊天机器人"变成了真正的"知识助手"。它不是要替代AI的创造力，而是让AI在需要的时候能够"查资料"——这恰恰是人类智能的体现。

---
# 参考资料

[^1]: ChromaDB官方文档 - https://docs.trychroma.com/
[^2]: LangChain RAG教程 - https://python.langchain.com/docs/tutorials/rag/
[^3]: DeepSeek API文档 - https://platform.deepseek.com/api-docs/
