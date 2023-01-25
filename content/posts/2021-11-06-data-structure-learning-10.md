---
title: 《浙大 数据结构》平衡二叉树
date: 2021-11-06
categories: Programming
tags: [CS]
---

# 什么是平衡二叉树

- “平衡因子”（Balance Factor，BF）：左子树高度减右子树高度的值BF(T)=HL-HR
- 平衡二叉树（Balance Binary Tree）也叫AVL树，可以是空树，否则任一结点的左右子树高度差的绝对值不超过1，即 |BF(T)| ≤1
- 结点数为 n 的AVL树，最大高度为$O(log_2n)$，查找效率也为$O(log_2n)$

# 平衡二叉树的调整

<aside>
💡 要注意，平衡二叉树永远是搜索树，满足搜索树的条件。

</aside>

- **RR右单旋**

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/cs-data-structure-5.jpg)

- **LL左单旋**

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/cs-data-structure-6.jpg)

- **LR旋转**

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/cs-data-structure-7.jpg)

- **RL旋转**

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/cs-data-structure-8.jpg)

- **无需调整**

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/cs-data-structure-9.jpg)