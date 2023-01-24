---
title: 《浙大 数据结构》二叉树
date: 2021-11-03T09:00:00
categories: Programming
tags: [CS]
---

# 二叉树的定义

- 度为2的树，可以为空。若不为空则由根节点和左子树TL和右子树TR两个不相交的二叉树组成
- 二叉树的子树有左右顺序之分
- 特殊二叉树：斜二叉树、完美二叉树（满二叉树）、完全二叉树

# 二叉树的重要性质

- 一个二叉树第 i 层的最大结点数为$2^{i-1}$，i≥1
- 深度为k的二叉树有最大结点总数为$2^k-1$，k≥1
- 对任何非空二叉树T，若$n_0$表示叶结点的个数、$n_2$是度为2的非叶结点个数，那么两者满足关系$n_0=n_2+1$

# 二叉树的抽象数据类型

**类型名称**：二叉树

**数据对象集**：一个有穷的结点集合。若不为空，则由根结点和其左右二叉子树组成。

**操作集**：BT属于BinTree, Item属于ElementType

1. Boolean IsEmpty(BinTree BT)：判别BT是否为空
2. void Traversal(BinTree BT)：遍历（按照某个顺序访问每个结点）
3. BinTree CreatBinTree()：创建一个二叉树

常用的遍历方法有：

1. 先序——根、左子树、右子树
2. 中序——左子树、根、右子树
3. 后序——左子树、右子树、根
4. 层次遍历——从上到下、从左到右

# 二叉树的储存结构

## 顺序存储结构

完全二叉树

n个结点的完全二叉树的结点父子关系：

- 非根节点的父节点序号是 i/2
- 结点的左孩子结点的序号是 2i
- 结点的右孩子结点的序号是 2i+1

<aside>
💡 一般二叉树也可以采用这种结构，但会造成空间的浪费。

</aside>

## 链表存储结构

```c
typedef struct TreeNode *BinTree; 
typedef BinTree Position;
struct TreeNode
{
    ElementType Data; 
    BinTree Left; 
    BinTree Right;
}
```