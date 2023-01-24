---
title: 《浙大 数据结构》二叉树的遍历
date: 2021-11-03T10:00:00
categories: Programming
tags: [CS]
---

# 三种常用遍历

- 先序遍历

```c
void PreOrderTraversal( BinTree BT )
{
     if( BT )  //如果BT不空
     {
        printf("%d", BT->Data);
        PreOrderTraversal( BT->Left );  //递归
        PreOrderTraversal( BT->Right );  //递归
     }
}
```

- 中序遍历

```c
void PreOrderTraversal( BinTree BT )
{
     if( BT )  //如果BT不空
     {
        PreOrderTraversal( BT->Left );  //递归
        printf("%d", BT->Data);
        PreOrderTraversal( BT->Right );  //递归
     }
}
```

- 后序遍历

```c
void PreOrderTraversal( BinTree BT )
{
     if( BT )  //如果BT不空
     {
        PreOrderTraversal( BT->Left );  //递归
        PreOrderTraversal( BT->Right );  //递归
        printf("%d", BT->Data);
     }
}
```

<aside>
💡 先序、中序、后序遍历过程，经过结点的路线一致，只是访问各结点的时机不同。

</aside>

# 二叉树的非递归遍历

<aside>
💡 非递归遍历算法实现的基本思路：使用堆栈

</aside>

中序遍历的非递归遍历算法：

```c
void InOrderTraversal( BinTree BT )
{  
    BinTree T=BT;
    Stack S = CreatStack( MaxSize ); /*创建并初始化堆栈S*/ 
    while( T || !IsEmpty(S) )
    {  //IsEmpty是判断堆栈空不空
        while(T){ /*一直向左并将沿途结点压入堆栈*/ \
            Push(S,T);
            T = T->Left; 
            }
        if(!IsEmpty(S)){
            T = Pop(S); /*结点弹出堆栈*/
            printf("%5d", T->Data); /*(访问)打印结点*/ 
            T = T->Right; /*转向右子树*/
        } 
    }
}
```

- 先序
- 后序

# 层序遍历

<aside>
💡 二叉树遍历的核心问题：二维结构的线性化。
层序遍历使用队列完成。

</aside>

层序的基本过程：

1. 根节点入队
2. 从队列中取出一个元素
3. 访问该元素所指的结点
4. 若该元素所指的结点左右孩子结点非空，则将其左右孩子的指针顺序入队

实现：

```c
void LevelOrderTraversal ( BinTree BT )
{
    Queue Q; BinTree T;
    if ( !BT ) return; /* 若是空树则直接返回 */ 
    Q = CreatQueue( MaxSize ); /*创建并初始化队列Q*/ 
    AddQ( Q, BT ); // 把根节点放到队列里去
    while ( !IsEmptyQ( Q ) ) 
    {
        T = DeleteQ( Q );  // pop出一个元素,产生的元素赋给 T指针
        printf("%d\n", T->Data); /*访问取出队列的结点*/ 
        if ( T->Left ) AddQ( Q, T->Left );
        if ( T->Right ) AddQ( Q, T->Right );
    } 
}
```

# 遍历二叉树的应用

> 输出二叉树中的叶子结点
> 

<aside>
💡 在二叉树的先序遍历算法中加入检测叶子结点的代码：“左右子树是否都为空”。

</aside>

```c
void PreOrderPrintLeaves( BinTree BT ) 
{
    if( BT ) 
    {
        if ( !BT->Left && !BT->Right ) // 如果没有左右子树,就打印出来
            printf("%d", BT->Data ); 
        PreOrderPrintLeaves ( BT->Left ); 
        PreOrderPrintLeaves ( BT->Right );
    } 
}
```

> 求二叉树的高度
> 

<aside>
💡 HEIGHT = MAX ( HL , HR ) + 1

</aside>

```c
int PostOrderGetHeight( BinTree BT ) 
{
    int HL, HR, MaxH;
    if( BT ) 
    {
        HL = PostOrderGetHeight(BT->Left); /*求左子树的深度*/ 
        HR = PostOrderGetHeight(BT->Right); /*求右子树的深度*/ 
        MaxH = (HL > HR)? HL : HR; /*取左右子树较大的深度*/ 
        return ( MaxH + 1 ); /*返回树的深度*/
    }
    else return 0; /* 空树深度为0 */ 
}
```

> 二元运算表达式树及其遍历
> 

<aside>
💡 前缀和后缀表达式可以得到正确的表达式，中缀表达式会受到运算符优先级的影响。

</aside>

> 已知三种遍历中的任意两种遍历序列，能否唯一确定一颗二叉树？
> 

<aside>
💡 必须要有中序遍历才行，只有先序和后序不行。

</aside>