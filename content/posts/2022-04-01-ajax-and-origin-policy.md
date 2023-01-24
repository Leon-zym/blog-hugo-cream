---
title: 各种 AJAX 的实现与前端跨域问题
date: 2022-04-01
categories: Programming
tags: [JavaScript]
---

# Ajax简介

Asynchronous JavaScript and XML：异步的JS和XML。

- 通过Ajax可以在浏览器中向服务器发送异步请求
- 优势：无刷新获取数据
- 可以实现懒加载

# XML简介

XML：可扩展标记语言。

- XML被设计用来传输和存储数据
- 没有预定义标签，均为自定义标签
- Ajax早期使用其传输数据，但现今被JSON代替

# Ajax的特点

## 优点

- 无需刷新页面与服务器进行通信
- 允许页面根据用户事件来更新部分页面内容

## 缺点

- 没有历史记录，不能回退
- 存在跨域问题
- 对SEO不友好

# HTTP协议

Hypertext Transport Protocol：超文本传输协议。

- 协议规定了浏览器和万维网服务器之间的互相通信和规则
- 请求报文和响应报文

# 原生Ajax请求

## GET请求

```js
// 创建对象
const xhr = new XMLHttpRequest();
// 初始化，设置请求和方法
xhr.open("GET", "http://127.0.0.1:8000/server");
// 发送
xhr.send();

// 事件绑定，处理服务端返回的结果
// xhr里面的状态码有0 1 2 3 4五种，当为4的时候表示服务端的数据已经返回完毕
xhr.onreadystatechange = function () {
    if (xhr.readyState === 4) {
        // 判断状态响应码 200 404 403 500，其中2xx开头的都表示成功
        if (xhr.status >= 200 && xhr.status < 300) {
            // 处理服务端返回的结果
            // 响应行
            console.log(xhr.status); //状态码
            console.log(xhr.statusText); //状态字符串
            // 所有的响应头
            console.log(xhr.getAllResponseHeaders());
            // 响应体
            console.log(xhr.response);

            // 数据呈现
        }
    }
};
```

## POST请求

```js
// 创建对象
const xhr = new XMLHttpRequest();
xhr.open("POST", "http://127.0.0.1:8000/server");
// 设置请求头信息
xhr.setRequestHeader(
    "Content-Type",
    "application/x-www-form-urlencoded"
);
xhr.send("a=100&b=200&c=300");
xhr.onreadystatechange = function () {
    if (xhr.readyState === 4) {
        if (xhr.status >= 200 && xhr.status < 300) {
            
            // 数据呈现
        }
    }
};
```

## 响应JSON

```js
const xhr = new XMLHttpRequest();
// 设置响应体数据类型
xhr.responseType = "json";
xhr.open("GET", "http://127.0.0.1:8000/json-server");
xhr.send();
xhr.onreadystatechange = function () {
    if (xhr.readyState === 4) {
        if (xhr.status >= 200 && xhr.status < 300) {
            
            // 数据呈现（直接呈现则为字符串类型的数据）

            // 手动转换
            let data = JSON.parse(xhr.response);
            // 数据呈现（转换后数据为对象类型）

            // 自动转换，需要先在服务端利用JSON.stringify()转换后发送回来再数据呈现（对象类型）
        }
    }
};
```

## 重复请求问题

```js
let x = null;
// 标识变量
let isSending = false;

// 判断标识变量
if (isSending) {
    // 若重复请求（上一个请求还没完成），则取消上一次的请求，然后再创建新的请求
    x.abort();
}
x = new XMLHttpRequest();
// 修改isSending的值
isSending = true;
x.open("GET", "http://127.0.0.1:8000/delay");
x.send();
x.onreadystatechange = function () {
    if (x.readyStatus === 4) {
        // 修改标识变量isSending的值
        isSending = false;
    }
};
```

## 取消请求

```js
x.abort();
```

## 超时与网络异常

```js
// 设置2s超时
xhr.timeout = 2000;
// 超时回调
xhr.ontimeout = function () {
    alert("网络超时，请稍后再试！");
};
// 网络异常回调
xhr.onerror = function () {
    alert("你的网络似乎出了点问题！");
};
xhr.open("GET", "http://127.0.0.1:8000/delay");
xhr.send();
xhr.onreadystatechange = function () {
    if (xhr.readyState === 4) {
        if (xhr.status >= 200 && xhr.status < 300) {
            
            // 数据呈现
        }
    }
};
```

---

# jQuery发送Ajax请求

- 需要引入jQuery的文件

## GET请求

```js
$.get(
    // 请求URL
    "http://127.0.0.1:8000/jquery-server",
    // 传递参数
    { a: 100, b: 200, c: 300 },
    // 回调函数
    function (data) {
        console.log(data);
    },
    // 响应体结果
    "json"  // 返回的是JSON对象形式
);
```

## POST请求

```js
$.post(
    "http://127.0.0.1:8000/jquery-server",
    { a: 100, b: 200, c: 300 },
    function (data) {
        console.log(data);
    }
    // "json"  // 返回的是字符串形式
);
```

## Ajax通用性方式

```js
$.ajax({
    // url
    url: "http://127.0.0.1:8000/jquery-server",
    // 参数
    data: { a: 100, b: 200, c: 300 },
    // 请求类型
    type: "GET",
    // 响应体结果
    dataType: "json",
    // 成功时的回调
    success: function (data) {
        console.log(data);
    },
    // 超时时间
    timeout: 2000,
    // 失败时的回调
    error: function () {
        console.log("出错了！");
    },
    // 头信息
    headers: {
        a: 400,
        d: 500,
    },
});
```

---

# axios发送Ajax请求

是Vue和React推荐的Ajax请求工具包。

## GET请求

```js
// GET请求
axios.get("/axios-server", {
    // url参数
    params: {
        id: 100,
        vip: 7,
    },
    // 请求头信息
    headers: {
        name: "Leon",
        age: 18,
    },
});
```

## POST请求

- `post(url, [请求体, 其他配置项])`

```js
// POST请求
axios.post(
    "/axios-server",
    {
        // 请求体
        username: "admin",
        password: "123456",
    },
    {
        // url参数
        params: {
            id: 200,
            vip: 9,
        },
        // 请求头信息
        headers: {
            name: "Jack",
            age: 22,
        },
    }
);
```

## axios通用性方式

```js
axios({
    // 请求方法
    method: "POST",
    // URL
    url: "/axios-server",
    // URL参数
    params: {
        vip: 10,
        level: 30,
    },
    // 头信息
    headers: {
        a: 100,
        b: 200,
    },
    // 请求体参数
    data: {
        username: "admin",
        password: "123456",
    },
});
```

# fetch发送Ajax请求

```js
fetch("http://127.0.0.1:8000/fetch-server?vip=10", {
    // 请求方法
    method: "POST",
    // 请求头
    headers: {
        name: "Melody",
        age: "22",
    },
    body: "username=admin&password=123456",
});
```

# 跨域

## 同源策略

Same-Origin Policy：同源策略，是浏览器的一种安全策略。

- 同源：协议、域名、端口号必须完全保持一致
- Ajax默认需要遵循同源策略才能发送请求
- 违背同源策略即为跨域

## 跨域解决方案

### JSONP

JSON with Padding 是一个非官方的跨域解决方案，只支持GET请求。

- 利用的是html中一些本身具备跨域能力的标签，如script、img、link等
- script返回的应当是一段可执行的js代码（回调函数）

### 利用jQuery发送JSONP

- index.html
  
    ```js
    $.getJSON(
        "http://127.0.0.1:8000/jquery-jsonp-server?callback=?",
        function (data) {
            $(".result").html(`
                姓名：${data.name}</br>
                年龄：${data.age}</br>
                性别：${data.gender}
            `);
        }
    );
    ```
    
- server.js
  
    ```js
    // 接收callback参数
    let cb = request.query.callback;
    let str = JSON.stringify(data);
    response.end(`${cb}(${str})`);
    ```
    

### CORS

Cross-Origin Resource Sharing 跨域资源共享，是官方的跨域解决方案，支持GET和POST请求。

- 不需要在客户端做任何特殊操作，安全在服务器中进行处理
- 跨域资源共享标准新增了一组HTTP首部字段，允许服务器声明哪些源站通过浏览器有权限访问哪些资源
- server.js中设置响应头，如：
  
    ```js
    response.setHeader("Access-Control-Allow-Origin", "*");
    response.setHeader("Access-Control-Allow-Headers", "*");
    response.setHeader("Access-Control-Allow-Method", "*");
    ```