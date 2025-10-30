---

---
--- 
> 原文链接： https://zhuanlan.zhihu.com/p/648650828

vector 是 C++ 标准库中的一个**动态数组容器**，它可以自动管理内存大小，可以在运行时根据需要动态增长或缩小。它是一个非常常用且强大的容器，用于存储一系列元素。下面详细介绍 `vector` 的使用方法，并提供相应的代码案例。

## **1.包含头文件：**

首先，使用需要引入头文件 `<vector>`。

```cpp
#include <vector>
```

## **2.创建 vector 对象：**

直接使用 `vector` **模板类**来创建一个 vector 对象。可以创建存储特定类型元素的 vector，格式为： `vector<数据类型> 名字`。例如：

```cpp
vector<int> myVector; // 创建一个存储整数的 vector，名字为myVector
vector<char> myVector; // 创建一个存储字符的 vector，名字为myVector
vector<string> myVector; // 创建一个存储字符串的 vector，名字为myVector
……
```

## **3.初始化一维 vector 对象：**

### 3.1 `vector < int > myVector`;

此时myVector中没有任何元素，直接进行访问会报错。

可以使用 myVector.resize(num)，或者myVector.resize(n, num) 来初始化。

①前者是使用num个0来初始化；

```cpp
	vector < int > myVector;
	myVector.resize(5);
	//输出内容是：0 0 0 0 0
	for (int i = 0; i < myVector.size(); i++) {
		cout << myVector[i] << " ";
	}
	cout << endl;
```

②后者是使用n个num来初始化。

```cpp
	vector < int > myVector;

	myVector.resize(5,10);
	//输出内容是：10 10 10 10 10
	for (int i = 0; i < myVector.size(); i++) {
		cout << myVector[i] << " ";
	}
	cout << endl;
```

### 3.2 `vector < int > myVector = {1,2,3,4,5}`;

这种方法在初始化后就进行了赋值，此时myVector.size() == 5。如果使用myVector.resize(num)来修改的话：①对于num<myVector.size()的情况，如num\==3，会丢弃myVector最后的4和5；

```cpp
	vector < int > myVector = { 1,2,3,4,5 };
	myVector.resize(3);
	//输出内容是：1 2 3
	for (int i = 0; i < myVector.size(); i++) {
		cout << myVector[i] << " ";
	}
	cout << endl;
```

②对于num>myVector.size()的情况，如num\==7，会用0来填充没有赋值的部分，此处就是最后两个位置；

```cpp
	vector < int > myVector = { 1,2,3,4,5 };
	myVector.resize(7);
	//输出内容是：1 2 3 4 5 0 0
	for (int i = 0; i < myVector.size(); i++) {
		cout << myVector[i] << " ";
	}
	cout << endl;
```

### 3.3 `vector < int > myVector(num)`; 或者 `vector < int > myVector(n,num)`;

类似于resize的用法

### 3.4 `vector < int > myVector(testVector)`; 或者 `vector < int > myVector = testVector`;

这种方法是使用另外一个数组来初始化myVector，注意，这里的testVector也必须是vector类型

①`vector < int > myVector(testVector)`;

```cpp
	vector < int > testVector = { 1,2,3,4,5 };
	vector < int > myVector(testVector);
	//输出内容是：1 2 3 4 5
	for (int i = 0; i < myVector.size(); i++) {
		cout << myVector[i] << " ";
	}
	cout << endl;
```

②`vector < int > myVector = testVector`;

```cpp
	vector < int > testVector = { 1,2,3,4,5 };
	vector < int > myVector = testVector;
	//输出内容是：1 2 3 4 5
	for (int i = 0; i < myVector.size(); i++) {
		cout << myVector[i] << " ";
	}
	cout << endl;
```

### 3.5使用指针初始化一维vector;

`vector < int > myVector (*p, *q);` 使用另外一个数组的指针来初始化v，这里既可以使用vector的指针，也可以使用普通数组的指针。

```cpp
	int arr[5] = { 1,2,3,4,5 };
	vector<int> myVector = { 1,2,3,4 };

	//输出内容是：1 2 3
	vector<int> vector1(arr, arr + 3);
	for (int i = 0; i < vector1.size(); i++)
		cout << vector1[i] << " ";   
	cout << endl;
	//输出内容是：2 3
	vector<int> vector2(myVector.begin() + 1, myVector.end() - 1);
	for (int i = 0; i < vector2.size(); i++)
		cout << vector2[i] << " ";   	
	cout << endl;
```

## 4.初始化二维 vector 对象：

### 4.1 vector < vector < int > > myVector;

和一维数组一样，这里的myVector中没有任何元素，myVector.size() == 0，直接访问会报错。

  
①可以先使用myVector.resize(n)来初始化这个二维数组的第一维，然后使用一个for循环再初始化第二维。此时myVector中的元素都是0，不是空格。

```cpp
	vector < vector < int > > myVector;
	myVector.resize(5);
	for (int i = 0; i < 5; i++) {
		myVector[i].resize(5);
	}
       
        // 输出的是一片空格 
	for (int i = 0; i < myVector.size(); i++) {
		for (int j = 0; j < myVector[i].size(); j++) {
			cout << myVector[i][j] << " ";
		}
		cout << endl;
	}
	cout << endl;
```

### 4.2 vector < vector < int > > myVector(n, testVector);

可以直接使用n和testVector来初始化myVector，但是testVector需要是vctor类型

```cpp
	vector <int> testVector(4,1);
	vector < vector < int > > myVector(4, testVector);
	//输出内容是： 4行4列共16个1
	for (int i = 0; i < myVector.size(); i++) {
		for (int j = 0; j < myVector[i].size(); j++) {
			cout << myVector[i][j] << " ";
		}
		cout << endl;
	}
	cout << endl;
```

### 4.3 通过复制其他vector的方式

类似于3.4，这里不在赘述

### 4.4 使用指针初始化二维vector

既可以使用vector的指针，也可以使用普通数组的指针。

①使用vector的指针

```cpp
	vector<int> vector1 = { 1,2,3,4 };
	vector<vector<int>> vector2(4, vector1);
	vector<vector<int>> myVector(vector2.begin(), vector2.end());
	for (int i = 0; i < myVector.size(); i++) {
		for (int j = 0; j < myVector[i].size(); j++)
			cout << myVector[i][j] << " ";
		cout << endl;
	}
	//输出内容是：
	/*1 2 3 4
	1 2 3 4
	1 2 3 4
	1 2 3 4*/
```

②使用普通数组的指针

```cpp
	int arr[4][4] = { {1,2,3,4},{5,6,7,8},{9,10,11,12},{13,14,15,16} };

	vector<vector<int>> myVector;

	for (int i = 0; i < 4; i++) {
		// 使用指针 arr[i] 初始化每一行
		vector<int> row(arr[i], arr[i] + 4);
		myVector.push_back(row);
	}

	for (int i = 0; i < myVector.size(); i++) {
		for (int j = 0; j < myVector[i].size(); j++)
			cout << myVector[i][j] << " ";
		cout << endl;
	}
	//输出内容是：
	/*1 2 3 4
	5 6 7 8
	9 10 11 12
	13 14 15 16*/
```

## 5. 访问 vector 中的元素：

直接使用下标操作符 `[]` 来访问 vector 中特定索引的元素。

```cpp
	vector<int> myVector = { 100,200,300,400 };
	cout << myVector[0] << endl; // 100
	cout << myVector[1] << endl; // 200
	cout << myVector[2] << endl; // 300
	cout << myVector[3] << endl; // 400
```

## **6.获取 vector 的大小：**

使用size()或者capacity()函数

```cpp
	vector<int> myVector = { 100,200,300,400, 500 };
	cout << myVector.size() << endl; // 5
	cout << myVector.capacity() << endl; // 5
```

## 7.向 vector 中添加元素：

使用 `push_back()` 函数将元素添加到 vector 的末尾，默认且只能添加到末尾。

```cpp
	vector<int> myVector = { 1,2,3,4 };
	myVector.push_back(100);
	myVector.push_back(200);
	myVector.push_back(300);
	//输出内容是：1 2 3 4 100 200 300
	for (int i = 0; i < myVector.size(); i++) {
		cout << myVector[i] << " ";
	}
	cout << endl;
```

## 8.向 vector 中插入元素：

使用 `insert()` 函数来在指定位置插入元素。需要提供插入位置的迭代器和要插入的元素值。

```cpp
	vector<int> myVector = { 100,200,300,400,500,600 };
	
	vector<int>::iterator it;
	
	it = myVector.begin(); //索引为0的位置
	myVector.insert(it, 111); //向索引为0的位置插入元素111
	//输出内容为：111 100 200 300 400 500 600
	for (int i = 0; i < myVector.size(); i++) {
		cout << myVector[i] << " ";
	}
	cout << endl;

	it = myVector.begin() + 2; //索引为2的位置
	myVector.insert(it, 222); //向索引为2的位置插入元素222
	//输出内容为：111 100 222 200 300 400 500 600
	for (int i = 0; i < myVector.size(); i++) {
		cout << myVector[i] << " ";
	}
	cout << endl;

	it = myVector.end(); //myVector的末尾
	myVector.insert(it, 999); //向myVector的末尾插入元素999
	//输出内容为：111 100 222 200 300 400 500 600 999
	for (int i = 0; i < myVector.size(); i++) {
		cout << myVector[i] << " ";
	}
	cout << endl;
```

## 9.删除 vector 中的元素：

使用 `pop_back()` 函数删除 vector 末尾的元素，默认且只能删除末尾的元素 。

```cpp
	vector<int> myVector = { 100,200,300,400,500 };
	myVector.pop_back();
	myVector.pop_back();
	cout << myVector.size() << endl; // 3
	//输出内容是：100 200 300
	for (int i = 0; i < myVector.size(); i++) {
		cout << myVector[i] << " ";
	}
	cout << endl;
```

## 10.删除 vector 中指定位置的元素：

使用 `erase()` 函数来删除指定位置的元素，需要提供删除位置的迭代器。

```cpp
	vector<int> myVector = { 100,200,300,400,500,600 };
	vector<int>::iterator it;

	it = myVector.begin(); //索引为0的位置
	myVector.erase(it); //删除索引为0的位置的元素
	//输出内容为：200 300 400 500 600
	for (int i = 0; i < myVector.size(); i++) {
		cout << myVector[i] << " ";
	}
	cout << endl;

	it = myVector.begin() + 2; //索引为2的位置
	myVector.erase(it); //删除索引为2的位置的元素
	//输出内容为：200 300 500 600
	for (int i = 0; i < myVector.size(); i++) {
		cout << myVector[i] << " ";
	}
	cout << endl;
```

## 11.删除 vector 中指定数值的元素：

使用 `remove()` 函数来删除指定值的元素。

①如果能在目标vector中找到该数值的元素，直接删除

```cpp
	vector<int> myVector = { 100,200,300,400,500,600 };
	myVector.erase(remove(myVector.begin(), myVector.end(), 500), myVector.end()); //删除数值为500的元素
	myVector.erase(remove(myVector.begin(), myVector.end(), 300), myVector.end()); //删除数值为300的元素
	//输出内容为：100 200 400 600
	for (int i = 0; i < myVector.size(); i++) {
		cout << myVector[i] << " ";
	}
	cout << endl;
```

②如果目标vector中找不到该数值的元素，不做任何操作，不会报错

```cpp
	vector<int> myVector = { 100,200,300,400,500,600 };
	myVector.erase(remove(myVector.begin(), myVector.end(), 555), myVector.end()); //删除数值为555的元素
	myVector.erase(remove(myVector.begin(), myVector.end(), 333), myVector.end()); //删除数值为333的元素
	//输出内容为：100 200 300 400 500 600
	for (int i = 0; i < myVector.size(); i++) {
		cout << myVector[i] << " ";
	}
	cout << endl;
```

## 12.修改 vector 中的元素：

直接使用下标操作符 \[] 来修改 vector 中特定索引的元素。

```cpp
	vector<int> myVector = { 100,200,300,400,500 };
	myVector[0] = 111; // 修改索引为0的元素
	myVector[1] = 222; // 修改索引为0的元素
	//输出内容是：111 222 300 400 500
	for (int i = 0; i < myVector.size(); i++) {
		cout << myVector[i] << " ";
	}
	cout << endl;
```

## 13.查找 vector 中的元素：

使用 `find()` 函数来查找指定值的元素，或者使用迭代器来遍历查找。

### ①使用 find() 函数查找：

```cpp
	vector<int> myVector = { 100,200,300,400,500,600 };
	vector<int>::iterator it = find(myVector.begin(), myVector.end(), 500);
	//输出内容为：目标元素的索引为: 4
	if (it != myVector.end()) {
		cout << "目标元素的索引为: " << distance(myVector.begin(), it) <<endl;
	}
	else {
		cout << "没有找到" <<endl;
	}
```

### ②使用迭代器遍历查找：

```cpp
	vector<int> myVector = { 100,200,300,400,500,600 };
	bool found = false;
	int valueToFind = 300;

	//输出内容为：目标元素的索引为: 2
	for (vector<int>::iterator it = myVector.begin(); it != myVector.end(); ++it) {
		if (*it == valueToFind) {
			cout << "目标元素的索引为: " << distance(myVector.begin(), it) << endl;
			found = true;
			break;
		}
	}
	if (!found) {
		cout << "没有找到" << endl;
	}
```

## 14.清空 vector 中的元素：

使用`clear()` 函数可以清空 vector 中的所有元素。

```cpp
	vector<int> myVector = { 100,200,300,400,500,600 };
	cout << myVector.size() << endl; // 6
	myVector.clear();
	cout << myVector.size() << endl; // 0
```

## 15.使用索引**遍历 vector 中的元素：**

使用for循环和索引来遍历 vector 中的元素。

```cpp
	vector<int> myVector = { 100,200,300,400,500,600 };
	//输出内容是：100 200 300 400 500 600
	for (int i = 0; i < myVector.size(); i++) {
		cout << myVector[i] << " ";
	}
	cout << endl;
```

## 16.使用迭代器遍历 vector：

### 通过迭代器遍历的方法

```cpp
        vector<int> myVector = { 100,200,300,400,500,600 };
	//输出内容是：100 200 300 400 500 600
	for (vector<int>::iterator it = myVector.begin(); it != myVector.end(); it++) {
		cout << *it << " ";
	}
	cout << endl;
```

## 17.使用foreach循环遍历 vector：

### ①第一种通过foreach循环遍历的方法

在这个例子中，使用的是范围-based for 循环（也称为foreach循环），其中 `int it` 是一个迭代变量，而不是传统的迭代器。这种循环方式是C++11引入的一种简化语法，用于遍历容器中的元素。

for (int it : myVector){}，这里需要指定myVector中元素的类型，因为我定义的myVector元素类型是int，这里就使用int

```cpp
	vector<int> myVector = { 100,200,300,400,500,600 };
	//输出内容是：100 200 300 400 500 600
	for (int it : myVector) {
		cout << it << " ";
	}
	cout << endl;
```

### ②第二种通过foreach循环遍历的方法（推荐）

这种遍历方式使用了C++11引入的范围-**based for 循环**，也称为**foreach循环**。在这种循环中，`auto it` 是一个**自动类型推断**的语法，`it` 并不是一个传统意义上的迭代器，而是直接取得 `myVector` 中的**每个元素的值**。

for (auto it : myVector){},这里直接使用auto，不需要根据myVector中元素的类型改变

```cpp
	 vector<int> myVector = { 100,200,300,400,500,600 };
	//输出内容是：100 200 300 400 500 600
	for (auto it : myVector) {
		cout << it << " ";
	}
	cout << endl;
```


--- 
## 应用实例（插入+查询）

原题： [P2141 [NOIP 2014 普及组] 珠心算测验](https://www.luogu.com.cn/problem/P2141)
解答：
```c
#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int a[100] = {0};
vector<int> sums;

int main(void) {
    int n;
    cin >> n;
    
    for (int i = 0; i < n; i++) {
        cin >> a[i];
    }

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            sums.push_back(a[i] + a[j]);
        }
    }

    int ans = 0;
    for (int i = 0; i < n; i++) {
        if (find(sums.begin(), sums.end(), a[i]) != sums.end()) {
            ans+=1;
        }
    }

    cout << ans;
    
    return 0;
}
```