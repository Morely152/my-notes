---

---
--- 

# 一、问题背景

在使用Android Studio进行手机app开发时，使用有线USB调试比较麻烦，打算使用无线调试，扫码配对时报错：
![](20260127124051872.png)

于是改用命令行，通过adb连接，同样连接失败：

```shell
C:\Users\Hc>adb pair [手机ip地址]:[配对端口]
Enter pairing code: [手机WLAN配对码]
error: protocol fault (could not read status message): No error
```

改用[知乎大佬的方案](https://zhuanlan.zhihu.com/p/645083186)，插线之后进行配对再发起连接，仍然报错：

``` shell
C:\Users\Hc>adb devices
List of devices attached
[手机设备id]        device


C:\Users\Hc>adb tcpip 36900     # 这里随便指定一个空闲端口
restarting in TCP mode port: 36900

C:\Users\Hc>adb devices
List of devices attached
f6d175f7        device


C:\Users\Hc>adb connect [手机ip地址]:36900
cannot connect to [手机ip地址]:36900: 由于连接方在一段时间后没有正确答复或连接的主机没有反应，连接尝试失败。 (10060)
```

# 二、解决方案

在Gemini的建议下，直接ping手机ip，发现不通:

```shell
C:\Users\Hc>ping [手机ip地址]

正在 Ping [手机ip地址] 具有 32 字节的数据:
来自 [PC的ip地址] 的回复: 无法访问目标主机。
来自 [PC的ip地址] 的回复: 无法访问目标主机。
来自 [PC的ip地址] 的回复: 无法访问目标主机。
来自 [PC的ip地址] 的回复: 无法访问目标主机。

[手机ip地址] 的 Ping 统计信息:
    数据包: 已发送 = 4，已接收 = 4，丢失 = 0 (0% 丢失)，
```

**Gemini**的分析如下：

既然 `ping` 结果显示 **“无法访问目标主机”**，这说明问题不在 ADB 软件本身，而是你的**电脑和手机在网络层面上根本不通**。
虽然你可能觉得它们连的是同一个 Wi-Fi，但以下几个原因会导致这种“近在咫尺却无法通讯”的情况：

1. 确认手机 IP 是否发生了变动：手机的 IP 地址是动态分配的，可能在你操作的过程中已经变成了其他数字。
	- **检查方法：** 进入手机 `设置 -> 关于手机 -> 状态信息` 或 `Wi-Fi 设置 -> 详情`，确认当前的 IP 是否还是之前的IP。
2. 检查局域网“隔离” (最核心原因)：如果 IP 没错但 Ping 不通，通常是路由器设置了拦截：
	- **防火墙策略：** 检查你的电脑是否将当前 Wi-Fi 识别为“**公共网络**”而不是“**专用网络**”。公共网络模式下，Windows 会禁止局域网内的其他设备发现你的电脑。
	- **AP 隔离 (Access Point Isolation)：** 许多路由器（尤其是公共 Wi-Fi、酒店 Wi-Fi 或开启了“访客网络”）会开启此功能，它允许设备上网，但禁止设备之间互相发现。
## 第0步：直接使用PC热点

如果是PC笔记本电脑或其他配置了无线网卡的计算机，直接用手机连接计算机的热点即可绕过路由器，从而解决AP隔离的问题。

## 第1步：将电脑WLAN切换为专用网络

![](20260127125312768.png)

再次ping手机热点，如果能通就解决问题，不通则进行下一步：

## 第2步：关闭路由器的AP隔离

登录路由器管理端，ip一般为`192.168.1.1`、`192.168.3.1`等，关闭AP隔离之后问题得到解决。

--- 
# 三、问题解决

由于我的PC上有无线网卡，直接使用手机连接PC热点后，成功建立了连接，命令行和Android Studio均可以看到设备：

```shell
C:\Users\Hc>adb pair [手机ip地址]:[配对端口]
Enter pairing code: [手机配对码]
Successfully paired to [手机ip地址]:[配对端口] [guid=adb-f6d175f7-F9pzOH]

C:\Users\Hc>adb connect [手机ip地址]:[连接端口]
connected to [手机ip地址]:[连接端口]

# 可以成功看到设备
C:\Users\Hc>adb devices
List of devices attached
[手机ip地址]:[连接端口]   device
```

![](20260127131518603.png)