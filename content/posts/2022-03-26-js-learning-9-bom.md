---
title: JavaScript  BOM (三)
date: 2022-03-26T10:00:00
categories: Programming
tags: [JavaScript]
---

# JavaScriptBOM（三）

Created: March 26, 2022 11:13 PM
Stage: Learning
技术栈: JavaScript

# 本地存储

数据存储在用户的浏览器中，设置和读取方便，页面刷新不丢失数据。

## window.sessionStorage

- 生命周期为关闭浏览器窗口
- 在同一个页面窗口下，数据可以共享
- 以键值对的方式使用
- 值的数据类型只能是字符串
- 存储容量最大为5m

---

- `sessionStorage.setItem(key, value)` 存储数据
- `sessionStorage.getItem(key)` 获取数据
- `sessionStorage.removeItem(key)` 删除数据
- `sessionStorage.clear()` 清空数据

## window.localStorage

- 生命周期永久生效，关闭页面窗口也会存在，除非手动删除
- 可以多页面窗口共享数据（同一浏览器共享数据）
- 以键值对形式使用
- 值的数据类型只能是字符串
- 存储容量最大为20m

---

- `localStorage.setItem(key, value)` 存储数据
- `localStorage.getItem(key)` 获取数据
- `localStorage.removeItem(key)` 删除数据
- `localStorage.clear()` 清空数据

Tips：

- `JSON.stringify()` 将对象类型的数据转换为字符串类型，以便本地存储
- `JSON.parse()` 将字符串类型的数据转换为对象类型，以便从本地存储中获取后使用
- `change` 事件：当发生变化时触发