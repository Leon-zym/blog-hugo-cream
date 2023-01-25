---
title: jQuery 学习 (一)
date: 2022-03-26T09:00:00
categories: Programming
tags: [jQuery]
---

# jQuery简介

JavaScript库即为library，是一个封装好的特定的集合（方法和函数）。

jQuery就是一个JavaScript库，为的是快速方便操作DOM，里面基本都是函数（方法）。

### 优点：

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/jquery-5.png)

### 使用步骤

1. 引入jQuery文件即可
2. 入口函数：
    - 等待DOM加载完毕后再执行js代码
      
        ```js
        $(document).ready(function() {
          
        })
        ```
        
    - 等待DOM加载完毕后再执行js代码
      
        ```js
        $(function() {
          
        })
        ```
        

- `$` 等同于`jQuery` ，是jQuery的别称
- `$` 是jQuery的顶级对象，相当与原生js中的 `window` 对象

### jQuery对象和DOM对象

- 原生js获取的对象就是DOM对象
- jQeury获取的对象就是jQuery对象，其本质是：把DOM元素利用 `$` 进行包装，以伪数组的形式存储
- 两种对象的属性和方法不能混用

- DOM对象转换为jQuery对象：`$(DOM对象)`
- jQuery对象转换为DOM对象：`$('选择器')[index]` 或 `$('选择器').get(index)`

# jQuery常用API

### jQuery选择器 `$('选择器')`

- jQuery基础选择器：引号里面直接写CSS选择器
  
    ![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/jquery-1.png)
    
- jQuery层级选择器
  
    ![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/jquery-2.png)
    
- jQuery筛选选择器
  
    ![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/jquery-3.png)
    
- jQuery筛选方法（方法，要加小括号）
  
    ![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/jquery-4.png)
    
- `parents()` 祖先选择器
    - 参数省略，表示选择所有的祖先元素，包括body和html
    - 参数可写指定的祖先元素名
- jQuery获取当前对象的索引号 `$(this).index()`

### 隐式迭代

遍历内部DOM元素（伪数组形式存储）的过程称为隐式迭代。即jQuery会自动将匹配到的所有元素进行遍历，执行相应的方法。

### jQuery排他思想

利用隐式迭代，不需要循环绑定事件，也不需要循环清除其他对象的相关属性。

1. `$(this)` 当前对象修改样式属性
2. `$(this).siblings()` 其他兄弟对象清除样式属性

### 链式编程

为了节省代码量，使代码更加优雅。

`$(this).css('color', 'red').siblings().css('color', '');`

### 操作css方法

- `$(this).css('属性名', '属性值')`
    - 参数若只写属性名，则返回属性值，带单位
    - 参数若是属性键值对，则修改相应的属性值，属性值若为数字，则可以不带单位和引号
- 设置多组样式：
  
    ```js
    $(this).css({
      属性名1: '属性值1',
      属性名2: '属性值2',
      属性名3: '属性值3',
    });
    ```
    
    - 同时设置多组样式可以采用对象形式，花括号包含、属性名属性值用冒号隔开、多个键值对用逗号隔开
    - 属性名和数字属性值可以不用加引号
    - 复合属性民必须采用驼峰命名法
- 设置类样式方法：类名不加点
    - 添加类名：`$(this).addClass('类名')`
        - 相当于追加类名，不会覆盖掉原来的类名
    - 移除类名：`$(this).removeClass('类名')`
    - 切换类名：`$(this).toggleClass('类名')`
        - 触发一次添加类名，再触发一次移除类名，依次切换

# jQuery效果

### 显示与隐藏

- 显示：`show([speed], [easing], [fn])`
    - 参数均可省略，无参数表示无动画直接显示
- 隐藏：`hide([speed], [easing], [fn])`
- 切换：`toggle([speed], [easing], [fn])`

### 滑动

- 下滑：`slideDown([speed], [easing], [fn])`
- 上滑：`slideUp([speed], [easing], [fn])`
- 切换：`slideToggle([speed], [easing], [fn])`

### 事件切换

- `hover([over], out)`
    - over鼠标经过触发的函数
    - out鼠标离开触发的函数
    - 若只写一个函数，则事件切换都执行这个函数。可结合toggle使用

### 动画队列

- 动画或效果队列：动画或效果一旦触发就会执行，如果多次触发，就会造成多个动画或效果排队执行。
- `stop()` 方法：写在动画或效果的前面，会先停止上一次的动画或效果，再去执行当前的动画效果

### 淡入淡出

- 淡入：`fadeIn([speed], [easing], [fn])`
- 淡出：`fadeOut([speed], [easing], [fn])`
- 切换：`fadeToggle([speed], [easing], [fn])`
- 渐进到指定不透明度：`fadeTo([speed], opacity, [easing], [fn])`
    - opacity不透明度为必要参数，取值范围 0~1

### 自定义动画 animate

- `animate(params, [speed], [easing], [fn])`
    - params为必要参数：想要修改的样式属性，以对象形式传递。
        - 花括号包含、属性名属性值用冒号隔开、多个键值对用逗号隔开
        - 属性名和数字属性值可以不用加引号
        - 复合属性民必须采用驼峰命名法

# jQuery属性操作

- `prop()` 获取或设置元素的固有属性值
- `attr()` 获取或设置元素的自定义属性值
- `data()` 数据缓存

# jQuery内容文本值

- `html()` 获取或修改元素内容（含标签）
- `text()` 获取或修改元素文本内容（不含标签）
- `val()` 获取或修改表单内部的值
- `toFixed()` 保留小数位数，参数为小数点后的位数

# jQuery元素操作

## 遍历元素

- `element.each(function(index, domEle) {})` 遍历DOM元素
    - 回调函数的第一个参数为索引号
    - 第二个参数为DOM元素，若要进行jQuery操作，组要转换为jQuery对象
    - 两个参数均可自定义名称
- `$.each(object, function(index, element) {})` 遍历数组和对象

## 创建元素

`$("元素标签")` 动态创建元素

## 添加元素

### 内部添加（父子关系）

- `element.append()` 将指定元素添加到父元素内部的最后面
- `element.prepend()` 将指定元素添加到父元素内部的最前面

### 外部添加（兄弟关系）

- `element.after()` 将指定元素添加到目标元素的后面
- `element.before()` 将指定元素添加到目标元素的前面

## 删除元素

- `element.remove()` 删除元素本身
- `element.empty()` 删除元素中的所有子节点
- `element.html("")` 删除元素中的所有子节点