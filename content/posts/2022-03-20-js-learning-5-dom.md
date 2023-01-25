---
title: JavaScript  DOM (一)
date: 2022-03-20
categories: Programming
tags: [JavaScript]
---

API（Application Programming Interface 应用程序编程接口）。

Web API是浏览器提供的一套操作浏览器功能和页面元素的API（BOM和DOM）。

# DOM简介

DOM（Document Object Model 文档对象模型）：是处理可扩展标记语言HTML或XML的标准编程接口。

### DOM树

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/js-dom-1.png)

DOM把以上内容都可看做是一个对象

# 获取元素

- `console.dir()` 打印返回的元素对象，可以更好的查看里面的属性和方法

### 根据ID获取

- `document.getElementById()` 方法
    - 参数为ID字符串，大小写敏感，用引号包含
    - 返回的是一个Element对象，若没有匹配到则返回null

### 根据标签名获取

- `document.getElementsByTagName()` 方法：在整个文档里获取
    - 参数为标签名字符串，用引号包含
    - 返回的是指定标签名对象的集合，以伪数组的形式存储（即使页面中没有或只有一个相应标签也依然是伪数组形式）
    - 要操作返回的对象，可以用索引号的方式查找某一个，或结合循环遍历所有
- `element.getElementsByTagName()` 方法：在父元素内部获取子元素
    - 要先通过`document`在整个文档里获取某个父元素对象的集合（伪数组），再通过`element[index]`获取伪数组里某单个父元素内部的标签
      
        ```js
        var ol = document.getElementsByTagName('ol');
        var li = ol[0].getElementsByTagName('li');
        ```
        
    - 但常结合ID获取来确定单个父元素
      
        ```js
        var ol = document.getElementById('ol');
        var li = ol.getElementsByTagName('li');
        ```
        

### 根据class类名获取（H5新增）

- `document.getElementsByClassName()` 方法
    - 参数为类名字符串，用引号包含
    - 返回的是指定类名对象的集合，以伪数组的形式存储（即使页面中没有或只有一个相应类名也依然是伪数组形式）
    - 要操作返回的对象，可以用索引号的方式查找某一个，或结合循环遍历所有

### 选择器获取（H5新增）

- `document.querySelector()` 方法：第一个元素对象
    - 参数为选择器字符串（#ID  .class  tag），用引号包含
    - 返回指定选择器的第一个元素对象
- `document.querySelectorAll()` 方法：所有元素对象
    - 参数为选择器字符串（#ID  .class  tag），用引号包含
    - 返回的是指定选择器的所有元素对象集合，以伪数组的形式存储（即使页面中没有或只有一个相应元素也依然是伪数组形式）

### 特殊元素获取

- `document.body` 方法
    - 返回整个body元素对象
- `document.documentElement` 方法
    - 返回整个html元素对象

# 事件基础

事件是可以被js检测到的一种行为：触发→响应 机制。

事件三要素：

1. 事件源：事件被触发的对象
2. 事件类型：事件被触发的条件（点击、按键、滚动等）
3. 事件处理程序：处理事件的函数

```js
var btn = getElementById('btn');
btn.onclick = function() {};
```

### 执行事件的步骤

1. 获取事件源
2. 注册事件（绑定事件），可忽略
3. 添加事件处理程序（函数赋值）

# 事件类型 总结

- `onclick` 鼠标点击
- `onfocus` 获得焦点
- `onblur` 失去焦点
- `onmouseover` 鼠标经过
- `onmouseout` 鼠标离开

# 操作元素

<aside>
💡 可用 `this` 代替事件函数的调用者

</aside>

<aside>
💡 不仅可以修改元素，也可读取元素

</aside>

### 修改元素的内容

- `element.innerText` 属性：
    - 仅修改元素内的文字，不能识别HTML标签，且会将空格、换行去除
- `element.innerHTML` 属性：
    - 不仅能改变元素内的文字，而且能识别HTML标签，且保留空格、换行
    - W3C标准，推荐使用

### 内置属性操作

- `element.属性名` 修改元素的内置属性
- `element.src` 属性：改变元素src属性
- `element.href` 属性：改变元素href属性
- `element.title` 属性：改变元素title属性

### 自定义属性操作

- `element.getAttribute('属性名')` 方法：读取元素的自定义属性值
- `element.setAttribute('属性名', '值')` 方法：修改元素的自定义属性值
- `element.removeAttribute('属性名')` 方法：移除元素的自定义属性

### H5自定义属性操作

- 目的是为了保存并使用数据。有些数据直接保存在页面中，不必保存在数据库
- H5规定，自定义属性名以 `data-` 开头并且赋值
- 可用 `getAttribute()` 获取自定义属性，`setAttribute()` 设置自定义属性
- H5新增，`element.dataset.属性名` 或 `element.dataset['属性名']` 获取自定义属性 ，属性名不含data-，且属性名以驼峰命名法书写
    - dataset是一个集合，存放了所有以data开头的自定义属性
    - 兼容性问题严重，且规范严格，不推荐使用

### 表单元素的属性操作

- `input.value` 属性：修改表单里面填充的文字
- `button.disabled` 属性：将按钮点击禁用
- `type` `checked` `selected` 等属性

### 样式属性操作

- `element.style.属性` 属性：行内样式操作
    - property属性名采用驼峰命名法
    - 修改后产生的是行内样式，权重比style中的样式高
    
    - 利用 `element.style.display = 'none'` 来隐藏页面元素
    - 利用 `element.style.backgroundPosition = '0 -' + index + 'px'` 结合循环来实现精灵图坐标依次改变
    
    - 事件类型：
        - `element.onfocus` 获得焦点事件
        - `element.onblur` 失去焦点事件

- `element.className` 属性：类名样式操作
    - 通过提前写好某个预制类名的CSS样式，然后通过事件给元素添加预制的类名，来达到修改样式属性的效果
    - 适合样式修改较多的情况下
    - 修改后会覆盖掉原来的类名
    - 若要保留原来的类名，可以利用多类名选择器，修改为先后都有的多类名

# 排他思想

如果有同一组元素，想要某个元素实现某种样式，需要用到循环的排他思想算法：

1. 所有元素清除样式
2. 给当前元素设置样式

# 节点操作

获取元素不仅可以利用DOM提供的方法，还可以利用节点关系。

利用节点关系（父子兄）获取元素，逻辑性强，但兼容性稍弱。

页面中的所有内容都是节点（node），在DOM树中，所有节点均可以通过JavaScript访问，所有节点均可被创建、修改、删除。

## 节点类型

一般节点至少拥有：nodeType（节点类型）、nodeName（节点名称）、nodeValue（节点值）这三个属性。

- 元素节点 nodeType：1（最常用）
- 属性节点 nodeType：2
- 文本节点 nodeType：3（文本包含空格、换行）

---

## 获取节点

### 父子节点操作

- `element.parentNode`  获取元素的父节点（最近的一级父节点）
    - 若找不到父节点就返回null
- `element.childNode` 获取元素所有的子节点集合（包含元素节点、属性节点、文本节点）
    - 若只要里面的元素节点，则需要结合循环，只要 `nodeType == 1` 的节点
    - 不推荐
- `element.children` 获取元素所有的子元素节点集合（只包含元素节点）
    - 只读属性
    - 非标准，但受到各个浏览器的支持，常用
    - 可根据索引号获取出子元素节点集合中的任意一个元素节点，常用
    - 元素最后一个节点的索引号不固定，则可用`element.children[element.children.length - 1]` 获取最后一个元素节点
- `element.firstChild` 获取元素的第一个子节点
- `element.lastChild` 获取元素的最后一个子节点
- `element.firstElementChild` 获取元素第一个子元素节点
    - 有兼容性问题
- `element.lastElementChild` 获取元素最后一个子元素节点
    - 有兼容性问题

### 兄弟节点操作

- `node.nextSibling` 获取当前元素的下一个兄弟节点（包含元素节点、属性节点、文本节点）
    - 若找不到则返回null
- `node.previousSibling` 获取当前元素的上一个兄弟节点
- `node.nextElementSibling` 获取当前元素的下一个兄弟元素节点（只包含元素节点）
    - 找不到就返回null
    - 有兼容性问题
- `node.previousElementSibling` 获取当前元素的上一个兄弟元素节点

## 创建节点

- `document.createElement('tagName')` 方法：创建由tagName标签指定的HTML元素（动态创建节点）
- `document.write('tagName')` 方法: 动态创建节点
    - 直接将内容写进页面的内容流. 但若文档流执行完毕再调用此方法, 则会导致页面全部重绘, 不常用
- `element.innerHTML` 属性: 为父节点创建子节点
    - 创建多个元素的效率更高, 但不要拼接字符串, 应采用数组形式拼接 (先把子节点循环push到数组中, 然后用join将数组转化为字符串给element.innerHTML)
- 三者区别
  
    ![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/js-dom-2.png)
    

## 添加节点

- `node.appendChild(child)` 方法：给node父节点的末尾添加一个child子节点
- `node.insertBefore(child, 指定子节点)` 方法：给node父节点的指定子节点前面添加一个child子节点

## 删除节点

- `node.removeChild(child)` 方法: 删除node父节点中的一个child子元素节点, 并返回删除的元素节点

<aside>
💡 阻止链接跳转 `javascript:void()0;` 或 `javascript:;`

</aside>

## 复制节点 (克隆节点)

- `node.cloneNode()` 方法: 克隆/拷贝node节点,并返回副本
    - 若参数为空或false, 则为浅拷贝, 只拷贝节点本身, 不拷贝其里面的子节点或内容
    - 若参数为true, 则为深拷贝, 拷贝节点本身和里面的子节点或内容