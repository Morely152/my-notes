--- 
# 一、问题概述：

在WPF项目中新建了文件Settings.json，用于保存开机自启动的设置记录，并将其属性设置为“内容--始终复制”以将JSON文件添加到项目文件夹中。
``` json
{
    "AutoStartEnabled": false
}
```
定义了下面的方法来载入设置的内容：
``` C#
        public static void LoadSettings()
        {
            if (File.Exists(SettingsFilePath))
            {
                string json = File.ReadAllText(SettingsFilePath);
                dynamic settings = JsonConvert.DeserializeObject(json);
                AutoStartEnabled = settings.AutoStartEnabled;
            }
            else
            {
                // 如果文件不存在，初始化默认设置
                AutoStartEnabled = false;
            }   
        }
```
- 运行程序，发现每次启动时，通过UI反馈的记录均为False，即使手动修改为True也会在运行的一瞬间变成False。
___
# 二、寻找原因：

- 手动修改为True扔不起效，可排除保存记录异常的情况。
- 怀疑是UI控件初始属性为False导致，查找之后未发现异常。
- 通过断点追踪，发现在程序读取JSON文件内容之前就已经变成了false。
- 又怀疑是程序在初始化时触发了按钮的取消选中事件，但未触发断点，可以排除。
- 这时突然想起“内容--始终复制”的属性，问题原因终于找到了。
___
# 三、问题复现

- 选中按钮后，修改JSON中"AutoStartEnabled"的值为True。
- 再次启动程序时，“始终复制”的属性使得开发环境中的Settings.json复制到编译后的程序所在的文件夹，将修改了的Json文件覆盖，造成属性异常变成False的假象。
___
# 四、解决问题

- 直接从源头解决问题，将开发环境中的json文件删除，杜绝文件被覆盖的可能性。
- 经过测试，现有方法支持在未找到json文件时创建文件，因此不需添加新建Json文件的程序。
___
# 五、回顾反思

- 通过测试发现，直接从文件夹启动编译后的程序不会出现覆盖的问题，证实了前面的分析。
- 能被这种小问题困扰如此之久，反映出自己对开发工具的不熟悉和思维深度的不足，也提示自己要通过积极寻找问题来积累自己的经验。