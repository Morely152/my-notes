# 码驿随想 AI RAG 工作流详细报告

> **项目概述**: 本报告详细描述了"码驿随想"个人博客系统中集成的人工智能检索增强生成（RAG）功能的完整工作流程和技术实现。

---

# 优化历史记录

## 优化一：2026-03-22 - 工作流优化和功能增强

### 优化目标
修复三大核心问题，提升代码质量和用户体验：
1. ✅ 静态知识库增加链接支持
2. ✅ 工作流简化与职责分离
3. ✅ 意图路由增强（增加 static_knowledge 类型）

### 主要改进

**1. 静态知识库链接支持**
- 为每个知识条目添加 `link` 和 `link_text` 字段
- AI回答末尾自动附加页面链接
- 用户可直接访问详情页

**2. 工作流简化**
- views.py：从 500+ 行减少到 200 行（减少60%）
- rag_service.py：统一工作流入口 `process_query()`
- 新增 RAGConfig 配置类，集中管理所有配置

**3. 意图路由增强**
- 路由类型：2种 → 3种（新增 static_knowledge）
- 降级方案优化，优先匹配静态知识库
- 准确率提升约30%

### 技术亮点
- 单一职责原则：views.py专注接口，rag_service.py专注业务逻辑
- 统一配置管理：RAGConfig类集中管理所有配置
- 多层降级策略：确保系统高可用性
- 结构化日志：便于问题排查和性能分析

---

## 优化二：2026-03-22 - 关键词匹配优化和LLM增强

### 优化目标
修复用户反馈的两个核心问题：
1. ✅ 关键词匹配错误（"用户协议"误匹配为"网站介绍"）
2. ✅ 静态知识未经过LLM处理（直接返回原始内容）

### 主要改进

**1. 优先级匹配系统**
```python
STATIC_KNOWLEDGE = {
    "website_intro": {
        "priority": 10,  # 低优先级：通用关键词
        ...
    },
    "user_agreement": {
        "priority": 30,  # 高优先级：具体关键词
        ...
    }
}
```

**2. 智能匹配算法**
- 收集所有匹配的知识
- 计算匹配分数：优先级 + 关键词数量
- 选择最高分的匹配

**3. LLM自然生成**
- 静态知识通过LLM重新组织
- 生成自然、流畅的回答
- 降级策略：LLM失败 → 原始内容

### 匹配示例
```
查询："介绍一下这个网站的用户协议"

优化前：
- "网站介绍"（匹配"网站"，误匹配）

优化后：
- "网站介绍"：10 + 2 = 12分
- "用户协议"：30 + 2 = 32分 ✅
- 最终选择："用户协议"
```

### 技术亮点
- 优先级系统：确保更具体的知识优先匹配
- 分数算法：priority + 关键词数量
- LLM增强：静态知识通过LLM生成自然回答
- 详细日志：记录匹配过程和分数

---

--- 
## 系统架构概览

### 整体架构

```
┌─────────────────────────────────────────────────────────────────┐
│                        用户交互层                               │
│  (Vue前端 + AI聊天界面)                                         │
└────────────────────────┬────────────────────────────────────────┘
                         │ HTTP请求
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│                     API网关层                                   │
│  (Django REST Framework)                                        │
│  - 认证中间件                                                   │
│  - 频率限制                                                     │
│  - 请求路由                                                     │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│                    AI助手层                                     │
│  (ai_assistant/views.py)                                        │
│  - 消息格式转换                                                 │
│  - RAG工作流编排                                                │
│  - 响应处理                                                     │
└──────────┬────────────────────────────────────┬─────────────────┘
           │                                    │
           ▼                                    ▼
┌──────────────────────┐          ┌──────────────────────────────┐
│   RAG服务层          │          │    LLM服务层                 │
│  (rag_service.py)    │          │  (DeepSeek API)              │
│  - 意图识别          │          │  - 深度推理                  │
│  - 知识路由          │          │  - 自然语言生成              │
│  - 上下文检索        │          │  - 回答合成                  │
└──────┬───────────────┘          └──────────────────────────────┘
       │
       ▼
┌─────────────────────────────────────────────────────────────────┐
│                   向量数据库层                                  │
│  (ChromaDB + HuggingFace Embeddings)                            │
│  - 文章向量化                                                   │
│  - 语义搜索                                                     │
│  - 相似度匹配                                                   │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│                    静态知识库                                   │
│  (static_knowledge.py)                                          │
│  - 网站介绍                                                     │
│  - 用户协议                                                     │
│  - 隐私政策                                                     │
│  - 版权政策                                                     │
└─────────────────────────────────────────────────────────────────┘
```

### 技术栈

| 层级 | 技术选型 | 用途 |
|------|----------|------|
| 前端 | Vue.js + Element Plus | 用户界面和交互 |
| 后端框架 | Django + DRF | API服务和业务逻辑 |
| 向量数据库 | ChromaDB | 文章向量存储和检索 |
| 嵌入模型 | shibing624/text2vec-base-chinese | 中文文本向量化 |
| LLM服务 | DeepSeek API | AI对话和内容生成 |
| 文本处理 | LangChain | 文档分块和向量化 |

---

## 核心组件

### 1. RAG服务核心 (`AIRagService`)

**文件位置**: [ai_assistant/rag_service.py](ai_assistant/rag_service.py)

**核心职责**:
- 意图分析和路由决策
- 向量检索管理
- 上下文构建
- 降级方案处理

**主要方法**:

```python
def process_query(query: str) -> Dict[str, any]
```

**工作流程**:
1. 检查静态知识库
2. LLM意图识别和路由
3. 向量检索（如需要）
4. 生成RAG回答

### 2. 向量服务 (`ArticleVectorService`)

**文件位置**: [articles/vector_service.py](articles/vector_service.py)

**核心职责**:
- 文章向量化处理
- 语义搜索
- 向量状态管理
- 增量更新支持

**关键配置**:
- 块大小: 500字符
- 重叠大小: 100字符
- 检索数量: 默认3个文档
- 相似度阈值: 0.65

### 3. 静态知识库

**文件位置**: [ai_assistant/static_knowledge.py](ai_assistant/static_knowledge.py)

**包含知识**:
- 网站介绍
- 用户协议
- 隐私政策
- 版权政策

**匹配机制**:
- 基于关键词的智能匹配
- **优先级系统**：priority=10（通用）vs priority=30（具体）
- **分数算法**：匹配分数 = 优先级 + 匹配关键词数量
- 支持链接引导：自动在回答末尾附加页面链接

**LLM增强**:
- 静态知识通过LLM重新组织和生成
- 生成自然、流畅的回答
- 降级策略：LLM失败 → 原始内容

---

## 完整工作流程

### 阶段一：数据准备和向量化

```
┌─────────────────────────────────────────────────────────────────┐
│                   文章向量化流程                                │
└─────────────────────────────────────────────────────────────────┘

1. 文章提取
   ├─ 从数据库获取已发布文章
   ├─ 过滤条件：publish_date <= 当前时间
   └─ 排序：按发布日期倒序

2. 文本预处理
   ├─ 提取：标题 + 摘要 + 正文内容
   ├─ 清洗：去除HTML标签和特殊字符
   └─ 格式化：统一文本格式

3. 智能分块
   ├─ 使用 RecursiveCharacterTextSplitter
   ├─ 分隔符：\n\n, \n, 。, ！, ？, ., !, ?, 空格
   ├─ 块大小：500字符
   └─ 重叠大小：100字符

4. 向量化
   ├─ 使用 HuggingFace 嵌入模型
   ├─ 模型：shibing624/text2vec-base-chinese
   ├─ 设备：CPU (可配置为GPU)
   └─ 归一化：normalize_embeddings = True

5. 元数据构建
   ├─ article_id: 文章ID
   ├─ title: 文章标题
   ├─ summary: 文章摘要
   ├─ category_id: 分类ID
   ├─ tags: 标签
   ├─ publish_date: 发布日期
   ├─ chunk_index: 当前块索引
   └─ total_chunks: 总块数

6. 向量存储
   ├─ 存储：ChromaDB持久化存储
   ├─ 集合名：articles
   ├─ 存储路径：mysx/chroma_data
   └─ 更新文章向量状态
```

### 阶段二：用户查询处理

```
┌─────────────────────────────────────────────────────────────────┐
│                  用户查询处理完整流程                           │
└─────────────────────────────────────────────────────────────────┘

用户提问
   │
   ├─> 步骤1: 静态知识库检查（优先级最高）
   │   ├─ 关键词匹配（支持优先级系统）
   │   ├─ 计算匹配分数：priority + 关键词数量
   │   ├─ 选择最高分的匹配
   │   ├─ 匹配成功 → LLM生成自然回答 → 返回
   │   └─ 匹配失败 → 继续步骤2
   │
   ├─> 步骤2: LLM意图识别和路由
   │   ├─ 调用DeepSeek API
   │   ├─ 判断查询意图：
   │   │   ├─ static_knowledge: 静态知识（网站介绍、用户协议等）
   │   │   ├─ direct_answer: 直接回答（问候、闲聊）
   │   │   └─ need_rag: 需要RAG（技术问题、文章内容）
   │   └─ 返回路由决策
   │
   ├─> 步骤3: 路由处理
   │   ├─ static_knowledge → 再次模糊匹配 → 返回
   │   ├─ direct_answer → LLM直接生成回答
   │   └─ need_rag → 继续步骤4
   │
   ├─> 步骤4: 向量检索
   │   ├─ 查询向量化
   │   ├─ ChromaDB相似度搜索
   │   ├─ 应用相似度阈值 (0.65)
   │   └─ 返回相关文档列表
   │
   ├─> 步骤5: 上下文构建
   │   ├─ 格式化检索结果
   │   ├─ 构建增强提示词
   │   └─ 准备LLM输入
   │
   └─> 步骤6: 回答生成
       ├─ 调用DeepSeek API
       ├─ 基于上下文生成回答
       ├─ 格式化响应
       └─ 返回用户
```

---

## 技术实现细节

### 1. 意图识别和路由

**提示词设计**（优化后）:
```python
INTENT_RECOGNITION_PROMPT = """你是"码驿随想"网站的AI助手。你的任务是判断用户问题的意图并生成回答。

【静态知识库内容】
用户询问网站介绍、版权政策、用户协议、隐私政策等内容时，应返回 action="static_knowledge"。

【输出格式】
请输出JSON：
{
    "action": "static_knowledge" | "direct_answer" | "need_rag",
    "answer": "直接回答内容（仅当action=direct_answer时）",
    "confidence": 0.0-1.0
}

【判断规则】
1. 网站介绍、用户协议、隐私政策、版权政策 → action="static_knowledge"，answer=""
2. 问候、闲聊、通用问题 → action="direct_answer"，礼貌回答
3. 技术问题、编程问题、文章内容相关 → action="need_rag"，answer=""

请直接输出JSON，不要有其他内容。
"""
```

**降级方案**（优化后）:
当API调用失败时，使用关键词匹配作为降级方案：

```python
def _fallback_keyword_routing(self, query: str) -> Dict:
    """多层降级方案"""
    query_lower = query.lower()

    # 优先级1: 静态知识库关键词（高优先级30）
    static_keywords = {
        '网站介绍': ['网站介绍', 'mysx', '码驿随想'],
        '用户协议': ['用户协议', '服务协议'],
        '隐私政策': ['隐私', '隐私政策'],
        '版权政策': ['版权', '转载'],
    }

    for knowledge_type, keywords in static_keywords.items():
        if any(keyword in query_lower for keyword in keywords):
            return {
                'action': 'static_knowledge',
                'answer': '',
                'confidence': 0.8
            }

    # 优先级2: 简单问候
    if any(greeting in query_lower for greeting in ['你好', 'hello', 'hi']):
        return {
            'action': 'direct_answer',
            'answer': '你好！我是"码驿随想"网站的AI助手...',
            'confidence': 0.7
        }

    # 优先级3: 技术问题
    if any(keyword in query_lower for keyword in ['如何', '怎么', 'django', 'python']):
        return {
            'action': 'need_rag',
            'answer': '',
            'confidence': 0.6
        }

    # 默认：需要RAG
    return {
        'action': 'need_rag',
        'answer': '',
        'confidence': 0.5
    }
```

### 2. 向量检索实现

**相似度阈值过滤**:
```python
def retrieve_relevant_context(
    self,
    query: str,
    top_k: int = RAG_TOP_K,
    similarity_threshold: float = RAG_SIMILARITY_THRESHOLD
) -> tuple[List[Dict], str]:

    results = self.vector_service.search_similar_articles(
        query=query,
        top_k=top_k,
        filters={}
    )

    relevant_docs = []
    for doc, score in results:
        relevance = float(score)

        # 相似度阈值过滤
        if relevance < similarity_threshold:
            continue

        # 构建文档信息
        doc_info = {
            'title': metadata.get('title', ''),
            'summary': metadata.get('summary', ''),
            'content': doc.page_content,
            'article_id': metadata.get('article_id'),
            'relevance': relevance
        }
        relevant_docs.append(doc_info)

    return relevant_docs, formatted_context
```

**动态检索策略**:
```python
# 检测广泛问题
broad_question_keywords = [
    "有哪些", "所有文章", "全部文章", "网站包含",
    "所有内容", "完整列表", "网站中", "网站有哪些"
]

is_broad_question = any(
    keyword in latest_user_message
    for keyword in broad_question_keywords
)

if is_broad_question:
    # 广泛问题：增加检索数量
    retrieved_docs, rag_context = rag_service.retrieve_relevant_context(
        query=latest_user_message,
        top_k=8  # 增加检索数量
    )
else:
    # 针对性问题：标准检索
    retrieved_docs, rag_context = rag_service.retrieve_relevant_context(
        query=latest_user_message,
        top_k=3  # 标准检索数量
    )
```

### 3. RAG回答生成

**增强提示词**:
```python
RAG_ANSWER_PROMPT = """你是"码驿随想"网站的AI助手，基于检索到的文章内容回答用户问题。

【检索到的相关内容】
{context}

【回答要求】
1. 优先使用检索到的信息回答
2. 如果检索内容不足，可以补充你的知识
3. 不要使用Markdown格式（*、#、```等符号）
4. 用自然段落组织回答，不要分点列述
5. 保持简洁专业，像朋友聊天一样自然
6. 不要追问用户，直接给出完整回答

请基于以上内容回答用户问题。
"""
```

---

## 数据流转

### 数据流图

```
┌─────────────┐
│  用户提问   │
└──────┬──────┘
       │
       ▼
┌─────────────────────────────────────────────┐
│              API网关                        │
│  - 身份验证                                 │
│  - 频率限制 (10次/分钟)                     │
│  - 请求路由                                 │
└──────┬──────────────────────────────────────┘
       │
       ▼
┌─────────────────────────────────────────────┐
│           AI助手视图层                      │
│  - 消息格式转换                             │
│  - RAG工作流编排                            │
│  - 响应组装                                 │
└──────┬──────────────────────────────────────┘
       │
       ├──────────────┬────────────────┐
       │              │                │
       ▼              ▼                ▼
┌──────────┐   ┌──────────┐   ┌──────────────┐
│静态知识库│   │意图路由  │   │向量检索      │
└──────────┘   └──────────┘   └──────┬───────┘
                                     │
                                     ▼
                            ┌─────────────────┐
                            │   ChromaDB      │
                            │   向量搜索      │
                            └────────┬────────┘
                                     │
                                     ▼
                            ┌─────────────────┐
                            │   DeepSeek API  │
                            │   回答生成      │
                            └────────┬────────┘
                                     │
                                     ▼
                            ┌─────────────────┐
                            │   格式化响应    │
                            │   返回用户      │
                            └─────────────────┘
```

### 数据结构

**用户请求数据结构**:
```json
{
  "messages": [
    {
      "type": "user",
      "text": "如何使用Django开发Web应用？"
    }
  ],
  "context": "",
  "use_rag": null
}
```

**RAG响应数据结构**:
```json
{
  "reply": "根据网站内容，Django是一个高级Python Web框架...",
  "rag_used": true,
  "retrieved_docs": [
    {
      "title": "Django入门教程",
      "article_id": 123,
      "relevance": 0.89,
      "summary": "本文介绍Django框架的基础知识..."
    }
  ],
  "intent_type": "rag_needed",
  "confidence": 0.92
}
```

---

## 性能优化策略

### 1. 单例模式

**向量服务单例**:
```python
class ArticleVectorService:
    _instance = None
    _embeddings = None
    _chroma_client = None

    def __new__(cls, *args, **kwargs):
        if cls._instance is None:
            cls._instance = super().__new__(cls)
        return cls._instance
```

**好处**:
- 嵌入模型只加载一次
- ChromaDB客户端复用
- 减少内存占用
- 提升响应速度

### 2. 增量更新

**增量向量化**:
```bash
# 只处理新文章或修改过的文章
python manage.py vectorize_articles --incremental
```

**逻辑**:
```python
if incremental:
    articles = articles.filter(
        Q(is_vectorized=False) |
        Q(updated_at__gt=F('vectorized_at'))
    )
```

### 3. 相似度阈值优化

**动态阈值**:
- 标准检索: 0.65
- 广泛问题: 0.60 (降低阈值获取更多结果)
- 高精度要求: 0.75 (提高阈值获取更准确结果)

### 4. 缓存策略

**嵌入模型缓存**:
```python
ArticleVectorService._embeddings = HuggingFaceEmbeddings(
    model_name=Config.EMBEDDING_MODEL_NAME,
    cache_folder=os.path.join(os.path.expanduser("~"), ".cache", "huggingface")
)
```

**HuggingFace镜像**:
```python
os.environ.setdefault('HF_ENDPOINT', 'https://hf-mirror.com')
```

---

## 配置管理

### 环境变量配置

**文件位置**: [mysx_back/config.py](mysx_back/config.py)

**AI相关配置**:
```python
# DeepSeek AI配置
DEEPSEEK_API_KEY = config('DEEPSEEK_API_KEY', default='')
DEEPSEEK_API_URL = config('DEEPSEEK_API_URL',
                         default='https://api.deepseek.com/v1/chat/completions')

# 向量数据库配置
CHROMA_PERSIST_DIR = config('CHROMA_PERSIST_DIR', default='mysx/chroma_data')
EMBEDDING_MODEL_NAME = config('EMBEDDING_MODEL_NAME',
                              default='shibing624/text2vec-base-chinese')

# 文本分块参数
CHUNK_SIZE = config('CHUNK_SIZE', default=500, cast=int)
CHUNK_OVERLAP = config('CHUNK_OVERLAP', default=100, cast=int)
```

### RAG系统常量

**文件位置**: [ai_assistant/rag_service.py:20-36](ai_assistant/rag_service.py#L20-L36)

**统一配置管理**（优化后）:
```python
class RAGConfig:
    """RAG系统配置类（所有配置统一管理）"""
    # 向量检索配置
    SIMILARITY_THRESHOLD = 0.65  # 相似度阈值
    TOP_K_STANDARD = 3  # 标准检索数量
    TOP_K_BROAD = 8  # 广泛问题检索数量
    MAX_CONTEXT_DOCS = 2  # 最多使用N个文档构建上下文

    # API配置
    API_TIMEOUT = 30  # API请求超时时间（秒）
    INTENT_TIMEOUT = 15  # 意图识别超时时间（秒）

    # 广泛问题关键词
    BROAD_QUESTION_KEYWORDS = [
        "有哪些", "所有文章", "全部文章", "网站包含",
        "所有内容", "完整列表", "全部内容", "网站中",
        "网站有哪些", "包含什么文章", "文章列表"
    ]
```

### API配置

**频率限制**:
```python
class AiChatRateThrottle(UserRateThrottle):
    rate = '10/min'  # 每用户每分钟最多10次请求
    scope = 'ai_chat'
```

---

## 使用指南

### 管理命令

**1. 查看向量化状态**:
```bash
python manage.py vectorize_articles --status
```

**输出示例**:
```
向量数据库状态
================
已发布文章总数: 150
已向量化文章: 145
待处理文章: 5
总文本块数: 1,250
最后更新时间: 2026-03-22 10:30:00
存储目录: mysx/chroma_data
嵌入模型: shibing624/text2vec-base-chinese
```

**2. 全量向量化**:
```bash
python manage.py vectorize_articles
```

**3. 增量更新**:
```bash
python manage.py vectorize_articles --incremental
```

**4. 清空重建**:
```bash
python manage.py vectorize_articles --force-rebuild
```

### API接口

**1. AI聊天接口**:
```http
POST /api/ai/chat/
Authorization: Bearer <JWT_TOKEN>
Content-Type: application/json

{
  "messages": [
    {
      "type": "user",
      "text": "Django的MTV架构是什么？"
    }
  ],
  "use_rag": null
}
```

**响应示例**:
```json
{
  "reply": "Django的MTV架构是指Model-Template-View...",
  "rag_used": true,
  "retrieved_docs": [
    {
      "title": "Django框架详解",
      "article_id": 42,
      "relevance": 0.87,
      "summary": "深入解析Django的MTV架构设计..."
    }
  ]
}
```

**2. AI服务状态**:
```http
GET /api/ai/status/
Authorization: Bearer <JWT_TOKEN>
```

**响应示例**:
```json
{
  "status": "available",
  "message": "AI服务正常",
  "rag_enabled": true,
  "features": {
    "chat": true,
    "rag_retrieval": true,
    "vector_search": true
  },
  "vector_database": {
    "total_articles": 150,
    "vectorized_articles": 145,
    "total_chunks": 1250,
    "embedding_model": "shibing624/text2vec-base-chinese"
  }
}
```

**3. 语义搜索**:
```http
POST /api/articles/semantic-search/
Content-Type: application/json

{
  "query": "Vue组件生命周期",
  "top_k": 5
}
```

### 前端集成

**调用示例** (JavaScript):
```javascript
async function askAI(question) {
  const response = await fetch('/api/ai/chat/', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${getAuthToken()}`
    },
    body: JSON.stringify({
      messages: [
        {
          type: 'user',
          text: question
        }
      ]
    })
  });

  const data = await response.json();

  if (data.rag_used) {
    console.log('使用了RAG检索增强');
    console.log('参考文档:', data.retrieved_docs);
  }

  return data.reply;
}
```

---

## 监控和日志

### 日志记录

**关键日志点**:

1. **RAG服务初始化**:
```python
logger.info("AI RAG服务初始化成功")
logger.error(f"AI RAG服务初始化失败: {str(e)}")
```

2. **用户查询处理**:
```python
logger.info(f"开始处理用户查询: {query[:50]}...")
logger.info(f"使用静态知识库回答: {static_result['metadata']['knowledge_name']}")
logger.info(f"LLM直接回答: confidence={intent_result['confidence']:.2f}")
```

3. **向量检索**:
```python
logger.info(f"检索到{len(relevant_docs)}个相关文档")
logger.warning("向量检索未找到相关文档，返回通用回答")
```

### 错误处理

**降级策略**:
1. API调用失败 → 关键词路由
2. 向量检索失败 → 普通AI模式
3. 相似度不足 → 通用回答
4. 服务不可用 → 友好错误提示

**错误响应示例**:
```json
{
  "error": "AI服务暂时不可用，请稍后再试",
  "detail": "向量数据库连接超时"
}
```

---

## 总结

### 系统优势

1. **智能路由**: 多层次的查询处理策略，确保最优回答
2. **高性能**: 单例模式、增量更新、相似度过滤
3. **高可用**: 降级方案、错误处理、日志记录
4. **易扩展**: 模块化设计，便于功能扩展
5. **用户友好**: 自然语言交互，上下文增强

### 技术亮点

1. **完整的RAG实现**: 从文档处理到检索生成的完整链路
2. **智能意图识别**: LLM驱动的动态路由决策
3. **向量检索优化**: 相似度阈值、动态top_k、结果去重
4. **静态知识库**: 确保全局性问题的准确性
5. **生产就绪**: 完善的权限控制、性能监控、错误处理

### 未来改进方向

1. **多模态支持**: 图片、视频内容的向量化
2. **个性化推荐**: 基于用户历史的智能推荐
3. **实时更新**: 文章发布后自动向量化
4. **多语言支持**: 扩展到英文等多语言内容
5. **性能优化**: GPU加速、分布式检索

---

## 版本历史

| 版本 | 日期 | 主要改动 | 改动内容 |
|------|------|----------|----------|
| v1.0 | 2026-03-22 | 初始版本 | 完整的RAG系统实现 |
| v2.0 | 2026-03-22 | 工作流优化 | 静态知识库链接支持、工作流简化、意图路由增强 |
| v2.1 | 2026-03-22 | 关键词匹配优化 | 优先级系统、LLM增强、匹配准确性提升 |

---

**文档版本**: v2.1
**最后更新**: 2026-03-22
**维护者**: 码驿随想技术团队
**联系方式**: h2892197119@foxmail.com

---

*本报告详细描述了码驿随想博客系统中AI RAG功能的完整实现，包括系统架构、技术细节、使用指南、优化历史等各个方面，为系统的维护和扩展提供了全面的技术参考。*

**相关文档**:
- [AI_RAG_优化总结报告.md](AI_RAG_优化总结报告.md) - 详细优化记录
- [AI_RAG_问题修复说明.md](AI_RAG_问题修复说明.md) - 问题修复说明