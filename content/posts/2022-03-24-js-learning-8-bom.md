---
title: JavaScript  BOM (二)
date: 2022-03-24
categories: Programming
tags: [JavaScript]
---

# 元素偏移量

## offset系列

动态地得到元素的大小、位置等信息，不带单位。

- `element.offsetTop` 属性：返回元素相对于 带有定位的父级元素 上边框的偏移量
    - 若父级元素都没有定位，则返回相对于body的偏移量
- `element.offsetLeft` 属性：返回元素相对于 带有定位的父级元素 左边框的偏移
    - 若父级元素都没有定位，则返回相对于body的偏移量
- `element.offsetWidth` 属性：返回元素自身的width宽度，包含content、padding和border
- `element.offsetHeight` 属性：返回元素自身的height高度，包含content、padding和border
- `element.offsetParent` 属性：返回元素 带有定位的父级元素
    - 若父级元素都没有定位，则返回body

Tips：可以结合 `e.pageX` 和 `e.pageY` 确定鼠标在盒子里的坐标。

### offset与style的区别

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/js-bom-3.png)

## 鼠标事件

- `mousemove` 鼠标移动
- `mousedown` 鼠标按下
- `mouseup` 鼠标弹起

# 元素可视区

## client系列

使用client系列的相关属性获取元素可视区的相关信息。如动态获取元素的边框大小、元素大小等，不带单位。

- `element.clientTop` 属性：返回元素上边框的大小
- `element.clientLeft` 属性：返回元素左边框的大小
- `element.clientWidth` 属性：返回元素自身的width宽度，包含content、padding，不包含border
- `element.clientHeight` 属性：返回元素自身的height高度，包含content、padding，不包含border

Tips：与offset的主要区别就是返回的值不包含border边框。

# 元素滚动

## scroll系列

使用scroll系列的属性可以动态获取元素的大小、滚动距离等，不带单位。

- `element.scrollTop` 属性：返回元素被卷去的上侧距离
- `element.scrollLeft` 属性：返回元素被卷去的左侧距离
- `element.scrollWidth` 属性：返回元素自身的实际width宽度，包含超出盒子宽度的内容content，包含padding，不包含border
- `element.scrollHeight` 属性：返回元素自身的实际height高度，包含超出盒子高度的内容content，包含padding，不包含border

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/js-bom-4.png)

## 页面被卷去的距离

当浏览器的宽高度不足以显示整个页面时，会自动出现滚动条。当滚动条向下滚动时，页面上面被隐藏掉的高度，称为页面被卷去的头部。

页面滚动时，会触发 `scroll` 滚动事件。

- `window.pageYOffset` 属性：页面被卷去的头部距离
- `window.pageXOffset` 属性：页面被卷去的左侧距离

- IE9+支持，兼容性问题解决：

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/js-bom-5.png)

# 三大系列对比：

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/js-bom-6.png)

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/js-bom-7.png)

# Flexible.js分析

## 立即执行函数

不需要调用，定义后立即执行的函数，称为立即执行函数。

最大的作用是会独立创建一个作用域，内部的所有变量都是局部变量，不会有命名冲突的情况。

- `(function() {}) ()` 或者 `(function() {} ())`
- 可以传参
- 可以有函数名
- 若有多个立即执行函数，则需要在多个函数之间添加`;`隔开

## pageshow事件

- `pageshow` 事件：页面重新显示
    - 该事件应添加给window对象
- `pageshow` 与 `load` 的区别：
  
    ![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/js-bom-8.png)
    

# mouseenter和mouseover的区别

- `mouseenter` 事件：当鼠标移动到元素上时就会触发事件，类似mouseover

区别：

- mouseover是鼠标经过盒子自身会触发，经过其子盒子还会触发
    - 因为mouseover会冒泡
- mouseenter是鼠标只有经过自身盒子才会触发，经过其子盒子不会触发
    - 因为mouseenter不会冒泡

- `mouseleave` 事件：鼠标离开。常和mouseenter配合使用

# 动画函数封装

核心原理：通过定时器 `setInterval()` 不断移动盒子的位置。

### 封装步骤：

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/js-bom-9.png)

- 元素本身一定要添加定位
- 函数需要传递两个参数：动画对象、移动距离

### 动画函数给不同元素记录不同的定时器

将 `setInterval()` 定时器赋给动画对象的一个方法，以此将区分不同元素的不同定时器。

### 缓动效果原理

- 核心算法：（目标距离 - 当前的位置）/ 10

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/js-bom-10.png)

### 动画函数添加回调函数

回调函数callback定义后作为参数传给动画函数，然后在动画函数的定时器结束后再调用。