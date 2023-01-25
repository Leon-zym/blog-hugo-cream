---
title: JavaScript  BOM (一)
date: 2022-03-23
categories: Programming
tags: [JavaScript]
---

# BOM简介

BOM（Browser Object Model）：浏览器对象模型，提供了独立于内容而与浏览器窗口进行交互的对象。其顶级对象是window。

BOM缺乏标准，整体兼容性较差。

- BOM具有双重角色：
    - 它是js访问浏览器窗口的接口
    - 它是一个全局对象：定义在全局作用域的变量和函数都会自动变成window对象的属性和方法
        - 调用时可以省略window
        - `window.name` 是一个特殊属性，所以js变量名不应定为name

# window对象的常见事件

- `load` 窗口加载事件：等待页面全部加载完毕后会触发该事件，包含样式表、图片、flash等
- `DOMContentLoaded` 窗口加载事件：仅当DOM加载完毕后就会触发该事件，不包含样式表、图片、flash等，IE9+支持
- `resize` 窗口大小调整事件：当浏览器窗口大小变化时，就会触发该事件
    - 利用该事件完成响应式布局

# 定时器

### 回调函数

回调函数 callback：需要触发条件，条件触发后再回头调用的函数，不按照代码顺序直接调用

- `window.setTimeout(回调函数, [延迟的毫秒数])` 方法：在延迟时间到期后就会执行一次回调函数
    - 回调函数可以为函数名，也可以直接写一个函数
    - 延迟时间可以省略，若省略默认延迟时间为0，无单位
    - 定时器若有很多，则可以给定时器赋值一个标识符timeout ID
- `window.clearTimeout(timeout ID)` 方法：取消先前建立的timeout定时器
    - 参数timeout ID就是定时器的标识符
- `window.setInterval(回调函数, [延迟的毫秒数])` 方法：在间隔时间到期后会反复执行回调函数
    - 回调函数可以为函数名，也可以直接写一个函数
    - 延迟时间可以省略，若省略默认延迟时间为0，无单位
    - 定时器若有很多，则可以给定时器赋值一个标识符interval ID
- `window.clearInterval(interval ID)` 方法：取消先前建立的interval定时器
    - 参数interval ID就是定时器的标识符

# this指向问题

一般情况下，this指向最终调用它的对象

- 全局作用域下或普通函数中，this指向全局对象window（普通函数属于window的方法）
    - 定时器中的this指向window（因为定时器也是window的方法）
- 自定义对象的方法里面的this指向该对象
- 构造函数内的this指向构造函数实例

# js执行队列

js是单线程的，就意味着所有任务都需要排队。

## 同步和异步

为利用多核CPU的计算能力，HTML5提出Web Worker标准，允许js脚本创建多个线程，于是js出现了同步和异步。

- 同步任务：同步任务都在主线程上执行，形成一个执行栈
- 异步任务：js的异步是通过回调函数实现的，异步任务相关的回调函数会被添加到任务队列中（消息队列）
    - 普通事件：如click、resize等
    - 资源加载：如load、error等
    - 定时器：setTimeout、setInterval

## js执行机制

1. 先执行执行栈中的同步任务
2. 把异步任务（回到函数）放入任务队列中
3. 当执行栈中的同步任务执行完毕，系统就会按次序读取任务队列中的异步任务。于是异步任务结束等待状态，进入执行栈，开始执行

## 事件循环 event loop

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/js-bom-1.png)

主线程不断地重复获取任务、执行任务、再获取任务、再执行任务，这种机制称为事件循环 event loop

# location对象

location属性用于获取或设置窗体的URL，并且可以用于解析URL。因为这个属性返回的是一个对象，因此将之称之为location对象。

### URL

统一资源定位符（Uniform Resource Locator）是互联网上标准资源的地址。互联网上每个资源都有一个唯一的URL，它包含的信息指出文件的位置，以及浏览器应该怎么处理它。

URL的一把语法格式为：

`protocol://host[:port]/path/[?query]#fragment` 

---

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/js-bom-2.png)

## location对象的属性

- `location.href` 获取或设置整个URL
- `location.host` 返回主机（域名）
- `location.port` 返回端口号
- `location.pathname` 返回路径
- `location.search` 返回参数
- `location.hash` 返回片段

## location对象的方法

- `location.assign()` 方法：和href一样，可以跳转页面（重定向页面）
    - 记录历史，可以后退到先前的页面
- `location.replace()` 方法：替换当前页面
    - 不记录历史，不能后退到先前的页面
- `location.reload()` 方法：重新加载页面，相当于刷新
    - 若参数为true，则会强制刷新（不从缓存加载，直接从服务器加载）

# navigator对象

navigator对象包含浏览器的信息，它有很多属性，最常用的是userAgent，该属性返回由客户机发送至服务器的user-agent头部的值。

根据userAgent的值判断用户是移动端还是PC端，从而实现不同设备显示不同的页面。

# history对象

history对象可以与浏览器的历史记录进行交互。该对象包含用户在浏览器窗口中访问过的URL。

### history对象的方法

- `history.back()` 方法：后退功能
- `history.forward()` 方法：前进功能
- `history.go(参数)` 方法：前进后退功能
    - 参数为1，则前进一个页面。参数为-1，则后退一个页面