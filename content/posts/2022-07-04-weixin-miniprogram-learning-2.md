---
title: 微信小程序开发学习 (二)
date: 2022-07-04
categories: Programming
tags: [miniprogram]
---

# 声明式导航

跳转页面可以使用`<navigator>`组件进行声明式导航，需要指定`url`和`open-type`属性，url需要以`/`开头。

若要跳转到的页面为tabBar，则open-type为`switchTab`。

```html
<navigator url="/pages/message/message" open-type="switchTab">导航到消息页面</navigator>
```

若要跳转到的页面为普通页面，则open-type为`navigate`，或省略不写。

```html
<navigator url="/pages/info/info" open-type="navigate">导航到info页面</navigator>
```

若要后退到上一个或上多个页面，则open-type为`navigateBack`，不需要url。同时指定`delta`属性，值为数字，表示要后退的层级。若仅后退到上一个页面，也可以省略delta属性。

```html
<navigator open-type="navigateBack" delta="1">后退到上一个页面</navigator>
```

# 编程式导航

跳转到tabBar页面也可以使用`wx.switchTab(Object)`方法进行编程式导航。其中参数Object对象的属性有：

![image-20220704172044745](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/image-20220704172044745.png)

```html
<!-- wxml中 -->
<button bindtap="gotoMessage">跳转到消息页面</button>
```

```js
// js中
gotoMessage() {
  wx.switchTab({
    url: '/pages/message/message'
  })
}
```

跳转到普通页面也可以使用`wx.navigateTo(Object)`方法进行编程式导航。

```html
<!-- wxml中 -->
<button bindtap="gotoInfo">跳转到info页面</button>
```

```js
// js中
gotoInfo() {
  wx.navigateTo({
    url: '/pages/info/info'
  })
}
```

后退到上一个或上多个页面，也可以使用`wx.navigateBack(Object)`方法进行编程式导航。其中Object参数对象中的url属性变成了delta属性，delta为1可以省略。

```html
<!-- wxml中 -->
<button bindtap="goBack">后退到上一个页面</button>
```

```js
// js中
goBack() {
  wx.navigateBack()
}
```

# 导航传参

在声明式导航和编程式导航中，都可以直接在url路径后面携带参数，格式为query形式。

```html
<navigator url="/pages/info/info?name=leon&age=23">携带参数跳转到info页面</navigator>
```

导航时传递的参数可以在`onLoad`事件中直接接收到，其options参数对象即为传递过来的参数。为了让其他地方也可以访问到参数，一般在data配置项中定义一个query变量用来存储参数。

```js
onLoad: function(options) {
  console.log(options) // options对象就是传递过来的参数
  this.setData({
    query: options
  })
}
```

# 下拉刷新事件

下拉刷新是移动端独有的事件，用于重新加载当前的页面数据。若需要全局开启，则在app.json的window配置项中，将`enablePullDownRefresh`设为true。若需要局部开启，则在页面json的window配置项中，将`enablePullDownRefresh`设为true。

> 一般来说，并不是所有的页面都需要下拉刷新，所以更推荐在局部单独开启。

若要修改下拉刷新的样式，则在json中通过`backgroundColor`和`backgroundTextStyle`属性来配置下拉刷新窗口的样式。

在页面js文件中，通过`onPullDownRefresh()`函数即可监听当前页面的下拉刷新事件，从而设置相应的回调。

下拉刷新的loading效果会一直显示，在处理完回调后应当手动停止loading效果，可以调用`wx.stopPullDownRefresh()`方法停止。

# 上拉触底事件

下拉刷新也是移动端独有的事件，用于页面加载更多的数据。在页面的js文件中，通过`onReachBottom()`函数即可监听当前页面的上拉触底事件，从而设置相应的回调。

> 由于上拉触底事件可以短时间反复触发，所以应当进行节流的处理。

上拉触底的距离是指触发时，滚动条离页面底部的距离。可以在全局或页面的json文件中通过`onReachBottomDistance`属性来修改默认的50px的距离。

# 生命周期

小程序的生命周期分为应用生命周期和页面生命周期。应用的生命周期函数需要在app.js中声明。

```js
App({
  // 初始化完成时触发，全局只触发一次
  onLaunch: function(options) { },
  // 启动时或从后台进入前台时触发
  onShow: function(options) { },
  // 从前台进入后台时触发
  onHide: function() { }
})
```

页面的生命周期函数需要在页面的js中声明。

```js
Page({
  // 页面加载时触发，本页面只触发一次
  onLoad: function(options) { },
  // 页面显示/切入前台时触发
  onShow: function() { },
  // 页面初次渲染完成时触发，本页面只触发一次
  onReady: function() { },
  // 页面隐藏/切入后台时触发
  onHide: function() { },
  // 页面卸载时触发，本页面只触发一次
  onUnload: function() { }
})
```

# wxs脚本

是小程序独有的一套脚本语言，结合wxml可以构建出页面的结构。wxml中无法调用js中定义的函数，但可以调用wxs中定义的函数，因此wxs在小程序中的典型应用场景就是过滤器。

wxs与JavaScript的关系：

![image-20220705103631260](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/image-20220705103631260.png)

内联的wxs代码写在wxml的`<wxs>`标签内，标签必须提供一个`module`属性作为模块的名称，以方便在wxml中访问模块中的成员。

```html
<view>{{m1.toUpper(username)}}</view>

<wxs module="m1">
  // 将文本转换为大写形式
  module.exports.toUpper = function(str) {
    return str.toUpperCase()
  }
</wxs>
```

外联的wxs代码写在`.wxs`的文件中，同样需要用module.exports暴露出去。然后在wxml中的`<wxs>`标签中使用src引入。

```html
<view>{{m1.toUpper(username)}}</view>

<wxs module="m1" src="../../utils/tools.wxs"></wxs>
```

> 注意：wxs中定义的函数不能作为组件的事件回调函数！

> wxs具有隔离性，与js代码不相通，不能相互调用。但wxs在iOS上性能比js好很多。

# cb && cb()

cb即callback，代表某个回调函数。`cb && cb()`的写法运用了逻辑与运算符，若cb回调存在，则调用cb();若cb回调不存在，则不调用。可以将cb作为函数定义时的形参，在调用函数时，根据是否传递了cb回调来决定是否执行cb。
