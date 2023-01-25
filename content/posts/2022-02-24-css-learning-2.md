---
title: CSS 基础 (二)
date: 2022-02-24
categories: Programming
tags: [CSS]
---

# 盒子模型

- Content padding border margin

### border 边框

- border-width 边框粗细
- 值：px

- border-style 边框样式
- 值：none默认，solid，dotted，dashed

- border-color 边框颜色
- 值：预定义颜色值，十六进制，rgb

- 复合属性 border: width style color
    - 不严格要求顺序，但一般按照此顺序

- border-top  border-bottom  border-left  border-right 可以分别设置盒子的4条边

- border-collapse: collapse 合并相邻的边框

- border边框宽度会影响盒子的实际大小

### padding 内边距

- padding-top  padding-bottom  padding-left  padding-right 分别设置内边距的大小，即边框与内容之间的距离

- 复合属性 padding: px
    - 一个值：上下左右都相同
    - 两个值：上下相同，左右相同
    - 三个值：上，左右相同，下
    - 四个值：上，右，下，左
    - 顺时针设置

- padding内边距的大小也会影响盒子的实际大小
- 但如果盒子本身没有指定width/height大小，则padding不会撑开盒子

### margin 外边距

- margin-top  margin-bottom  margin-left  margin-right 分别设置外边距的大小，即盒子与盒子之间的距离

- 复合属性 margin: px
    - 一个值：上下左右都相同
    - 两个值：上下相同，左右相同
    - 三个值：上，左右相同，下
    - 四个值：上，右，下，左
    - 顺时针设置
    
- 块级元素水平居中对齐：
    - 设置width宽度
    - margin: 0 auto
- 行内元素或行内块元素水平居中对齐：
    - 给其父元素添加text-align: center

- 使用margin定义块级元素的垂直外边距时，可能会出现外边距的合并
- 嵌套块元素垂直外边距margin的塌陷
    - 对于两个嵌套关系（父子关系）的块元素，父元素有上margin，子元素也有上margin，此时父元素会塌陷较大的margin值
    - 解决方案：
        - 为父元素定义上边框border
        - 为父元素定义内边距padding
        - 为父元素添加 overflow: hidden

- 清除内外边距
  
    ```css
    * {
      padding: 0;
      margin: 0;
    }
    ```
    
- 行内元素尽量只设置左右内外边距，不要设置上下内外边距，但可以转换成块元素或行内块元素后再设置

# 属性

- list-style 列表样式
- 值：none

- border-radius 圆角边框
- 值：圆角半径px，百分比%
    - 若盒子为正方形，且将圆角的半径设置为正方形边长的一半，则效果为圆形
    - 若盒子为长方形，且将圆角的半径设置为矩形高度的一半，则效果为圆角矩形
    - 可以有4个值，分别为左上角 右上角 右下角 左下角
    - 2个值，分别为左上右下角 右上左下角
    - 或3个值
    - 也可以分开写 border-top-left-radius  border-bottom-right-radius等

- box-shadow 盒子阴影
- 值：
    - h-shadow 水平阴影的位置px，可为负，必须
    - v-shadow 垂直阴影的位置px，可为负，必须
    - blur 模糊距离px，可选
    - spread 阴影的尺寸px，可选
    - color 阴影的颜色，可选
        - 常将其设置为rgba的形式，调整透明度
    - inset 将默认的外部阴影改为内部阴影，可选
- 阴影不占用空间，不影响其他盒子的布局

- text-shadow 文字阴影
- 值：
    - h-shadow 水平阴影的位置px，可为负，必须
    - v-shadow 垂直阴影的位置px，可为负，必须
    - blur 模糊距离px，可选
    - color 阴影颜色，可选

# 浮动

- 多个块级元素纵向排列用**标准流**，多个块级元素横向排列用**浮动**

- float 创建浮动框
- 值：none默认，left元素向左浮动，right元素向右浮动

### 浮动特性

- 脱标：脱离标准流的控制
- 浮动的盒子不再保留原来的位置
- 如果多个盒子都设置了浮动，则它们会按照属性值在一行内显示，且顶端对齐排列
- 如果父级元素的宽度装不下一行的浮动盒子，则多处的盒子会另起一行对齐
- 浮动的盒子之间不会有空隙
- 任何元素都可以设置浮动，且设置后都会具有行内块元素的特性
    - 块级元素本身未设置宽度，本于父级元素一样宽，但设置浮动后，大小由内容决定
    - 如果行内元素有了浮动，则不需要转换即可设置宽高度等

- TIPS：
    - 常先用标准流的父级元素上下排列位置，再将内部的子元素浮动，左右排列位置
    - 常先设置盒子的大小，再设置盒子的位置
    - 浮动的盒子只会影响浮动盒子后面的标准流，不会影响前面的标准流
    - 多个子元素盒子，其中一个要设置浮动，则应该将其他盒子都设置浮动，以防出现问题

 

- 由于很多时候父元素的高度不固定，因此可以不设置父元素的高度，由内部子元素的高度撑开，但需要清除浮动
    - clear 清除浮动
    - 值：left清除左侧浮动的影响，right清除右侧浮动的影响，both清除左右两侧的浮动影响
        - 需要在HTML里子元素后面，设置一个空的块级元素，并在CSS里调用其赋予clear属性
    
    - overflow 清除浮动
    - 值：hidden，auto，scrol
        - 给父元素添加overflow的属性，以清除浮动
    
    - :after 伪元素法清除浮动
        - 给HTML里父元素添加clearfix的类名，并在CSS里调用以下代码：
        
        ```css
        .clearfix:after {
          content: "";
          display: block;
          height: 0;
          clear: both;
          visibility: hidden;
        }
        .clearfix {
          *zoom: 1;
        }
        ```
        
    - 双伪元素清除浮动
        - 给HTML里父元素添加clearfix的类名，并在CSS里调用以下代码：
        
        ```css
        .clearfix:before, .clearfix:after {
          content: "";
          display: table;
        }
        .clearfix:after {
          clear: both;
        }
        .clearfix {
          *zoom: 1;
        }
        ```
        

# CSS TIPS

### CSS属性书写顺序

1. 布局定位属性：display position float clear visibility overflow
2. 自身属性：width height margin padding border background
3. 文本属性：color font text-decoration text-align vertical-align white-space break-word
4. 其他属性（CSS3）：content cursor border-radius box-shadow text-shadow background:linear-gradient

### 页面布局整体思路

1. 确定页面的版心（可视区）
2. 分析页面中的行模块，以及每个行模块中的列模块
3. 一行中的列模块经常用float浮动布局，先确定每个列的大小，然后确定列的位置
4. 制作HTML的结构，先有结构后有样式

- 一般在CSS文件的最上面添加公共类
- 比如body清除margin和padding，a链接清除下划线

- 在头部的导航栏中，一般不会直接用 a 链接，而是用 li 列表包含 a 链接
- 需要让导航栏在一行显示，则是给 li 加浮动，因为 li 是块级元素，需要一行显示
  
- nav 栏可以不给宽度，以便将来可以继续添加文字。由于其浮动，所以具有行内块元素的特性，宽度由内容撑开
- 导航栏内链接文字不一样多，所以最好给 a 链接左右padding撑开盒子，而不是给宽度

- button元素默认有个边框，需要清除
- 表单中的输入框和按钮都属于行内块元素，中间有个缝隙，会影响宽度布局，可以将其都float浮动，以清除缝隙

- 浮动的盒子不会出现margin外边距合并塌陷的问题

# 定位

- 定位 = 定位模式 + 边偏移

- position 定位模式
- 值：static静态定位，relative相对定位，absolute绝对定位，fixed固定定位

- top，bottom，left，right 边偏移
- 值：px
    - 四个边偏移的量是相对于其父元素的偏移距离

- static 静态定位，默认模式
- 按照标准流的特性摆放位置，没有边偏移

- relative 相对定位
- 相对于自身原来的位置移动，移动时参照点是自身位置
- 原来在标准流的位置保留占有，不脱标

- absolute 绝对定位
- 如果没有祖先元素，或是祖先元素没有定位，则以浏览器为准定位
- 如果祖先元素有定位（相对 绝对 固定），则以最近一级的有定位的祖先元素为参考点移动位置
- 不占有自身原来的位置，脱标

- 子绝父相：因为父级元素需要占有位置，因此是相对定位，子盒子不需要占有位置，则是绝对定位

- fixed 固定定位
- 以浏览器的可视窗口为参照点移动位置
- 跟父元素没有任何关系
- 不随滚动条滚动
- 不占有自身原来的位置，脱标

- fixed固定定位的盒子固定在版心右侧位置算法：
    1. 让需要固定定位的盒子left: 50%，走到浏览器可视窗口的的一半位置，即版心的一半位置
    2. 再让需要固定定位的盒子margin-left为版心宽度width的一半距离，即多走版心宽度一半的位置
    3. 盒子即固定定位在版心的右侧对齐了

- sticky 粘性定位
- 以浏览器的可视窗口为参照点移动位置（fixed固定定位特性）
- 占有自身原来的位置（relative相对定位特性）
- 必须添加至少一个边偏移才会生效

总结：

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/css-grammer-2.png)

- z-index 定位叠放次序
- 值：auto默认，整数数值（正整数、负整数、0）
    - 数值越大，盒子越靠上
    - 如果数值相同，则按照代码书写顺序，后来者居上
    - 只有position定位的盒子才有此属性

- 绝对定位的盒子水平居中算法：
    1. 让需要水平居中的绝对定位盒子left: 50%，走到父级元素的水平中心位置
    2. 再让需要水平居中的绝对定位盒子margin-left为自身宽度的一半（负值），让盒子向左移动自身宽度的一半
    3. 盒子即处于水平居中的位置了
- 垂直居中同理

# TIPS

- 行内元素添加absolute绝对定位或者fixed固定定位后，可以直接设置宽度和高度
- 块级元素添加absolute绝对定位或者fixed固定定位后，如果没有设置宽度高度，则默认是内容的大小
- 脱标的盒子不会触发外边距合并塌陷，如浮动、绝对定位、固定定位
- 浮动的元素不会压住下面标准流的文字和图片，只会压住盒子
- 但绝对定位、固定定位会压住下面标准流所有的内容

# 元素的显示与隐藏

- display 属性
- 值：none隐藏对象，block显示对象（转换为块级元素）
    - 隐藏后不再占有原来的位置

 

- visibility 属性
- 值：visible显示对象，hidden隐藏对象
    - 隐藏后继续占有原来的位置

- overflow 溢出
- 值：visible显示溢出部分（默认），hidden隐藏溢出部分，scroll始终显示滚动条，auto仅在有溢出时显示滚动条
    - 有定位的盒子慎用overflow: hidden