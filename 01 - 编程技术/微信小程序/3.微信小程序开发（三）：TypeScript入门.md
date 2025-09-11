---

---
--- 
> 本篇笔记部分内容整理自网络中的一些文章及视频，详见文末的“参考资料”部分。存在部分AI生成的内容，请仔细甄别可能存在的错误。
---  
# 一、TypeScript简介

> TS（TypeScript）是由微软开发的一种开源编程语言，它是 JavaScript 的一个超集，主要特点是在JavaScript的基础上添加了静态类型系统。TS适合中大型项目或对代码质量要求较高的场景，它通过类型系统提升了代码的健壮性和可维护性，同时保留了JavaScript的灵活性和生态优势。

使用TypeScript进行开发具有以下优势：
1. **静态类型检查**
    - 在编译阶段就能发现类型相关的错误，减少运行时错误。
    - 增强代码的可靠性和可维护性，尤其在大型项目中优势明显。
2. **代码可读性与可维护性**
    - 类型注解让代码更清晰，便于团队协作和后续维护。
    - 编辑器能提供更智能的自动补全、类型提示等功能。
3. **更好的重构支持**
    - 类型系统帮助开发者更安全地进行代码重构，降低出错概率。
4. **渐进式采用**
    - 可以逐步将 JavaScript 代码迁移到 TypeScript，无需一次性重写。
5. **丰富的生态系统**
    - 与主流框架（如 React、Vue 等）和工具（如 Webpack、VS Code 等）良好集成。
    - 拥有庞大的社区支持和大量的学习资源。

TypeScript官方文档： https://www.tslang.cn/docs/handbook/basic-types.html
# 二、TypeScript基本数据类型

只需在声明变量时，添加上`:数据类型`即可定义变量的数据类型。常用的基本数据类型如下：

## 1.字符串:string

使用单引号'或双引号"声明。

```ts
let name: string = "小明";
```

## 2.数字:number

支持二进制、八进制、十进制、十六进制。

```ts
let decLiteral: number = 100;
let hexLiteral: number = 0xf00d; 
let binaryLiteral: number = 0b1010; 
let octalLiteral: number = 0o744;
```

模版字符串：使用反引号\`定义，支持在字符串中使用`${}`嵌入表达式或实现多行文本。

```ts
let info: string = `姓名：${user.name} 年龄：${user.age}`;
let description: string = `
	1. the first line of the multiline text,
	2. the second line of the multiline text,
	3. the last line of the multiline text.`;
```

使用`+`可以连接两个不同类型的数据，如：

```ts
let info: string = "我叫" + user.name + "，我今年" + user.age + "岁。";
```
## 3.布尔:boolean

取值只能是true或者false。

```ts
let is_done: boolean = true;
```

## 4.undefined类型

只能取值undefined

```ts
let ud:undefined = undefined;
```

## 5.null类型

```ts
let n:null = null;
```

## 6.空类型:void

表示没有任何类型(相当于null)，用于指定函数无返回值。

```ts
function say_hello(): void{};
```

## 7.未知类型:unknown

接收用户输入或API返回内容时，变量的类型往往是未知的，此时可以使用unknown类型的变量，指定编译器以任意的数据类型接收这些内容。

```ts
let notSure: unknown = 4;

notSure = "或许是一个字符串";
notSure = false;
```

如果有一个 `unknwon` 类型的变量，可以通过 `typeof` 、严格相等(不仅检查数值，也要求数据类型相同)或者更高级的类型检查来将其的类型范围缩小。

```ts
// @errors: 2322 2322 2322
declare const maybe: unknown;
// 'maybe' could be a string, object, boolean, undefined, or other types
const aNumber: number = maybe;

if (maybe === true) {
  // TypeScript knows that maybe is a boolean now
  const aBoolean: boolean = maybe;
  // So, it cannot be a string
  const aString: string = maybe;
}

if (typeof maybe === "string") {
  // TypeScript knows that maybe is a string
  const aString: string = maybe;
  // So, it cannot be a boolean
  const aBoolean: boolean = maybe;
}
```

## 8.任意类型:any

需要处理来自用户的输入或第三方代码库的结果时，通常不希望类型检查器对这些值进行检查而是直接让它们通过编译阶段的检查，就可以使用`any`类型来标记这些变量

```ts
let obj:any;

obj = 100;
obj = "小明";
obj = function() {};
```

## 补充：unknown类型与any类型的区别

在 TypeScript 中，`unknown`和`any`都是用于表示类型不确定的值，但它们在类型安全性上有显著区别，主要体现在对类型检查的严格程度上：

1. **`any`类型**（不是很安全）：
    - 完全绕过TypeScript的类型检查
    - 可以对`any`类型的值执行任何操作（调用任意方法、访问任意属性等），不会触发类型错误
    - 可以将`any`类型赋值给任何其他类型，反之亦然

2. **`unknown`类型**（相对比较安全）：
    - 是类型安全的`any`，被设计为更安全的替代方案
    - 不能直接对`unknown`类型的值执行操作，必须先进行**类型检查**或**类型断言**（见后文）
    - `unknown`类型的值只能赋值给`unknown`或`any`类型，不能直接赋值给其他类型

如何选择使用哪一种类型：
- 当需要临时绕过类型检查且确定操作安全时，可以使用`any`
- 当需要处理类型不确定的值但希望保持类型安全时，应优先使用`unknown`
- `unknown`强制开发者进行显式的类型处理，减少了意外错误的可能性，是更推荐的做法

## 9.never类型

表示那些永不存在的值的类型，可以作为只抛出异常或没有返回值的函数的返回值。never类型的值可以赋值给热呢类型，但是任何类型的值不能赋值为never类型。

```ts
// 返回never的函数必须存在无法达到的终点
function error(message: string): never {
    throw new Error(message);
}

// 推断的返回值类型为never
function fail() {
    return error("Something failed");
}

// 返回never的函数必须存在无法达到的终点
function infiniteLoop(): never {
    while (true) {
    }
}
```

## 10.字面量

只能赋值为定义的值。

```ts
let animal:"cat";

animal = "cat";      // √
animal = "dog";      // × 
```

目前 TypeScript 中有三种可用的字面量类型集合，分别是：字符串、数字和布尔值。

# 三、TypeScript复杂数据类型

## 1.数组：array

数组有两种定义方法。

法一：在元素类型后面接上 `[]`，表示由此类型元素组成的一个数组。

```ts
let arr:number[] = [1, 2, 3, 4];
```

- 数组不接受指定类型以外的其他类型数据，若尝试向上述数组中插入布尔值`true`，TS会报错。想要让数组接受任何类型的数据，可将其定义为`any`类型。

## 2. 元组：tuple

与Python中的元组类似，是一个已知元素数量和类型的数组，各元素的类型不必相同。

```TS
let x: [string, number] = ["yes", 100];
```

尝试越界访问元组中的元素时，会触发错误：

```ts
x[3] = "world"; 
// Error, Property '3' does not exist on type '[string, number]'.

console.log(x[5].toString()); 
// Error, Property '5' does not exist on type '[string, number]'.
```
## 3.枚举：enum

使用枚举类型可以为一组数值赋予友好的名字，从而避免用数字表示一些可选的项目，使得难以阅读与理解。
默认情况下，元素的编号从0开始，也可以手动编号，后续元素会在此基础上迭加。

```ts
enum Color {Red, Green, Blue}
let c: Color = Color.Green;
let colorName: string = Color[2];    // 不清楚编号2是什么意义，可以通过这样的方法获取,取到的值为"Green"

enum Week {Sunday = 7, Monday = 1, Tuesday, Wednesday, Thursday, Friday, Saturday}
```

## 4.Object类型

`object`表示非原始类型，也就是除`number`，`string`，`boolean`，`symbol`，`null`或`undefined`之外的类型。

使用`object`类型，就可以更好的表示像`Object.create`这样的API。

```ts
declare function create(o: object | null): void; 

create({ prop: 0 });  // OK 
create(null);         // OK 

create(42);           // Error 
create("string");     // Error 
create(false);        // Error 
create(undefined);    // Error
```

## 5.类型断言

通常在“清楚地知道一个实体具有比它现有类型更确切的类型(文档里是这么写的，我没看懂)”的情况下，使用类型断言告知编译器自己清楚且确定使用这样的数据类型，类似于“类型转换”，是不进行特殊的数据检查和解构。它没有运行时的影响，只在编译阶段起作用。

建议使用`as`语法，写法如下：

```ts
let value: any = "这是一个字符串";

let length: number = (value as string).length;
```

## 注：使用`var`、`let`以及`const`声明变量的区别

|      | var               | let                     | const                   |
| ---- | ----------------- | ----------------------- | ----------------------- |
| 作用域  | 函数作用域             | 块级作用域                   | 块级作用域                   |
| 变量提升 | 声明会提到函数顶部（赋值不会）   | 存在“暂时性死区”，<br>先使用后声明会报错 | 存在“暂时性死区”，<br>先使用后声明会报错 |
| 可重名性 | 允许在同一作用域内重复声明同一变量 | 不允许在同一作用域内重复声明同一变量      | 不允许在同一作用域内重复声明同一变量      |
| 可修改性 | 声明的变量可以被重新赋值      | 声明的变量可以被重新赋值            | 声明的是常量，不允许修改            |
- 函数作用域：即使在if、for代码块中定义的变量，在整个函数体中也可以访问。
- 块级作用域：声明的变量仅在自己的代码块中可见。

在 TypeScript 开发中，推荐优先使用`const`，当确实需要重新赋值时再使用`let`，**尽量避免使用`var`**，以减少作用域相关的问题。

### **奇怪的“变量捕获”问题**

```ts
for (var i = 0; i < 10; i++) {
	setTimeout(function () {     // 设置定时器
		console.log(i);
	}, 100 * i);                 // 100*i ms后执行中间的代码
}
```

对于上面的代码，运行结果是10个10而不是0-9的遍历（[点击运行代码](https://jsbin.com/cowayayaho/edit?html,output)），与印象中预期的输出不同。原因是，由于使用`var`定义变量，我们传给`setTimeout`的每一个函数表达式实际上都**引用了相同作用域里的同一个`i`**。即**在定时器延迟输出以前，for循环已经完成了0-9的遍历**，i也已经增加到了10，于是输出的是10个10而不是1-10的遍历。

有意思的是，将`var`换成`let`，输出的结果又变成了0-9的遍历（[点击运行代码](https://jsbin.com/vidulibika/1/edit?html,output))。以下是AI给出的解释，或许更通俗易懂：

1. 使用`var`时输出 10 个 10 的原因
	- `var`的作用域特性：`var`声明的变量具有函数作用域（而非块级作用域），在for循环中，变量i在整个函数范围内都是同一个变量。
	- 定时器的异步执行：`setTimeout`是异步执行的，**当循环结束后，定时器中的回调函数才会开始执行**。此时循环已经完成，`i`的值已经变成了10（循环终止条件是i < 10，最后一次递增后i为 10）。
	- 闭包引用同一变量：所有定时器的回调函数都引用了同一个`i`（函数作用域内的唯一变量），因此当它们执行时，都会读取到i的最终值10。
2. 改成let后输出 0-9 的原因
	- `let`的块级作用域：`let`声明的变量具有块级作用域，在for循环中，每次迭代都会创建一个新的i变量（每个循环块内的i都是独立的）。
	- 绑定当前值：每个定时器的回调函数捕获的是当前循环块内的i，即每次迭代时i的当前值（0、1、2...9）。
	- 避免共享变量问题：由于每个i都是独立的，因此当定时器执行时，会分别输出各自捕获的i值，即 0 到 9。

因此，为了避免出现这样看起来玄乎的“迷之问题”，建议使用`let`声明变量。

### let声明的块作用域

> 当用`let`声明一个变量，它使用的是**词法作用域**或**块作用域**。 不同于使用`var`声明的变量那样可以在包含它们的函数外访问，块作用域变量在包含它们的块或`for`循环之外是不能访问的。

> 拥有块级作用域的变量的另一个特点是，它们不能在被声明之前读或写。 虽然这些变量始终“存在”于它们的作用域里，但在直到声明它的代码之前的区域都属于**暂时性死区**。 它只是用来说明我们不能在`let`语句之前访问它们。

--- 
# 参考资料

[^1]: 听风是风.从零开始的微信小程序入门教程(三)\[EB/OL].(2020-04-16)\[2025-08-15]. https://www.cnblogs.com/echolun/p/12709761.html
