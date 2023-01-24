---
title: async / await 的用法回顾及一点思考
date: 2022-10-28
categories: Programming
tags: [JavaScript]
---

# async / await 用法巩固

async / await 是 Promise 的语法糖，是基于 Promise 实现的。作用是使得 Promise 的用法更加简洁明了，看起来像书写同步代码一样，避免了 then 方法的链式调用，更加直观。

## async

async 关键字表明其后面的函数内部包含异步操作。同时需要注意的是，async 会将其后面的这个普通函数的返回值包装成一个 Promise 对象，以 `Promise.resolve()` 的形式返回。我们可以通过 then 方法拿到返回的值。

```js
async fn() {
  // do something ...
  return 12
}

let res1 = fn()
console.log(res1) // Promise {<resolved>: 12}

fn().then(res => console.log(res)) // 12
```

## await

而 await 关键字只能出现在 async 关键字修饰的函数内部，不能单独使用。其后面一般跟一个返回 Promise 对象的函数，用于等待此 Promise 对象的状态改变（resolved / rejected）。

注意：

1. await 只是让 async 修饰的这个函数内部阻塞等待，而不是阻塞整个程序。
2. 如果 await 后面是一个 Promise 对象，则 await 会返回其成功的值，可以用变量承接
3. 如果 await 后面是一个普通的值，则会直接将其作为 await 的返回值

```js
async mainFn() {
  // do something ...
  let res = await mockRequest()
  console.log(res) // 12
}

mockRequest() {
  return new Promise(resolve => {
    // do something ...
    resolve(12)
  })
}
```

当然，如果 await 后面返回的 Promise 对象变为了 rejected，函数内部就不会往下执行了。我们需要使用 `try{} catch(){}` 来捕获错误。

```js
async mainFn() {
  // do something ...
  try {
    let res = await mockRequest()
    console.log(res) // 不会被执行
  } catch(err) {
    console.error(err) // 22
  }
}

mockRequest() {
  return new Promise(reject => {
    // do something ...
    reject(22)
  })
}
```

# 一个想法

> 突然想到，既然 async 可以把普通函数的返回值包装成 Promise 对象，那么是否可以完全替代 `new Promise(resolve, reject)` 来构造 Promise 对象呢？

## demo

```js
async request(id) {
  // send ajax request ...
  if(res.code == 0) {
    return res.data
  } else {
    return Promise.reject(res.message)
  }
}

async getUserData(id) {
  try {
    const userData = await this.request(id)
    console.log('userData:', userData)
  } catch(errMsg) {
    console.error('error message:', errMsg)
  }
}

getUserData(3438)
```

## 思考

当我把这个想法用 demo 代码写出来以后，我现在感觉答案应该是不行……

1. 用 async 修饰函数，只能自动地将 return 的结果统统变成 `Promise.resolve()` 的形式，但是处理失败的逻辑后，仍然需要手动调用 `Promise.reject()` 来包装返回值。这就得不偿失了
2. 那既然还是需要手动调用 `Promise.reject()`，那 async 的存在意义就不大了，还是需要用到 `Promise`、`resolve()`、`reject()` 这样的字眼。就偏离了初衷

3. 只能在 return 的时候改变 Promise 对象的状态，没法在改变状态后继续执行后面的代码了

## 再思考

> 那为什么要设计成 async 可以把普通函数的返回值包装成 Promise 对象呢？有什么作用？

突然想到，async 修饰函数就是表明函数内部存在异步操作，即所有 await 修饰的部分。那么 async 修饰的函数本身就也变成了一个异步的函数。

假如 async 修饰的函数 A 又被外部函数 B 所调用，需要等待函数 A 执行完才能继续，那么这个时候就可以在外部函数 B 中使用 await 修饰函数 A。

也就是说，使用 async / await 很多时候需要在里里外外的方法之间一层一层地包裹，所以将 async 设计成了这样。

emmmm……为了套娃。
