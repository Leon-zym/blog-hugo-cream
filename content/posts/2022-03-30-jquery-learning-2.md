---
title: jQuery 学习 (二)
date: 2022-03-30
categories: Programming
tags: [jQuery]
---

# jQuery尺寸、位置操作

## jQuery尺寸

- `width()` `height()` 获取或修改元素的宽高度，只包含content部分的width和height
- `innerWidth()` `innerHeight()` 获取或修改元素的宽高度，包含content和padding部分的width和height
- `outerWidth()` `outerHeight()` 获取或修改元素的宽高度，包含content、padding和border部分的width和height
    - 若参数为true，则额外加上margin部分的宽高度

- Tips：
    - 尺寸值不跟单位，返回值为数字型

## jQuery位置

- `offset()` 方法：获取或设置元素相对于文档的偏移量，跟父级元素无关
    - 返回值为对象，内部有left和top属性
- `position()` 方法：获取元素相对于带有定位的父级元素的偏移量
    - 若无带有定位的父级元素，则以文档为准
    - 返回值为对象，内部有left和top属性
    - 不能设置只能获取

## jQuery被卷去的头部

- `scrollTop()` 获取或设置元素被卷去的头部
- `scrollLeft()` 获取或设置元素被卷去的左侧

- Tips：
    - 若要整个页面滚动，则对象应为 `$("body, html")`
    - 若要带动画的滚动，则采用animate里面的scrollTop属性

# jQuery事件

## 事件注册

`element.event(function() {})` 单个事件注册

## 事件处理

- `element.on(events, [selector], fn)` 可以同时注册多个事件和事件处理程序
    - events：一个或多个事件类型，用空格分隔
    - selector：可选参数，元素的子元素选择器，用于事件委派
    - fn：回调函数
    - 若要同时绑定多个事件处理函数，则参数采用对象形式依次书写
    - 可以给未来动态创建的元素注册事件，即先注册事件再创建元素
- `element.one(events, [selector], fn)` 只触发一次的事件绑定，触发后不再生效

## 事件委派

`element.on(events, [selector], fn)` 将事件注册到父级元素上，同时selector参数选择要作用于的子元素

## 事件解绑

- `element.off(events, [selector])` 将元素身上的事件解绑
    - 若参数为空，则表示将元素身上的所有事件解绑
    - 若只想解绑某些事件，则events参数为要解绑的事件类型
    - 若要解绑事件委派，则再跟上作用于的子元素

## 自动触发事件

- `element.event()` 直接触发事件
- `element.trigger("type")` 直接触发事件
- `element.triggerHandler("type")` 直接触发事件，但不会触发元素的默认事件行为，如光标闪烁等

## 事件对象

[事件对象](JavaScript%E8%BF%9B%E9%98%B6DOM%EF%BC%88%E4%BA%8C%EF%BC%89%204e89dcfed9694d0fbe44ce86e315e7b3.md) 

# 对象拷贝

`$.extend([deep], target, object1, [objectN])` 将对象拷贝（合并）给另一个对象使用

- 实为合并，即有冲突的会被新的覆盖
- deep：true为深拷贝，false为浅拷贝（默认）
    - 浅拷贝即只将复杂数据类型的地址拷贝过去，数据有关联性
    - 深拷贝即将对象整个拷贝过去，两份数据，没有关联性
- target：要拷贝给的目标对象
- object：被拷贝的源对象，可有多个

# jQuery多库共存

使jQuery的库和其他js库不冲突而共存。

- 将 `$` 符号统一改为 `jQuery`
- 自定义一个新的jQuery别称：`var nickName = $.noConflict()`

# jQuery插件

插件是依赖jQuery来完成的，所以仍需要先引入jQuery文件。

- 瀑布流
- 图片懒加载（延迟加载）：当用户滚动到可视区域时，再将图片加载出来。减轻服务器的压力
- 全屏滚动

## Bootstrap

- BootstrapJS也属于jQuery的插件，利用jQuery开发
- 要引入Bootstrap和jQuery两者的js文件。