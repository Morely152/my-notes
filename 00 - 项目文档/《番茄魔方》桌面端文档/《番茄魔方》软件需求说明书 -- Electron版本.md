___
## 一、系统概述

基于Electron开发的跨平台桌面应用，整合番茄工作法、白噪音、任务管理和便签功能，帮助用户提升工作效率。支持Windows系统。

___
## 二、功能需求

### 1. 界面布局

- 左侧垂直导航栏（200px宽）：主页、统计、设置、帮助按钮
- 右侧内容区：根据导航显示对应模块内容$\pi$

### 2. 核心功能模块

#### （1）番茄钟模块
- 标准模式：25+5\*3 → 30长休息
- 自定义模式：可设置工作时间（1-60min）、短休（1-30min）、长休（5-60min）
- 计时器可视化：环形进度条+数字倒计时
- 打断记录：支持暂停/重启/重置番茄钟操作记录

#### （2）白噪音模块
- 12种环境音（雨声/海浪/咖啡厅等）
- 混音控制：独立音量滑块（0-100%）和开关
- 声音可视化：波形动画展示

#### （3）任务管理模块
- 时间轴视图：横向时间刻度（可缩放，一条当天时间轴，精确到分钟；一条年度时间轴，精确到天），纵向多轨道
- 任务操作：拖拽创建/调整时间范围/右键菜单（重命名/删除/完成）
- 甘特图展示：不同颜色区分任务状态

#### （4）便签模块
- Markdown编辑器：实时预览分屏模式
- 自动保存：每次输入后300ms自动保存
- 多标签管理：支持创建多个便签页

#### （5）统计模块
- 数据维度：今日/本月/全部
- 可视化展示：
    - 折线图：番茄钟数量趋势
    - 柱状图：任务完成对比
    - 热力图：专注时间段分布

#### （6）设置模块
- 通用设置：开机启动/托盘图标/更新检查
- 主题设置：深色/浅色模式+自定义主题色（HSL拾色器）
- 数据管理：导出/导入数据库

### 3. 数据存储

- SQLite数据库设计：
```sql
	-- 番茄钟表
    CREATE TABLE pomodoros (
      id INTEGER PRIMARY KEY,
      start_time DATETIME,
      duration INTEGER,
      type TEXT CHECK(type IN ('work', 'short_break', 'long_break'))
    );
    
    -- 任务表
    CREATE TABLE tasks (
      id INTEGER PRIMARY KEY,
      title TEXT,
      start_time DATETIME,
      end_time DATETIME,
      track INTEGER,
      completed BOOLEAN
    );
    
    -- 白噪音配置表
    CREATE TABLE white_noise (
      sound_id INTEGER PRIMARY KEY,
      volume REAL CHECK(volume >= 0 AND volume <= 1),
      enabled BOOLEAN
    );
```
___
## 三、技术架构设计
### 1. 技术选型

|模块|技术方案|
|---|---|
|核心框架|Electron 26.x|
|前端框架|React 18 + TypeScript|
|状态管理|Redux Toolkit + redux-persist|
|数据库|SQLite3 + TypeORM|
|图表库|ECharts 5|
|Markdown|CodeMirror 6 + markdown-it|
|音频处理|Howler.js|
|时间轴组件|Vis.js Timeline|
|构建工具|electron-forge + webpack 5|
|测试框架|Jest + Testing Library|

### 2. 关键技术点
1. **多窗口通信**：使用IPC实现主进程与渲染进程通信
2. **性能优化**：
    - Web Worker处理复杂计算（如统计数据分析）
    - 虚拟滚动优化长列表性能
3. **数据同步**：
    - 数据库操作队列确保事务顺序
    - 增量更新机制减少IO开销
4. **异常处理**：
    - 全局错误边界捕获React异常
    - 进程崩溃恢复机制

### 3. 开发规范
1. 代码风格：ESLint Airbnb规范 + Prettier
2. 提交规范：Conventional Commits
3. 文档管理：TypeDoc生成API文档
4. 国际化：i18next实现多语言支持

## 四、非功能需求

1. 性能要求：
    - 主界面加载时间 < 800ms
    - 数据库操作响应 < 50ms
2. 兼容性：
    - 支持Electron 26.x对应Chromium版本
    - 最低系统要求：Windows 10 / macOS 10.15 / Ubuntu 20.04
3. 安全性：
    - 数据库加密：SQLCipher扩展
    - 输入内容过滤：XSS防护
4. 可维护性：
    - 模块化设计（高内聚低耦合）
    - 单元测试覆盖率 > 80%

## 五、开发计划

1. 架构搭建（3天）：Electron基础配置+核心模块划分
2. 基础功能开发（2周）：番茄钟+数据库模块
3. 高级功能开发（3周）：任务管理+白噪音+统计模块
4. 测试优化（1周）：性能调优+异常测试
5. 发布准备（3天）：打包配置+自动更新


