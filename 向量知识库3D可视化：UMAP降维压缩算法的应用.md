---

---
---
> 本文内容来源于作者个人项目实践总结，记录了从向量存储到三维可视化展示的完整实现过程。
>
> 本文遵循 [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) 协议发布。
>
> ⚠️ 部分内容由AI生成，请仔细甄别可能存在的错误。
---

# 一、为什么要做向量知识库的可视化？

## 1.痛点：高维向量的"黑盒"困境

大家做 `RAG`（Retrieval-Augmented Generation，检索增强生成）系统的时候，应该都有过这种感受——文本被嵌入模型变成向量之后，扔进向量数据库，然后……就没了 😂。你能看到的就是一堆数字，`[0.023, -0.127, 0.056, ...]`，动辄几百上千维。

你可能会问自己：

- 这些向量在空间里到底长什么样？
- 相似的文章真的聚在一起了吗？
- 不同分类的文章在语义空间中有没有明显边界？
- 我的分块策略合理吗？

这些问题，光靠看数据库里的数字是完全回答不了的（当然你要是能看懂几百维的浮点数组我也服气 🤣）。

所以——可视化一下，不就什么都清楚了吗！

## 2.思路：降维 + 3D渲染

高维向量我们是没法直接画的，但可以先用降维算法把它压到三维空间，再用 3D 散点图渲染出来。整体思路很简单：

```
文章文本 → 嵌入模型 → 高维向量 → UMAP降维 → 3D坐标 → ECharts渲染
```

用到的主要技术栈：

| 层级 | 技术 | 作用 |
|------|------|------|
| 嵌入模型 | HuggingFace（本地部署） | 将文本转为高维向量 |
| 向量数据库 | ChromaDB | 存储和检索向量 |
| 降维算法 | **UMAP（Uniform Manifold Approximation and Projection）** | 高维→3维 |
| 后端框架 | Django + DRF | 提供 API |
| 异步任务 | ThreadPoolExecutor | 后台处理降维计算 |
| 前端框架 | Vue 3 + ECharts GL | 3D 散点图展示 |

# 二、后端：从ChromaDB到3D坐标

## 1.向量是怎么存进去的

在讲可视化之前，先简单过一下向量是怎么来的。项目里用了一个 `ArticleVectorService` 类来管理整个向量化流程，它是个线程安全的单例：

```python
# vector_service.py
class ArticleVectorService:
    _instance = None
    _initialized = False
    _embeddings = None       # 类级别缓存嵌入模型
    _chroma_client = None    # 类级别缓存Chroma客户端
    _init_lock = threading.Lock()
```

初始化的时候做了这么几件事：

```python
# 使用 HuggingFace 本地嵌入模型
from langchain_huggingface import HuggingFaceEmbeddings
from langchain_chroma import Chroma

# 嵌入模型（CPU模式，normalize对相似度检索更友好）
embeddings = HuggingFaceEmbeddings(
    model_name=Config.EMBEDDING_MODEL_NAME,
    model_kwargs={'device': 'cpu'},
    encode_kwargs={'normalize_embeddings': True},
)

# ChromaDB 向量数据库
chroma_client = Chroma(
    persist_directory=Config.CHROMA_PERSIST_DIR,
    embedding_function=embeddings,
    collection_name="articles"
)
```

文章被 `RecursiveCharacterTextSplitter` 分块后，每块文本通过嵌入模型变成一个向量，连同元数据一起存进 ChromaDB。

## 2.核心：UMAP降维处理

这是整个可视化方案的核心。我们的任务是把 ChromaDB 里的高维向量降到三维坐标。

先看完整的处理流程：

```python
# tasks_simple.py — generate_viz_data_task()
from sklearn.preprocessing import StandardScaler
import umap
import numpy as np

# 1. 从ChromaDB获取全部向量数据
collection = vector_service.chroma_client._collection
results = collection.get(include=['embeddings', 'metadatas', 'documents'])

embeddings = np.array(results['embeddings'])
metadatas = results['metadatas']
documents = results['documents']

# 2. 可选：分类过滤
if category_filter:
    filtered_indices = [
        i for i, meta in enumerate(metadatas)
        if meta.get('category_name') == category_filter
    ]
    embeddings = embeddings[filtered_indices]
    # ...同步过滤metadatas和documents

# 3. 可选：均匀采样（数据量太大时）
if sample_size and int(sample_size) < len(embeddings):
    indices = np.linspace(0, len(embeddings) - 1, sample_size, dtype=int)
    embeddings = embeddings[indices]
    # ...

# 4. 标准化
scaler = StandardScaler()
embeddings_normalized = scaler.fit_transform(embeddings)

# 5. UMAP降维
n_neighbors = min(15, len(embeddings) - 1)
reducer = umap.UMAP(
    n_components=3,            # 降到3维
    n_neighbors=n_neighbors,   # 动态调整邻域大小
    min_dist=0.3,              # 最小距离，控制聚集程度
    metric='cosine',           # 余弦距离，更适合文本语义
    spread=1.0,
    random_state=42,           # 固定种子保证可复现
    n_jobs=1,
    low_memory=True
)
coords_3d = reducer.fit_transform(embeddings_normalized)

# 6. 归一化到[0, 20]范围
coords_3d = (coords_3d - coords_3d.min(axis=0)) / \
            (coords_3d.max(axis=0) - coords_3d.min(axis=0)) * 20
```

这里有几个点值得说道说道：

**为什么用 UMAP 而不是 PCA 或 t-SNE？**

- `PCA`（主成分分析）是线性的，它只能捕捉线性关系，对于语义空间这种高度非线性的结构，效果很差
- `t-SNE` 虽然也能降维，但它计算复杂度是 O(n²)，数据量一大就慢到怀疑人生，而且它更多是"保局部"，全局结构容易丢
- `UMAP` 既保局部结构又保全局拓扑，计算速度还比 t-SNE 快得多——简直是降维界的"六边形战士"

**几个关键参数解释：**

- `n_neighbors=15`：控制 UMAP 在构建局部流形结构时考虑多少个邻居。值越大，越关注全局结构；值越小，越关注局部细节
- `min_dist=0.3`：控制降维后点之间的最小距离。值越小，相似的点会挤在一起形成紧密的簇；值越大，点会更均匀地分散
- `metric='cosine'`：文本向量用余弦距离比欧氏距离更合适，因为它关注方向而不是绝对大小

**为什么做标准化？**

`StandardScaler` 把每个维度的数据都变换到均值 0、标准差 1 的分布。这一步很重要，不然某些方差特别大的维度会主导 UMAP 的结果（~~相信我，不加这步你会得到一团奇怪的云~~）。

## 3.异步任务：别让用户干等

UMAP 降维是个计算密集型操作，几百到几千条数据可能需要 20-30 秒。如果用同步请求，前端会直接超时（Django 的默认请求超时也不够）。

所以方案是：**POST 启动任务 → 返回 task_id → 前端轮询 GET 查状态**。

### 3.1 后端视图层

```python
# vector_views.py — VectorVisualizationView
class VectorVisualizationView(APIView):
    """向量数据可视化API视图（异步版本）"""

    def post(self, request):
        """POST 启动异步任务，返回 task_id"""
        from articles.tasks_simple import submit_viz_data_task

        task_id = submit_viz_data_task(
            sample_size=request.data.get('sample_size'),
            category_filter=request.data.get('category')
        )
        return Response({
            'status': 'success',
            'task_id': task_id,
            'poll_url': f'/api/articles/vectorize/viz-data/?task_id={task_id}'
        }, status=202)

    def get(self, request):
        """GET 轮询任务状态"""
        task_id = request.query_params.get('task_id')
        if task_id:
            task_info = get_task_status(task_id)
            if task_info['task_status'] == 'SUCCESS':
                return Response(task_info.get('result', {}))
            elif task_info['task_status'] == 'FAILURE':
                return Response({'status': 'error', ...})
            else:
                return Response({'status': 'processing', ...}, status=202)
```

### 3.2 线程池任务管理

项目没有用 Celery（~~杀鸡焉用牛刀~~），而是用 Python 标准库的 `ThreadPoolExecutor` 实现了一个轻量的任务管理器：

```python
# thread_pool_manager.py
class TaskManager:
    """单例模式的任务管理器"""

    def __init__(self):
        self.tasks = {}                # 任务信息存储
        self.task_results = {}         # 成功结果
        self.task_errors = {}          # 失败信息
        self.executor = ThreadPoolExecutor(
            max_workers=2,             # 最多同时2个任务
            thread_name_prefix="vectorize"
        )

    def submit_task(self, func, task_name, callback=None, **kwargs):
        """提交任务到线程池，返回 task_id"""
        task_id = self.generate_task_id()
        # 包装函数：执行 → 存结果 → 更新状态
        future = self.executor.submit(task_wrapper)
        self.tasks[task_id] = {
            'task_id': task_id,
            'task_name': task_name,
            'status': 'PENDING',
            'future': future,
            # ...
        }
        return task_id
```

这样做的好处显而易见——轻量、无额外依赖（不需要 Redis/RabbitMQ），对于这种单机小项目来说足够了。

## 4.数据格式：对接ECharts

降维完成后，数据会被组装成 ECharts GL 的 `scatter3D` 系列需要的格式：

```python
echarts_data = []
for i, (coord, meta, doc) in enumerate(zip(coords_3d, metadatas, documents)):
    echarts_data.append({
        "name": f"chunk_{i}",
        "value": [float(coord[0]), float(coord[1]), float(coord[2])],
        "category": meta.get('category_name', '未分类'),
        "article_id": meta.get('article_id', 0),
        "article_title": meta.get('title', ''),
        "text_length": len(doc),
        "original_text": doc[:100],
        "chunk_index": meta.get('chunk_index', i)
    })
```

最终返回给前端的数据长这样：

```json
{
    "status": "success",
    "data": [
        {
            "name": "chunk_0",
            "value": [12.5, 8.3, 15.1],
            "category": "Python",
            "article_title": "深入理解Python装饰器",
            "text_length": 512,
            "original_text": "装饰器是Python中最优雅的语法糖之一..."
        }
    ],
    "metadata": {
        "total_chunks": 868,
        "categories": ["Python", "前端", "AI"],
        "umap_params": {
            "n_components": 3,
            "n_neighbors": 15,
            "min_dist": 0.3
        }
    }
}
```

---

# 三、前端：Vue 3 + ECharts GL 渲染三维散点图

## 1.轮询机制：优雅地等待后端处理

前端的轮询逻辑我觉得挺值得拿出来说一下。整体流程是这样的：

```
用户打开页面 → POST请求启动任务 → 拿到task_id
    ↓
每2秒GET轮询一次 → processing? 继续
                   → success? 渲染图表 🎉
                   → error? 提示用户
    ↓
超过30次（约60秒）→ 提示超时
```

核心代码：

```javascript
// VectorVisualization.vue
const POLL_INTERVAL = 2000     // 2秒轮询一次
const MAX_POLL_ATTEMPTS = 30   // 最多30次（约60秒）
let pollAttempts = 0

const fetchVisualizationData = async () => {
  loading.value = true
  pollAttempts = 0

  // 步骤1：POST启动异步任务
  const startResponse = await apiInstance.post('/articles/vectorize/viz-data/', taskParams, {
    timeout: 120000
  })
  currentTaskId = startResponse.data.task_id

  // 步骤2：开始轮询
  pollingTimer = setInterval(pollTaskStatus, POLL_INTERVAL)
  pollTaskStatus()  // 立即执行一次
}

const pollTaskStatus = async () => {
  const response = await apiInstance.get(
    `/articles/vectorize/viz-data/?task_id=${currentTaskId}`
  )

  if (response.data.status === 'success') {
    // 拿到数据，停止轮询，渲染图表
    clearInterval(pollingTimer)
    chartData.value = response.data.data
    metadata.value = response.data.metadata
    loading.value = false
    setTimeout(() => initChart(), 100)
  } else if (response.data.status === 'processing') {
    // 还在处理，继续等
    if (pollAttempts >= MAX_POLL_ATTEMPTS) {
      clearInterval(pollingTimer)
      // 提示超时
    }
  }
}
```

需要注意，轮询定时器在组件卸载时一定要清理掉，不然用户切个页面回来，一堆定时器在那里空跑：

```javascript
onUnmounted(() => {
  if (pollingTimer) {
    clearInterval(pollingTimer)
    pollingTimer = null
  }
  // 清理动画定时器
  animationTimeouts.forEach(t => clearTimeout(t))
  // 销毁图表实例
  if (chartInstance) {
    chartInstance.dispose()
    chartInstance = null
  }
})
```

## 2.3D散点图配置：ECharts GL

图表初始化部分，需要引入 `echarts` 和 `echarts-gl`：

```javascript
import * as echarts from 'echarts'
import 'echarts-gl'
```

然后是 ECharts 的配置。为了让视觉效果更好看，我做了一些设计上的考虑：

### 2.1 颜色方案

没有用传统的"按分类分配颜色"方案（~~因为懒~~），而是给每个点随机生成一个 HSL 颜色，然后用更亮的版本做高亮边框：

```javascript
// 随机颜色
const generateRandomColor = () => {
  return `hsl(${Math.random() * 360}, ${60 + Math.random() * 30}%, ${50 + Math.random() * 20}%)`
}

// 更亮的边框色
const generateBrightBorder = (hslColor) => {
  const match = hslColor.match(/hsl\((\d+\.?\d*),\s*(\d+)%,\s*(\d+)%\)/)
  if (match) {
    const h = parseFloat(match[1])
    const s = parseFloat(match[2])
    const l = parseFloat(match[3])
    return `hsl(${h}, ${s}%, ${Math.min(l + 30, 90)}%)`
  }
  return 'rgba(255, 255, 255, 0.6)'
}
```

### 2.2 点的大小映射

散点的大小反映了文本块的长度——文本越长，点越大。做了一个线性映射：

```javascript
const symbolSizes = sizes.map(size => {
  const normalizedSize = (size - minSize) / (maxSize - minSize)
  return 3 + normalizedSize * (12 - 3)  // 映射到 3-12 像素
})
```

### 2.3 完整的ECharts配置

```javascript
const option = {
  tooltip: {
    formatter: (params) => {
      const data = params.data
      const truncatedText = data.original_text?.length > 20
        ? data.original_text.substring(0, 20) + '...'
        : data.original_text || ''
      return `
        <div style="padding: 8px;">
          <div style="font-weight: bold;">${data.article_title || '未知标题'}</div>
          <div style="font-size: 12px; color: #666;">文本长度: ${data.text_length}字符</div>
          <div style="font-size: 12px; color: #666;">${truncatedText}</div>
        </div>
      `
    }
  },
  // 三轴配置
  xAxis3D: {
    name: '语义维度 1 (理论抽象度)',
    nameTextStyle: { color: '#fff', fontSize: 12 },
    axisLine: { lineStyle: { color: '#fff' } },
    splitLine: { lineStyle: { color: 'rgba(255,255,255,0.1)' } }
  },
  yAxis3D: { name: '语义维度 2 (应用广度)', /* 类似配置 */ },
  zAxis3D: { name: '语义维度 3 (技术深度)', /* 类似配置 */ },
  // 3D容器
  grid3D: {
    viewControl: {
      autoRotate: true,
      autoRotateSpeed: 50,   // 初始快速旋转
      distance: 300,          // 初始远距离看全貌
      alpha: 30,
      beta: 45,
      panMouseButton: 'left',
      rotateMouseButton: 'right'
    },
    backgroundColor: '#1b1b2f',
    boxWidth: 250,
    boxHeight: 200,
    boxDepth: 250
  },
  series: [{
    type: 'scatter3D',
    data: points.map((point, idx) => ({
      value: [...point, sizes[idx], categoryIndices[idx]],
      symbolSize: symbolSizes[idx],
      itemStyle: { color: randomColors[idx] },
      // ...其他元数据
    })),
    emphasis: {
      scale: 2,
      label: { show: true, formatter: (p) => p.data.article_title }
    },
    progressive: 1000,
    progressiveThreshold: 3000  // 大数据量渐进式渲染
  }]
}
```

## 3.开场动画：先快后慢的旋转

为了给用户一个"哇哦"的感觉（~~好吧其实就是想炫一下~~），加了一个简单的开场动画：

1. 初始状态：快速旋转（speed=50），远距离（distance=300），用户看到整体轮廓
2. 500ms 后：减速到 speed=10，拉近到 distance=100

```javascript
const startAnimationSequence = () => {
  setTimeout(() => {
    chartInstance.setOption({
      grid3D: {
        viewControl: {
          autoRotateSpeed: 10,
          distance: 100
        }
      }
    })
  }, 500)
}
```

动画之后用户可以自由拖拽、缩放、旋转来探索数据。右键旋转、左键平移，鼠标悬停可以看每个点的详细信息。

---

# 四、整体架构回顾

把整个流程串起来，就是下面这个架构：

```
┌──────────────────────────────────────────────────────┐
│                     Vue 3 前端                       │
│  VectorVisualization.vue                             │
│  ┌─────────────┐    ┌──────────────┐                 │
│  │POST启动任务 │───→│ GET 轮询状态 │──→ ECharts GL   │
│  └─────────────┘    └──────────────┘    3D渲染       │
└──────────┬───────────────┬───────────────────────────┘
           │               │
           ▼               ▼
┌──────────────────────────────────────────────────────┐
│                   Django 后端                          │
│  ┌──────────────────┐  ┌──────────────────────┐      │
│  │ VectorVisualization│  │ ThreadPoolExecutor   │      │
│  │ View (DRF)        │  │ TaskManager (单例)    │      │
│  └──────────────────┘  └──────────┬───────────┘      │
│                                  │                    │
│                     ┌────────────▼────────────┐       │
│                     │ generate_viz_data_task  │       │
│                     │ 1. ChromaDB取向量       │       │
│                     │ 2. StandardScaler标准化  │       │
│                     │ 3. UMAP降维到3维        │       │
│                     │ 4. 组装ECharts格式      │       │
│                     └────────────┬───────────┘       │
│                                  │                    │
│                     ┌────────────▼───────────┐        │
│                     │  ArticleVectorService  │        │
│                     │  HuggingFace + ChromaDB │        │
│                     └────────────────────────┘        │
└──────────────────────────────────────────────────────┘
```

---

# 五、总结

这篇文章记录了我实现向量知识库三维可视化的完整过程，回顾一下核心要点：

- **降维算法选型**：选择 UMAP 而非 PCA/t-SNE，兼顾了速度和效果，`cosine` 距离度量更适合文本语义空间
- **标准化前置**：`StandardScaler` 处理后再做 UMAP，避免高方差维度主导结果
- **异步任务架构**：用 `ThreadPoolExecutor` 替代 Celery 实现轻量异步，POST→轮询GET的模式有效解决了计算密集型接口超时问题
- **前端轮询策略**：2秒间隔 + 30次上限（约60秒），组件卸载时必须清理定时器和图表实例
- **3D可视化细节**：ECharts GL 的 `scatter3D` + 开场动画 + tooltip 交互，让抽象的语义空间变得直观可见

做完这个可视化之后，最直观的感受是——**你能亲眼看到相似主题的文章确实聚在一起，不同类别的文章确实分布在不同的区域**。这种"眼见为实"的感觉，比看任何数值指标都更能验证你的 RAG 系统是不是在正确方向上。

如果你也在做向量相关的项目，强烈建议加上可视化这一环。**毕竟，代码不会骗人，向量也不会——只是有时候我们需要一双眼睛去看懂它。**

---

# 参考资料

[^1]: [UMAP: Uniform Manifold Approximation and Projection for Dimension Reduction — McInnes, L., Healy, J., & Melville, J. (2018)](https://arxiv.org/abs/1802.03426)
[^2]: [ECharts GL 文档 — Apache ECharts](https://echarts.apache.org/zh/option-gl.html)
[^3]: [LangChain 向量存储文档](https://python.langchain.com/docs/concepts/vectorstores/)
[^4]: [ChromaDB 官方文档](https://www.trychroma.com/docs)
