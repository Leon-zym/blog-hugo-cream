---
title: 更好的 CSS 毛玻璃效果做法
date: 2023-01-05
categories: Programming
tags: [CSS]
---

## 一般的 CSS 毛玻璃做法

之前看到一些网站很喜欢使用毛玻璃效果的、固定定位的顶栏。一般的做法是使用 `backdrop-filter: blur()` 属性来实现元素背景模糊：

```css
.top {
  position: fixed;
  top: 0px;
  backdrop-filter: blur(12px);
}
```

但是我在滚动网页的时候，觉得这种显示效果并不好。会出现模糊后的色团在滚动时互相干扰，产生一种闪烁、抖动的现象。

## 达到更好的毛玻璃效果

![Screen Shot 2023-01-05 at 8.33.18 PM](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/Screen%20Shot%202023-01-05%20at%208.33.18%20PM.png)

今天在逛 Twitter 的时候，偶然注意到 Twitter 的网页版也使用到了毛玻璃效果的顶栏，但它的显示效果就很好，优雅自然不突兀。

为了一探究竟，F12 打开了调试台。定位到相关元素后，发现 CSS 样式中不仅使用到了 `backdrop-filter: blur()`，还用 `background-color: rgba()` 给元素添加了一个半透明背景色：

![Screen Shot 2023-01-14 at 11.28.02 AM](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/Screen%20Shot%202023-01-14%20at%2011.28.02%20AM.png)

在我手动去掉这个背景色属性后，上面所说的不好的现象就回来了。尤其是滚动到文字部分的时候闪烁格外明显：

![Screen Shot 2023-01-05 at 8.34.53 PM](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/Screen%20Shot%202023-01-05%20at%208.34.53%20PM.png)

## 猜测

我猜测单独使用背景模糊效果不好，是因为背景中的图片文字等色彩过渡幅度过大，而在滚动过程中，高斯模糊时色彩相互"晕染"是实时计算的，进而导致了闪烁、抖动等现象。

而同时给前面的元素加上半透明背景色后，由于背景色的覆盖，使得元素背景中透上来的色彩被"中和"了一部分，色彩在过渡时不至于变化幅度太大。这时再加上 `backdrop-filter: blur()` 的属性，效果就很好了。

一般 Light 主题背景色就选白色，Dark 主题背景色就选黑色，再看情况调整不透明度。