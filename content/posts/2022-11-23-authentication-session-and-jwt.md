---
title: 服务端身份认证 Session 和 JWT
date: 2022-11-23
categories: Programming
tags: [Node.js]
---

身份认证 Authentication，即鉴权。由于 HTTP 协议是无状态的，即每次 HTTP 请求都是独立的，服务器不会主动保留每次 HTTP 请求的状态，所以每次请求时都需要身份认证。

对于服务端渲染，一般使用 session 认证机制；对于前后端分离，一般使用 JWT 认证机制。

## 在 Express 中使用 Session 认证

![session](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/2022-11-23-session.png)

npm 安装 `express-session` 包 -> 导入 -> app.use() 注册中间件并配置。

```js
const express = require('express')
const session = require('express-session')

const app = express()

app.use(session({
  secret: 'any string', // 随意的字符串即可
  resave: false, // 固定写法
  saveUninitialized: true // 固定写法
}))
```

只有注册了 Session 中间件，req 中才会多出一个 session 对象。利用 `req.session` 就可以完成各种认证操作：

```js
// 用户登录接口
app.post('/api/login', (req, res) => {
  if(req.body.username != 'admin' || req.body.password != '123abc') {
    return res.send({status: 1, msg: 'login failed'})
  }
  // 登录成功，保存用户的信息到 Session 中
  req.session.user = req.body
  req.session.isLogin = true
})

// 获取用户名的接口
app.get('/api/getUser', (req, res) => {
  if(!req.session.isLogin) {
    return res.send({status: 1, msg: 'get failed'})
  }
  // 认证成功，将用户名返回
  res.send({status: 0, msg: 'get ok', username: req.session.user.username})
})

// 退出登录的接口
app.get('/api/logout', (req, res) => {
  // 清空 Session
  req.session.destroy()
  // 退出成功，返回信息
  res.send({status: 0, msg: 'logout ok'})
})
```

## 在 Express 中使用 JWT 认证

![session](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/2022-11-23-token.png)

npm 安装 `jsonwebtoken` 和 `express-jwt` 两个包 -> 导入并使用。

```js
const express = require('express')
const jwt = require('jsonwebtoken')
const expressJWT = require('express-jwt')

const app = express()

// 定义一个加密密钥
const secretKey = 'some complex string'

// 注册中间件，用于解密 Authorization 请起头中的 token，认证成功后会将解密出的 JSON 对象放在 req.user 里。认证失败会报错，需要做错误捕获
// unless 方法可以指定哪些接口不需要访问权限
app.use(expressJWT({secret: secretKey}).unless({path: [/^\/api\//]}))

// 用户登录接口
app.post('/api/login', (req, res) => {
  if(req.body.username != 'admin' || req.body.password != '123abc') {
    return res.send({status: 1, msg: 'login failed'})
  }
  // 登录成功，生成 token 字符串并返回
  // 用于加密的 sign 方法接收三个参数：用户信息对象，加密密钥，配置信息对象。返回 token 字符串
  const tokenStr = jwt.sign({username: req.body.username}, secretKey, {expiresIn: '30s'})
  res.send({status: 0, msg: 'login ok', token: tokenStr})
})

// 获取用户名的接口
app.get('/api/getUser', (req, res) => {
  // 中间件已经认证通过，直接返回用户名即可
  // 利用 req.user 就可以拿到加密时传入的用户信息对象
  res.send({status: 0, msg: 'get ok', username: req.user})
})

// 用于捕获错误的全局中间件
app.use((err, req, res, next) => {
    // token 认证失败导致的错误
    if(err.name === 'UnauthorizedError') {
        return res.send({status: 401, msg: 'invalid token'})
    } else {
        // 其他原因导致的错误
        res.send({status: 500, msg: 'unknow error'})
    }
})
```