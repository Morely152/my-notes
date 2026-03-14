---

---
--- 
#### 核心功能1：前端深浅色主题配置与响应式布局设计

为了提供良好的用户体验和视觉一致性，设计了完整规范的深浅色主题系统和响应式布局框架。系统采用CSS变量实现主题切换，使用Pinia进行状态管理，并支持跨标签页同步。采用基于媒体查询的响应式布局，适配了多种尺寸的屏幕。

##### 1.1 主题状态管理（Pinia Store）

```javascript
import { defineStore } from 'pinia'
import { ref, watch } from 'vue'

export const useThemeStore = defineStore('theme', () => {
  // 主题状态 - 从localStorage读取或默认light
  const theme = ref(localStorage.getItem('theme') || 'light')

  // 初始化主题
  const initTheme = () => {
    applyTheme(theme.value)
  }

  // 应用主题 - 设置data-theme属性并保存到localStorage
  const applyTheme = (newTheme) => {
    document.documentElement.setAttribute('data-theme', newTheme)
    localStorage.setItem('theme', newTheme)
  }

  // 切换主题
  const toggleTheme = () => {
    const newTheme = theme.value === 'light' ? 'dark' : 'light'
    setTheme(newTheme)
  }

  // 设置主题
  const setTheme = (newTheme) => {
    theme.value = newTheme
    applyTheme(newTheme)
  }

  // 监听localStorage变化（跨标签页同步）
  const handleStorageChange = (e) => {
    if (e.key === 'theme') {
      theme.value = e.newValue || 'light'
    }
  }

  window.addEventListener('storage', handleStorageChange)

  return { theme, initTheme, toggleTheme, setTheme }
})
```

##### 1.2 CSS变量定义（深浅色主题配色）

```css
/* 浅色模式 */
:root {
  /* 画布层 */
  --bg-page: #F5F2ED;
  --bg-card: #EBE8E2;
  --bg-code: #2D2D2D;

  /* 文字层 */
  --text-h: #1A1A1A;
  --text-p: #3C3C3B;
  --text-s: #66625c;

  /* 功能色 */
  --accent: #8E4D39;
  --border: #E0DDD5;

  /* 字体 */
  --font-serif: 'Lora', 'Source Serif Pro', '思源宋体', 'Noto Serif SC', Georgia, serif;
  --font-sans: 'Inter', system-ui, -apple-system, '思源黑体', 'Noto Sans SC', 'Microsoft YaHei', sans-serif;
  --line-height: 1.8;
  --max-width: 720px;

  /* 过渡效果 */
  --transition-speed: 0.4s;

  /* Element Plus 主题变量 */
  --el-color-primary: #8E4D39;
  --el-color-primary-light-3: #a86550;
  --el-color-primary-light-5: #c28367;
  --el-color-primary-dark-2: #7a4331;
}

/* 深色模式 */
[data-theme="dark"] {
  /* 画布层 */
  --bg-page: #1C1B1A;
  --bg-card: #252422;
  --bg-code: #141312;

  /* 文字层 */
  --text-h: #E8E4DE;
  --text-p: #CECAC3;
  --text-s: #66625c;

  /* 功能色 */
  --accent: #D4B896;
  --border: #33312E;

  /* Element Plus 自定义主题变量 */
  --el-color-primary: #D4B896;
  --el-color-primary-light-3: #e0c9a7;
  --el-color-primary-dark-2: #c4ad8b;
}

/* 主题温度转换效果 */
:root, [data-theme="dark"] {
  transition:
    --bg-page 0.6s cubic-bezier(0.65, 0, 0.35, 1),
    --bg-card 0.6s cubic-bezier(0.65, 0, 0.35, 1),
    --text-h 0.6s cubic-bezier(0.65, 0, 0.35, 1),
    --text-p 0.6s cubic-bezier(0.65, 0, 0.35, 1),
    --accent 0.6s cubic-bezier(0.65, 0, 0.35, 1),
    --border 0.6s cubic-bezier(0.65, 0, 0.35, 1);
}
```

##### 1.3 响应式布局设计（媒体查询）

```css
/* 小屏手机 (≤ 480px) */
@media (max-width: 480px) {
  .section {
    padding: 0;
    margin: 0 10px;
  }
  .article-title {
    font-size: 22px;
  }
}

/* 手机/小平板 (≤ 768px) */
@media (max-width: 768px) {
  .nav-links-desktop {
    display: none;
  }
  .posts-container {
    grid-template-columns: 1fr;
  }
  .gallery-wall {
    height: auto;
    display: grid;
    grid-template-columns: repeat(2, 1fr);
  }
}

/* 平板 (≤ 1024px) */
@media (max-width: 1024px) {
  .right-section.sidebar {
    width: 350px;
  }
  .section {
    margin-left: 5%;
    margin-right: 5%;
  }
}

/* 桌面端 (> 1024px) */
@media (min-width: 1025px) {
  .section {
    max-width: var(--max-width);
    margin: 0 auto;
  }
}
```

#### 核心功能2：首页GSAP分页滑动效果

为了打造沉浸式的浏览体验，首页采用全屏分页滑动设计，使用GSAP动画库实现流畅的页面切换效果。系统支持滚轮、触摸、键盘、导航点多种交互方式，并配合微动画效果增强视觉吸引力。

###### 2.1 平滑滚动核心逻辑

```javascript
const initSmoothScroll = () => {
  const sectionElements = [section0, section1, section2, section3, section4]
    .map(ref => ref.value).filter(Boolean)

  // 核心配置参数
  const scrollDuration = 1400      // 滚动动画持续时间(ms)
  const ease = "power3.inOut"       // 缓动函数
  const wheelThreshold = 5          // 滚轮阈值
  const debounceTime = 80           // 防抖延迟

  // 初始化sections位置 - 绝对定位堆叠
  sectionElements.forEach((section, index) => {
    gsap.set(section, {
      y: index * 100 + '%',         // 垂直位置偏移
      position: 'absolute',
      top: 0,
      left: 0,
      width: '100%'
    })
  })

  // 页面切换方法
  smoothScroll = {
    sections: sectionElements,
    currentSection: 0,
    isAnimating: false,

    goToSection(index) {
      // 防止重复触发和越界
      if (this.isAnimating || index < 0 || index >= this.sections.length) return

      this.isAnimating = true
      this.currentSection = index
      activeSection.value = index

      // GSAP动画：移动所有section到新位置
      this.sections.forEach((section, i) => {
        gsap.to(section, {
          y: (i - index) * 100 + '%',     // 计算目标位置
          duration: scrollDuration / 1000, // 1.4秒
          ease: ease,
          onComplete: () => {
            if (i === this.sections.length - 1) {
              this.isAnimating = false
            }
          }
        })
      })

      this.triggerSectionAnimation(index)
    }
  }
}
```

##### 2.2 滚轮事件处理（防抖+累加）

```javascript
const handleWheel = (e) => {
  const now = Date.now()

  // 收集滚轮事件（150ms内的）
  wheelEvents.push({ deltaY: e.deltaY, time: now })
  wheelEvents = wheelEvents.filter(event => now - event.time < 150)

  if (wheelTimeout) clearTimeout(wheelTimeout)

  // 防抖处理
  wheelTimeout = setTimeout(() => {
    if (smoothScroll && !smoothScroll.isAnimating) {
      // 累加滚轮增量
      const totalDelta = wheelEvents.reduce((sum, e) => sum + e.deltaY, 0)

      if (Math.abs(totalDelta) > wheelThreshold * 2) {
        if (totalDelta > 0) {
          smoothScroll.nextSection()   // 向下
        } else {
          smoothScroll.prevSection()   // 向上
        }
      }
    }
    wheelEvents = []
  }, debounceTime)
}
```
##### 2.4 微动画视觉效果

```javascript
triggerSectionAnimation(index) {
  if (index === 1) {
    // 文章列表交错淡入
    gsap.fromTo(".post-item",
      { x: 50, opacity: 0 },
      {
        x: 0,
        opacity: 1,
        stagger: 0.15,    // 每个间隔0.15秒
        duration: 0.8,
        ease: "power2.out",
        delay: 0.3
      }
    )
  } else if (index === 2) {
    // 影集拼图散列动画，照片散落出现
    gsap.fromTo(".photo",
      { y: 50, rotation: gsap.utils.random(-15, 15), opacity: 0 },
      {
        y: 0,
        rotation: (i) => [-5, 3, 2, -4, -2, 4, -3, 2, 5, -1][i] || 0,
        opacity: 1,
        stagger: 0.1,
        duration: 1,
        ease: "back.out(1.7)",  // 弹性缓动
        delay: 0.3
      }
    )
  }
}
```

#### 核心功能3：Token自动刷新机制

在Axios响应拦截器中，实现了API请求异常自动化处理的功能，核心作用是应对Token过期和用户权限异常场景。当接口返回401未授权错误且非刷新Token请求时，会自动调用刷新Token接口，用新获取的access token更新本地存储，并重新发起原请求；若检测到403错误且判定为用户状态异常（封禁/注销），会清空本地存储并跳转至登录页，并报告错误。

```javascript
// 响应拦截器 - 处理token过期等情况
api.interceptors.response.use(
  (response) => response,
  async (error) => {
    const originalRequest = error.config;

    // 如果是401错误且不是刷新token的请求
    if (error.response?.status === 401 && !originalRequest._retry) {
      originalRequest._retry = true;  // 防止无限循环

      try {
        // 尝试使用refresh token获取新的access token
        const refreshToken = localStorage.getItem('refresh_token');
        const response = await axios.post(`${API_BASE_URL}/users/token/refresh/`, {
          refresh: refreshToken
        });

        const { access } = response.data;
        localStorage.setItem('access_token', access);

        // 重新发送原始请求
        originalRequest.headers.Authorization = `Bearer ${access}`;
        return api(originalRequest);
      } catch (refreshError) {
        // 刷新失败，清除本地存储并跳转登录页
        localStorage.removeItem('access_token');
        localStorage.removeItem('refresh_token');
        window.location.href = '/login';
      }
    }

    // 处理用户被封禁的情况
    if (error.response?.status === 403) {
      const errorData = error.response.data;
      if (errorData?.error === 'USER_BANNED' || errorData?.error === 'USER_DELETED') {
        localStorage.clear();
        window.location.href = `/login?error=${encodeURIComponent(errorData.message)}`;
      }
    }

    return Promise.reject(error);
  }
);
```

#### 核心功能4：文章图谱解析算法

为了直观展示文章之间的关联关系，设计了知识图谱功能。后端将文章按专栏结构编制为JSON树形数据，前端通过ECharts力导向图进行可视化渲染，支持点击跳转查看文章和专栏，以及拖拽、缩放等交互操作。

##### 4.1 后端JSON树形结构生成

```python
@action(detail=False, methods=['get'], permission_classes=[AllowAny])
def collection_tree(self, request):
    """
    获取文章合集树形结构
    返回格式：
    {
      "name": "码驿随想",
      "children": [
        {"name": "独立文章1", "id": 1},
        {"name": "独立文章2", "id": 2},
        {
          "name": "专栏合集",
          "id": 1,
          "children": [
            {"name": "专栏文章1", "id": 3},
            {"name": "专栏文章2", "id": 4}
          ]
        }
      ]
    }
    """
    columns = ArticleColumn.objects.all()
    all_articles = Article.objects.all()

    # 收集所有专栏中的文章ID
    column_article_ids = set()
    for column in columns:
        if column.article_ids:
            column_article_ids.update(column.article_ids)

    # 获取独立文章（不在任何专栏中）
    independent_articles = all_articles.exclude(
        id__in=column_article_ids
    ).order_by('id')

    children = []

    # 添加独立文章
    for article in independent_articles:
        children.append({
            'name': article.title,
            'id': article.id
        })

    # 添加专栏及其文章
    for column in columns:
        column_articles = []
        if column.article_ids:
            articles_in_column = []
            for article_id in column.article_ids:
                try:
                    article = all_articles.get(id=article_id)
                    articles_in_column.append(article)
                except Article.DoesNotExist:
                    continue

            column_articles = [
                {'name': article.title, 'id': article.id}
                for article in articles_in_column
            ]

        children.append({
            'name': column.name,
            'id': column.id,
            'children': column_articles if column_articles else []
        })

    return Response({
        'name': '码驿随想',
        'children': children
    })
```

##### 4.2 前端树形数据转图谱数据

```javascript
const convertToGraphData = (treeData) => {
  const nodes = []
  const links = []
  const colors = getThemeColors()

  // 1. 添加根节点
  const rootNodeId = 'root'
  nodes.push({
    id: rootNodeId,
    name: treeData.name || '码驿随想',
    symbolSize: 60,
    itemStyle: {
      color: colors.root.bg,
      borderColor: colors.root.border,
      borderWidth: 3
    },
    category: 0,
    value: 100
  })

  // 2. 遍历子节点
  if (treeData.children && treeData.children.length > 0) {
    treeData.children.forEach((child, index) => {
      if (child.children && Array.isArray(child.children) && child.children.length > 0) {
        // 专栏节点处理
        const columnId = `column_${index}`

        nodes.push({
          id: columnId,
          name: child.name,
          columnId: child.id,
          symbolSize: 40,
          itemStyle: {
            color: colors.column.bg,
            borderColor: colors.column.border,
            borderWidth: 2
          },
          category: 1,
          value: child.children.length * 10
        })

        // 根节点到专栏的连线
        links.push({
          source: rootNodeId,
          target: columnId,
          lineStyle: {
            color: colors.line,
            width: 2,
            opacity: 0.6,
            curveness: 0
          }
        })

        // 专栏下的文章节点
        child.children.forEach((article) => {
          const articleId = `article_${article.id}`
          nodes.push({
            id: articleId,
            name: article.name,
            articleId: article.id,
            symbolSize: 25,
            itemStyle: {
              color: colors.article.bg,
              borderColor: colors.article.border,
              borderWidth: 1.5
            },
            category: 2,
            value: 5
          })

          // 专栏到文章的连线
          links.push({
            source: columnId,
            target: articleId,
            lineStyle: {
              color: colors.line,
              width: 1,
              opacity: 0.4,
              curveness: 0
            }
          })
        })
      } else {
        // 独立文章处理
        const articleId = `article_${child.id}`
        nodes.push({
          id: articleId,
          name: child.name,
          articleId: child.id,
          symbolSize: 30,
          itemStyle: {
            color: colors.standalone.bg,
            borderColor: colors.standalone.border,
            borderWidth: 2
          },
          category: 3,
          value: 8
        })

        // 根节点到独立文章的连线
        links.push({
          source: rootNodeId,
          target: articleId,
          lineStyle: {
            color: colors.line,
            width: 1.5,
            opacity: 0.5,
            curveness: 0
          }
        })
      }
    })
  }

  return { nodes, links }
}
```

##### 4.3 ECharts力导向图配置

```javascript
const option = {
  backgroundColor: 'transparent',
  series: [{
    type: 'graph',
    layout: 'force',
    data: graphData.nodes,
    links: graphData.links,
    categories: [
      { name: '根节点' },
      { name: '专栏' },
      { name: '文章' },
      { name: '独立文章' }
    ],
    roam: true,  // 支持缩放和平移
    label: {
      show: true,
      position: 'right',
      formatter: '{b}'
    },
    labelLayout: {
      hideOverlap: true
    },
    scaleLimit: {
      min: 0.4,
      max: 2
    },
    emphasis: {
      focus: 'adjacency',
      lineStyle: { width: 3 }
    },
    force: {
      repulsion: 300,           // 节点间斥力
      edgeLength: [50, 150],    // 边长度范围
      gravity: 0.1,             // 向心力
      friction: 0.6,            // 阻尼系数
      layoutAnimation: true
    }
  }]
}

// 点击事件处理
chart.on('click', function(params) {
  if (params.dataType === 'node') {
    if (params.data.columnId) {
      // 点击专栏 - 打开专栏详情页
      window.open(`/columns?column=${params.data.columnId}`, '_blank')
    } else if (params.data.articleId) {
      // 点击文章 - 打开文章详情页
      window.open(`/article/${params.data.articleId}`, '_blank')
    }
  }
})
```

#### 核心功能5：文章搜索权重排序

该算法实现了文章高级搜索功能，核心是基于多字段权重的精准检索与排序：当传入搜索关键词时，通过Django原生支持的ORM的Case、When和Coalesce函数为不同字段匹配结果赋予差异化权重（标题3分、摘要2分、内容1分），并以此权重降序结合发布时间降序排序，让匹配度更高的文章优先展示。

后期打算引入Elasticsearch等专业搜索引擎进行优化，实现更精准灵活的权重控制和更快速的响应。

```python
def advanced_search(self, request):
    """
    高级搜索文章
    创意点：
    1. 多字段权重排序：标题(3) > 摘要(2) > 内容(1)
    2. 使用Django ORM的Coalesce和Case实现条件权重
    3. 支持年份范围查询
    """
    keyword = request.query_params.get('keyword', '')
    category = request.query_params.get('category')
    start_year = request.query_params.get('start_year')
    end_year = request.query_params.get('end_year')

    articles = self.get_queryset()

    if keyword:
        articles = articles.annotate(
            search_weight=Coalesce(
                Case(
                    When(Q(title__icontains=keyword), then=Value(3)),
                    When(Q(summary__icontains=keyword), then=Value(2)),
                    When(Q(content__icontains=keyword), then=Value(1)),
                    default=Value(0),
                    output_field=IntegerField(),
                ),
                Value(0),
                output_field=IntegerField(),
            )
        ).filter(
            Q(title__icontains=keyword) |
            Q(summary__icontains=keyword) |
            Q(content__icontains=keyword)
        ).order_by('-search_weight', '-publish_date')

    # 其他过滤条件
    if category:
        articles = articles.filter(category_id=category)

    if start_year:
        articles = articles.filter(publish_date__gte=f'{start_year}-01-01')

    if end_year:
        articles = articles.filter(publish_date__lte=f'{end_year}-12-31')

    return Response(articles.values())
```

#### 核心功能6：动态Sitemap生成

为了优化SEO，让搜索引擎及时更新网站的地图索引，设计了专用的网站地图接口。有新的文章上传后，搜索引擎调用接口就可以获取新的网站地图数据，从而自动实现新文章的搜索匹配。

```python
@require_GET
def dynamic_sitemap(request):
    """
    动态生成 sitemap.xml
    创意点：
    1. 实时从数据库获取数据，无需手动更新
    2. 包含完整的priority和changefreq
    3. 自动缓存1小时减少数据库压力
    4. 包含静态页面、文章、影集、项目
    """
    # 静态页面配置
    static_urls = [
        {'path': '/', 'priority': '1.0', 'changefreq': 'daily'},
        {'path': '/articles', 'priority': '0.9', 'changefreq': 'daily'},
        {'path': '/gallery', 'priority': '0.8', 'changefreq': 'weekly'},
        {'path': '/projects', 'priority': '0.8', 'changefreq': 'weekly'},
        {'path': '/columns', 'priority': '0.7', 'changefreq': 'weekly'},
        {'path': '/knowledge-graph', 'priority': '0.6', 'changefreq': 'monthly'},
    ]

    # 获取所有数据
    articles = Article.objects.filter(is_published=True)
    gallery_images = GalleryImage.objects.all()
    projects = Project.objects.all()

    urlset = Element('urlset', xmlns='http://www.sitemaps.org/schemas/sitemap/0.9')

    # 添加静态页面
    for static_url in static_urls:
        url = SubElement(urlset, 'url')
        loc = SubElement(url, 'loc')
        loc.text = f"{SITE_URL}{static_url['path']}"
        priority = SubElement(url, 'priority')
        priority.text = str(static_url['priority'])
        changefreq = SubElement(url, 'changefreq')
        changefreq.text = static_url['changefreq']

    # 添加文章
    for article in articles:
        url = SubElement(urlset, 'url')
        loc = SubElement(url, 'loc')
        loc.text = f"{SITE_URL}/article/{article.id}"
        lastmod = SubElement(url, 'lastmod')
        lastmod.text = article.publish_date.strftime('%Y-%m-%d')
        priority = SubElement(url, 'priority')
        priority.text = '0.7'
        changefreq = SubElement(url, 'changefreq')
        changefreq.text = 'monthly'

    # 添加影集、项目...

    response = HttpResponse(content_type='application/xml')
    response['Cache-Control'] = 'public, max-age=3600'
    response.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    response.write(tostring(urlset, encoding='unicode'))
    return response
```

#### 核心功能7：图片智能压缩与WebP转换

WebP格式的图片具有高效的压缩能力，可以在保证图片质量的前提下大幅度减少空间占用，有利于减少网站加载时间，节省服务器流量。本系统采用了将png等格式的图片自动压缩转换为WebP的算法，适配多种图片格式，算法稳定性良好。

```python
def compress_image(self, image_file, quality=85, max_width=1920, max_height=1080):
    """
    压缩图片并转换为webp格式
    创意点：
    1. 自动处理多种色彩模式（RGBA/P/L等转为RGB）
    2. 使用LANCZOS高质量重采样算法
    3. 保持宽高比的智能缩放
    4. 自动计算压缩率
    """
    try:
        img = Image.open(image_file)
        original_size = image_file.size

        # 转换为RGB模式（webp需要）
        if img.mode in ('RGBA', 'P', 'L', 'LA', 'CMYK'):
            background = Image.new('RGB', img.size, (255, 255, 255))
            if img.mode == 'P':
                img = img.convert('RGBA')
            if img.mode in ('RGBA', 'LA'):
                background.paste(img, mask=img.split()[-1])
            else:
                background.paste(img)
            img = background

        # 调整尺寸（保持宽高比）
        img.thumbnail((max_width, max_height), Image.Resampling.LANCZOS)

        # 压缩并转换为webp
        output = BytesIO()
        img.save(output, format='WEBP', quality=quality, optimize=True)
        output.seek(0)

        compressed_size = output.getbuffer().nbytes
        compression_ratio = (1 - compressed_size / original_size) * 100

        logger.info(f"图片压缩: {original_size // 1024}KB -> {compressed_size // 1024}KB ({compression_ratio:.1f}%)")
        return output, compression_ratio
    except Exception as e:
        logger.error(f"图片压缩失败: {e}")
        raise
```

#### 核心功能8：文章图片批量处理

为了优化文章发布流程，设计了完整的图片批量处理功能。用户选择文件夹后，系统自动筛选图片文件，逐个上传到后端进行压缩预处理，然后上传至Cloudflare R2并返回CDN链接，最后自动替换文章内容中的本地图片引用。

##### 8.1 前端批量上传逻辑

```javascript
const handleFolderSelect = async (event) => {
  const files = Array.from(event.target.files)

  // 筛选图片文件
  const imageFiles = files.filter(file => file.type.startsWith('image/'))

  // 准备上传列表数据
  uploadImageList.value = await Promise.all(
    imageFiles.map(async (file) => {
      const thumbnail = await createThumbnail(file)
      return {
        file: file,
        fileName: file.name,
        fileSize: formatFileSize(file.size),
        thumbnail: thumbnail,
        status: 'pending',  // pending, uploading, success, error
        errorMessage: '',
        uploadedUrl: ''
      }
    })
  )

  uploadDialogVisible.value = true
}

// 批量上传执行
const startBatchUpload = async () => {
  isUploading.value = true
  let successCount = 0
  const imageMapping = {}

  // 逐个上传图片
  for (let i = 0; i < uploadImageList.value.length; i++) {
    const imageItem = uploadImageList.value[i]
    imageItem.status = 'uploading'

    try {
      // 上传图片
      const url = await uploadSingleImage(imageItem.file)

      imageItem.status = 'success'
      imageItem.uploadedUrl = url
      imageMapping[imageItem.fileName] = url
      successCount++

    } catch (error) {
      imageItem.status = 'error'
      imageItem.errorMessage = error.message
    }
  }

  // 替换文章内容中的本地图片链接
  if (successCount > 0) {
    const updatedContent = replaceLocalImageLinks(articleForm.content, imageMapping)
    articleForm.content = updatedContent
  }

  isUploading.value = false
}

// 单个图片上传
const uploadSingleImage = async (file) => {
  const formData = new FormData()
  formData.append('image', file)

  const response = await fetch(`${API_BASE_URL}/upload/image/`, {
    method: 'POST',
    body: formData
  })

  const result = await response.json()
  return result.data.url
}
```

##### 8.2 Cloudflare R2上传服务

```python
class CloudflareR2Service:
    """Cloudflare R2 图床上传服务"""

    def __init__(self):
        self.access_key = settings.CLOUDFLARE_R2_ACCESS_KEY
        self.secret_key = settings.CLOUDFLARE_R2_SECRET_KEY
        self.bucket_name = settings.CLOUDFLARE_R2_BUCKET_NAME
        self.endpoint_url = settings.CLOUDFLARE_R2_ENDPOINT_URL
        self.custom_domain = settings.CLOUDFLARE_R2_CUSTOM_DOMAIN

        # 初始化S3客户端（兼容R2）
        self.s3_client = boto3.client(
            's3',
            endpoint_url=self.endpoint_url,
            aws_access_key_id=self.access_key,
            aws_secret_access_key=self.secret_key,
            region_name='auto'
        )

    def upload_to_r2(self, file_obj, filename, content_type='image/webp'):
        """上传文件到Cloudflare R2"""
        try:
            self.s3_client.put_object(
                Bucket=self.bucket_name,
                Key=filename,
                Body=file_obj.getvalue(),
                ContentType=content_type,
                ACL='public-read'
            )

            # 生成CDN URL
            if self.custom_domain:
                url = f"https://{self.custom_domain}/{filename}"
            else:
                url = f"https://{self.bucket_name}.{self.endpoint_url}/{filename}"

            return url
        except Exception as e:
            logger.error(f"R2上传失败: {e}")
            raise

    def generate_unique_filename(self, original_filename):
        """生成唯一文件名: 20260308_143052_a3b7c9d1.webp"""
        timestamp = timezone.now().strftime('%Y%m%d_%H%M%S')
        unique_id = str(uuid.uuid4())[:8]
        filename = f"{timestamp}_{unique_id}.webp"
        return filename
```

##### 8.3 图片URL自动替换

```javascript
const replaceLocalImageLinks = (content, imageMapping) => {
  let updatedContent = content

  // 使用正则表达式，匹配多种格式的本地图片链接
  const localImagePatterns = [
    /!\[([^\]]*)\]\(([^)]+)\)/g,      // Markdown: ![alt](path)
    /<img[^>]+src=["']([^"']+)["'][^>]*>/g  // HTML: <img src="path">
  ]

  localImagePatterns.forEach(pattern => {
    updatedContent = updatedContent.replace(pattern, (match, altOrSrc, src) => {
      const isMarkdown = match.startsWith('!')
      const imageSrc = isMarkdown ? src : altOrSrc
      const alt = isMarkdown ? altOrSrc : ''

      // 提取文件名
      const fileName = imageSrc.split(/[\/\\]/).pop()

      // 检查是否有对应的上传映射
      if (imageMapping[fileName]) {
        const newUrl = imageMapping[fileName]

        if (isMarkdown) {
          return `![${alt}](${newUrl})`
        } else {
          return match.replace(/src=["'][^"']+["']/, `src="${newUrl}"`)
        }
      }

      return match
    })
  })

  return updatedContent
}
```
