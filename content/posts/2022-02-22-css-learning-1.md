---
title: CSS 基础 (一)
date: 2022-02-22
categories: Programming
tags: [CSS]
---

# CSS语法规范

- 选择器及一条或多条声明组成
- 属性和属性值以键值对形式出现  属性:属性值;
- 外部样式表需要在HTML文件中添加<link>标签：<link rel="stylesheet" href="filename.css">

# 选择器

### 基础选择器

- 标签选择器
- 类选择器：不同HTMl元素可以调用同一个类，一个HTML元素可以同时调用多个类class
- id选择器：只能被调用一次
- 通配符选择器：不需要被调用，会作用于HTML里所有标签

### 复合选择器

- 后代选择器：包含后代以及后代的所有后代，隔开符号为空格
- 子选择器：仅包含子代当代，隔开符号为大于号
- 并集选择器：可以并集选择其他各种复合选择器，隔开符号为逗号
- 伪类选择器：
    - a链接伪类选择器：需要按照以下的顺序LVHA
        - a:link 选择所有未被访问的链接
        - a:visited 选择所有已被访问过的链接
        - a:hover 选择鼠标指针位于其上的链接
        - a:active 选择活动链接（鼠标按下未弹起）
    - focus 伪类选择器：用于选取获得焦点的表单元素
        - input:focus

# 元素显示模式

- 块级元素：独占一行
    - 可设置宽高度、内外边距，默认宽度和父级元素相同
    - 可包含块级元素和行内元素，但文字类的元素里面不允许放块级元素，如<p> <h>

- 行内元素（内联元素）：一行多个
    - 不可以直接设置宽度高度，默认宽度为本身内容的宽度
    - 只可包含文本和其他行内元素，但\<a>链接里面可以放块级元素，但将\<a>转换成块级元素更安全
    - \<a>链接里面不可再放\<a>链接

- 行内块元素：同时具有两者的特点
    - 一行多个，相邻元素之间会有空白间隙
    - 默认宽度为本身内容宽度
    - 宽高度、行高、内外边距都可设置

### 元素显示模式的转换

- 属性 display:
    - block 转换为块级元素
    - inline 转换为行内元素
    - inline-block 转换为行内块元素

# 属性

### 字体属性

- font-family 字体类型
- 值：字体名
    - 可包含多个字体，按照先后顺序寻找显示，字体名称若有空格则用引号包含
    - 可以直接给body元素指定字体

- font-size 字体大小
- 值：像素px
    - 可以给body元素指定字体大小

- font-weight 字体粗细
- 值：normal，bold，bolder，lighter，数字
    - 提倡使用数字，400=normal，700=bold

- font-style 字体样式
- 值：normal默认，italic斜体

- 复合属性 font:  font-style  font-weight  font-size/line-height  font-family
    - 不能颠倒顺序
    - font-size和font-family必须保留，其他可以省略

### 文本属性

- color 文本颜色
- 值：预定义颜色值red blue deeppink等，十六进制#ff0000等，RGB数值对rgb(255,0,0)
    - 常用十六进制表示
    
- text-align 文本水平对齐
- 值：left默认，center，right
    - 本质是让盒子里的文字对齐，盒子不会变

- text-decoration 文本装饰线
- 值：none默认，underline，overline，line-through
    - 可用于取消a链接自带的下划线

- text-indent 文本首行缩进
- 值：px，em
    - 只有第一行会缩进
    - 可以为负值，即向左凸出

- line-height 行间距（行高）
- 值：px
    - 行间距=上间距+文本高度+下间距
    - 本质是修改上下间距的大小
    - 可以设置行间距=盒子的高度，实现文字垂直居中

### 背景

- background-color 背景颜色
- 值：transparent默认，预定义颜色值，十六进制，rgb

- 背景线性渐变
- background: -webkit-linear-gradient( 起始方向，颜色1，颜色2，...)
- Tips：
    - 必须加浏览器私有前缀
    - 起始方向可以是方位名词或度数，默认为top

- background-image 背景图片
- 值：none默认，url(绝对地址 相对地址)
    - 背景颜色和背景图片可以同时添加，但背景图片会压住背景颜色

- background-repeat 背景平铺
- 值：repeat默认，no-repeat，repeat-x，repeat-y

- background-position 背景图片位置
- 值：x轴（方位名词，px），y轴（方位名词，px）
    - 方位名词：top bottom center left right，可以不按照先x后y的顺序，且若只指定其中一个方向，则另一个方向上默认居中对齐
    - px：严格按照先x后y的顺序，且若只指定一个方向（x轴），则另一个方向（y轴）默认垂直居中对齐
    - 也可以混合方位名词和px，但严格按照先x后y的顺序

- background-attachment 背景附着
- 值：scroll（默认值）随内容滚动显示，fixed固定显示

- 背景复合属性 background: bgc bgi bgr bga bgp
    - 属性值的顺序不分顺序，但建议按照约定顺序

- 背景颜色半透明 background: rgba(r, g, b, alpha)
    - rgb数值对 + 阿尔法通道（0～1）
    - alpha通道数可以省略小数点前的0
    - 仅将背景色半透明，不影响其他内容

# CSS三大特性

- 层叠性：当选择器和属性相同，因为存在多个属性值而冲突时，就近原则，覆盖且仅覆盖冲突的属性
- 继承性：子标签会继承父标签的某些样式（如文本类的属性，以及颜色）
    - 行高的继承性：行高数值后可以不跟单位，表示倍数，则后面继承这一属性的文字，行高均为其本身字体大小的相应倍数
- 优先级：当选择器不同，属性相同时，根据选择器的权重先后执行
  
    ![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/css-grammer-1.png)
    
    - 等级从左到右依次判断
    - 即使父级元素的权重很高，但子元素继承过来后权重仍然为0,0,0,0
    - 复合选择器会有权重的叠加，但不会有进位