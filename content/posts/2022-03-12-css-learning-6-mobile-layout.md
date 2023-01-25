---
title: CSS 移动端布局 (二)
date: 2022-03-12
categories: Programming
tags: [CSS]
---

# 规范

### 代码规范

- 类名语义化，简短明确，字母开头，字母均为小写，单词之间用下划线连接
- 类名嵌套尽量不超过三层
- 尽量避免直接使用元素选择器
- 避免使用id选择器
- 避免使用通配符 * 和 ! important
- 属性按顺序书写
    1. 布局定位属性：`display` `position` `float` `clear` `visibility` `overflow`
    2. 自身属性：`width` `height` `margin` `padding` `border` `background`
    3. 文本属性：`color` `font` `text-decoration` `text-align` `vertical-align` `white-space` `break-word`
    4. 其他属性（CSS3）：`content` `cursor` `border-radius` `box-shadow` `text-shadow` `background:linear-gradient`

### 目录规范

- 项目文件夹
    - 样式文件夹 css
    - 业务类图片文件夹 images
    - 样式类图片文件夹 icons
    - 字体类文件夹 fonts

# 响应式布局

- 原理：使用媒体查询，针对不同宽度的设备进行布局和样式设置，从而适配不同的设备
- 设备尺寸划分：
  
    ![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/css-layout-mobile-2.png)
    

### 响应式布局容器

响应式需要一个父级作为布局容器，来配合子元素实现变化效果。

在不同的屏幕下，通过媒体查询来改变这个布局容器的大小，再改变里面子元素的排列方式和大小。从而实现在不同的屏幕下，看到不同的页面布局和样式变化。

- 响应式尺寸划分（常用）
  
    ![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/css-layout-mobile-3.png)
    

# Bootstrap开发框架

**框架：**是指一套架构，它有一套比较完整的网页功能解决方案，且控制权在框架本身，有预制样式库、组件、插件。但使用者需要按照框架所规定的某种规范开发。

---

- **Bootstrap使用：**
    - 引入Bootstrap
    - 利用class类名调用文档里的预制组件、样式
    - 利用CSS层叠性覆盖Bootstrap默认的样式属性
        - 注意权重问题

- **布局容器：**Bootstrap需要为页面内容和栅格系统包裹一个.container容器。Bootstrap预先定义好了这个类，叫`.container`。它提供了两个这种类：
    - container类
      
        ![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/css-layout-mobile-4.png)
        
    - container-fluid类
      
        ![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/css-layout-mobile-5.png)
        

### Bootstrap栅格系统（grid system）

- Bootstrap提供了一套响应式、移动设备优先的流式栅格系统，随着屏幕或视口（viewport）尺寸的增加，系统会自动分为最多12列。
- Bootstrap里面在不同屏幕下，container的宽度不同，再把container划分为12等份
- 栅格系统划分的是页面的内容，而rem划分的是屏幕尺寸

---

- 栅格选项参数：栅格系统通过一系列的行（row）和列（column）的组合来创建页面布局。
  
    ![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/css-layout-mobile-6.png)
    
    - 行（row）必须放在container布局容器里面
    - 要实现列的平均划分，需要给列（column）添加**类前缀**
        - 如 `class="col-lg-3"` 表示在宽屏设备下，该列占3份
    - 若列大于12份，则最后一个元素将另起一行排列
    - 若列小于12份，则不会占满整个行
    - 可以同时为一列指定多个设备的类名，以便划分不同的份数
        - 如 `class="col-md-4 col-sm-6"` 表示在在中等屏幕下占4份，在小屏设备下占6份
    - 每一列默认有个左右15px的padding

- 列嵌套：在列嵌套后，栅格系统会在列内再划分12等份
    - 列嵌套最好加一个行row，这样可以取消父元素的padding值，而且高度和父级一样

- 列偏移：使用 `.col-md-offset-*` 类来将列向右侧偏移*份，以实现对齐效果

 

- 列排序：使用 `.col-md-push-*` 和 `.col-md-pull-*` 类来改变列的顺序

- 响应式工具：利用媒体查询功能，针对不同的设备展示或隐藏页面内容
    - 隐藏：
      
        ![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/css-layout-mobile-7.png)
        
    - 显示：
      
        ![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/css-layout-mobile-8.png)
        

# ETC

### vw和vh

- vw（viewport width）视口宽度单位
- vh（viewport height）视口高度单位
- vw和vh都是相对单位，类似em和rem
- 1vw = 1/100视口宽度，1vh = 1/100视口高度
- 百分比是相对于父级元素来说的，而vw和vh是相对于当前整个视口来说的，跟父级元素无关
- 开发中一般使用vw，很少使用vh
- 移动端可以使用，PC端兼容性差