---
title: CSS 移动端布局 (一)
date: 2022-03-08
categories: Programming
tags: [CSS]
---

# viewport 视口

- 布局视口 layout viewport
    - 一般的视口分辨率为980px，但元素会被缩小
- 视觉视口 visual viewport
    - 移动端浏览器的可视区域
- 理想视口 ideal viewport
    - 应手动添加meta视口标签
    - 将布局视口的宽度与理想视口的宽度一致

### meta视口标签

属性：

- width：宽度设置的是viewport宽度
    - 值：可以设置device-width特殊值，即设备的宽度
- user-scalable：用户是否可以缩放
    - 值：yes（1），no（0）
- initial-scale：初始缩放比
    - 值：大于0的数字，默认为1
- minimum-scale：最大缩放比
    - 值：大于0的数字
- maximum-scale：最小缩放比
    - 值：大于0的数字

# 二倍图

### 物理像素&物理像素比

- 1px不一定等于一个物理像素。PC端页面1px等于一个物理像素，但移动端不一定
- 1px能显示的物理像素的个数，成为物理像素比（dpr）
- 物理像素，即设备的实际分辨率
- 开发尺寸，即物理像素值除以物理像素比

### 多倍图

在标准viewport设置中，使用倍图来提高图片的质量，解决在高清设备中的模糊问题，通常为二倍图，但也还存在3倍图4倍图等。

### 背景缩放 background-size

- background-size 属性
- 值：
    - 宽度px 高度px
    - cover 扩大至完全覆盖父级元素的区域，但可能有部分图片显示不全
    - contain 扩大至图片的最大尺寸，以使其宽度高度完全适应父级元素的区域
- Tips：
    - 宽高度若只写一个参数，则其为背景图片的宽度，高度等比例缩放
    - 宽高度也可以用百分比表示，相对于父级元素
    - 若背景图是精灵图，则应先将精灵图缩放至相应倍数（px），然后再测量背景图缩放后的位置坐标

# 移动端技术解决方案

- 移动端浏览器主要考虑Webkit内核，兼容性问题较少
- 移动端开发可以单独制作移动端页面（主流），也可以制作响应式页面（复杂）
- CSS样式初始化（normalize.css）
- CSS3盒子模型 box-sizing: border-box;

### 特殊样式

- CSS3盒子模型
    - -webkit-box-sizing: border-box;
- 去除点击高亮：移动端链接点击后的背景高亮样式
    - -webkit-tap-highlight-color: transparent;
- 去除移动端浏览器默认的外观：在iOS上添加后才能给按钮和输入框自定义样式
    - -webkit-appearance: none;
- 禁用长按页面时的弹出菜单
    - img, a { -webkit-touch-callout: none; }

# 移动端常见布局

### 移动端技术选型

- 单独制作移动端页面（主流）
    - 流式布局（百分比布局）
    - flex弹性布局
    - less + rem + 媒体查询布局
    - 混合布局
- 响应式页面兼容移动端（其次）
    - 媒体查询
    - bootstrap

# 流式布局（百分比布局）

- width height 宽高度用百分比表示
- max-width（max-height） 最大宽高度
- min-width（min-height） 最小宽高度

- Tips：
    - 超出最大最小的宽高度以后，盒子的大小不再变化，出现滚动条
    - 一般最小宽度设为320px

# flex布局

flex布局也称为“弹性布局”，为盒状模型提供最大的灵活性，任何一个容器都可以指定为flex布局。

Tips：

- 当为父级元素设置flex布局后，子元素的float、clear、vertical-align属性都会失效
- 伸缩布局 = 弹性布局 = 伸缩盒布局 = 弹性盒布局 = flex布局
- 采用flex布局的元素，称为flex容器（flex container），简称“容器”。其所有子元素自动成为容器成员，称为flex项目（flex item），简称“项目”。
- 原理：通过给父盒子添加flex属性（display: flex），来控制子盒子的位置和排列方式

---

### 父项的常见属性

- flex-direction 设置主轴的方向
- 值：
    - row 水平从左到右（默认）
    - row-reverse 水平从右到左（元素顺序反转）
    - column 从上到下
    - column-reverse 从下到上（元素顺序反转）
- Tips：
    - 默认的主轴即X轴方向，水平向右；侧轴即Y轴方向，垂直向下
    - 子盒子默认跟着主轴方向排列
    - 当X轴Y轴中，其中一个方向设置为主轴后，侧轴即为另一个方向

---

- justify-content 设置主轴上子元素的排列方式
- 值：
    - flex-start 在主轴上靠头部对齐（默认）
    - flex-end 在主轴上靠尾部对齐（元素依然是从左到右的顺序，不反转）
    - center 在主轴上居中对齐
    - space-around 平分剩余空间
    - space-between 先头尾两边贴边，再平分剩余空间
- Tips：
    - 使用前一定要确定好主轴的方向

---

- flex-wrap 设置子元素是否换行
- 值：
    - nowrap 不换行（默认），如果子元素装不开，则会自动缩小子元素的宽度，始终在一行里显示
    - wrap 换行

---

- align-items 设置侧轴上子元素的排列方式（单行）
- 值：
    - stretch 拉伸（默认），在侧轴上将子元素拉伸至与父元素贴边，但子元素在侧轴方向上需要不舍设置宽高度
    - flex-start 在侧轴上靠头部对齐
    - flex-end 在侧轴上靠尾部对齐（元素依然是从左到右的顺序，不反转）
    - center 在侧轴上居中对齐
- Tips：
    - 只能在子元素为单行的时候使用，多行无效

---

- align-content 设置侧轴上子元素的排列方式（多行）
- 值：
    - flex-start 在侧轴上靠头部对齐（默认）
    - flex-end 在侧轴上靠尾部对齐（元素依然是从左到右的顺序，不反转）
    - center 在侧轴上居中对齐
    - space-around 平分剩余空间
    - space-between 先头尾两边贴边，再平分剩余空间
    - stretch 拉伸，在侧轴上将子元素拉伸至与父元素贴边，但子元素在侧轴方向上需要不舍设置宽高度
- Tips：
    - 只能在子元素为多行的时候使用，单行无效
    - 结合 flex-wrap: wrap 使用

---

- flex-flow 属性是flex-direction和flex-wrap两者的复合属性
- 值：
    - row wrap
    - row nowrap
    - column wrap
    - column nowrap
    - row-reverse wrap
    - row-reverse nowrap
    - column-reverse wrap
    - column-reverse nowrap

### 子项的常见属性

- flex 定义子项目分配的剩余空间
- 值：数值 / 百分比。表示该子项目所占剩余空间的份数
    - Tips：
    - 剩余空间平均分成若干分数，参与分配的子项的个数即为总的分数，flex的数值即为该子项所占的分数
    - 若参与分配的子项仅有一个，flex: 1即为全部占满

---

- align-self 控制子项目自己在侧轴上的排列方式
- 值：
    - auto（默认），表示继承父元素的align-items属性，如果没有父元素，则等同于stretch
    - stretch 拉伸，在侧轴上将子元素拉伸至与父元素贴边，但子元素在侧轴方向上需要不舍设置宽高度
    - flex-start 在侧轴上靠头部对齐
    - flex-end 在侧轴上靠尾部对齐（元素依然是从左到右的顺序，不反转）
    - center 在侧轴上居中对齐
- Tips：
    - 该属性允许单个项目有着与其他项目不同的对齐方式，可覆盖align-items属性

---

- order 定义项目的排列顺序
- 值：
    - 数值，数值越小排列顺序越靠前，可为负值（默认为0）
- Tips：
    - 和z-index不同

# rem适配布局

### rem（root em）单位

- em、rem都是相对单位
- em是相对于父元素的字体大小
- rem是相对于HTML元素的字体大小
- rem单位的优点就是可以通过改变HTML元素里面font-size文字大小，从而修改页面中元素的大小，可以整体控制

### 媒体查询（Media Query）

媒体查询是CSS3的新语法。

- @media媒体查询可以针对不同的屏幕尺寸设置不同的样式
- 在重置浏览器大小的过程中，页面也会根据浏览器的宽高度重新渲染页面

---

语法规范：

```css
@media mediatype and|not|only (media feature) {
  CSS-Code;
}
```

- 查询类型 mediatype
    - all 用于所有设备
    - print 用于打印机和打印预览
    - screen 用于电脑、平板、手机等屏幕

- 关键字：将媒体类型或多个媒体特性连接到一起，作为媒体查询的条件
    - and：将多个媒体特性连接到一起，相当于“且”
    - not：排除某个媒体类型，相当于“非”，可省略
    - only：指定某个媒体类型，可省略

- 媒体特性 media feature：根据不同的媒体类型的媒体特性，设置不同的展示风格。键值对要加小括号
    - width：px 定义输出设备中页面可见区域的宽度
    - min-width：px 定义输出设备中页面最小可见区域的宽度
    - max-width：px 定义输出设备中页面最大可见区域的宽度

---

Tips：

- 媒体查询应当按照从小到大或者从大到小的顺序写
- 但如果按照从小到大的顺序，代码可以更加简介。因为CSS的层叠性，后面的样式会层叠掉前面冲突的样式。

---

引入资源：

- 当样式比较繁杂的时候，可以针对不同的媒体设备使用不同的stylesheets样式表。
- 原理：在link中判断设备的尺寸，然后引入不同的CSS文件

语法规范：

```css
<link rel="stylesheet" media="mediatype and|not|only (media feature)" href="style.css">
```

### Less基础

CSS的弊端：

- CSS是一门非程序式语言，没有变量、函数、作用域等概念
- 没有逻辑代码，冗余度高
- 不方便维护、扩展、复用
- 没有很好的计算能力
- 对非前端开发工程师不友好

Less（Linear Style Sheets）是一门CSS扩展语言，也称为CSS预处理器。常见的CSS预处理器有：Sass、Less、Stylus。

Less在CSS的基础上，加入了程序式语言的特性。引入了变量、Mixin混入、运算、函数等功能。简化CSS的编写，降低维护成本。

---

- Less变量：
    - 定义：`@变量名: 值;`
- Less编译：Less文件不能直接被HTML引入使用，需要编译成CSS文件后再引入HTML中
- Less引入：在less文件中可以引入另一个less文件样式
    - `@import "Less文件名";`
- Less嵌套：
    - 后代选择器：在父元素的属性花括号内，直接嵌套子元素的选择器及其属性
    - 伪元素、伪类、交集选择器：在父元素的属性花括号内，加上&符号后，再嵌套选择器及其属性
- Less运算：任何颜色、数字、变量都可以参与运算
    - 提供 加+ 减- 乘* 除/ 运算
    - 数值与符号之间需要空格隔开
    - 两个数参与运算，若只有一个单位，则结果以这个单位为准
    - 两个数参与运算，若两个有不同的单位，则结果以第一个单位为准

### rem适配方案

技术方案1：

- less
- 媒体查询
- rem

技术方案2：（推荐）

- flexible.js
- rem

---

适配方案1：

- HTML中font-size大小
  
    ![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/css-layout-mobile-1.png)
    
- 元素大小取值方法：
    - 公式：页面元素的rem值 = 元素像素值px / (屏幕宽度px / 划分的份数)
    - 屏幕宽度px / 划分的份数，即HTML中的font-size大小
    - 公式简化：页面元素rem值 = 元素像素值px / HTML中font-size大小

适配方案2：

- 不需要再写媒体查询，由js处理
- 屏幕划分份数为10等份，HTML中font-size = 屏幕宽度 / 10
- 需要引入flexible.js文件
  
    ```css
    <script src="js/flexible.js"> </script>
    ```