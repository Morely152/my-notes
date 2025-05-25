___
## 一、系统概述

基于WPF开发的跨平台桌面应用，整合番茄工作法、白噪音、任务管理和便签功能，帮助用户提升工作效率。支持Windows系统。
## 二、功能需求

### 1. 界面布局

- 左侧垂直导航栏：主页、任务、统计、设置、帮助按钮，点击后跳转到对应的页面
- 右侧内容区：根据导航显示对应页面内容

### 2. 核心功能模块

#### （1）番茄钟模块
- 标准模式：25分钟工作 - 5分钟休息循环
- 自定义模式：可设置工作时间（1-150min）、休息时间（1-60min）
- 计时器可视化：环形进度条+数字倒计时
- 打断记录：支持暂停/重启番茄钟操作

#### （2）白噪音模块(NAudio库实现)
- 12种环境音（雨声/海浪/咖啡店等）
- 混音控制：独立音量滑块（0-100%）和开关

#### （3）任务管理模块(甘特图实现)
- 时间轴视图：横向时间刻度（可选择年、月、日三个刻度），纵向多轨道任务表
- 任务操作：可对任务进行添加、重命名、删除、修改等操作

#### （4）便签模块
- 支持用户输入中英文字符、常见标点符号
- 支持Enter键换行、Tab键缩进

#### （5）统计模块
- 数据维度：今日/本月/全部
- 可视化展示：
    - 折线图：番茄钟数量趋势
    - 热力图：专注时间段分布
- 需要实现较为美观的周报总结，最好能实现基于AI大模型的个性化分析和建议

#### （6）设置模块
- 通用设置：开机启动/托盘图标/更新检查
- 主题设置：深色/浅色模式+自定义主题色(资源字典)
- 数据管理：导出/导入数据库

### 3. 数据存储
- 要求对用户的番茄钟记录、便签内容、任务数据等进行持久化保存，并且支持数据导出和迁移

## 三、性能要求
### 1. 响应速度

- **界面切换响应时间**：<300ms
- **番茄钟启动/暂停响应时间**：<100ms
- **白噪音播放延迟**：<50ms
- **任务操作响应时间**：添加/修改/删除任务 <200ms
- **统计图表渲染时间**：<500ms（数据量<10万条时）

### 2. 内存占用

- **基础内存占用**：<150MB（空载状态）
- **峰值内存限制**：
    - 白噪音播放时：<250MB
    - 甘特图加载大型项目时：<350MB
    - 长期运行24小时内存增长：<50MB

### 3. CPU占用率

- **空闲状态**：<1%
- **番茄钟运行期间**：<3%
- **白噪音播放期间**：<5%（混音最多3个音源时）

### 4. 存储性能

- **数据库操作响应**：
    - 插入单条记录：<10ms
    - 查询100条记录：<50ms
- **数据导出速度**：1MB/s（JSON格式）
- **数据导入速度**：0.5MB/s（含数据校验）







# <font color="#ff0000">(以下内容为临时数据，不要写入文档)</font>

---
- SQLite数据库设计：
```sql	
	-- 番茄钟记录表 
	 CREATE TABLE TomatoRecords (
		Id INTEGER PRIMARY KEY AUTOINCREMENT,
		UserId INTEGER NOT NULL,
		StartTime DATETIME NOT NULL,
		EndTime DATETIME,
		IsCompleted BOOLEAN NOT NULL,
		Type TEXT NOT NULL,
		Note TEXT
	);
    
    -- 白噪音配置表
	CREATE TABLE NoiseSets (
		SetName TEXT PRIMARY KEY,
		PlayStates TEXT NOT NULL CHECK(length(PlayStates) = 12),
		Volumes TEXT NOT NULL CHECK(length(Volumes) = 36)
	);
	
	-- 任务管理配置表
	CREATE TABLE TaskConfig (
	  Id INTEGER PRIMARY KEY AUTOINCREMENT, -- 配置ID
	  Container_id INTEGER NOT NULL,       -- 容器ID（1, 2, 3）
	  TaskType TEXT NOT NULL CHECK(task_type IN ('void','timedCheckIn','checkIn', 'dayCount')), -- 任务类型(打卡器/计日器)
	  RuleId INTEGER,                     -- 关联的打卡规则ID（如果是打卡器）
	  DayCountId INTEGER,                 -- 关联的计日器ID（如果是计日器）
	  FOREIGN KEY (RuleId) REFERENCES CheckInRules(id), -- 外键关联打卡规则表
	  FOREIGN KEY (DayCountId) REFERENCES DayCounts(id) -- 外键关联计日表
	);
	
	-- 打卡规则表
	CREATE TABLE CheckInRules (
	  Id INTEGER PRIMARY KEY NOT NULL, -- 规则ID
	  Title TEXT NOT NULL,                  -- 打卡标题
	  EarliestTime TIME NOT NULL,          -- 每天最早打卡时间
	  LatestTime TIME NOT NULL,            -- 每天最晚打卡时间
	  SkipWeekends BOOLEAN，               -- 是否跳过周末       
	  CheckInFreq INTEGER NOT NULL        -- 打卡次数
	);
	
	-- 打卡记录表
	CREATE TABLE CheckInRecords (
	  Id INTEGER PRIMARY KEY AUTOINCREMENT, -- 记录ID
	  UserId INTEGER NOT NULL,              -- 用户ID
	  RuleId INTEGER NOT NULL,              -- 关联的规则ID
	  CheckInTime DATETIME NOT NULL,        -- 打卡时间
	  FOREIGN KEY (RuleId) REFERENCES CheckInRules(id) -- 外键关联规则表
	);
	
	-- 正计日/倒计日表
	CREATE TABLE DayCounts (
	  Id INTEGER PRIMARY KEY, -- 计日器ID
	  Title TEXT NOT NULL,    -- 计日标题
	  TargetDate DATE         -- 目标日期
	);
	
	-- 任务记录表
	CREATE TABLE TaskRecords (
	    Id INTEGER PRIMARY KEY AUTOINCREMENT,
	    Name TEXT NOT NULL,
	    StartTime TEXT NOT NULL,  -- 存储为ISO8601格式的字符串 (YYYY-MM-DD HH:MM)
	    EndTime TEXT NOT NULL,    -- 存储为ISO8601格式的字符串 (YYYY-MM-DD HH:MM)
	    TaskProgress REAL DEFAULT 0 CHECK(TaskProgress >= 0 AND TaskProgress <= 100),
	    Status TEXT DEFAULT '普通' CHECK(Status IN ('宽松', '普通', '紧急')),
	);
```

- 数据库表结构关系图
![](20250514185608308.png)
___



# 软件特色

1. **软件功能齐全，集成常用服务**
	- 配置番茄钟+任务管理两大辅助工具，从时间和任务两个维度进行高效管理。
	- 提供白噪音虚拟环境，有利于减少环境干扰，保持专注并高效地完成任务。
2. **界面简约美观，风格统一协调**
	- 采用统一规范的配色和字体，使UI界面整洁有序。
	- 使用圆角+阴影样式的卡片式布局 ，层次感鲜明。
3. **操作便捷高效，利于专注效率**
	- 软件设计时尽量不使用弹窗，减少手动关闭负担。
	- 主页面信息简明扼要，将详细信息隐藏在次要页面中，便于用户纵览全局。
	- 设置页面相关项目直接提供了辅助说明，无需在说明文档中查询，方便用户进行操作。
4. **任务列表管理高效，待办工作一目了然**
	- 采用垂直化列表的方式进行任务管理，时间剩余+任务进度双维度把控。
	- 任务内容同步到首页，时刻提醒防止遗忘。
1. **数据分析简洁明了， AI总结高效直白**
- 使用热力图、折线图和饼图进行专注数据反馈，内容直白明了。
- 接入腾讯混元大模型进行分析和总结，提供有价值的建议和鼓励。
1. **软件轻便易用，快速响应操作**
-  使用轻量级的SQLite数据库存储数据，能够实现快速地完成数据的读取和写入，同时相较于MySQL、Postgres等大型数据库占用的存储空间更小。
- 软件配备了详细的说明文档和相关信息，能够帮助用户快速了解软件的主要功能和常见问题的解决方案。