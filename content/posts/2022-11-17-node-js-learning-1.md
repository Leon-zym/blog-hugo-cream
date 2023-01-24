---
title: Node.js 学习 内置模块
date:  2022-11-17
categories: Programming
tags: [Node.js]
---

## 简介

Node.js是JavaScript的后端运行环境（runtime），类比浏览器是JavaScript的前端运行环境。Node.js使用的是Chrome的V8解析引擎，除了解析引擎外，还包含了一些内置的API：fs模块、path模块、http模块、etc……

> // Node.js 是用 C++ 写的，V8 引擎也是

## fs 文件系统模块

读取文件： `fs.readFile(path, [options], callback)`

可选参数options表示以什么编码格式读取文件，默认为UTF8。

```js
const fs = require('fs')

fs.readFile('./assets/demo1.txt', function(err, result) {
  if(err) {
    return console.log('文件读取失败！' + err.message)
  }
  console.log('文件读取成功！' + result)
})
```

写入文件： `fs.writeFile(path, data, [options], callback)`

```js
const fs = require('fs')

fs.writeFile('./assets/demo2.txt', 'Hello Node.js!', function(err, result) {
  if(err) {
    return console.log('文件写入失败！', err.message)
  }
  console.log('文件写入成功！')
})
```

注意：

- 使用 fs 模块操作文件的时候，若使用相对路径，可能会出现路径动态拼接错误。这是因为代码在执行的时候，会以执行 node 命令时所处的目录，动态地拼接出被操作文件的完整绝对路径。所以 fs 模块中的路径尽量使用 `__dirname` + 相对路径拼接的形式，`__dirname` 表示当前代码文件所处的目录。
- `fs.write()` 只能创建文件，而不能创建路径。即路径必须是提前就存在的，否则报错
- 重复调用 `fs.write()` 写入同一个文件，会覆盖之前写入的内容

```js
fs.readFile(__dirname + '/assets/demo1.txt', function(){})
```

## path 路径模块

拼接路径： `path.join()`

```js
const path = require('path')

// ../会抵消前面的一个路径
const pathStr = path.join('/a', '/b/c', '../', './d', '/e')
console.log(pathStr)  // 输出：/a/b/d/e
```

fs中的拼接路径的推荐写法：

```js
fs.readFile(path.join(__dirname, '/assets/demo1.txt'), function(){})
```

获取路径中的文件名： `path.basename()`

```js
const fpath = '/a/b/c/index.html'

var fullname = path.basename(fpath)
console.log(fullname)  // 输出index.html

var nameWithoutExt = path.basename(fpath, '.html')
```

## http 模块

```js
const http = require('http')

// 创建 Web 服务器实例
const server = http.createServer()

// 绑定 request 事件，监听客户端的请求并响应
server.on('request', function(req, res) {
    console.log('url:', req.url, ', method:', req.method)
    // do something...
    res.setHeader('Content-Type', 'text/html; charset=utf8')
    res.end('Hello Node.js, 这是一段中文字符。')
})

// 监听端口，启动服务器
server.listen(80, function() {
    console.log('Server running at http://127.0.0.1:80') // 80端口可省略
})
```

request 事件会在服务器接收到客户端的请求时触发，回调函数中的 req 是请求对象，包含客户端请求时的相关数据和属性。res 是响应对象，包含服务器响应时的相关数据和属性。但是响应数据中如果存在中文，会出现乱码的情况，我们需要在响应头中手动设置内容的编码格式。

可以通过判断 `req.url` 来简单处理后端路由。

## 模块化 & npm 包

Node.js 中默认使用 CommonJS 模块化规范。

其他略……