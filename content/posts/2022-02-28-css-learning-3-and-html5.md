---
title: CSS 技巧 + HTML5 新特性 + CSS3 新特性 (一)
date: 2022-02-28
categories: Programming
tags: [CSS, HTML]
---

# CSS高级技巧

### 精灵图

为了减少服务区接受和发送请求的次数，提页面的加载速度，，提出CSS精灵图技术（CSS Sprites）

- 核心原理：将网页中的一些小背景图整合到一张大图中
- 实现原理：利用background-position: x y 将大图移动到相应的显示区域位置
- 由于背景图片的默认坐标在左上角，所以一般background-position的x y坐标值为负数

### 字体图标

主要用于显示网页中通用、常用的小图标

- 显示为图标，但本质属于字体

### CSS三角

一些常见的三角形，可以直接用CSS画出来

- 利用无大小的盒子一侧方向的边框充当三角形
- 实现示例：
  
    ```css
    div {
      width: 0;
      height: 0;
      line-height: 0;
      font-size: 0;
      border: 50px solid transparent;
      border-left-color: pink;
    }
    ```
    
- 然后利用定位将三角子盒子放置在父盒子相应的位置上

### 鼠标指针样式

更改默认的鼠标指针样式

- cursor 属性
- 值：default三角箭头，pointer，move，text，not-allowed

### 表单样式

- input {outline: none} 取消点击输入框后的轮廓线
- textarea {resize: none} 防止拖拽文本域

### 行内块元素垂直对齐

- vertical-align 垂直对齐
- 值：baseline基线对齐（默认），top顶部对齐，middle中线对齐，bottom底线对齐
    - 只针对行内元素或行内块元素有效
    - 常用于设置图片或表单与文字垂直对齐
    - 还可去除图片底部默认的空白缝隙（为基线对齐保留的位置）

### 溢出文字的省略号显示

- 单行文本溢出显示省略号
    1. white-space 属性
        - 值：normal自动换行（默认），nowrap强制一行内显示
    2. overflow: hidden 溢出部分不显示
    3. text-overflow 属性
        - 值：ellipsis文字用省略号代替溢出部分
    
    ```css
    div {
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }
    ```
    
- 多行文本溢出显示省略号
    - 有较大兼容性问题，适合于webKit内核浏览器或移动端浏览器
    - 还需要设置合适的盒子高度
    - 更推荐丢给后端完成
    
    ```css
    div {
      overflow: hidden;
      text-overflow: ellipsis;
      /* 弹性伸缩盒子模型显示 */
      display: -webkit-box;
      /* 限制在一个块元素内显示的文本的行数 */
      -webkit-line-clamp: 2;
      /* 设置或检索伸缩盒对象的子元素的排列方式 */
      -webkit-box-orient: vertical;
    }
    ```
    

### margin负值的运用

- 使盒子的边框重叠，避免双层边框的现象
- 为使鼠标指针悬停时，重叠的边框前一个不被后一个压住
    - 如果盒子没有定位，则可以在鼠标指针hover悬停时，添加relative相对定位，提高当前盒子的层级
    - 如果盒子有定位，且不能为relative相对定位，则可以在鼠标指针hover悬停时，添加 z-index: 1 来提高当前盒子的层级

### 文字环绕浮动元素

利用浮动元素不会压住文字的特性，不需要将文字浮动

### 行内块元素的运用

利用行内块元素之间有间隙，可以设置宽高度，父级元素添加text-align: center后，内部所有行内块元素都可以整体居中等特性，便于制作页面底部的页面跳转导航栏

### CSS直角三角

在CSS三角的基础上，将左边和下边的边框宽度设置为0（只保留四分之一部分），再将上边框宽度调大（使三角形的一个边长更长），再将上面的边框颜色设为transparent透明，即可得到一个直角三角形

### CSS初始化

因不同浏览器对有些标签的默认值不同，为消除差异增加兼容性，需要对CSS初始化（CSS reset）：

```css
/*把所有标签的内外边距清零*/
* {
  margin: 0;
  padding: 0;
}

/*使em和i里面的文字不倾斜*/
em,
i {
  font-style: normal;
}

/*去掉li前面的小圆点*/
li {
  list-style: none;
}

/*去掉低版本浏览器中含链接的图片外边的边框，去掉图片底部为基线对齐保留的空白缝隙*/
img {
   border: 0;
  vertical-align: middle;
}

/*鼠标指针悬停在button按钮上时，鼠标指针变为小手*/
button {
  cursor: pointer;
}

/*链接a取消下划线，改颜色*/
a {
  text-decoration: none;
  color: #666;
}

/*鼠标指针悬停在a链接上时，更改颜色*/
a:hover {
  color: #fff;
}

/*更改按钮button和输入框input里的文字字体*/
button,
input {
  font-family: "Helvetica Neue", Helvetica, Arial, "PingFang SC", "Hiragino Sans GB", "Heiti SC", "Microsoft YaHei", "WenQuanYi Micro Hei", sans-serif;
}

/*更改整个页面的背景颜色和文字字体、大小、行高、颜色、CSS3抗锯齿性*/
body {
  -webkit-font-smoothing: antialiased;
  background-color: #fff;
  font: 12px/1.5 "Helvetica Neue", Helvetica, Arial, "PingFang SC", "Hiragino Sans GB", "Heiti SC", "Microsoft YaHei", "WenQuanYi Micro Hei", sans-serif;
  color: #666;
}

/*用:after伪元素给clearfix类清除浮动*/
.clearfix:after {
  visibility: hidden;
  clear: both;
  display: block;
  content: ".";
  height: 0;
}
.clearfix {
  *zoom: 1;
}
```

### 中文字体名编码表示

为避免浏览器不识别中文字体名，CSS中应将中文字体名用编码表示，提高兼容性

# HTML5新特性

HTML增加了一些新的标签、新的表单、新的表单属性等，但都有兼容性问题，只能在IE9以上的浏览器中使用

### HTML5新增的语义化标签

主要针对搜索引擎优化，更适合移动端，在页面中可以使用多次，但在IE9中需要转换为块元素

- <header>头部标签</header>
- <nav>导航标签</nav>
- <article>内容标签</article>
- <section>定义文档某个区域</section>
- <aside>侧边栏标签</aside>
- <footer>尾部标签</footer>

### HTML5新增的多媒体标签

方便在页面中嵌入音频和视频，不再需要flash或其他浏览器插件

- <video scr=”视频文件地址”></video> 视频标签，必要属性src指向视频文件的地址
- 常见属性：
    - autoplay=”autoplay” 视频自动播放（Chrome需要添加muted来解决被禁用的问题）
    - controls=”controls” 向用户显示播放控件（不同浏览器控件可能不同）
    - width=“px” height=“px” 设置播放器的宽高度
    - loop=”loop” 循环播放
    - preload=”auto”预加载视频 preload=“none”不预加载视频，（如果有auto属性就忽略该preload属性）
    - poster=“URL” 加载等待时显示的画面图片地址
    - muted=“muted” 静音播放
- 尽量使用mp4格式视频，兼容性更好

---

- <audio src=”音频文件地址”></audio> 音频标签，必要属性src指向音频文件的地址
- 常见属性：
    - autoplay=“autoplay” 音频自动播放（Chrome中被禁用）
    - controls=“controls” 向用户显示播放控件
    - loop=“loop” 循环播放
    - muted=“muted” 静音播放
    - preload=“auto” / “none” 是否预加载音频
- 尽量使用mp3格式音频，兼容性更好

### HTML5新增的input表单类型

验证的时候必须添加form表单域，当用户点击submit提交按钮就可以验证表单了

- type=”email” 限制用户输入必须为Email邮箱类型
- type=”url” 限制用户输入必须为URL网址类型
- type=”date” 限制用户输入必须为日期类型
- type=”time” 限制用户输入必须为时间类型
- type=”month” 限制用户输入必须为月类型
- type=”week” 限制用户输入必须为周类型
- type=”number” 限制用户输入必须为数字类型
- type=”tel” 电话号码
- type=”search” 搜索框
- type=”color” 生成一个颜色选择表单

### HTML5新增的表单属性

- required=”required” 限制输入内容不能为空
- placeholder=“提示文本” 输入框中的默认文本信息，若存在默认值则不显示
- autofocus=“autofocus” 页面加载完后自动聚焦到输入框
- autocomplete=“on” / “of” 当用户开始输入时，浏览器基于之前输入过的值，作出提示（默认为on）
- multiple=“multiple” 可以多选文件上传提交

# CSS3新特性

新增的CSS3特性有兼容性问题，IE9以上的浏览器才支持，移动端支持优于PC端，仍在不断改进中

## CSS3新增的选择器

### 属性选择器：

- E[att] 选择具有att属性的E元素
- E[att=”val”] 选择具有att属性，且值为val的E元素
- E[att^=”val”] 选择具有att属性，且值以val开头的E元素
- E[att$=”val”] 选择具有att属性，且值以val结尾的E元素
- E[att*=”val”] 选择具有att属性，且值中含有val的E元素
- 属性选择器的权重为0,0,1,0
- 类选择器、属性选择器、伪类选择器 权重都为0,0,1,0

### 结构伪类选择器：

- E:first-child 匹配父元素中的第一个子元素E
- E:last-child 匹配父元素中的最后一个子元素E
- E:nth-child(n) 匹配父元素中的第 n 个子元素E
    - n可以为数字、关键字、公式
    - 数字：从1开始
    - 关键字：even偶数 / odd奇数（可以做表格隔行变色处理）
    - 公式：n表示从0开始，每次加1，往后计算，第0个和超出的部分会被忽略
        - n 表示所有的项
        - 2n 表示偶数
        - 2n+1 表示奇数
        - mn 表示m的倍数
        - n+m 表示从第m个开始到最后（包含第m个）
        - -n+m 表示前m个（包含第m个）
- E:first-of-type 指定类型E的第一个
- E:last-of-type 指定类型E的最后一个
- E:nth-of-type(n) 指定类型E的第n个
    - 用法同nth-child(n)

<aside>
💡 区别：nth-child(n)会先把所有类型的子元素全部排序，再将序号n的元素匹配指定的类型，若匹配不上，则会失败。nth-of-type(n)只会将指定类型的子元素排序，忽略非指定类型的元素

</aside>

### 伪元素选择器

伪元素选择器可以利用CSS创建新标签元素，而不需要HTML标签，简化HTML结构。

伪元素创建的属于行内元素，但在文档树中看不到，所以称之为伪元素。

- element::before {}在元素内部的前面插入内容
- element::after {}在元素内部的后面插入内容
- 必要属性content
- 权重为0,0,0,1

## CSS3盒子模型

- box-sizing 指定盒子模型
- 值：
    - content-box：盒子的最终大小为width+padding+border，修改padding和border会撑大盒子（默认）
    - border-box：盒子的最终大小为width，修改padding和border不会撑大盒子，但前提是padding+border的宽度之和不超过width的宽度（可将此属性加入CSS初始化代码，作用于*所有元素）

## CSS3的其他新特性

### filter滤镜

将模糊或颜色偏移等图形效果应用于元素。

filter属性的值为一个函数()

- filter: blur(px) 模糊处理，px数值越大越模糊

### calc()函数

此函数作为属性值，可以在声明CSS属性值时执行一些计算

函数括号里面可以使用 + - * / 运算

## CSS3过渡

过渡transition是CSS3中具有颠覆性的特性之一，可以在不使用flash或javascript的情况下，使元素从一种样式变为另一种样式的时候，为元素添加效果。虽然存在兼容性问题，IE9以下不支持，但不会影响页面布局。

经常和 :hover 一起搭配使用

- transition 过渡
- 值：
    - 属性：想要变化的CSS属性名（必要）
    - 花费时间：过渡过程需要花费的时间，单位为s秒（必要）
    - 运动曲线：四种模式，默认为ease（可省略）
      
        ![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/css-grammer-3.png)
        
    - 何时开始：设置延迟触发过渡效果的时间，单位为s秒，默认为0s（可省略）

- 添加对象：给需要过渡效果的元素添加此属性（谁做过渡给谁加）
- 若对象需要添加多个过渡效果，则可以在多组属性值之间，用逗号隔开。若需要所有属性都变化，可以写只写个all（常用）

<aside>
💡 广义的HTML5指HTML5+CSS3+javascript

</aside>