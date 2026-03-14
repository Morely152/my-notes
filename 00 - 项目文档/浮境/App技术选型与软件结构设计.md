## 1. 整体架构设计

系统采用 **“端-云-模”** 三位一体架构，确保前端交互的丝滑感与后端逻辑的严密性。

---
## 2. 技术选型一览表

### 2.1 客户端 (Mobile App)

- **开发框架**：**Flutter 3.x**（利用 Dart FFI 处理高性能音频混音）。
- **音频引擎**：**Just_Audio + Audio_Service**（支持多实例播放与后台保活）。
- **状态管理**：**Riverpod** 或 **Provider**（处理异步流式数据，如 AI 生成进度）。
- **本地存储**：**Isar Database**（高性能 NoSQL，用于缓存故事文本和播放历史）。

### 2.2 后端服务 (Backend)

- **逻辑框架**：**FastAPI**（基于 Python 异步协程，完美适配 GLM-4 并发调用）。
- **数据库**：**PostgreSQL 16**（核心账务与元数据存储）。
- **缓存与队列**：**Redis**（用于存储流式 TTS 片段和接口防刷限流）。
- **容器化**：**Docker + K8s**（保障系统弹性扩展）。

### 2.3 外部集成 (Third-party Services)

- **大模型**：**GLM-4.7 API**（负责高逻辑性助眠故事创作）。
- **语音合成**：**阿里云智能语音交互 (TTS)**（流式输出，选择治愈系音色）。
- **内容审核**：**阿里云内容安全 (Moderation)**（文本/音频违规扫描）。
- **验证与安全**：**阿里云短信服务 (SMS)** + **号码认证服务**。

---

## 3. 详细模块设计

### 3.1 双轨播放器模块 (Dual-Track Audio)

这是 App 的技术核心，通过两个独立的播放线程实现“氛围”与“故事”的无缝混音。

- **Player A (氛围音实例)**：
    
    - **资源处理**：本地循环（Looping）播放 OGG/MP3 格式。
    - **交互逻辑**：由“入眠遥控器”左栏控制。
        
- **Player B (故事语音实例)**：
    
    - **资源处理**：通过 HLS 或流式音频流播放。
    - **交互逻辑**：由“入眠遥控器”右栏控制，支持进度拖动。
        
- **淡入淡出组件**：封装一个 `VolumeController` 类，在定时关闭触发时，通过 `AnimationController` 在 10s 内线性降低 `Volume` 值。
    
### 3.2 AI 故事生成流水线 (Story Pipeline)

由于故事生成较长，采用**异步流式**处理逻辑：

1. **用户发起请求**：客户端通过 WebSocket 或长轮询连接后端。
2. **大模型推理**：后端向 GLM-4.7 发送 Prompt，开启流式输出。
3. **安全前置**：生成的文本片段即时送入**阿里云内容安全接口**。
4. **TTS 转换**：审核通过的文本即时送入**阿里云 TTS** 转换为音频流。
5. **前端呈现**：用户边看生成的文本，边听合成的语音。

### 3.3 账务与积分安全模块 (Financial Security)

针对积分充值与消耗，PostgreSQL 侧的设计如下：

- **分布式锁**：使用 Redis 分布式锁确保同一用户不会并发执行多次扣费请求。
- **事务保障**：

```sql
BEGIN;
-- 1. 验证并扣除积分
UPDATE user_accounts SET credits = credits - 10 WHERE user_id = 'xxx' AND credits >= 10;
-- 2. 写入消耗日志
INSERT INTO credit_logs (user_id, action, amount) VALUES ('xxx', 'generate_story', -10);
COMMIT; -- 如果第一步失败（余额不足），事务自动终止
```

- **余额审计**：每日定时运行 `CheckBalance` 脚本，核对（充值总额 - 消耗总额 == 当前余额）。
---
## 4. 软件结构/代码分层设计

### 4.1 后端分层 (FastAPI Project Structure)

```
app/
├── api/              # 路由入口 (v1/auth, v1/story, v1/payment)
├── services/         # 业务核心 (GLM调用逻辑, TTS处理, 积分对账)
├── models/           # PostgreSQL 模型定义
├── schemas/          # Pydantic 响应数据模型
├── core/             # 配置文件与阿里云 SDK 初始化
└── main.py           # 程序入口
```

### 4.2 前端分层 (Flutter Project Structure)

```
lib/
├── core/             # 公用组件, 主题颜色 (深暖色调定义)
├── providers/        # 状态管理 (双播放器状态, 积分状态)
├── views/            # 页面 (氛围页, 故事页, 遥控器页)
├── widgets/          # 自定义 UI (呼吸感动画卡片, 独立音量滑块)
└── services/         # API 客户端与本地数据库操作
```

---

## 5. UI/UX 技术规范实现

- **色调管理**：定义 `AppColors.darkBackground` (#121212) 和 `AppColors.warmAmber` (#FFBF00)。
- **动画规范**：全屏转场统一使用 `CupertinoPageRoute` 的淡入效果。
- **低蓝光处理**：前端全局覆盖一个极低透明度的“琥珀色滤镜（ColorFilter）”，可在设置中开启。

---

## 6. 后台管理模块 (Web端)

- **技术栈**：**Vue3 + Element Plus**。
- **核心功能**：
    - **流量看板**：Token 实时消耗曲线。
    - **人工审核抽检**：对广场公开内容进行“一键下架”操作。
    - **异常警报**：对对账不平、接口报错率过高等情况通过邮件/钉钉预警。