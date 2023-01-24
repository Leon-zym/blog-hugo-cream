---
title: 《浙大 数据结构》线性结构
date: 2021-08-05T10:00:00
categories: Programming
tags: [CS]
---

# 线性表及其实现

## 多项式的表示

> 一元多项式：$f(x)=a_0+a_1x+...+a_{n-1}x^{n-1}+a_nx^n$
主要运算：多项式相加、相减、相乘等
> 

表示方法：

- 顺序存储结构直接表示
- 顺序存储结构表示非零项
- 链表结构存储非零项

## 线性表的定义

由同类型数据元素构成有序序列的线性结构。

- 表中元素个数称为线性表的长度
- 线性表没有元素时，称为空表
- 表起始位置称表头，表结束位置称表尾

## 线性表的抽象数据类型描述

类型名称：线性表（List）

数据对象集：n(≥0)个元素构成的有序序列

操作集：线性表$L\in List$，整数$i$表示位置，元素$X\in ElementType$。

基本操作：

1. List MakeEmpty(): 初始化一个空表
2. ElementType FindKth(int K, List L): 根据位序K，返回相应元素
3. int Find(ElementType X, List L): 在表中查找X第一次出现的位置
4. void insert(ElementType X, int i, List L): 插入
5. void Delete(int i, List L): 删除
6. int length(List L): 返回长度

## 线性表的顺序存储实现

```c
typedef struct LNode *List;
struct LNode
{
    ElementType Data[MAXSIZE];
    int Last;
};
struct LNode L;
List PtrL;
```

访问元素：L.Data[i] 或 PtrL→Data[i]

线性表长度：L.Last+1 或 PtrL→Last+1

主要操作的实现：

- 初始化（建立空的顺序表）

```c
List MakeEmpty()
{
    List PtrL;
    PtrL = (List)malloc(sizeof(struct LNode));
    PtrL.Last = -1;
    return PtrL;
}
```

- 查找

```c
int Find(ElementType X, List PtrL)
{
    int i = 0;
    while(i <= PtrL->Last && PtrL->Data[i] != X)
        i++;
    if(i > PtrL->Last)
        return -1;  //如果没找到，则返回-1
    else
        return i;  //找到则返回i
}
```

平均查找次数为(n+1)/2，平均时间性能为O(n)。

- 插入

```c
void Insert(ElementType X, int i, List PtrL)
{
    int j;

    if(PtrL->Last == MAXSIZE-1)
    {
        printf("list is full.");  //表已满
        return;
    }
    if(i<1 || i>PtrL->Last+2)
    {
    printf("position is illegal.");  //位置不合法
    }

    for(j=PtrL->Last; j>=i-1; j--)
    {
    PtrL->Data[j+1] = PtrL->Data[j];  //以倒序将i后面的元素依次后移，腾出位置
    }
    
    PtrL->Data[i-1] = X;  //插入新元素
    PtrL->Last++;  //将Last重新指向最后元素的位置
    return;
}
```

平均移动次数为n/2，平均时间性能为O(n)

- 删除

```c
void Delete(int i, List PtrL)
{
    int j;
    if(i<1 || i>PtrL->Last+1)
    {
        printf("不存在第%d个元素。" ,i);
        return;
    }

    for(j=i; j<=PtrL->Last; j++)
    {
        PtrL->Data[j-1] = PtrL->Data[j];  //以正序将i后面的元素前移
    }

    PtrL->Last--;  //将Last重新指向最后的元素
    return;
}
```

平均移动次数为(n-1)/2，平均时间性能为O(n)

## 线性表的链式存储实现

不要求逻辑上相邻的两个元素物理上也相邻。通过“链”建立起数据元素之间的逻辑关系。插入、删除不需要移动数据元素。只需要修改“链”。

```c
typedef struct LNode *List;
struct LNode
{
    ElementType Data;
    List Next;
};
struct LNode L;
List PtrL;
```

主要操作的实现

- 求表长

```c
int Length(List PtrL)  //链表的名字即链表的头指针
{
    List p = PtrL;  //指向链表的第一个结点
    int j = 0;
    while(p)  //链表的最后一个结点的Next为Null，跳出循环
    {
        p = p->Next;  //遍历链表
        j++;
    }
    return j;
}
```

时间复杂度为O(n)

- 查找（按序号）

```c
List FindKth(int K, List PtrL)
{
    List p = PtrL;
    int i = 1;
    while(p!=NULL && i<K)
    {
        p = p->Next;
        i++;
    }
    
    if(i==K)
    {
        return p;
    }
    else
    {
        return NULL;
    }
}
```

- 查找（按值）

```c
List Find(ElementType X, List PtrL)
{
    List p = PtrL;
    while(p!=NULL && p->Data!=X)
    {
        p = p->Next;
    }
    return p;
}
```

平均时间复杂度为O(n)

- 插入

```c
List Insert(ElementType X, int i, List PtrL)
{
    List p, s;  //p为第i-1个结点，s为第i个结点
    if(i==1)  //若新结点插在表头，特殊处理
    {
        s = (List)malloc(sizeof(struct LNode));  //申请空间
        s->Data = X;  //填装结点的Data
        s->Next = PtrL;  //填装结点的Next
        return p;  //为函数返回新表头的指针
    }
    
    p = FindKth(i-1, PtrL);  //调用FindKth函数返回第i-1个结点
    if(p == NULL)  //判断存在与否
    {
        printf("wrong argument!");
        return NULL;
    }
    else
    {
        s = (List)malloc(sizeof(struct LNode));
        s->Data = X;
        s->Next = p->Next;  //先把原p后面的结点地址赋给s
        p->Next = s;  //再把s的地址赋给p，顺序不可调转
        return PtrL;
    }
}
```

平均查找次数为n/2

- 删除

```c
List Delete(int i, List PtrL)
{
    List p, s;
    if(i == 1)  //若要删除的是表的第一个结点
    {
        s = PtrL;
        if(PtrL != NULL)
            PtrL = PtrL->Next;  //从表中删除
        else
            return NULL;  //空表
        free(s);  //释放被删除的结点
        return PtrL;
    }
    
    p = FindKth(i-1, PtrL);  //查找第i-1个结点
    if(p = NULL)
    {
        printf("第%d个结点不存在。", i-1);
        return NULL;
    }
    else if(p->Next == NULL)
    {
        printf("第%d个结点不存在。", i);
        return NULL;
    }
    else
    {
        s = p->Next;
        p->Next = s->Next;
        free(s);
        return PtrL;
    }
}
```

平均时间复杂度为n/2

# 广义表(Generalized List)

- 广义表是线性表的推广
- 对于线性表来说，n个元素都是基本的单元素。而广义表中，这些元素不仅可以是单元素也可以是另一个广义表

```c
typedef struct GNode *GList;
struct GNode
{
    int Tag;  //标志域：0表示结点为单元素，1表示结点为广义表
    union  //联合体：子表的指针域SubList与单元素数据域Data复用，即共用存储空间
    {
        ElementType Data;
        GList SubList;
    }URegion;
    GList Next;  //指向后继结点
};
```

## 多重链表

- 链表中的结点可能同时隶属于多个链
- 多重链表中结点的指针域会有多个，如前面广义表的实现中，包含了Next和SubList两个指针域
- 但包含两个指针域的链表并不一定是多重链表，比如双向链表就不是多重链表
- 多重链表有广泛的用途，基本上如树、图这样相对复杂的数据结构都可以采用多重链表的方式实现存储

## 十字链表

- 十字链表是一种典型的多重链表。可以用十字链表来存储“稀疏矩阵”
- 实现：略