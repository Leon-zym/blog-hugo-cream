---
title: JavaScript  DOM (二)
date: 2022-03-22
categories: Programming
tags: [JavaScript]
---

# 注册事件（绑定事件）

- 传统注册方式：利用on开头的事件
    - 注册事件的统一性：同一个元素的同一个事件只能设置一个处理函数，最后注册的处理函数会覆盖前面注册的处理函数
- 方法监听注册方式：W3C推荐的方式
    - 有兼容性问题，IE9+才支持
    - 同一个元素同一个事件可以注册多个监听器，按照注册顺序依次执行

## 事件监听方式

- `eventTarget.addEventListener(type, listener, [useCapture])` 方法：将指定的监听器注册到目标对象上，当该对象触发指定事件时，就会执行事件处理函数
    - type：事件类型字符串，如click、mouseover等，用引号包含，没有on
    - listener：事件处理函数，事件发生时，会调用该监听函数
    - useCapture：可选参数，为布尔值，默认为false
- `eventTarget.attachEvent(eventNameWithOn, callback)` 方法：
    - 只有IE8及以前版本的IE浏览器支持，不推荐

# 删除事件（解绑事件）

- 传统注册方式：`eventTarget.onclick = null` 方式
- 方法监听注册方式：

## 事件监听方式

- `eventTarget.removeEventListener(type, listener, [useCapture])` 方法：移除目标对象上的指定监听事件
    - 要移除的监听事件处理函数需要有函数名，所以在定义时不能用匿名函数
- `eventTarget.detachEvent(eventNameWithOn, callback)` 方法：
    - 不推荐

# DOM事件流

事件发生时会在元素节点之间按照特定的顺序传播，这个传播过程称为DOM事件流。

DOM事件流分为三个阶段：

1. 捕获阶段
2. 当前目标阶段
3. 冒泡阶段

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/js-dom-3.png)

- js代码中只能执行捕获或冒泡中的一个阶段
- `onclick`和`attachEvent` 只能得到冒泡阶段
- `eventTarget.addEventListener(type, listener, [useCapture])` 方法可以得到冒泡或捕获阶段：
    - 若useCapture参数为true，则表示在事件捕获阶段调用事件处理函数，若参数为false或空（默认），则表示在事件冒泡阶段调用事件处理函数
- 开发中很少使用事件捕获，更关注事件冒泡。且有些事件没有冒泡阶段，如 `onblur` `onfocus` `onmouseenter` `onmouseleave`

# 事件对象

- 事件对象写在事件处理函数的小括号内，类似形参，名称常用event、evt、e
- 当事件发生时，系统自动创建，不需要传参
    - 事件对象是事件相关的一系列数据集合，内部有很多属性和方法
- IE9-不兼容，用 `window.event` 代替

## 常见事件对象的属性和方法

- `e.target` 返回触发事件的对象
    - `this` 返回绑定事件的对象
    - IE9-浏览器用 `e.srcElement` 代替
- `e.type` 返回事件类型，不带on
- `e.preventDefault()` 方法：阻止默认事件行为，如阻止链接跳转、阻止提交按钮提交
    - IE9-不兼容，用 `e.returnValue` 属性代替
    - 也可用`return false;`语句代替，但会导致后面的代码不再执行

## 阻止事件冒泡

- `e.stopPropagation()`方法：利用事件对象里面的方法
    - IE9-用 `e.cancelBubble`属性代替

# 事件委托（代理、委派）

- 原理：不是为每个子节点单独设置事件监听器，而是为父节点设置事件监听器，然后利用冒泡原理影响设置每个子节点。
- 作用：只操作一次DOM，提高了程序的性能。
- 结合 `e.target` 获得并操作触发事件的子节点对象

# 常用的鼠标事件

- `contextmenu` 鼠标右键菜单
    - 用于禁用默认的浏览器上下文菜单
      
        ```js
        document.addEventListener('contextmenu', function(e) {
          e.preventDefault();
        }
        ```
    
- `selectstart` 鼠标选中文字
    - 用于禁止鼠标选中文字
      
        ```js
        document.addEventListener('selectstart', function(e) {
          e.preventDefault();
        }
        ```
        

# 鼠标事件对象 MouseEvent

- `e.clientX` 返回鼠标相对于浏览器窗口可视区的X坐标
- `e.clientY` 返回鼠标相对于浏览器窗口可视区的Y坐标
- `e.pageX` 返回鼠标相对于文档页面的X坐标，IE9+兼容
- `e.pageY` 返回鼠标相对于文档页面的Y坐标，IE9+兼容
- `e.screenX` `e.screenY` 返回鼠标相对于电脑屏幕的XY坐标

# 常用键盘事件

- `keyup` 按键被松开时触发
- `keydown` 按键被按下时触发
- `keypress` 按键被按下时触发，但不能识别ctrl、shift等功能键
- 三个事件的执行顺序：keydown keypress keyup
- keydown和keypress在按键被按下但文本还未落入文本框时就触发，而keyup在按键被松开且文本已经落入文本框时才触发

# 键盘事件对象 KeyboardEvent

- `e.keyCode` 返回按键的ASCII值
    - 事件若为 `keyup` 或 `keydown` ，则不区分字母大小写，均返回大写字母的ASCII值
    - 事件若为 `keypress` ，则区分字母大小写