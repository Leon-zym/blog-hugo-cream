---
title: 一些笔记
date: 2022-10-22
categories: Programming
tags: [miniprogram, JavaScript]
---

# 微信小程序API的回调函数中this问题

微信小程序提供的API，大部分是基于回调函数的，只有少部分支持以Promise风格调用。作为参数，回调函数一般有`success` `fail` `complete`三种，分别对应接口调用成功、失败、结束（不论成功或失败）。

## 问题

三种回调函数的形式既可以是普通函数，也可以是箭头函数。但是在普通函数的定义中，无法访问到页面或组件的`this`对象。

```js
wx.request({
  // ...
  success(res) {
    this.resolveRequest(res)  // 报错，提示不存在this
  },
  fail(err) {
    console.error(err)
  },
  complete() {
    console.log('Request complete!')
  }
})
```

## 解决方案一

最简单也是最常见的办法，就是将回调函数的形式写成箭头函数。由于箭头函数没有自己的this对象，所以函数内部的this指向上层作用域的this。即`success`内部的this指向`wx.request()`这层的this，即页面或组件的this对象。

```js
wx.request({
  // ...
  success: (res) => {
    this.resolveRequest(res)
  }
})
```

## 解决方案二

在上层作用域提前保存住页面或组件的this对象，然后再使用。

```js
let _this = this
wx.request({
  // ...
  success(res) {
    _this.resolveRequest(res)
  }
})
```

## 解决方案三

如果此API支持，可以使用Promise风格调用。或将其包装成Promise风格。

---

# 前端实现分页加载

分页加载一般在后端实现，特别是数据量很大的情况下。但在数据量适中的时候，也可以由前端实现。

## 代码

```vue
<template>
  <button @click="pageLoad" style="width: 200px; height: 100px;">点击加载</button>
</template>

<script>
export default {
  data() {
    return {
      mockData: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
      currentPage: 0, // 当前页数
      perPage: 3, // 每页数量
      start: 0,
      end: 0,
      pageData: []
    }
  },

  methods: {
    pageLoad() {
      this.currentPage++
      let res = this.pageDataRequire(this.mockData, this.currentPage, this.perPage, 'asc')
      if (res) {
        console.log(this.pageData)
      } else {
        console.error('没有更多数据了~')
      }
    },

    // sort: asc正序 / desc倒序
    pageDataRequire(totalData, currentPage, perPage, sort = "asc") {
      let newData = []
      let totalLength = totalData.length // 总数据长度
      if (sort === 'asc') {
        this.start = (currentPage - 1) * perPage
        this.end = currentPage * perPage > totalLength ? totalLength : currentPage * perPage
        if (this.start >= totalLength) {
          return false
        } else {
          newData = totalData.slice(this.start, this.end)
          this.pageData = [...this.pageData, ...newData]
          return true
        }
      }
      if (sort === 'desc') {
        this.start = totalLength - (currentPage * perPage) < 0 ? 0 : totalLength - (currentPage * perPage)
        this.end = totalLength - ((currentPage - 1) * perPage)
        if (this.end <= 0) {
          return false
        } else {
          newData = totalData.slice(this.start, this.end)
          this.pageData = [...this.pageData, ...newData]
          return true
        }
      }
    }
  }
}
</script>
```

## 效果

正序：

![image-20221022170809060](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/image-20221022170809060.png)

倒序：

![image-20221022170854099](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/image-20221022170854099.png)

---

# 前端实现模糊搜索

// TODO