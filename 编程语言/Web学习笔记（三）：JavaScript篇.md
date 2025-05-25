---

---
--- 
> 声明：本篇笔记部分摘自[《Web前端技术 - 航空工业出版社》](https://www.wenjingketang.com/bookinfo?book_id=9310)，遵循[CC BY 4.0协议](https://creativecommons.org/licenses/by/4.0/legalcode.zh-hans)。
> 存在由AI生成的小部分内容，仅供参考，请仔细甄别可能存在的错误。
___
# 一、JavaScript概述

> JavaScript 是一种高级、解释型编程语言，主要用于网页开发。它运行在浏览器中，能动态操作网页内容（如DOM）、处理用户交互、发送网络请求等。特点包括：
>
> - **动态性**：无需编译，代码可直接运行。
> - **面向对象**：支持基于原型的继承。
> - **事件驱动**：通过事件监听响应用户操作。
> - **跨平台**：几乎所有浏览器都支持。
>
>常与HTML、CSS结合使用，现代框架如React、Vue使其功能更强大。Node.js扩展了其用途，可用于服务器端开发。

# 二、基本语法

## 1.标识符

- 指开发者自定义的变量名、函数名、属性等名称。
- JavaScript中的标识符命名规则：
	- 由字母、下划线`_`、美元符号`$`和数字组成；
	- 不允许以数字开头；
	- 不允许使用关键字和保留字定义标识符（如`char`）。
- 标识符的常用格式
	- 全大写命名法：`REDBAG`（常用于常量命名）
	- 驼峰命名法：`redBag`（常用于函数命名）
	- 帕斯卡命名法：`RedBag`（常用于类名和构造器命名）
	- 下划线命名法：`red_bag`（常用于变量命名）
## 2.关键字和保留字

- 关键字，指JavaScript预先定义好的单词，被赋予了一定的意义。
	- 常见关键字：`break`、`case`、`catch`、`continue`、`debugger`、`default`、`delete`、`do`、`else`、`finally`、`for`、`funciton`、`if`、`in`、`instanceof`、`new`、`return`、`switch`、`this`、`throw`、`try`、`typeof`、`var`、`void`、`while`、`with`。
- 保留字，指将来可能使用的关键字，是为js发展空间预留的一些单词。
	- 常见保留字：`abstract`、`boolean`、`byte`、`char`、`class`、`const`、`double`、`enum`、`export`、`extends`、`final`、`float`、`goto`、`implements`、`import`、`int`、`interface`、`long`、`native`、`package`、`private`、`protected`、`public`、`short`、`static`、`super`、`synchronized`、`throws`、`transient`、`volatile`。

## 3.变量的声明与赋值

- 与Python类似，JavaScript是一种**弱类型语言**；与C/C++不同，在声明变量时无需确定变量的数据类型，也可以给变量赋予不同类型的数据，JavaScript 会根据上下文自动进行类型转换。[^1]
```js
// 定义变量
var a = 1;
// 更改变量数据类型
a = "小明";
```

## 4.输出方式(常用)
### ① 页面输出
```js
document.write("<div>输出的内容</div>");
```
![](20250520081716000.png)
- 直接将**元素**加载到页面上（加载的不是文字，而是一个**标签**）
### ② 控制台输出
```js
console.log("输出的内容");
```
![](20250520082256298.png)
- 在控制台输出内容，多用于打印相关变量的值，进行调试。
### ③ 弹窗输出
#### 普通弹窗(适用于通知)
```js
alert("输出的内容");
```
![](20250523100337688.png)
- 多用于触发相关事件时，弹出相应的警告信息(如关闭标签时询问是否保存)。
#### 选择弹窗(多用于询问)
```js
var is_confirmed = confirm("提示信息");
```
![](20250520083211096.png)
- 需要确认某项操作，而不仅是通知用户时，使用次方法弹出一个包含"确定"与"取消"按钮的弹窗。
	- 用户点击其中某个选项时，会返回`true`(确定)或`false`(取消)。
#### 输入弹窗(多用于获取信息)
```js
var input_info = prompt("提示信息");
```
![](20250520083410880.png)
- 用于提示用户输入一些信息，返回值为输入的内容。

## 5.在字符串中嵌入变量
### ① 模版字符串([ES6](https://www.bookstack.cn/read/es6-3rd/docs-intro.md)推荐使用)
```js
const name = 'Alice';
const age = 25;

const message = `My name is ${name} and I'm ${age} years old.`;
console.log(message); 
// 输出: My name is Alice and I'm 25 years old.
```
### ② 字符串拼接(传统方式)
```js
const name = 'Charlie';
const age = 35;

const message = 'My name is '.concat(name, ' and I\'m ', age, ' years old.'); // 可也以用“+”进行连接
console.log(message);
// 输出: My name is Charlie and I'm 35 years old.
```
其中，**模版字符串**具有以下优点，一般是最佳的方案：
- 更简洁易读
- 支持多行字符串
- 可以直接嵌入表达式 `${expression}`
- 自动处理类型转换
## 6.JavaScript注释
js中的注释方式与C/C++类似,使用下面两种格式进行注释：
```js
// 这是单行注释

/*
多行注释的第一行
多行注释的第二行
*/
```
# 三、JavaScript的引入与连接
## 1.行内式
```html
<!-- 单击按钮出现提示框 -->
<button onclick="alert('清除缓存成功！')">清除浏览器缓存</button>

<!-- 单击标签出现提示框 -->
<a href="javascript: alert('弹窗内容')">点击这里显示弹窗</a>
```
- 将js代码作为HTML标签的属性值使用。
## 2.内嵌式
```html
<script>
	<!-- 这里写JavaScript代码 -->
</script>
```
## 3.外链式
```html
<script src="js文件路径" [async | defer]></script>
```
- 一般将外链js的标签写在`<body>`的末尾，方便浏览器优先加载网页内容，提高响应速度。
- async属性(可选)表示**异步下载同步执行**,即下载js文件时不阻塞HTML的解析和显示，js文件下载后立即执行。
- defer属性(可选)表示异步下载异步执行，即即下载js文件时不阻塞HTML的解析和显示，等HTML解析渲染完成后再执行文件。
# 四、变量与数据类型
## 1.变量的声明与赋值
- 与Python类似，JavaScript是一种**弱类型语言**；与C/C++不同，在声明变量时无需确定变量的数据类型，也可以给变量赋予不同类型的数据，JavaScript 会根据上下文自动进行类型转换。[^1]
```js
// 定义变量
var a = 1;
// 更改变量数据类型
a = "小明";

// 声明一个常量
const PI = 3.1415926;
```
- ES6以前，声明变量时多用`var`关键字，格式为`var 变量名;`
- ES6以后，增加了`let`关键字用于声明便联合，语法格式同样为`let 变量名;`
- 声明常量使用`const`关键字；常量一般用全大写命名，在程序运行中的值不变化。
- 使用`var`与`let`的区别：
	- `let`支持块作用域(循环体、函数体等)，`var`不支持。
	- 在同一个作用域中，`var`关键字可以重复声明一个变量，而`let`不可以。
## 什么是ES6：

> “ES6（ECMAScript）是由Ecma国际（前身为欧洲计算机制造商协会）通过ECMA-262标
> 准化的脚本程序设计语言。JavaScript和Jscript语言可以理解为ECMAScript的实现和扩
> 展。完整的 JavaScript由三部分组成，分别是ECMAScript、DOM、BOM。2015年6月，
> ECMAScript 6发布了正式版本。" ——《Web前端技术》P207
## 2.变量的作用域
- 全局变量：在所有函数之外声明的变量。
- 局部变量：在函数体重声明的变量，或者函数的形参。
- 块级变量：在代码块(循环体、if分支)中声明的变量，只在对应的块中有效。
## 3.数据类型
### ① Undefined类型：未定义
- 是JavaScript特有的数据类型，仅有`Undefined`一种取值，表示未定义的值。
- 定义一个变量但未赋值时，变量的值就是`undefined`。
### ② Null类型：空
- 也是JavaScript中特有的数据类型，仅有`null`一种取值，是一个空的对象指针。
- 与`Undefined`类型相似，`null == undefined`。
- 不同之处在于，`null`表示变量(或对象)不存在或无效，`undefined`表示变量没有被赋值。
### ③ Boolean类型：布尔值
- 有两个取值，`true`（真）与`false`（假）。
- 使用`Boolean()`方法，可将`undefined`类型与`Null`类型的数据转换成`false`。
### ④ Number类型：数值
- JavaScript中，数值不分整数与小数，所有的数值都属于`Number`类型。
```js
var a = 10, b = -10;
var c = 9.85, d = 2.12E5; // d的值为2.12 * 100000
var e = 026, f = 0x34;    // 分别为8进制(以0开头)与16进制(以0x开头)
```
- 使用`Number()`方法将其他类型的值转换成数值类型，转换规则如下表：

| 类型        | Number()的值 |
| --------- | ---------- |
| Undefined | NaN        |
| Null      | 0          |
| true      | 1          |
| false     | 0          |

- `NaN`的全称为"not a numble"，表示非数字，但本身属`Number`类型。
- 在JavaScript中，将一个数除以0不会报错，而是得到一个`NaN`的值。
- 对`NaN`进行任何计算操作，结果都是`NaN`。`NaN`不等于任何值，包括它本身。
	- 因此，判断一个值是否非数字时，不应使用`if (a == NaN)`，而是使用`isNaN(a)`方法。
- 此外，在大数据方向，经常使用`Number(Null) = 0`的特性来将空值化0。
### ⑤ String类型：字符串
- 是由多个Unicode字符组成的**字符序列**，可由一对单引号（''）或双引号（""），但是需要正确配对。
- 常用转义字符见下表：

| 字符   | 含义  | 字符   | 含义     | 字符   | 含义    |
| ---- | --- | ---- | ------ | ---- | ----- |
| `\'` | 单引号 | `\b` | 退格     | `\r` | 回车    |
| `\"` | 双引号 | `\\` | 反斜杠    | `\f` | 换页    |
| `\n` | 换行  | `\t` | Tab制表符 | `\e` | Esc字符 |

- 使用`String()`方法将其他类型的值转换成字符串类型的值，转换规则如下表：

| 类型        | String()的值  |
| --------- | ----------- |
| Undefined | 'undefined' |
| Null      | 'null'      |
| true      | 'true'      |
| false     | 'false'     |
# 五、运算符
## 1.算数运算符与逻辑运算符
- 与C/C++类似，JavaScript中同样有`+、-、*、/、%、++、--、+=、=`等算数运算符与赋值运算符，且用法相同，此处省略。
## 2.比较运算符
- `<、>、<=、>=`的用法与C/C++相同。
- 与C/C++不同的是，JavaSCript中除了使用`==、!=`进行比较，还支持`===、!===`的比较运算符。
	- 前者在比较时会进行**隐式类型转换**，即将两者转换成相同的数据类型后再进行数值的比较。
	- 后者不会进行隐式类型转换，且在比较数值以外，还会比较二者的数据类型是否相同。
## 3.条件运算符
```js
max = a > b ? a : b;
// 变量 = 表达式 ？ 为真时的返回值 ： 为假时的返回值；
```
- 即C语言中的**问号表达式**，用法相同。
## 4.逻辑运算符
- 分别用`&&`、`||`与`!`表示逻辑与、逻辑或和逻辑非。
# 六、流程控制语句
JavaScript的流程控制语句语法与C/C++基本相同，此处只给出语法实例。
## 1.选择语句
### ① if语句
```js
if (条件1) {
	操作1
} else if (条件2) {
	操作2
} else {
	操作3
}
```
### ② switch语句
```js
switch (变量) {
	case 取值1:
		操作1
		break;
	case 取值2:
		操作2
		break;
	default:
		操作3
		break;
}
```
- 注意：
## 2.循环语句
## 3.跳转语句

# 七、函数
# 八、对象
# 九、数组
# 十、DOM
# 十一、BOM
# 十二、事件
--- 
# 参考资料
[^1]: 王铁柱6.为什么说js是弱类型语言，它的优缺点分别是什么？\[EB/OL].(2024-11-28)\[2025-05-13]. https://www.cnblogs.com/ai888/p/18573400.