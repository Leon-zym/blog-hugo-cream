---
title: 《浙大 数据结构》堆栈
date: 2021-08-05T11:00:00
categories: Programming
tags: [CS]
---

# 什么是堆栈

- 堆栈（Stack）：具有一定操作约束的线性表
- 只在一端（栈顶 Top）做插入、删除
- 插入数据：入栈（Push）
- 删除数据：出栈（Pop）
- 遵循“后入先出”：Last In First Out（LIFO）

## 堆栈的抽象数据类型描述

类型名称：堆栈（Stack）

数据对象集：一个有0个或多个元素的有穷线性表

操作集：长度为MaxSize的堆栈S属于Stack，堆栈元素item属于ElementType

1. Stack CreateStack (int MaxSize)：生成空堆栈，其最大长度为MaxSize
2. int IsFull (Stack S, int MaxSize)：判断堆栈S是否已满
3. void Push (Stack S, ElementType item)：将元素item压入堆栈
4. int IsEmpty (Stack S)：判断堆栈是否为空
5. ElementType Pop (Stack S)：删除并返回栈顶元素

## 栈的顺序存储实现

栈的顺序存储结构通常由一个一维数组和一个记录栈顶元素位置的变量组成

```c
#define MaxSize <储存数据元素的最大个数>
typedef struct SNode *Stack;
struct SNode
{
    ElementType Data[MaxSize];
    int Top;
};
```

主要操作的实现：

- 入栈

```c
void Push(Stack PtrS, ElementType item)
{
    if(PtrS->Top == MaxSize-1)
    {
        printf("堆栈已满");
        return;
    }
    else
    {
        PtrS->Data[++(PtrS->Top)] = item;
        return;
    }
} 
```

- 出栈

```c
ElementType Pop(Stack PtrL)
{
    if(PtrS->Top = -1)
    {
        printf("堆栈为空");
        return ERROR;  //ERROR是ElementType的特殊值，标志错误
    }
    else
        return(PtrS->Data[(PtrS->top)--]);
}
```

> 例：用一个数组实现两个堆栈，要求最大地利用数组空间，使数组只要有空间，入栈操作就能成功。
> 

<aside>
💡 分析：一种比较聪明的办法是使这两个栈分别从数组的两头开始向中间生长；当两个栈的顶指针相遇时，表示两个栈都满了。

</aside>

```c
#define MaxSize <存储数据元素的最大个数>
struct DStack
{
    ElementType Data[MaxSize];
    int Top1;  //堆栈1的栈顶指针
    int Top2;  //堆栈2的栈顶指针
}S;
S.Top1 = -1;
S.Top2 = MaxSize;
```

- 入栈

```c
void Push(struct DStack *PtrS, ElementType item, int Tag)
{
    if(PtrS->Top2 - PtrS->Top1 == 1)
    {
        printf("堆栈已满");
        return;
    }
    
    if(Tag == 1)
        PtrS->Data[++(PtrS->Top1)] = item;  //先右移一位，再赋值
    else
        PtrS->Data[--(PtrS->Top2)] = item;  //先左移一位，再赋值
}
```

- 出栈

```c
ElementType Pop(struct DStack *PtrS, int Tag)
{
    if(Tag == 1)
    {
        if(PtrS->Tag == -1)
        {
            printf("堆栈1为空");
            return NULL;
        }
        else
            return PtrS-Data[(PtrS->Top)--];  //先赋值，再左移一位
    }

    if(Tag == MaxSize)
    {
        if(PtrS->Tag == MaxSize)
        {
            printf("堆栈2为空");
            return NULL;
        }
        else
            return PtrS->Data[(PtrS->Top)++];  //先赋值，再右移一位
    }
}
```

## 堆栈的链式存储实现

栈的链式存储结构实际上就是一个单链表，叫做链栈。插入和删除操作只能在链栈的栈顶进行。且栈顶指针Top应该在链表的头部。

```c
typedef struct SNode *Stack;
struct SNode
{
    ElementType Data;
    struct SNode *Next;
};
```

- 堆栈初始化（建立空栈）

```c
Stack CreateStack()  //构建一个堆栈的头结点，返回其指针
{
    Stack S;
    S = (Stack)malloc(sizeof(struct SNode));
    S->Next = NULL;
    return S;
}
```

- 判断堆栈是否为空

```c
int IsEmpty(Stack S)
{
    return (S->Next == NULL);  //若为空，则返回1，否则返回0
}
```

- 插入（入栈）

```c
void Push(ElementType item, Stack S)
{
    struct SNode *TmpCell;
    TmpCell = (struct SNode)malloc(sizeof(struct SNode));  //建立新的结点
    TmpCell->Element = item;  //向新结点赋值
    TmpCell->Next = S->Next;  //新结点指向原结点的下一个结点
    S->Next = TmpCell;  //原结点指向新结点
}
```

- 删除（出栈）

```c
ElementType Pop(Stack S)
{
    struct SNode *FirstCell;
    ElementType TopElem;
    
    if(IsEmpty(S))
    {
        printf("堆栈为空");
        return NULL;
    }
    else
    {
        FirstCell = S->Next;
        S->Next = FirstCell->Next;
        TopElem = FirstCell->Element;
        free(FirstCell);
        return TopElem;
    }
}
```

## 堆栈的应用

> 表达式求值：中缀表达式如何转换为后缀表达式
> 

从头到尾读取中缀表达式的每一个对象，对不同对象按照不同的情况处理：

1. 运算数：直接输出
2. 左括号：压入堆栈
3. 右括号：将栈顶的运算符弹出并输出，直到遇到左括号（左括号出栈但不输出）
4. 运算符：若优先级大于栈顶运算符，则把它压入堆栈；若优先级小于等于栈顶运算符时，将栈顶运算符弹出并输出；再去比较新的栈顶运算符，直到该运算符大于栈顶运算符优先级为止，然后将该运算符压入堆栈
5. 若各对象处理完毕，则把堆栈中存留的运算符一并输出

堆栈的其他用途：

- 函数调用及递归实现
- 深度优先搜索
- 回溯算法