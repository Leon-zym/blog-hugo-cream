---
title: Node.js 学习 Express 框架
date: 2022-11-20
categories: Programming
tags: [Node.js]
---

## 初步使用 Express

```js
const express = require('express')

// 创建 Web 服务实例
const app = express()

// 处理 GET 请求
app.get('/', (req, res) => {
  const query = req.query
  res.send(query) // 将 URL 中携带的 query 参数返回
})

// 处理 POST 请求
app.post('/postData', (req, res) => {
  res.send({ name: 'Leon', age: 18 }) // 响应一个 JOSN 对象
})

// 启动服务，监听 8081 端口
app.listen(8081, () => {
  console.log('server on http://127.0.0.1:8081')
})
```

## 托管静态资源

```js
const express = require('express')

const app = express()

// 将 file 目录中的文件挂载出去，路径中不含目录名
app.use(express.static('./file'))

// 将 static 目录中的文件挂载出去，路径需以前缀字符串 static 开头
app.use('static', express.static('./static'))

app.listen(8081, () => {
  console.log('server on http://127.0.0.1:8081')
})
```

可以使用 `http://127.0.0.1:8081/static/github-cat.html` 路径访问静态资源。

也可以同时挂载多个静态资源目录，但冲突的路径（文件名）以最先挂载的为准。

## Express 路由

可以直接把路由挂载在 app 身上，但不推荐。推荐将路由抽离成单独的模块。

在路由模块中：

```js
const express = require('express')

// 创建路由实例对象
const router = express.Router()

// 把路由规则挂载在路由实例对象身上
router.get('/', (req, res) => {
  res.send({ url: req.url, method: req.method })
})

router.post('/postData', (req, res) => {
  res.send({ url: req.url, method: req.method })
})

// 向外暴露出去
module.exports = router
```

在其他文件中导入并注册即可：

```js
const router = require('./router')
// 注册
app.use(router)
```

也可以为某个模块添加路由前缀：

```js
app.use('/api', router)
```

## Express 中间件

Express 的中间件本质上就是一个 function 处理函数，但其形参中包含 `(req, res, next)`。客户端发起的任何请求，到达服务器后都会依次（按定义顺序）触发中间件。next 函数是实现多个中间件连续调用的关键，调用后会把流转关系转交给下一个中间件或路由。

作用：多个中间件之间共享同一份 `req` 和 `res`，所以可以在上游中间件中统一为这两个对象添加属性和方法，以供下游中间件或路由使用。

定义并注册全局中间件：

```js
const middleWare = (req, res, next) => {
    // do something
    next()
}

app.use(middleWare)
```

定义并注册局部中间件：

```js
const middleWare1 = (req, res, next) => {
    // do something 1
    next()
}
const middleWare2 = (req, res, next) => {
    // do something 2
    next()
}

// 此中间件只在当前路由规则中局部生效
app.get('/', middleWare1, (req, res) => {
    // 处理路由
})

// 多个局部中间件也可以括在一个数组中传递
app.get('/ getData', [middleWare1, middleWare2], (req, res) => {
    // 处理路由
})
```

注意点：

- 中间件的定义要放在路由规则前面
- next 方法调用后不应再有其他操作

中间件的分类：

- 应用级别：绑定在 app 实例身上
- 路由级别：绑定在 router 实例身上
- 错误级别：捕获项目中的异常错误，防止项目崩溃。形参变为 `(err, req, res, next)`。且必须注册在所有路由之后
- Express 内置中间件：
    - express.static()：托管静态资源
    - express.json()：解析 JSON 格式的请求体数据
    - express.urlencoded()：解析 URL-encoded 格式的请求体数据
- 第三方中间件：npm 安装 -> require 导入 -> app.use() 注册并使用

## Express 使用 CORS 解决接口跨域问题

CORS 由一系列 HTTP 响应头组成，决定浏览器是否按照“同源策略”限制前端 JS 代码跨域获取资源。CORS 在服务器端配置即可，客户端无需任何额外的配置。

CORS 响应头有：

- `Access-Control-Allow-Origin` 对域名的限制：值可以为某个域名，或为 `*` 表示任何域名
- `Access-Control-Allow-Headers` 对请求头的限制：默认只支持 9 个特定的请求头
- `Access-Control-Allow-Methods` 对请求方式的限制：默认只支持 GET、POST、HEAD 方式

仅使用限制的请求头和请求方式的为简单请求。否则实际请求前还需要预检请求。即浏览器会先发送 OPTION 请求进行预检，已获知服务器是否允许该实际请求，服务器响应预检请求后，浏览器才会发送实际请求，并携带数据。

cors 是 Express 的一个中间件。npm 安装 -> 导入 -> 在路由规则之前 app.use() 注册即可。

## JSONP 解决接口跨域问题

浏览器端使用 `<script>` 标签的 src 属性，请求服务器的资源，同时服务器返回一个函数的调用。称之为 JSONP。现在基本已淘汰。

缺陷：

- 只支持 GET 请求
- 不属于真正的 AJAX 请求，没有使用到 `XMLHttpRequest` 对象

JSONP 步骤：

1. 拿到客户端的回调函数名称
2. 定义要发送的数据
3. 拼接出回调函数调用的字符串
4. 把拼接的字符串响应给客户端

如果服务器同时配置了 CORS 和 JSONP，则应把 JSONP 配置写在前面，防止冲突。

