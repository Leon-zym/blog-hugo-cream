---
title: MySQL 数据库的基本使用
date: 2022-11-22
categories: Programming
tags: [MySQL, Node.js]
---

## 数据库的一些基本概念

分类上有：

- 关系型（SQL）数据库：MySQL、Oracle、SQL Server 等
- 非关系型（NoSQL）数据库：MongoDB 等

关系型（SQL）数据库的数据组织结构有：数据库 database、数据表 table、数据行 row、字段 field。

同时，SQL 也是一门数据库编程语言。只支持在关系型数据库中使用。

## MySQL 的一些基本概念

- MySQL 服务：后台运行的一组关键服务
- 用户：不同用户不同权限。自带用户有 root 等
- 在 shell 里连接时，以某个用户登录本地 MySQL 服务：`mysql -u root -p`
- 在数据库管理软件里连接时，本地的默认 host 为：`localhost:3306`
- 自带的数据库 schema 有：information_schema、mysql、performance_schema、sys 四个
- schema：数据库。一般一个项目一个数据库
- table：表。在一个数据库中可以有多个表，一般一个表记录业务中的一类数据
- column：列。也就是一个字段，可以设置一些属性，如 Data Type、Default Expression、Auto Increment 等

## 常见 SQL 语法

**SELECT 语句**：用于从表中查询数据。执行的结果被存放在一个结果表（结果集）中。

```SQL
-- 从 users_table 中查询所有的数据
SELECT * FROM users_table

-- 从 users_table 中查询指定字段的数据
SELECT username, password FROM users_table
```

**INSERT INTO 语句**：用于向表中插入新的数据行。

```SQL
-- 向 users_table 中插入行，指定字段和其值相对应
INSERT INTO users_table (username, password) VALUES ('Lihua', '1234abc')
```

**UPDATE 语句**：用于修改表中的数据。

```SQL
-- 将 users_table 中 id 为 4 的用户密码修改为 0000
UPDATE users_table SET password='0000' WHERE id=4

-- 修改多个字段
UPDATE users_table SET password='0000', status=1 WHERE id=4

```

**DELETE 语句**：用于删除表中的行。

```SQL
-- 从 users_table 中删除 id 小于 5 且 status 不为 1 的用户
DELETE FROM users_table WHERE id<5 AND status!=1
```

**WHERE 子句**：用于限定选择的标准。

**AND 和 OR 运算符**：可以在 WHERE 子句中将多个条件结合起来。

**ORDER BY 语句**：用于根据指定的字段对结果集进行排序。默认为升序 ASC，要降序可以使用 DESC 关键字。

```SQL
-- 从 users_table 中查询所有数据，并按照 status 字段降序排序
SELECT * FROM users_table ORDER BY status DESC

-- 从 users_table 中查询所有数据，并先按照 status 字段降序排序，再按照 id 升序排序
SELECT * FROM users_table ORDER BY status DESC, id ASC
```

**COUNT(\*) 函数**：用于返回查询结果的总数据条数。

```SQL
-- 从 users_table 中查询 status 为 0 的总数据条数
SELECT COUNT(*) FROM users_table WHERE status=0
```

**AS 关键字**：用于给查询结果中的字段设置别名。

```SQL
-- 从 users_table 中查询 status 为 0 的总数据条数，并将结果集中的字段设置别名为 total
SELECT COUNT(*) AS total FROM users_table WHERE status=0
```

## 在项目中操作 MySQL

安装 npm 包 `mysql` 后，连接、测试并查询数据：

```js
const mysql = require('mysql')

// 建立与 MySQL 数据库的连接
const db = mysql.createPool({
    host: '127.0.0.1',
    user: 'root',
    password: 'root',
    database: 'test_schema'
})

// 检测 MySQL 模块是否正常运行
db.query('SELECT 1', (err, res) => {
    if(err) return console.log(err.message)
    console.log(res) // [ RowDataPacket { '1': 1 } ]
})

// 查询表中数据
db.query('SELECT * FROM users_table', (err, res) => {
    if(err) return console.log(err.message)
    console.log(res) // 返回一个数组
})
```

## 踩坑记录

执行上面的代码后，出现了报错：

```
ER_NOT_SUPPORTED_AUTH_MODE: Client does not support authentication protocol requested by server; consider upgrading MySQL client
```

看些像是身份认证方面的问题，[去 stackoverflow 上查了一下](https://stackoverflow.com/questions/50093144/mysql-8-0-client-does-not-support-authentication-protocol-requested-by-server)，发现是 MySQL 8.0 后的版本默认使用 `caching_sha2_password` 加密方式，而 npm 上的 `mysql` 包~~暂时~~一直没有兼容导致的问题。

解决：由于是个人练手的本地数据库，所以不太考虑安全性 && keep life simple，重新用老的加密方式修改一遍 MySQL 用户的密码即可。

```SQL
-- 这里用户为 root，URL 为 localhost，修改的密码为 password
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';

-- 然后使之生效
flush privileges;
```

## 继续 在项目中操作 MySQL

向表中插入数据：

```js
// 准备数据
const userInfo = { username: 'Leon', password: '123abc' }

// 准备 SQL 语句，? 表示占位符
const insSqlStr = 'INSERT INTO users_table (username, password) VALUES (?, ?)'

// 使用数组的形式依次替换占位符
db.query(insSqlStr, [userInfo.username, userInfo.password], (err, res) => {
    if(err) return console.log(err.message)
    if(res.affectedRows === 1) { // 返回一个对象，可以判断是否插入成功
        console.log('insert successfully')
        // do something...
    }
})

// 插入数据的简化写法
// const userInfo = { username: 'Leon', password: '123abc' }
// const insSqlStr = 'INSERT INTO users_table SET ?'
// db.query(insSqlStr, userInfo, () => {})
```

更新表中数据：

```js
const newUserInfo = { username: 'Jack', password: '0000aaa' }

const updSqlStr = 'UPDATE users_table SET username=?, password=? WHERE id=7'

db.query(updSqlStr, [newUserInfo.username, newUserInfo.password], (err, res) => {
    if(err) return console.log(err.message)
    if(res.affectedRows === 1) { // 返回一个对象，可以判断是否修改成功
        console.log('update successfully')
        // do something...
    }
})

// 更新数据的简化写法
// const newUserInfo = { id: 7, username: 'Jack', password: '0000aaa', status: 0 }
// const updSqlStr = 'UPDATE users_table SET ? WHERE id=?'
// db.query(updSqlStr, [newUserInfo, newUserInfo.id], () => {})
```

删除表中数据：

```js
const delSqlStr = 'DELETE FROM users_table WHERE id=?'

db.query(delSqlStr, 6, (err, res) => {
    if(err) return console.log(err.message)
    if(res.affectedRows === 1) { // 返回一个对象，可以判断是否删除成功
        console.log(' delete successfully')
        // do something...
    }
})
```

> 但是一般业务里不会真正去删除数据，更推荐使用标记删除的形式来代替删除。即额外定义一个字段，执行删除操作就将该字段修改为“删除”状态。

