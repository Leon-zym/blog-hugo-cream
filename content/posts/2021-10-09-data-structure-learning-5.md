---
title: 《浙大 数据结构》队列的应用
date: 2021-10-09T09:00:00
categories: Programming
tags: [CS]
---

## 多项式的加法运算实现

<aside>
💡 主要思路：相同指数的项系数相加，其余部分进行拷贝。
采用不带头结点的单向链表，按照指数递减的顺序排列各项。

</aside>

构造：

```c
struct PolyNode
{
    int coef;  //系数
    int expon;  //指数
    struct PolyNode *link;  //指向下一个结点的指针
};
typedef struct PolyNode *Polynomial;
Polynomial P1, P2;
```

算法思路：

两个指针P1和P2分别指向这两个多项式第一个结点，不断循环:

- P1->expon == P2->expon相同：系数相加，若结果不为0，则作为结果多项式对应项的系数。同时，P1和P2都分别指向下一项；
- P1->expon > P2->expon：将P1的当前项存入结果多项式，并使P1指向下一项；
- P1->expon < P2->expon：将P2的当前项存入结果多项式，并使P2指向下一项；
- 当某一多项式处理完时，将另一个多项式的所有结点依次复制到结果多项式中去。

实现：

```c
Polynomial PolyAdd (Polynomial P1, Polynomial P2) 
{
    Polynomial front, rear, temp;  // 结果多项式的头、尾
    int sum;
    
    // 临时空结点作为结果多项式的表头, front rear都指向这个空结点
    rear = (Polynomial) malloc(sizeof(struct PolyNode)); 
    front = rear;  //由front记录结果多项式链表头结点
    
    while ( P1 && P2 )  //当两个多项式都有非零项(都不空)待处理时 
        switch ( Compare(P1->expon, P2->expon) )  //比较两个指数
        { 
            case 1:  //p1大
                //系数和指素接到rear的后面
                Attach( P1->coef, P1->expon, &rear); 
                P1 = P1->link;
                break;
            case -1:  //p2大
                Attach(P2->coef, P2->expon, &rear); 
                P2 = P2->link;
                break;
            case 0: //p1 == p2
                sum = P1->coef + P2->coef;
                // 判断sum不等于0
                if ( sum )
                    Attach(sum, P1->expon, &rear); 
                P1 = P1->link;
                P2 = P2->link;
                break;
        }
    //将未处理完的另一个多项式的所有节点依次复制到结果多项式中去 
    //p1不空
    for ( ; P1; P1 = P1->link ) 
        Attach(P1->coef, P1->expon, &rear);
    // p2不空
    for ( ; P2; P2 = P2->link ) 
        Attach(P2->coef, P2->expon, &rear); 
    
    // rear指向结果多项式的最后一项,现在结束了,把link设为NULL
    rear->link = NULL;
    // 释放临时结点
    temp = front;
    front = front->link;  //令front指向结果多项式第一个非零项
    free(temp);  //释放临时空表头结点
    return front;
}
```

其中attach函数的实现：

```c
//传入系数和指数,以及最后一个结点的指针位置(指针的指针),于在本函数中需要改变当前结果表达式尾项指针的值,所以函数传递进来的是结点指针的地址，*pRear指向尾项
 void Attach( int c, int e, Polynomial *pRear )
{
    Polynomial P;
    //申请新结点 
    P =(Polynomial)malloc(sizeof(struct PolyNode)); 
    P->coef = c;  //对新结点赋值
    P->expon = e;
    P->link=NULL;
    //将P指向的新结点插入到当前结果表达式尾项的后面
    (*pRear)->link = P;
    *pRear = P;  //修改pRear值
}
```

# 题目

> 设计函数分别求两个一元多项式的乘积与和。
> 

求解思路：

1. 多项式表示
2. 程序框架
3. 读多项式
4. 加法实现
5. 乘法实现
6. 多项式输出

## 多项式表示

仅表示非零项

两种方法：

- 数组：编程简单，调试容易。但需要事先确定数组的大小
- 链表：动态性强。但编程略微复杂，调试比较困难

## 程序框架及读入多项式

程序框架搭建：

```c
int main()
{
    Polynomial P1, P2, PP, PS;
    
    P1 = ReadPoly();
    P2 = ReadPoly();
    PP = Mult(P1, P2);
    PrintPoly(PP);
    PS = Add(P1, P2);
    PrintPoly(PS);
    
    return 0;
}
```

读入多项式：

```c
Polynomial ReadPoly()
{
    ......
    scanf("%d", &N);
    ......
    while(N--)
    {
        scanf("%d %d", &c, %e);
        Attach(c, e, &Rear);
    }
    ......
    return P;
}
```

其中Attach函数的实现：

```c
//传入系数和指数,以及最后一个结点的指针位置(指针的指针),于在本函数中需要改变当前结果表达式尾项指针的值,所以函数传递进来的是结点指针的地址，*pRear指向尾项
 void Attach( int c, int e, Polynomial *pRear )
{
    Polynomial P;
    //申请新结点 
    P =(Polynomial)malloc(sizeof(struct PolyNode)); 
    P->coef = c;  //对新结点赋值
    P->expon = e;
    P->link=NULL;
    //将P指向的新结点插入到当前结果表达式尾项的后面
    (*pRear)->link = P;
    *pRear = P;  //修改pRear值
}
```

## 加法乘法运算及多项式输出

多项式加法的实现：

```c
Polynomial PolyAdd (Polynomial P1, Polynomial P2) 
{
    Polynomial front, rear, temp;  // 结果多项式的头、尾
    int sum;
    
    // 临时空结点作为结果多项式的表头, front rear都指向这个空结点
    rear = (Polynomial) malloc(sizeof(struct PolyNode)); 
    front = rear;  //由front记录结果多项式链表头结点
    
    while ( P1 && P2 )  //当两个多项式都有非零项(都不空)待处理时 
        switch ( Compare(P1->expon, P2->expon) )  //比较两个指数
        { 
            case 1:  //p1大
                //系数和指素接到rear的后面
                Attach( P1->coef, P1->expon, &rear); 
                P1 = P1->link;
                break;
            case -1:  //p2大
                Attach(P2->coef, P2->expon, &rear); 
                P2 = P2->link;
                break;
            case 0: //p1 == p2
                sum = P1->coef + P2->coef;
                // 判断sum不等于0
                if ( sum )
                    Attach(sum, P1->expon, &rear); 
                P1 = P1->link;
                P2 = P2->link;
                break;
        }
    //将未处理完的另一个多项式的所有节点依次复制到结果多项式中去 
    //p1不空
    for ( ; P1; P1 = P1->link ) 
        Attach(P1->coef, P1->expon, &rear);
    // p2不空
    for ( ; P2; P2 = P2->link ) 
        Attach(P2->coef, P2->expon, &rear); 
    
    // rear指向结果多项式的最后一项,现在结束了,把link设为NULL
    rear->link = NULL;
    // 释放临时结点
    temp = front;
    front = front->link;  //令front指向结果多项式第一个非零项
    free(temp);  //释放临时空表头结点
    return front;
}
```

多项式乘法的实现：

略。。。

多项式的输出：

```c
void PrintPoly(Polynomial P)
{
    int flag = 0;  //用于调整输出格式，控制有无空格
    
    if(!P)
    {
        printf("0 0\n");
        return;
    }
    
    while(P)
    {
        if(!flag)
            flag = 1;
        else
            printf(" ");
        printf("%d %d", P->coef, P->expon);
        P = P->link;
    }
}
```