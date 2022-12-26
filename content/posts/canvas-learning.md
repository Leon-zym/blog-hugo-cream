---
title: 原生 Canvas 使用
date: 
tags: [Canvas]
slug: 
draft: true
---

## 用 canvas 画一个纯色方块

先在 HTML 中使用 `<canvas>` 标签并加上 id：

```html
<div id="container">
  <canvas id="canvas"></canvas>
</div>
```

默认情况下，canvas 元素有 width: 300px; height: 150px; 所以外层的 container 会被撑开。

JS 中