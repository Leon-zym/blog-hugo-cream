---
title: 回顾 手写一个 AJAX
date: 2022-12-07T09:00:00
categories: Programming
tags: [JavaScript]
---

## 乌龙

看面经的时候，遇到一道题是要求手写一个 AJAX 实现。本来是非常简单基础的内容，但我当时把 AJAX 和 XMLHttpRequest()  两个概念搞混了，理解成要手写实现一个 XMLHttpRequest()，着实有些摸不着头脑了。不过既然遇到了，还是回顾一下最基础的 AJAX 实现吧。

## 重新认识 AJAX

AJAX 是 Asynchronous JavaScript And XML 的简称。允许我们在不刷新整个页面的情况下，就可以异步获取数据，并更新页面的部分内容。

而 AJAX 的实现依赖浏览器自带的 `XMLHttpRequest()` 接口。

## 手写 AJAX 之 GET 请求

```js
const btn1 = document.querySelector('#button1')
const res1 = document.querySelector('#result1')

btn1.onClick = function() {
  // 创建 xhr 对象
  const xhr = new XMLHttpRequest()
  
  // 初始化，设置请求方法和 URL
  xhr.open('GET', 'https://leonzym.com/getData')
  // 发送请求
  xhr.send()
  
  // 每当异步对象的 readyState 发生改变，就会触发onreadystatechange 方法，readyState 有 0 1 2 3 4 五种，当为 4 的时候表示服务端的数据已经返回完毕
  xhr.onreadystatechange = function() {
    if(xhr.readyState === 4) {
      // 判断状态响应码，其中 2xx 开头的和 304 都表示成功
      if(xhr.status >= 200 && xhr.status < 300 || xhr.status == 304) {
        // 打印响应状态码、状态字符串
        console.log(xhr.status, xhr.stateText)
        // 打印所有响应头
        console.log(xhr.getAllResponseHeaders())
        // 打印响应体
        console.log(xhr.response)
        // 更新 result 节点
        res1.innerHTML = xhr.response
      }
    }
  }
}
```

## 手写 AJAX 之 POST 请求

就是多了添加请求头的操作，以及发送的 data 数据要放在 xhr.send() 方法中。

```js
const btn2 = document.querySelector('#button2')
const res2 = document.querySelector('#result2')

btn2.onClick = function() {
  // 准备要 post 的数据
  const jsonData = JSON.stringfy({name: 'Leon', age: 18})
  
  const xhr = new XMLHttpRequest()
  
  // 初始化，设置请求方法和 URL
  xhr.open('POST', 'https://leonzym.com/sendData')
  // 设置请求头
  xhr.setRequestHeader('Content-type', 'application/json')
  // 发送请求，并携带数据
  xhr.send(jsonData)
  
  xhr.onreadystatechange = function() {
    if(xhr.readyState === 4) {
      if(xhr.status >= 200 && xhr.status < 300 || xhr.status == 304) {
        console.log(xhr.status, xhr.stateText)
        console.log(xhr.getAllResponseHeaders())
        res2.innerHTML = xhr.response
      }
    }
  }
}
```

## 还需完善

- 兼容 IE6 及以下
- 处理 URL 路径中的中文
- 设置请求超时及其回调
- 完善失败时的回调
- 解决可能的跨域问题