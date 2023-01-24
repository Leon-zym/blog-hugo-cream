---
title: JavaScript ES6 新特性
date: 2022-04-03
categories: Programming
tags: [JavaScript]
---

# Promise

Promise是ES6引入的异步编程的新解决方案。

语法上Promise是一个构造函数，用来封装异步操作并可以获取其成功和失败的结果。

### 实例化并调用

```js
// 实例化Promise构造函数
const p = new Promise(function (resolve, reject) {
  let data = '数据库中的数据';
  // 如果成功则调用resolve方法
  resolve (data);

  // 如果失败则调用reject方法
  // let err = '数据获取失败';
  // reject(err);
})

// 调用Promise对象的then方法
p.then(function (value) {
  // 成功时执行
}, function (reason) {
  // 失败时执行
})
```

### 应用

- Promise封装读取文件操作
- Promise封装Ajax操作

### then方法

`p.then (function (value) {成功时的回调函数体}, function (reason) {失败时的回调函数体});`

then方法本身也有一个返回结果，是一个Promise对象，而这个对象的状态由回调函数的执行结果决定：

- 如果回调函数中返回的结果为非Promise类型的属性，则状态为成功，返回值为对象成功的值
- 如果回调函数中返回的结果为Promise对象，则状态为该Promise对象的状态，返回值为该Promise对象的值
- 如果回调函数中抛出错误，则状态为失败，返回值为抛出的错误

---

then方法可以链式调用。

### catch方法

是then方法的一个语法糖，用来执行失败时的回调函数。即相当于then方法里只写第二个失败的参数。

`p.catch (function (reason) {失败时的回调函数体});`

# Set

ES6提供了新的数据结构 `Set`（集合），实质上为对象。它类似于数组，但成员的值是唯一的。

集合实现了Iterator接口，所以可以使用扩展运算符 `...` 和 `for...of` 遍历。

### 声明

`let s = new Set();` 

`let s = new Set(['arr1', 'arr2', 'arr3']);`

### 特性

- 集合中的成员会自动去重

### 属性和方法

- `s.size` 属性：获取集合的成员个数
- `s.add(arr)` 方法：向集合中添加新成员arr
- `s.delete(arr)` 方法：删除集合中的成员arr
- `s.has(arr)` 方法：查询集合中是否有arr成员，返回true或false
- `s.clear()` 方法：清空集合
- 遍历集合s：`for(let v of s) {函数体}`

### 应用

- 数组去重：先将数组传进 `new Set()` 转换为一个集合，然后再用 `...` 扩展运算符展开后转换回数组，即可实现数组去重
    - `let result = [...new Set(arr)];`
- 数组交集：去重后（减少计算），利用数组的 `filter()` 方法和集合的 `s.has()` 方法结合实现返回两数组的交集
    - `let result = [...new Set(arr1)].filter(item => new Set(arr2).has(item));`
- 数组并集：将两数组用 `...` 展开后合并为一个新数组，然后执行数组去重的操作
    - `let union = [...new Set([...arr1, ...arr2])]`
- 数组差集：在求数组交集的基础上，加入一个取反的步骤
    - `let diff = [...new Set(arr1)].filter(item => !(new Set(arr2).has(item)));`

# Map

ES6提供了Map数据结构，实质上为对象。它类似于对象，也是键值对的集合。

但其中的”键“不限于字符串，还可以是各种类型的值（包括对象）。

Map也实现了Iterator接口，所以可以使用扩展运算符 `...` 和 `for...of` 遍历。

### 声明

`let m = new Map();`

### 属性和方法

- `m.size` 属性：获取Map中键值对的个数
- `m.set(key, value)` 方法：增加一个新键值对
- `m.delete(key)` 方法：删除某个键值对key
- `m.get(key)` 方法：获取某个键值对key
- `m.clear()` 方法：清空Map

---

实质上，Map中的每一个键值对都是一个数组，此数组的元素都有两个（键和值）。

# class类

ES6提供了更接近传统语言的写法，引入了class类的概念，作为对象的模板。

通过class关键字，可以定义类。

class可以看做js的一个语法糖，它的绝大部分功能，ES5都可以做到，新的class写法只是让对象原型的写法更加清晰，更像面向对象编程的语法而已。

### 定义class类

```js
class Phone{
  // 构造方法（名字不能修改，在new的时候自动执行）
  // 属性
  constructor(brand, price) {
    this.brand = brand;
    this.price = price;
  }

  // 方法
  call() {
    console.log('I can call.');
  }
}
```

### class类的静态成员

```js
class Phone{
  // 定义静态成员（属性或方法）
  static name = '手机';
  static change() {
    console.log('我可以改变世界');
  }
}

let nokia = new Phone();
console.log(nokia.name);  // 输出undefin
console.log(Phone.name);  // 输出 手机
```

可以看出，类的静态成员属于类本身，而不属于实例对象

### class类继承

使用extends关键字实现继承。

略 ... ...

### 子类对父类的重写

子类不能直接调用父类的同名方法。

略 ... ...

### get和set

- get：在class类的定义中，使用get定义的属性可以绑定一个函数，在调用该属性时，会自动执行绑定的函数，且该属性的值即为函数的return返回值
- get应用：需要对象动态计算结果并返回的时候
- set：在class类的定义中，使用set定义的属性可以绑定一个函数，同时函数必须有一个参数传入。在调用该属性并对其赋值时，会自动执行绑定的函数
- set应用：可以做更多的控制和判断，如判断给对象设置的的值是否合法

# 数值扩展

- `Number.EPSILON` 属性：js中的最小精度。`EPSILON` 的值接近于 2.22 E-16，可以用于解决浮点数计算的精度问题
- 二进制和八进制：二进制数用 `0b` 开头，八进制数用 `0o` 开头，十六进制用 `0x` 开头
- `Number.isFinite()` 方法：判断数值是否为一个有限数。返回值为true或false
- `Number.isNaN()` 方法：判断数值是否为一个NaN。返回值为true或false
- `Number.isInteger()` 方法：判断数值是否为一个整数。返回值为true或false
- `Number.parseInt()` 和 `Number.parseFloat()` 方法：将字符串转换为整数和浮点数，均会舍弃字符部分
- `Math.trunc()` 方法：将数字的小数部分直接抹掉
- `Math.sign()` 方法：判断数值是正数（返回1），负数（返回-1），0（返回0）

# 对象方法的扩展

- `Object.is(value1, value2)` 方法：判断两个值是否完全相等。返回值为true或false
    - 可以对NaN做判断
- `Object.assign(obj1, obj2)` 方法：将两个对象合并为一个并返回
    - obj1中冲突的键会被obj2覆盖，不冲突的保留
    - 可用于配置项的合并
- `Object.setPrototypeOf()` 方法：设置原型对象
- `Object.getPrototypeOf()` 方法：获取原型对象

# 模块化

模块化是指将一个大的程序文件，拆分成许多小的文件，再将许多小的文件组合起来。

### 模块化的优点

- 防止命名冲突
- 代码复用
- 高维护性

### 实现语法

- `export` 命令：用于规定模块的对外接口
    - 分别暴露：在需要暴露的语句前面加上 `export` 关键字即可
      
        ```js
        export let name = 'Leon';
        export function cando() {
          console.log('I can code.');
        }
        ```
        
    - 统一暴露：将需要暴露的名称统一写在 `export {}` 中
      
        ```js
        let name = 'Leon';
        function cando() {
          console.log('I can code.');
        }
        
        export {name, cando};
        ```
        
    - 默认暴露：将需要暴露的对象写在 `export default {}` 中
      
        ```js
        export default {
          name: 'Leon',
          cando: function() {
            console.log('I can code.');
          }
        }
        ```
        
        - 在调用时需要多加一层default
- `import` 命令：用于输入其他模块提供的功能
    - 通用导入方式：
      
        ```js
        <script type="module">
          // 引入m1.js的内容，将其中全部暴露出来的语句赋给m1变量
          import * as m1 from "./src/js/m1.js";
        </script>
        ```
        
    - 解构赋值方式：
      
        ```js
        <script type="module">
          // 引入分别暴露或统一暴露
          import {name, cando} from "./src/js/m1.js";
          import {name as myname, cannotdo} from "./src/js/m2.js";
          
          // 引入默认暴露
          import {default as m3} from "./src/js/m3.js";
        </script>
        ```
        
        - 若出现命名冲突，可以使用别名
        - 引入默认暴露，必须使用别名
    - 简便方式：仅针对默认暴露
      
        ```js
        <script type="module">
          import m3 from "./src/js/m3.js";
        </script>
        ```
    
- 通过入口文件使用模块化
    1. 将import语句写在入口文件中
    2. 使用 `<script scr="./src/js/app.js" type="module"></script>` 标签引入入口文件

### 使用工具实现

- babel-cli
- babel-preset-env
- browserify（webpack）

### 引入npm包

1. 安装npm包
2. 使用 `import $ from 'jquery';` 引入npm包（如jQuery）