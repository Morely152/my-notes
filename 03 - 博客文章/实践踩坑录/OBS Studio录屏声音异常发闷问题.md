___
在使用OBS进行录屏时，发现声音失真发闷现象很严重。
上网查询，得到以下原因及解决方案，建议逐个排查：
## 1.输入设备选择了蓝牙耳机，耳机使用麦克风录音导致音质变差

原贴链接：[打开 OBS Studio 后播放音乐音质差如何解决？-知乎](https://www.zhihu.com/question/340185115)
解决方案：将输入设备全部禁用，或者留一个电脑自带的麦克风阵列

![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012101411919.png)
___
## 2. 系统扬声器开启了音频增益

原贴链接：[[首发] OBS音频很闷得慌的解决办法 -哔哩哔哩](https://www.bilibili.com/opus/827471891323158578)
解决方案：关闭音频增益

![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012101411921.png)
____
## 3.开启了杜比音效

原帖链接:[为什么OBS录制视频的声音发闷 -MystCastle的博客](https://blog.lifewith.fun/zh-cn/)
解决方案：关闭杜比音效
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012101411922.png)
___
## 4.默认输入设备和通信设备不正确
看评论区有人说要把默认的输入设备和通信设备都换成麦克风阵列，不能用蓝牙耳机
解决方案：
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012101411923.png)
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012101411924.png)
在我的电脑上，进行到这一步时，声音基本与关闭OBS时一致，失真发闷问题得到解决。