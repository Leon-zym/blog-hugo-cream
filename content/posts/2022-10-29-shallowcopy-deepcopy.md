---
title: 彻底搞懂深浅拷贝及其实现
date: 2022-10-29
categories: Programming
tags: [JavaScript]
---

# 什么是深浅拷贝

想当初，我一直以为赋值也算是浅拷贝……

## 赋值

对基本类型来说，赋值后就是两份栈内存中的独立数据，赋值后互不影响；对引用类型来说，赋值后仅是两份栈内存中的地址，地址指向堆内存中的同一份数据，赋值后相互影响。

实际上，浅拷贝和深拷贝都是对于引用类型来说的，比如拷贝一个对象或数组。

## 浅拷贝

新建一个对象，这个对象有原始对象的属性值的一份精确拷贝。如果属性是基本类型，拷贝的就是基本类型的值；如果属性是引用类型，拷贝的是其内存地址，会互相影响。

简单说，浅拷贝只解决了第一层的问题。

## 深拷贝

深拷贝会拷贝原始对象的所有属性，并拷贝属性指向的动态分配的内存。当对象和它所引用的对象一起被拷贝时即为深拷贝。

深拷贝相较于浅拷贝速度慢并且花销更大。深拷贝的两个对象互不影响。

# 如何实现深浅拷贝

## 浅拷贝的实现

### Object.assign() 实现

`Object.assign()` 把所有可枚举属性从一个或多个对象复制到目标对象，返回目标对象。

```js
const origin = {
  name: "Leon",
  friend: {
    name: "Jack",
    age: 18
  }
}
const shallowCopy = Object.assign({}, origin)

shallowCopy.name = "Mike"
shallowCpoy.friend.age = 23

console.log(origin)
// { name: "Leon", friend: { name: "Jack", age: 23 } }
console.log(shallowCopy)
// { name: "Mike", friend: { name: "Jack", age: 23 } }
```

### 拓展运算符实现

ES6 的 `...` 拓展运算符。

```js
let origin = ['Leon', 'Jack', ['Apple', 'Banana']]
let shallowCopy = [...origin]

shallowCopy[1] = 'Allen'
shallowCopy[2][1] = 'Peach'

console.log(origin)
// ['Leon', 'Jack', ['Apple', 'Peach']]
console.log(shallowCopy)
// ['Leon', 'Allen', ['Apple', 'Peach']]
```

### Array.prototype.slice() 实现

`slice()` 方法返回的是原数组的浅拷贝，原数组不会被改变。

```js
let origin = [0, 1, [2, 3]]
let shallowCopy = origin.slice(0) // 从第0个开始到数组结束，即整个数组

shallowCopy[1] = 8
shallowCopy[2][1] = 9

console.log(origin)
// [0, 1, [2, 9]]
console.log(shallowCopy)
// [0, 8, [2, 9]]
```

当然，`Array.prototype.concat()` 也一样可以实现。

### 自己手写实现

```js
function shallowCopy(object) {
  // 只拷贝对象
  if (!object || typeof object !== "object") return
  // 根据 object 的类型判断是新建一个数组还是对象
  let newObject = Array.isArray(object) ? [] : {}
  // 遍历 object，并且判断是 object 的自身属性才拷贝
  for (let key in object) {
    if (object.hasOwnProperty(key)) {
      newObject[key] = object[key]
    }
  }
  return newObject
}
```

这里注意，之所以还要用 `hasOwnProperty()` 多判断一步，是因为遍历原始对象时，其原型链上的属性也会被遍历到，而我们只需要拷贝其自身的属性。

## 深拷贝的实现

### Lodash 的 _.cloneDeep() 方法实现

```js
const _ = require('lodash')

let origin = {
    a: 1,
    b: { f: { g: 1 } },
    c: [1, 2, 3]
}
let deepCopy = _.cloneDeep(origin)

console.log(origin.b.f === deepCopy.b.f) // false
```

// TODO 源码分析

### jQuery 的 $.extend() 方法实现

```js
const $ = require('jquery')

let origin = {
    a: 1,
    b: { f: { g: 1 } },
    c: [1, 2, 3]
}
let deepCopy = $.extend(true, {}, origin)

console.log(origin.b.f === deepCopy.b.f) // false
```

### JSON.stringfy() 方法不完美实现

利用 `JSON.stringfy()` 将对象序列化成 JSON 字符串，再使用 `JSON.parse()` 来反序列化成对象。

```js
let origin = {
  name: "Leon",
  friend: {
    name: "Jack",
    age: 18
  }
}
let deepCopy = JSON.parse(JSON.stringfy(origin))

deepCopy.name = "Mike"
deepCopy.friend.age = 23

console.log(origin)
// { name: "Leon", friend: { name: "Jack", age: 18 } }
console.log(deepCopy)
// { name: "Mike", friend: { name: "Jack", age: 23 } }
```

这种实现方式比较常用，但是存在缺陷：

- 拷贝的对象中如果有函数、undefined、symbol，当使用过 `JSON.stringify()` 处理后都会消失
- 拷贝 Date 引用类型会变成字符串，拷贝 RegExp 引用类型会变成空对象
- 拷贝 NaN、Infinity、-Infinity，会变成 null
- 无法拷贝对象的原型链
- 无法拷贝不可枚举的属性
- 存在循环引用的问题，即存在 `prop[key] = prop`，会报错

如果原始对象中明确不存在以上的情况，才可以使用。

### 自己手写循环递归实现

// TODO