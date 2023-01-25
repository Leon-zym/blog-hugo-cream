---
title: 《王道计组》 计算机系统概述
date: 2022-02-12
categories: Programming
tags: [CS]
---

# 1.1 计算机发展历程

### 计算机的硬件发展

- 1946年世界上第一台电子数字计算机问世
- 计算机的发展已经经历了四代：
    - 电子管时代
    - 晶体管时代
    - 中小规模集成电路时代
    - 超大规模集成电路时代
- 摩尔定律
- 半导体存储器的发展
- 微处理器的发展

### 计算机软件的发展

- 机器语言 → 汇编语言 → 高级语言
- 高级语言的发展真正促进了软件的发展
- 操作系统：Windows、UNIX、Linux、macOS等

# 1.2 计算机系统层次结构

### 计算机硬件

**冯 · 诺依曼机基本思路：**

- 采用“存储程序”的工作方式
- 计算机硬件系统由**运算器、存储器、控制器、输入设备、输出设备**5大部件组成
- 指令和数据以同等地位存储在存储器中，均用二进制代码表示
- **以运算器为中心**

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/cs-architecture-1.png)

### 现代计算机

- **以存储器为中心**
- CPU = 运算器 + 控制器

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/cs-architecture-2.png)

存储器分为主存储器（又称内存储器）和辅助存储器（又称外存储器）。CPU能直接访问的是主存储器，辅助存储器的信息必须先调入主存后才能被CPU访问。

主存储器的基本组成：

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/cs-architecture-3.png)

- 存储体由许多存储单元组成，每个存储单元包含若干存储元件
- 每个存储元件存储一位二进制代码
- 因此每个存储单元可以存储一串二进制代码，这串代码称为存储字，代码的位数称为存储字长。存储字长可以是1B（8bit），或字节的偶数倍
- MAR的位数对应着存储单元的个数，如MAR为10位，则有2^10 = 1024个存储单元
- MDR的位数与存储字长相等

未完待续……