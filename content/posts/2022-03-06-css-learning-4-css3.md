---
title: CSS3 新特性 (二)
date: 2022-03-06
categories: Programming
tags: [CSS]
---

# 2D转换

转换（transform）是CSS3中具有颠覆性的特性之一，可以实现元素的位移translate、旋转rotate、缩放scale。

---

### translate 位移

- 三种形式：
    - transform: translate(x, y) 在 X轴 Y轴上位移。若只移动某一方向，则另一方向值为 0。注意中间用逗号隔开
    - transform: translateX(px) 仅在 X轴上位移
    - transform: translateY(px) 仅在 Y轴上位移
- Tips：
    - 最大的优点是不会影响到其他元素的位置，不脱标
    - X轴 Y轴的值除了单位px，还可以为百分比%，效果是盒子自身宽度高度的百分比
    - 可以配合定位实现子盒子在父盒子里面垂直+水平居中对齐
      
        ```css
        div {
          position: absolute;
          top: 50%;
          left: 50%;
          transform: translate(-50%,-50%);
        }
        ```
        
    - 对行内元素无效，仅对块级元素和行内块元素有效

### rotate 旋转

- transform: rotate(deg)
    - 角度为正值时顺时针旋转，为负值时逆时针旋转，单位为度deg
- Tips：
    - 默认旋转的圆心是元素的中心点
    - 可以结合 hover 和 transition 做动画效果
      
        ```css
        div {
          width: 200px;
          height: 200px;
          transition: all 0.5s;
        }
        div:hover {
          transform: rotate(360deg);
        }
        ```
        
    - 可以结合 border 边框做三角箭头

### scale 缩放

- 两种形式：
    - transform: scale(x, y) 在 X轴Y轴上倍数缩放，中间用逗号隔开
    - transform: scale(n) 在 X轴Y轴上等比例倍数缩放
- Tips:
    - 数值为倍数，没有单位
    - 默认为 1 倍，即不变。大于 1 为放大，小于 1 为缩小
    - x y可以为不同倍数
    - 默认以中心点缩放
    - 不会影响其他盒子，不脱标

### transform-origin 转换中心点

- transform-origin: x y
- Tips：
    - 默认为宽高度的 50% 处中心点
    - x y 坐标除了用像素值，还可以指定方位名词（top bottom left right center）

### 2D 转换的综合写法

- transform: translate() rotate() scale();
- Tips：
    - 三者顺序会影响转换的效果（先旋转会影响坐标轴的方向）
    - 当位移和其他属性同时存在时，应将位移放在最前面

# animation 动画

先定义动画，再调用动画。

### 1. 用 keyframes 定义动画：动画序列

```css
@keyframes 动画名称 {
  0%{
    初始状态;
  }
  100%{
    结束状态;
  }
}
```

- 动画序列中从 0%到 100%之间可以定义多个时间点，执行多个不同的状态变换。不同变换的执行时间为总的时间乘以百分比
- 等价于：

```css
@keyframes 动画名称 {
  from{
    初始状态;
  }
  to{
    结束状态;
  }
}
```

### 2. 元素调用动画

```css
div {
  animation-name: 动画名称;
  animation-duration: 持续时间（单位为s秒）;
}
```

---

### 动画 animation 属性

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/css-3-2.png)

- animation-name 要调用的动画名称（必要）
- animation-duration 动画完成一个周期花费的总时间，单位为 s 秒，默认为 0（必要）
- animation-timing-function 速度曲线模式，默认 ease
  
    ![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/css-3-3.png)
    
    
    
- animation-delay 动画开始的延迟时间，单位为 s 秒，默认为 0
- animatio-interation-count 动画被播放的次数，默认为 1，还有 infinite无限循环
- animation-direction  动画在下一周期是否逆向播放，默认为 normal 不逆向，还有 alternate 逆向
- animation-fill-mode 动画结束后的状态，默认为 backward 回到起始状态，还有 forward 保留在结束状态
- animation-play-state 动画播放或暂停，默认为 running 播放，还有 paused 暂停。常结合 hover 实现鼠标指针悬停暂停动画，移开继续动画

### animation 动画的综合写法

animation:  name动画名称  duration持续时间  timing-function速度曲线  delay何时开始  interation-count播放次数  direction是否逆向  fill-mode结束时状态

- belike：
  
    ```css
    animation: move 5s linear 2s infinite alternate;
    ```
    
- 综合写法中不包含 play-state 动画播放或暂停

# 3D转换

X轴：水平向右为正

Y轴：垂直向下为正

Z轴：垂直屏幕向外为正

---

### translate3d 移动

- 四种形式：
    - transform: translateX(px) 仅在X轴上移动，即2d移动
    - transform: translateY(px) 仅在Y轴上移动，即2d移动
    - transform: translateZ(px) 仅在Z轴上位移
    - transform: translate3d(x, y, z) 在X轴Y轴Z轴上移动。若只移动某些方向，则其他方向值为 0。注意中间用逗号隔开
- Tips：
    - Z轴上移动单位一般用像素px，不用百分比

### perspective 透视

透视也称之为视距，即眼睛到屏幕之间的距离

- perspective: px 透视距离
- Tips：
    - 透视的单位是像素px
    - 透视距离越小，成像越大，透视距离越大，成像越小
    - 透视写在被观察元素的父元素上

### rotate3d 旋转

- 四种形式：
    - transform: rotateX(deg) 沿X轴旋转
    - transform: rotateY(deg) 沿Y轴旋转
    - transform: rotateZ(deg) 沿Z轴旋转，即2d旋转
    - transform: rotate3d(x, y, z, deg) 沿自定义的轴（x y z矢量和）旋转deg角度
- Tips：
    - 左手法则：左手拇指指向某个坐标轴的正方向，其他四指的方向即为旋转的正方向（deg为正值），反之亦然
    - 给父元素加上perspective透视后，3d效果更明显

### transform-style  3D呈现

- transform-style 控制子元素是否开启三维立体空间
- 值：flat不开启（默认），preserve-3d开启
- Tips：
    - 写在父级元素上，影响的是子级元素

# 浏览器私有前缀

浏览器私有前缀是为了兼容老版本的写法，较新版本的浏览器无需添加。

- -moz- 代表Firefox浏览器私有属性
- -ms- 代表IE浏览器私有属性
- -webkit- 代表Safari、Chrome浏览器私有属性
- -o- 代表Opera浏览器私有属性

# CSS3 总结

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/css-3-1.png)

