---
title: 微信小程序开发学习 (三)
date: 2022-09-15
categories: Programming
tags: [miniprogram]
---

# 自定义组件

自定义组件的思想和Vue的差不多，都是为了提高代码的复用率。自定义组件一般放在Components文件夹中，其构成和普通页面的也是一样，分为wxml、wxss、js、json。

## 引用

自定义组件的引用分为全局引用和局部引用。局部引用是在页面的json配置中引用：

```json
"usingComponents": {
    "test-component": "../components/testComponent/testComponent"
}
```

引用后，在页面的wxml中使用组件：

```html
<test-component></test-component>
```

全局引用是在app.json配置中引用，在所有页面中可直接使用。

## 和页面的区别

自定义组件和页面的区别主要在js和json中。在json中需要声明 `"component": true`；在js中调用的是`Component()`构造函数，并且组件中的方法需要放在`methods: {}`配置项中。

## 样式隔离

默认情况下，自定义组件的样式存在隔离特性，即只对当前组件内部生效。

注意点：

- app.wxss全局样式表对组件内部无效
- 只有class类选择器具有样式隔离，id选择器、属性选择器、标签选择器不受隔离影响

同时，可以通过`styleIsolation`修改组件的样式隔离特性。在js中为：

```js
options: {
  styleIsolation: 'isolated'
}
```

或是在json中：

```json
"styleIsolation": "isolated"
```

styleIsolation的可选值：

![image-20220912135037550](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/image-20220912135037550.png)

## properties

properties是组件的对外属性，接收外界传递到组件中的数据，用于父子通信。

```js
properties: {
  max: {
    type: Number,
    value: 10  // 完整定义，指定属性默认值
  },
  min: Number  // 简化定义
}
```

properties和data一样也是可读可写的，且可以直接用于wxml渲染。但一般来说，使用data存储组件的私有变量，properties存储外界传递到组件中的数据。

## observers

observers数据监听器用于监听和响应任何属性或数据字段的变化，从而执行相应的操作。类似于Vue中的watch。

可以同时监听多个数据字段：

```js
observers: {
  'n1, n2': function(n1, n2) {
    let sum = n1 + n2
    this.setData({sum})
  }
}
```

也可以同时监听对象中的多个子数据字段：

```js
observers: {
  'rgb.r, rgb.g, rgb.b': function(r, g, b) {
    this.setData({
      fullColor: `${r}, ${g}, ${b}`
    })
  }
}
```

或使用通配符`**`监听对象中的所有子数据字段：

```js
observers: {
  'obj.**': function(obj) {
    // do something
  }
}
```

## 纯数据字段

不用于页面渲染的data数据字段，可以作为纯数据字段。使用纯数据字段可以提高页面的更新性能。

在options配置项中添加`pureDataPattern`正则表达式，符合这个正则的数据字段将成为纯数据字段。

```js
options: {
  // 指定正则
  pureDataPattern: /^_/
},
  
data: {
  foo: '213',  // 普通数据字段
  _bar: false  // 纯数据字段
}
```

## 组件的生命周期

![image-20220913223320584](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/image-20220913223320584.png)

注意：组件的生命周期函数不建议直接写在Component构造器中（旧），更推荐写在`lifetimes`配置项中（新）。

```js
lifetimes: {
  created() {
    // do something
  },
  attached() {
    // do something
  },
  detached() {
    // do something
  }
}
```

## 组件所在页面的生命周期

![image-20220913224736755](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/image-20220913224736755.png)

组件所在页面的状态发生变化时被调用，其需要定义在`pageLifetimes`配置项中。

```js
pageLifetimes: {
  show() {
    // do something
  },
  hide() {
    // do something
  }
}
```

## 插槽

组件内部提供一个`<slot>`节点占位，用于承载组件使用者提供的wxml结构。

小程序默认只支持单个插槽，如果需要使用多个插槽，则需要在组件的js中添加一个字段。

```js
options: {
  multipleSlots: true
}
```

多个插槽可以指定name加以区分：

```html
<view>
  <slot name="top-slot"></slot>
  <view>I'm middle</view>
  <slot name="bottom-slot"></slot>
</view>
```

```html
<my-component>
  <view slot="top-slot">content in top slot</view>
  <view slot="bottom-slot">content in bottom slot</view>
</my-component>
```

## 父子组件之间的通信

### 属性绑定

用于父组件给子组件传值，但只能传递普通类型的数据，不能传递方法：

```html
<my-component prop="{{prop}}"></my-component>
```

子组件在properties配置项中声明对应的属性：

```js
properties: {
  prop: Object
}
```

### 事件绑定

用于子组件给父组件传值，可以传递任何类型的数据，包括方法：

![image-20220914223811834](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/image-20220914223811834.png)

### 获取组件实例

在父组件里调用`this.selectComponent()`方法获取到子组件的实例对象，参数可以是id或class选择器。从而直接访问子组件的任意数据和方法。

```js
const child = this.selectComponent("#my-component")
child.setData({count: child.properties.number + 1})
child.getSum()
```

## behaviors

用于将组件间的共享代码抽离出去，提高代码复用率，类似Vue的mixins。

每个behavior可以包含一组属性、数据、方法、生命周期函数等，被组件引入时，会被合并到组件的代码中。

每个组件可以引用多个behavior，每个behavior也可以引用其他的behavior。

```js
module.exports = Behavior({
  properties: {},
  data: {},
  methods: {},
  // ......
})
```

```js
import myBehavior from "../behaviors/my-bahavior"

Component({
  behaviors: [myBehavior],
  // ......
})
```

![image-20220915205036103](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/image-20220915205036103.png)



组件内的字段和behavior内的可以同名，同名冲突后参照 [同名字段的覆盖和组合规则](https://developers.weixin.qq.com/miniprogram/dev/framework/custom-component/behaviors.html)

![image-20220915205405170](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/image-20220915205405170.png)

# 分包

把完整的小程序项目按照不同的需求划分为不同的子包，然后在构建时打包为不同的分包，用户就可以在使用时按需加载了。

使用分包可以优化小程序首次启动时的下载时间；且在多团队共同开发时可以更好地解耦协作。

使用后将小程序分为：一个主包（包含首页、tabBar页面、公共资源等）；多个分包（私有页面、私有资源等）。

限制：

- 整个小程序所有包的大小不超过16M；主包或单个分包的大小不超过2M
- 分包可以访问到主包，主包不能访问到分包，分包之间不能互相访问

## 配置分包

文件结构：

```
|----app.js
|----app.json
|----app.wxss
|----pages
    |____index
    |____personal
|----packageA
    |____pages
        |____activity
        |____coupon
|----packageB
    |____pages
        |____scan
        |____list
|----utils
```

app.json中配置：

```json
{
  "pages": [
    "pages/index",
    "pages/personal"
  ],
  "subpackages": [
    {
      "root": "packageA",
      "pages": [
        "pages/activity",
        "pages/coupon"
      ]
    },
    {
      "root": "packageB",
      "pages": [
        "pages/scan",
        "pages/list"
      ]
    }
  ]
}
```

## 独立分包

本质上也是分包，但独立分包可以不依赖于主包和其他分包，而单独运行。

配置上只需在分包配置中添加一个字段`"independent": true`即可。

除了普通分包的限制之外，独立分包还不能引用主包内的公共资源。

## 分包预下载

在进入指定页面时，由小程序框架自动预下载用户可能会用到的分包，从而提高进入后续分包页面时的启动速度。

在app.json中配置触发页面、触发网络、被触发分包等：

```json
{
  "preloadRule": {
    "pages/index": {
      "network": "all",
      "packages": ["packageA"]
    },
    "pages/personal": {
      "network": "wifi",
      "packages": ["packageB"]
    }
  }
}
```

限制：同一个分包中的页面共享预下载体积，大小限额为2M

# npm支持

## npm包

小程序可以安装使用部分第三方npm包。但由于缺少nodejs、浏览器和C++的环境，所以不支持依赖于nodejs内置库、浏览器内置对象、C++插件的npm包。

## Vant组件库

Vant Weapp是有赞出的一套小程序UI组件库，[官方文档](https://vant-contrib.gitee.io/vant-weapp/#/home)。

## API的Promise化

将官方基于回调函数的异步API改造成基于Promise的异步API，提高代码的可读性、可维护性，避免回调地狱。

使用npm包`miniprogram-api-promise`实现，[官方文档](https://www.npmjs.com/package/miniprogram-api-promise)。

## 全局数据共享

即状态管理，为了解决组件之间数据共享的问题。

使用npm包`mobx-miniprogram`和`mobx-miniprogram-bindings`实现，[官方文档](https://www.npmjs.com/package/mobx-miniprogram)。

# 其他

## 使用CSS变量

CSS变量名一般以`--`开头，并指定作用域。使用时以`var()`调用。CSS变量提高了代码的可读性，且易于维护。

```css
page {
  --main-color: #cccccc;
  --main-font-size: 14rpx;
}
```

```css
.text {
  color: var(--main-color);
  font-size: var(--main-font-size);
}
```

