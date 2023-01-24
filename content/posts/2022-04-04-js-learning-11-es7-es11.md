---
title: JavaScript ES7 至 ES11 新特性
date: 2022-04-04
categories: Programming
tags: [JavaScript]
---

# ES7新特性

### Array.prototype.includes

`includes()` 方法：用于判断数组中是否存在某个元素，返回布尔值。

用于取代 `indexOf()`。

### 幂运算

`**` 运算符进行幂运算：`2 ** 10 === 1024`。

用于取代 `Math.pow()`

# ES8新特性

### async和await

async和await两种语法结合使用，可以让异步代码像同步代码一样。

- async函数：在普通函数声明前面加上 `async` 关键字
    - 返回值为Promise对象
    - Promise对象的结果由async函数执行的返回值决定
        - 如果函数中返回的结果为非Promise类型，则返回的Promise对象状态为成功，返回值为函数返回的结果
        - 如果函数中返回的结果为Promise对象，则返回的Promise对象的状态和值与之对应
        - 如果函数中抛出错误，则返回的Promise对象状态为失败，返回值为抛出的错误
- await表达式：
    - await必须写在async函数中
    - await右侧的表达式一般为Promise对象
    - await返回的是Promise对象成功的值
    - 若await的Promise失败了，则会抛出异常，需要通过 `try...catch` 捕获处理
- async和await结合使用

### Object.values和Object.entries

- `Object.keys()` 方法：获取对象所有的键，返回形式为数组
- `Object.values()` 方法：获取对象所有的值，返回形式为数组
- `Object.entries()` 方法：获取对象所有的键值对，返回形式为数组，内部每个键值对也为一个数组
    - 方便创建Map

### Object.getOwnPropertyDescriptors

- `Object.getOwnPropertyDescriptors()` 方法：返回一个对象属性的描述对象
    - 用于深层克隆对象

# ES9新特性

### 对象展开

在ES6中，rest参数和spread扩展运算符只针对数组适用。但在ES8中，为对象也提供了像数组一样的rest参数和spread扩展运算符。

rest参数……

扩展运算符……

### 正则扩展

- 命名捕获分组
- 反向断言
- dotAll模式

# ES10新特性

### Object.fromEntries

`Object.fromEntries()` 将二维数组和Map转换为对象。和 `Object.entries()` 互为逆运算：

`Object.entries()` 方法：获取对象所有的键值对，返回形式为数组，内部每个键值对也为一个数组

### trimStart和trimEnd

- `trimStart()` 方法：清除字符串左侧的空格
- `trimEnd()` 方法：清除字符串右侧的空格

### flat和flatMap

- `flat()` 方法：将多维数组降低维度
    - 参数为降低的维度，为数值。默认值为1
- `flatMap()` 方法：将多维Map降低维度
    - 参数为降低的维度，为数值。默认值为1

### Symbol.prototype.description

`s.description` 属性：返回Symbol的标识符

# ES11新特性

### 私有属性

在class类里定义的私有属性（属性名前加 `#` ），实例化后无法在类的外部进行访问。

### Promise.allSettled

- `Promise.allSettled([p1, p2])` 方法：传入一个Promise对象组成的数组，返回一个状态始终为成功的Promise对象，成功的值为每个Promise对象自身的状态和值
- `Promise.all([p1, p2])` 方法：传入一个Promise对象组成的数组，返回一个Promise对象，其状态和值由传入的Promise数组决定
    - 若所有传入的Promise对象状态均为成功，则返回的Promise对象状态为成功，值为每个传入的Promise对象自身的值
    - 若传入的Promise对象中状态有失败的，则返回的Promise对象状态为失败，值为传入的Promise对象中失败的值

### String.prototype.matchAll

正则中对数据批量提取。

### 可选链操作符

`?.` 可选链操作符：用于做多层次的布尔判断，以取代 `&&` 。

### 动态import

按需动态引入模块文件，提高加载效率。

```js
import('./src/js/m1.js').then(module => {
  module.hello();
});
```

- 在需要加载js模块文件的时候再动态引入
- 返回的是一个Promise对象，成功的值即为引入的js模块文件中，暴露出来的对象

### BigInt

用于大数值的运算。

`Number.MAX_SAFE_INTEGER` 表示运算时的最大安全整数，而BigInt类型的大数值可以超过它进行运算。

- 大整型：在赋值时，数值后面加 `n`
- `BigInt()` 将普通的整型转换为大整形
    - 转换后的大整形不能直接与普通整型运算，参与运算的数值都应为大整型

### globalThis

全局对象：不论当前的执行环境如何，globalThis始终指向全局对象。