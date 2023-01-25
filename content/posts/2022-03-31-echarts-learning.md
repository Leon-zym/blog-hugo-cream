---
title: ECharts 学习
date: 2022-03-31
categories: Programming
tags: [Echarts]
---

# 数据可视化简介

目的：借助图形化的手段，清晰有效地传达与沟通信息。

ECharts是一个开源的js库。

# ECharts使用步骤

1. 引入echarts.js文件
2. 准备一个具备大小的DOM容器：用于放置生成的图表
3. 初始化echarts实例对象：实例化echarts对象
4. 指定配置项和数据：根据具体需求修改配置选项
5. 将配置项设置给echarts实例对象：让echarts对象根据修改好的配置项生效

# 相关配置

- `title`：标题组件
- `tooltip`：提示框组件
- `legend`：图例框组件
- `toolbox`：工具栏
- `grid`：直角坐标系内绘制网格
- `xAxis`：直角坐标系grid中的X轴
- `yAxis`：直角坐标系grid中的Y轴
- `series`：系列列表，每个系列通过type决定自己的图表类型
- `color`：调色盘颜色列表
- 其他配置项：查阅官方文档

### grid

- 调整实际显示图表的区域
- `containLabel`是否包含图表刻度标签的区域

### xAxis

- `boundaryGap`坐标轴两边是否留白

### series

- 数组形式，数组中的元素为对象形式。一个对象对应一个系列
- `stack`数据堆叠

### 总结

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/echarts-1.png)