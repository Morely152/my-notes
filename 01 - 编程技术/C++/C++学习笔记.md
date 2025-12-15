---

---
---

---
---
> 本篇笔记摘自[《C++程序设计》3小时期末速成不挂科！！！ - 数学建模老哥](https://www.bilibili.com/video/BV1Up4y1R7AR),遵循[CC BY 4.0协议](https://creativecommons.org/licenses/by/4.0/legalcode.zh-hans)。
> 存在由AI生成的小部分内容，仅供参考，请仔细甄别可能存在的错误。

# 一、数据类型
- C++的数据包括常量与变量，都具有一些数据类型：
## 1. 常见数据类型
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259356.png)
## 2.常量
- 分为数值常量和字符(串)型常量两种
### ① 数值常量
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259357.png)
- 指数形式：$3.14 \times 10 ^ {-2}$ -> 3.14e-2
### ② 字符型常量
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259358.png)
### ② 字符串型常量
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259359.png)
### ③ 常考例题
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259360.png)
## 3.整型
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259361.png)
- 占n个字节的有符号整数，取值范围是 $-2^{8n - 1}$ ~ $2 ^ {8n - 1} - 1$
- 占n个字节的有符号整数，取值范围是 $0$ ~ $2 ^ {8n} - 1$
## 4.浮点型
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259362.png)
## 5.布尔类型
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259363.png)
## ６.变量命名规则
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259365.png)
## 7.局部变量与全局变量
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259366.png)
# 二、运算符
## 1.算术运算符
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259367.png)
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259368.png)
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259369.png)
- 例题：
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259370.png)
## 2.赋值运算符
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259371.png)
## 3.比较运算符（关系运算符）
-  用于表达式的比较，并返回一个真值或假值
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259372.png)
## 4.逻辑运算符
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259373.png)
## 5.位运算符
- 两个多位二进制进行逻辑运算，采取**按位逻辑运算**的方法：
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259374.png)
## 6.杂项运算符
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259375.png)
- `sizeof()`多用于获取数组长度，如：
```C++
int a = {1, 2, 3, 4}
cout << sizeof(a) / sizeof(a[0]) 
// 数组总的字节数除以任何一个元素的字节数，即 16 / 4 = 4
```
## 7.运算符优先级
略
# 三、流程控制语句
if语句、switch语句、while语句、for语句、Switch语句等过于基础，此处略去
# 四、数组
## 1.一维数组
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259376.png)
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259377.png)
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259378.png)
## 2.二维数组
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259379.png)
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259380.png)
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259381.png)
## 3.vector动态数组
`vector`是C++标准模板库(STL)中的一个动态数组容器，它提供了以下主要功能：
1. **动态大小**：可以自动调整大小，不像普通数组需要预先指定固定大小
2. **连续存储**：元素在内存中是连续存储的，支持随机访问
3. **自动内存管理**：自动处理内存分配和释放
4. **丰富的成员函数**：提供多种便捷操作元素的方法
```CPP
#include <iostream>
#include <vector>

int main() {
    // 创建一个空的int类型vector
    std::vector<int> numbers;
    
    // 添加元素
    numbers.push_back(10);
    numbers.push_back(20);
    numbers.push_back(30);
    
    // 访问元素
    std::cout << "第一个元素: " << numbers[0] << std::endl;
    std::cout << "第二个元素: " << numbers.at(1) << std::endl;
    
    // 遍历vector
    for(auto num : numbers) {  // 范围for 循环
        std::cout << num << " ";
    }
    std::cout << std::endl;
    
    return 0;
}
```
- 常用操作：
```CPP
// 创建与初始化
std::vector<int> v1;                // 空vector
std::vector<int> v2(5);             // 5个元素，默认值为0
std::vector<int> v3(5, 10);         // 5个元素，每个都是10
std::vector<int> v4 = {1, 2, 3};    // 初始化列表
std::vector<int> v5(v4);            // 拷贝构造

// 添加元素 
v.push_back(100);       // 在末尾添加元素
v.insert(v.begin(), 5); // 在开头插入元素
v.emplace_back(200);    // 在末尾高效构造并添加元素(C++11)

// 访问元素
int first = v[0];       // 通过下标访问(不检查边界)
int second = v.at(1);   // 通过at()访问(会检查边界)
int last = v.back();    // 访问最后一个元素
int first = v.front();  // 访问第一个元素

// 删除元素
v.pop_back();           // 删除最后一个元素
v.erase(v.begin());     // 删除第一个元素
v.erase(v.begin()+1);   // 删除第二个元素
v.clear();              // 清空所有元素

// 容器操作
int size = v.size();        // 当前元素数量
bool empty = v.empty();     // 判断是否为空
v.resize(10);              // 调整大小
int cap = v.capacity();     // 当前容量(内存空间)
v.reserve(100);            // 预留空间(不改变size)

// 迭代器操作
for(auto it = v.begin(); it != v.end(); ++it) {
    std::cout << *it << " ";
}

for(auto rit = v.rbegin(); rit != v.rend(); ++rit) {
    std::cout << *rit << " ";  // 反向迭代
}

```
# 五、函数
## 1.函数定义
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259382.png)
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259383.png)
- 即使制定了函数返回值类型为void，在函数体中也可以写`return;`实现直接返回、取消执行后续逻辑的操作。
## 2.函数声明
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259384.png)
## 3.函数调用
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259385.png)
## 4.默认参数
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259386.png)
- 默认值参数应该位于形参列表的尾部，即无默认值的参数前面不应该出现有默认值的参数
## 5.内联函数(内置函数)
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259387.png)
- 内联函数分**显示声明**与**隐式声明**两种：
	- 显示声明：声明在定义类的外，并加上`inline`关键字
	- 隐式声明：声明在定义类的内部，不用加上`inline`关键字
# 六、指针
## 1.指针定义
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259388.png)
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259389.png)
## 2.常量与指针
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259390.png)
- 对于`int * p = 1`,认为`*`前面是对指针目标的描述(目标的数据类型等)，`*`后面是对指针自身的描述(指针名)，`const`在哪个部分，对应的描述对象就不可修改。
	- const int * p:先`const`后`*`(指向常量的指针（pointer to const）)，此时可以修改指针的目标，不能修改目标的值。
	- int * const p:先`*`后`const`(指针本身是常量（constant pointer）)，此时可以修改指针目标的值，不能修改指针的目标。
	- const int * const p:`const`修饰`p`变量以及`*p`指针，此时不能修改指针目标的值，也不能修改指针的目标。
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259391.png)
## 3.多级指针（指向指针的指针）
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259392.png)
## 4.指针函数（返回值为指针的函数）
定义语法：
```C++
int *a(int x, int y) {
	// 函数体
}
```
# 七、自定义数据类型
## 1.结构体
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259393.png)
- 访问结构体的成员时可以用`.`和`->`(后者可重载)；`ptr->member` 等价于 `(*ptr).member`。
## 2.联合体(共用体)
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259394.png)
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259395.png)
- 使用联合体的目的主要是为了提高内存的使用效率，但只能同时使用其中一个成员，所以要及时取用共用体中的值，防止改用其他成员时旧的数据被覆盖掉。
## 3.枚举
- 本质上类似于用数值给一组东西编号，如`week[7] = {1, 2, 3, 4, 5, 6, 7}`（称为"魔法数字"）。
- 这样写会降低代码可读性，其他用户很难看出1~7的具体意义，因此产生了枚举的数据类型：
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259396.png)
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259398.png)
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259399.png)
# 八、类和对象
## 1.类和对象的定义
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259400.png)
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259401.png)
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259402.png)
## 2.构造函数与析构函数
### ① 构造函数
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259403.png)
- 构造函数的常用写法：
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259404.png)
### ② 析构函数
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259405.png)
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259406.png)
## 3.成员函数、静态成员
### ① 成员函数
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259407.png)
### ② 静态成员
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259408.png)
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259409.png)
## 4.类的友元
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259410.png)
- A是B的友元 -> A可以访问B中标记为`private`和`protected`的属性和方法。
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259411.png)
# 九、继承与多态
## 1.继承
- 派生类(子类)可访问基类(父类)的`public`和`protected`属性与方法，无论选择哪种方式都无法直接访问基类的`private`属性与方法。
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259412.png)
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259413.png)
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259414.png)
- 构造函数与析构函数都不能被派生类所继承。 
## 2.多态
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259415.png)
### ① 静态多态
#### 函数重载
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259416.png)
-  C++不以返回值区分函数重载，而是根据形参列表来区分。
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259417.png)
#### 运算符重载
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259418.png)
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259419.png)
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259420.png)
- `<<`与`>>`的重载：
```CPP
#include <iostream>
#include <cmath>

class Complex {
private:
    double real;  // 实部
    double imag;  // 虚部

public:
    // 构造函数
    Complex(double r = 0.0, double i = 0.0) : real(r), imag(i) {}

    // 重载 + 运算符 (成员函数形式)
    Complex operator+(const Complex& other) const {
        return Complex(real + other.real, imag + other.imag);
    }

    // 重载 < 运算符 (按模比较)
    bool operator<(const Complex& other) const {
        return (std::sqrt(real*real + imag*imag) < 
                std::sqrt(other.real*other.real + other.imag*other.imag));
    }

    // 获取实部
    double getReal() const { return real; }
    
    // 获取虚部
    double getImag() const { return imag; }

    // 友元函数声明
    friend std::ostream& operator<<(std::ostream& os, const Complex& c);
    friend std::istream& operator>>(std::istream& is, Complex& c);
};

// 重载 << 运算符 (输出虚数)
std::ostream& operator<<(std::ostream& os, const Complex& c) {
    os << c.real;
    if (c.imag >= 0) {
        os << "+" << c.imag << "i";
    } else {
        os << c.imag << "i";
    }
    return os;
}

// 重载 >> 运算符 (输入虚数)
std::istream& operator>>(std::istream& is, Complex& c) {
    std::cout << "输入实部: ";
    is >> c.real;
    std::cout << "输入虚部: ";
    is >> c.imag;
    return is;
}

int main() {
    Complex c1, c2;
    
    // 测试 >> 运算符
    std::cout << "输入第一个虚数:\n";
    std::cin >> c1;
    std::cout << "输入第二个虚数:\n";
    std::cin >> c2;
    
    // 测试 << 运算符
    std::cout << "c1 = " << c1 << std::endl;
    std::cout << "c2 = " << c2 << std::endl;
    
    // 测试 + 运算符
    Complex sum = c1 + c2;
    std::cout << "c1 + c2 = " << sum << std::endl;
    
    // 测试 < 运算符
    if (c1 < c2) {
        std::cout << "c1的模小于c2的模" << std::endl;
    } else {
        std::cout << "c1的模不小于c2的模" << std::endl;
    }
    
    return 0;
}
```

### ② 动态多态
#### 虚函数
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259421.png)
- 静态链接在类的多态(成员函数重载)中出现的问题：
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259422.png)
- 通过将同样的`shape()`方法以`virtual`关键字标识为虚函数，可以实现根据子类的不同调用不同的方法，即使方法名、返回值，甚至参数列表都是相同的。
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259423.png)
- `virtual`关键字只需要写在基类的(纯)虚函数上即可，派生类中的虚函数无需再写`virtual`。
#### 虚基类
- 虚基类（Virtual Base Class）是C++中用于解决多重继承中的"菱形继承问题"（Diamond Problem）的一种机制。当多个派生类从同一个基类继承时，使用虚继承可以确保在最终的派生类中只有一份基类子对象。
- 例：A派生出B和C，同时D又继承自B和C（菱形继承），类D中就会有两份类A的成员，这会导致访问的二义性。
```CPP
#include <iostream>
using namespace std;

// 基类A
class A {
public:
    int data;
    A() : data(10) {
        cout << "A constructor" << endl;
    }
};

// 使用虚继承的类B
class B : virtual public A {
public:
    B() {
        cout << "B constructor" << endl;
    }
};

// 使用虚继承的类C
class C : virtual public A {
public:
    C() {
        cout << "C constructor" << endl;
    }
};

// 类D继承B和C
class D : public B, public C {
public:
    D() {
        cout << "D constructor" << endl;
    }
    
    void printData() {
        cout << "Data: " << data << endl; // 没有二义性
    }
};

int main() {
    D d;
    d.printData();
    
    // 输出A、B、C、D的构造函数，但A只被构造一次
    return 0;
}
```
1. 通过在继承时使用`virtual`关键字，B和C都虚继承自A，A即为**虚基类**
2. 当D继承B和C时，A的子对象在D中只有一份
3. 构造函数调用顺序：
    - 虚基类构造函数最先被调用（A）
    - 然后是普通基类构造函数（B、C）
    - 最后是派生类自己的构造函数（D）
- 如果不使用虚继承，D中将有两份A的成员，访问`data`时需要指定路径（`B::data`或`C::data`），否则会产生编译错误。
# 十、输入输出流
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259424.png)
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259425.png)
![](https://gitee.com/morely_152/my-pcitures/raw/master/20251012102259426.png)
# 十一、编程例题
## 1.虚函数
> 完整实现Shape抽象基类，包含：
> - 2个纯虚函数（area和perimeter）1个带默认实现的虚函数（printInfo）
> - 虚析构函数：必须使用虚析构函数 
> 实现3个具体派生类：
> - Circle（标记为final）
> - Rectangle
> - Square（继承自Rectangle）
> 总体任务：
> - 抽象基类 Shape：定义图形的基本接口
> - 具体图形类（Circle、Rectangle、Square）：实现特定图形功能
> - 管理类 ShapeManager：演示多态的实际应用

```CPP
#include <iostream>
#include <vector>

using namespace std;

class Shape {
public:
	virtual double area() const = 0;
	virtual double perimeter() const = 0;

	virtual void printInfo() const {
		cout << "图形信息如下：" << endl;
		cout << "面积为" << area() << endl;
		cout << "周长为" << perimeter() << endl;
	}

	virtual ~Shape() {
		cout << "图形已被回收。" << endl;
	}
};

class Circle final : public Shape {
private:
	double radius;
public:
	Circle(double r) :radius(r) {}

	double area() const override {
		return 3.14 *radius *radius;
	}

	double perimeter() const override {
		return 3.14 *radius *radius;
	}

	void printInfo() const override{
		cout << "圆形的信息如下：" << endl;
		cout << "半径为：" << radius << endl;
		cout << "面积为" << area() << endl;
		cout << "周长为" << perimeter() << endl;
		Shape::printInfo();
	}

	~Circle() {
		cout << "圆形已被回收。" << endl;
	}
};

class Rectangle : public Shape {
private:
	double width;
	double length;
public:
	Rectangle(double l, double w) :length(l), width(w) {}

	double area() const override {
		return width * length;
	}

	double perimeter() const override {
		return (width +length) * 2;
	}

	void printInfo() const override{
		cout << "长方形的信息如下：" << endl;
		cout << "长度为：" << length << ",宽度为：" << width << endl;
		cout << "面积为" << area() << endl;
		cout << "周长为" << perimeter() << endl;
		Shape::printInfo();
	}

	~Rectangle() {
		cout << "长方形已被回收。" << endl;
	}
};

class Square : public Rectangle {
private:
	double size;
public:
	Square(double s) : Rectangle(s, s) {
		size = s;
	}

	void printInfo() const override{
		cout << "正方形的信息如下：" << endl;
		cout << "边长为：" << size << endl;
		cout << "面积为" << area() << endl;
		cout << "周长为" << perimeter() << endl;
		Shape::printInfo();
	}

	~Square() {
		cout << "正方形已被回收。" << endl;
	}
};

class ShapeManager {
private:
	vector<Shape*> shapes;
public:
	void addShape(Shape* s) {
		shapes.push_back(s);
	}

	void printAllShapes() const {
		cout << "所有图形信息如下：" << endl;
		for (const auto&shape : shapes) {
			shape->printInfo();
			cout << endl;
		}
	}

	double totalArea() const {
		double sum = 0;
		for (const auto&shape : shapes) {
			sum += shape->area();
		}

		return sum;
	}

	double totalPerimeter() const {
		double sum = 0;
		for (const auto&shape : shapes) {
			sum += shape->perimeter();
		}

		return sum;
	}
};

int main(void) {
	ShapeManager sm;

	sm.addShape(new Circle(4));
	sm.addShape(new Rectangle(3, 4));
	sm.addShape(new Square(4));

	sm.printAllShapes();
	cout << "所有图形的面积之和为" << sm.totalArea() << endl;
	cout << "所有图形的周长之和为" << sm.totalPerimeter() << endl; 

	return 0;
}
```

## 2.运算符重载
> 定义一个时间类Time，包含三个属性： hour, minute 和 second
> 要求通过运算符重载实现如下功能:
> - 时间输入输出(>>、<<)；
> - 时间增加减少若干(+=、-=)，
> 	- 例：Time& operator+=(const Time&);Time& operator-=(const Time&)；
> - 时间前、后自增加/减少1秒(++、--)，
> 	- 前自增例：Time& operator++(); 
> 	- 后自增例：Time operator++(int)；
> 输入形式：
> - 输入固定为两个Time实例(time1，time2),每个实例占一行；
> - Time实例输入格式为：hour minute second。
> 输出形式：
> - Time实例输出格式为：hour:minute:second；
> - 每个输出实例占一行。
> 依次输出以下表达式的值
> - time1 += (time2++)
> - time1 -= time2
> - ++time2
> - time2 += (time1--)
> - --time1
> - time2 -= time1

```CPP
#include <iostream>
using namespace std;

class Time {
private:
	int hour;
	int minute;
	int second;

	void init() {
		minute += second / 60;
		second %= 60;
		if (second < 0) {
			second += 60;
			minute--;
		}

		hour += minute / 60;
		minute %= 60;
		if (minute < 0) {
			minute += 60;
			hour--;
		}

		hour %= 24;
		if (hour < 0) {
			hour += 24;
		}
	}

public:
	Time(int h = 0, int m = 0, int s = 0) : hour(h), minute(m), second(s) {
		init();
	}

	friend istream& operator>>(istream& is, Time& t) {
		is >> t.hour >> t.minute >> t.second;
		t.init();
		return is;
	}

	friend ostream& operator<<(ostream& os, Time& t) {
		os << t.hour << ":" << t.minute << ":" << t.second;
		return os;
	}

	Time& operator+=(const Time& other) {
		hour += other.hour;
		minute += other.minute;
		second += other.second;
		init();
		return *this;
	}

	Time& operator-=(const Time& other) {
		hour -= other.hour;
		minute -= other.minute;
		second -= other.second;
		init();
		return *this;
	}

	Time operator++() {
		second++;
		init();
		return *this;
	}

	Time operator++(int) {
		Time temp = *this;
		++(*this);
		return temp;
	}

	Time operator--() {
		second--;
		init();
		return *this;
	}

	Time operator--(int) {
		Time temp = *this;
		--(*this);
		return temp;
	}
};

int main(void) {
	Time t1, t2;

	cout << "请输入两个时间：" << endl;
	cin >> t1 >> t2;

	cout << "第一个时间为：" << t1 << endl;
	cout << "第二个时间为：" << t2 << endl;

	cout << "t1 += (t2++) = " << (t1 += (t2++)) << endl;
	cout << "t1 -= t2 = " << (t1 -= t2) << endl;
	cout << "++t2 = " << (++t2) << endl;
	cout << "t2 += (t1--) = " << (t2 += (t1--)) << endl;
	cout << " --t1 = " << (--t1) << endl;
	cout << "t2 -= t1 = " << (t2 -= t1) << endl;

	return 0;
}
```
## 3.虚基类
> 设计一个学校人员管理系统，包含以下角色：
> - 人员基础信息（姓名、年龄、ID）
> - 学生（额外信息：专业、年级）
> - 教师（额外信息：部门、职称）
> - 教授（可以是教师又是研究员）
> - 助教（可以是学生又是教师）

```CPP
#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Person {
protected:
	string name;
	int age;
	string id;
public:
	Person(string n, int a, string i) : name(n), age(a), id(i) {}

	virtual ~Person() {}

	virtual void display() {
		cout << "姓名：" << name << "年龄：" << age << "ID：" << id << endl;
	}
};

class Student :virtual public Person{
protected:
	string major;
	int grade;
public:
	Student(string n, int a, string id, string m, int g) : Person(n, a, id), major(m), grade(g) {}
	void display() override{
		Person::display();
		cout << "专业：" << major << "年级：" << grade << endl;
	}
};

class Teacher :virtual public Person{
protected:
	string department;
	string title;
public:
	Teacher(string n, int a, string id, string d, string t) : Person(n, a, id), department(d), title(t) {}
	void display() override{
		Person::display();
		cout << "部门：" << department << "职称：" << title << endl;
	}
};

class Professor : public Teacher{
private:
	string field;
public:
	Professor(string n, int a, string id, string d, string t, string f) :Person(n, a, id), Teacher(n, a, id, d, t), field(f) {}
	void display() override {
		Teacher::display();
		cout << "研究领域" << field << endl;
	}
};

class Tutor : public Student, public Teacher{
public:
	Tutor(string n, int a, string id, string m, int g, string d, string t) : Person(n, a, id), Student(n, a, id, m, g),Teacher(n, a, id, d, t) {}
	void display() override {
		Person::display();
		cout << "专业：" << major << "年级：" << grade << endl;
		cout << "部门：" << department << "职称：" << title << endl;
	}
};

class SChoolManageSys {
private:
	vector<Person*> people;
public:
	~SChoolManageSys() {
		for (auto p : people) {
			delete p;
		}
	}

	void addPerson(Person *p) {
		people.push_back(p);
	}

	void display() {
		cout << "所有人员信息：" << endl;
		for (auto &p : people) {
			p->display();
			cout << endl;
		}
	}
};

int main(void) {
	SChoolManageSys sys;
	sys.addPerson(new Student("张三", 20, "25001", "计算机科学与技术", 2));
	sys.addPerson(new Teacher("李四", 28, "25002", "数学系", "教授"));
	sys.addPerson(new Professor("王五", 42, "25003", "计算机系", "教授", "C++程序设计"));
	sys.addPerson(new Tutor("赵六", 25, "25004", "物理学", 3, "物理系", "助教"));

	sys.display();

	return 0;
}

```