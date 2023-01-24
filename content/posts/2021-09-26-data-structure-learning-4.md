---
title: 《浙大 数据结构》队列
date: 2021-09-26
categories: Programming
tags: [CS]
---

# 什么是队列

- 队列（Queue）：具有一定操作约束的线性表
- 插入和删除操作：只能在一段插入，而在另一端删除
- 数据插入：入队列（AddQ）
- 数据删除：出队列（DeleteQ）
- 遵循先来先服务
- 先进先出（FIFO）

## 队列的抽象数据类型描述

类型名称：队列（Queue）

数据对象集：一个有0个或多个元素的有穷线性表

操作集：长度为MaxSize的队列Q属于Queue，队列元素item属于ElementType

1. Queue CreateQueue(int MaxSize)：生成长度为MaxSize的空队列
2. int IsFullQ(Queue Q, int MaxSize)：判断队列Q是否已满
3. void AddQ(Queue Q, ElementType item)：将数据元素item插入队列Q里
4. int IsEmptyQ(Queue Q)：判断队列Q是否为空
5. ElementType Delete(Queue Q)：将队头数据元素从队列中删除并返回

## 队列的顺序存储实现

队列的顺序存储结构通常由一个一维数组，一个记录队列头元素位置的变量front，和一个记录队列尾元素位置的变量rear组成。

```c
#define MaxSize <存储数据元素的最大个数>
struct QNode
{
    ElementType Data[MaxSize];
    int rear;
    int front;
};
typedef struct QNode *Queue;
```

front是第一个元素的前一个位置，rear是最后一个元素的位置。初始时两者都为-1 。加入一个元素时rear+1，删除一个元素的时候front+1 。当rear == front的时候，队列为空。

<aside>
💡 循环队列：因为当rear == front的时候，无法判断队列已满还是为空，所以两种解决方法：1. 使用额外标记size或tag。2. 仅使用n-1个数组位置。

</aside>

主要操作的实现：

- 入队列

```c
void AddQ(Queue PtrQ, ElementType item)
{
    if((PtrQ->rear+1) % MaxSize == PtrQ->front)
    {
        printf("队列已满");
        return;
    }
    
    PtrQ->rear = (PtrQ->rear+1) % MaxSize;
    PtrQ->Data[PtrQ->rear] = item;
}
```

- 出队列

```c
ElementType DeleteQ(Queue PtrQ)
{
    if(PtrQ->front == PtrQ->rear)
    {
        printf("队列为空");
        return ERROR;
    }
    else
    {
        PtrQ->front = (PtrQ->front+1)% MaxSize;
        return PtrQ->Data[PtrQ->front];
    }
}
```

## 队列的链式存储结构

队列的链式存储结构也可以用一个单链表实现。插入和删除操作分别在链表的两头进行。

```c
struct Node  //链表结点结构
{
    ElementType Data;
    struct Node *Next;
};

struct QNode  //链表队列结构
{
    struct Node *rear;  //指向队尾结点
    struct Node *front;  //指向对头结点
};
typedef struct QNode *Queue;
Queue PtrQ;
```

- 不带头结点的链式队列出队操作

```c
ElementType DeleteQ(Queue PtrQ)
{
    struct Node *FrontCell;
    ElementType FrontElem;
    
    if(PtrQ->front == NULL)
    {
        printf("队列为空");
        return ERROR;
    }
    FrontCell = PtrQ->front;
    if(PtrQ->front == PtrQ->rear)  //若队列只有一个元素
        PtrQ->front = PtrQ->rear = NULL;  //删除后把队列置为空
    else
        PtrQ->front = PtrQ->front->Next;
    FrontElem = FrontCell->Data;
    free(FrontCell);  //记得要释放被删除的元素
    return FrontElem;
}
```