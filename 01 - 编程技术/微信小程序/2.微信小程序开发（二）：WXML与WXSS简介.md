---

---
--- 
> 本篇笔记部分内容整理自网络中的一些文章及视频，详见文末的“参考资料”部分。
--- 
# 一、WXML篇

WXML全称`WeiXin Markup Language`（微信标记语言），这是微信框架提供的一套标签语言。

我们在写HTML页面时，总是习惯使用`div`进行整体布局，使用`span`描述文本信息，使用`img`装载图片等等，但在WXML中会有一些差异。类似于vue，WXML提供的每个标签都是一个组件。

## ● “组件”的概念

在编写代码时，通常将具有相同功能的代码写在一起，以提高代码复用性，如：
```css
.nav {
	display: flex;
	justify-content: space-around;
	background-color: blue;
}
```
上述代码用于定义一个样式集，用于控制所有`nav`类的标签。

如果要很多地方都具有相同的内容（如导航栏、注册弹窗、每篇文章下的评论区），在每个地方都写一遍HTML+CSS+JavaScript会增加很多编码工作量，bug出现的可能性也会增加不少；需要修改这些组件时还需要到每一个组件的定义处修改，非常麻烦。

换一个角度思考，将这些通用的HTML、CSS、JavaScript代码封装成一个**组件**进行独立管理，如同定义好的函数一样，就可以在多个页面的多个地方使用这些组件。需要修改组件内容时，只需修改一次组件的定义即可，使用组件的地方会跟着更新。

要实现这个组件我们都得先定义好组件模板（HTML，决定组件结构），组件默认样式（CSS，决定组件外观），组件功能（JS，决定组件负责做哪些事）。在小程序框架中，官方已经提前帮我们实现了大量的组件，常见的有以下几种：

|   视图组件    |   用途   | 等价HTML标签 |
| :-------: | :----: | :------: |
| `<view>`  |  容器布局  | `<div>`  |
| `<text>`  | 装载多行文本 | `<span>` |
| `<image>` |  装载图片  | `<img>`  |

值得高兴的是，官方为这些组件提供了很多便捷的属性，如：

假设我们希望图片加载完成后获取图片的宽度，这里就可以利用`image`的`bindload`（图片加载完成后触发）属性：
```html
<view>
	<image bindload='imgLoad' src='···'></image>
</view>
```

```js
const app = getApp()

Page({
  //图片加载完成后执行的方法
  imgLoad(image) {
    console.log(image.detail.width);
  }
})
```

可以看到，图片加载完毕后，控制台输出了图片的宽度。此操作也可用于实现图片的懒加载等逻辑。

微信官方文档中的各种组件介绍： https://developers.weixin.qq.com/miniprogram/dev/component/
也有一些优秀的开源组件库，如 **Vant Weapp**： https://vant-ui.github.io/vant-weapp/#/home

# 二、WXSS篇

WXSS基本上兼容CSS的写法，选择器定义、属性以及对应的取值没有很大的变化，若有CSS基础可以快速上手。需要注意的是，手机上几乎不会出现“鼠标悬浮”的操作，因此在WXSS中无法使用`:hover`伪类选择器。

## 1.新单位rpx

微信小程序新增了一个单位`rpx`，定义如下：

> rpx（responsive pixel，响应式像素）: 可以根据屏幕宽度进行自适应。规定屏幕宽为750rpx。如在 iPhone6 上，屏幕宽度为375px，共有750个物理像素，则750rpx = 375px = 750物理像素，1rpx = 0.5px = 1物理像素。

官方推荐开发微信小程序时用 **iPhone6** 作为视觉稿的标准，在这样尺寸的屏幕上1rpx = 2px，是比较好算的整数倍关系。

## 2.WXSS的样式关联

在小程序中，同一个文件夹中的wxss文件中的样式会自动关联到wxml中，而根目录下`app.wxss`定义的是全局样式，会应用到所有的WXML文件上。

如果想让WXML链接其他文件夹下的wxss样式，需要在此WXML同文件夹的WXSS文件中使用`@import`导入外联样式，如：

pages文件夹下有index.wxml和index.wxss，需要链接styles文件夹下的default.wxss文件，此时需要在index.wxss中加上：

```css
@import "../styles/default.wxss"
```

此时，default.wxss中的样式就会应用到index.wxml上了。


--- 
# 参考资料

[^1]: 听风是风.从零开始的微信小程序入门教程(二)\[EB/OL].(2020-04-16)\[2025-07-29]. https://www.cnblogs.com/echolun/p/12709761.html