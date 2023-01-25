---
title: 《浙大 数据结构》绪论
date: 2021-08-05T09:00:00
categories: Programming
tags: [CS]
---

# 1.1 什么是数据结构

### 定义

数据结构（data structure）是计算机中存储、组织数据的方式。通常情况下，精心选择的数据结构可以带来最优效率的算法。——中文维基百科

### 推论

解决问题方法的效率，跟数据的组织方式、空间的利用效率、算法的巧妙程度有关。

### 案例

> 计算程序运行时间的通用代码：
> 

```c
#include <stdio.h>
#include <time.h>    //clock函数包含在time头文件中

clock_t start, stop;    //clock_t是clock函数返回的变量类型
double duration;

int main()
{                   //不在测试范围内的准备工作可在clock函数调用之前
  start = clock();  //开始计时
  MyFunction();    //要计时的函数
  stop = clock();  //结束计时
  duration = ((double)(stop - start)) / CLK_TCK;
  //clock函数返回的单位是“clock tick 时钟打点”，常数CLK_TCK即为每秒的时钟打点数。运算结果单位为秒
  
  return 0;
}
```

> 两种算法的耗时对比（证明“解决问题的效率跟算法的巧妙程度有关”的具体案例）：
写程序计算给定多项式 $f(x)=\Sigma^9_{i=0}i\cdot x^i$ 在给定点 x=1.1 处的值 f(1.1)
> 

```c
#include <stdio.h>
#include <time.h>
#include <math.h>   //用到了pow函数

clock_t start, stop;
double duration;
#define MAXN 10     //多项式最大项数，即最高次项的次数为MAXN-1
#define MAXK 1e7    //被测函数最大调用次数
double f1(int n, double a[], double x);     //普通算法
double f2(int n, double a[], double x);     //秦九韶算法

int main()
{
    int i;
    double result1, result2;
    double a[MAXN];     //存储多项式的系数
    for( i=0; i<MAXN; i++)
    {
        a[i] = (double) i;
    }

    start = clock();
    for(i=0; i<MAXK; i++)   //循环多次调用被测函数，防止被测函数执行时间过短而clock函数检测不到
    {
        result1 = f1(MAXN, a, 1.1);
    }
    stop = clock();
    duration = ((double)(stop - start)) / MAXK / CLK_TCK;   //结果要再除以循环的次数

    printf("ticks1 = %f\n", (double)(stop - start));
    printf("duration1 = %6.2e\n", duration);
    printf("result1 = %f\n", result1);

    putchar('\n');

    start = clock();
    for(i=0; i<MAXK; i++)
    {
        result2 = f2(MAXN, a, 1.1);
    }
    stop = clock();
    duration = ((double)(stop - start)) / MAXK /CLK_TCK;

    printf("ticks2 = %f\n", (double)(stop - start));
    printf("duration2 = %6.2e\n", duration);
    printf("result2 = %f\n", result2);

    return 0;
}

double f1(int n, double a[], double x)      //普通算法
{
    double p = 0;
    int i;
    for(i=0; i<n; i++)
    {
        p += (a[i] * pow(x, i));
    }
    return p;
}

double f2(int n, double a[], double x)      //秦九韶算法
{
    double p = a[n-1];
    int i;
    for(i=n-1; i>0; i--)
    {
        p = a[i-1] + p * x;
    }
    return p;
}
```

代码运行结果：

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/cs-data-structure-1.png)

两种算法的耗时大约是一个数量级的差距

### 什么是数据结构？

- 数据结构在计算机中的组织方式
    - 逻辑结构
    - 物理存储结构
- 数据对象必定与一系列加在其上的操作相关联
- 完成这些操作所用的方法就是算法

### 如何描述数据结构？

抽象数据类型（Abstract Data Type）：

- 数据类型
    - 数据对象集
    - 数据集合相关联的操作集
- 抽象：描述数据类型的方法不依赖具体的实现
    - 与存放数据的机器无关
    - 与数据存储的物理结构无关
    - 与实现操作的算法和编程语言均无关

# 1.2 什么是算法

### 定义

- 一个有限指令集
- 接受一些输入（有些情况下不需要输入）
- 产生输出
- 一定在有限步骤之后终止
- 每一条指令必须明确
    - 有充分明确的目标，不可有歧义
    - 计算机能处理的范围之内
    - 描述应不依赖于任何一种计算机语言以及具体实现的手段

### 案例

> 选择排序算法的伪码描述
> 

```c
//将N个整数List[0]...List[N-1]进行非递减排序

void SelectionSort (int List[], int N)
{
  for (i=0; i<N; i++)
  {
    MinPosition = ScanForMin (List, i, N-1);
    //从List[i]到List[N-1]中找最小元，并将其位置赋给MinPosition；
    Swap (List[i], List[MinPosition])
    //将未排序部分的最小元换到有序部分的最后位置；
  }
}
```

<aside>
💡 这段算法的描述似乎有误。。。

</aside>

### 算法的优劣标准

- 空间复杂度 S(n) ——根据算法写成的程序在执行时占用的存储单元的长度
- 时间复杂度 T(n) ——根据算法写成的程序在执行时耗费时间的长度

在分析一般算法的效率时，经常关注两种复杂度：最坏情况复杂度$T_{worst}(n)$和平均复杂度$T_{avg}(n)$，且$T_{avg}(n)\le T_{worsst}(n)$，更常用$T_{worst}(n)$。

### 复杂度的渐进表示法

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/cs-data-structure-2.png)

### 复杂度分析的窍门

![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/cs-data-structure-3.png)

# 1.3 应用实例：最大子列和问题

> 给定N个整数的序列$\{ A_1,A_2,...,A_N \}$，求函数$f(i,j)=max\{ 0,\Sigma ^j_{k=i} A_k \}$的最大值。
> 

算法1：三层循环

```c
int MaxSubseqSum1( int A[], int N)
{
    int ThisSum, MaxSum = 0;    //存储当前的子列和，以及最大的子列和
    int i, j, k;

    for( i=0; i<N; i++)     //i为子列左端的位置
    {
        for( j=i; j<N; j++)     //j为子列右端的位置
        {
            ThisSum =0;     //ThisSum存储当前从A[i]到A[j]的子列和
            for( k=i; k<=j; k++)
            {
                ThisSum += A[k];
            }
            if( ThisSum > MaxSum)   //若当前子列和更大
            {
                MaxSum = ThisSum;   //则更新最大子列和
            }
        }
    }
    return MaxSum;
}
```

算法1的时间复杂度为$T(N)=O(N^3)$

算法2：两层循环

```c
int MaxSubseqSum2( int A[], int N)
{
    int ThisSum, MaxSum = 0;
    int i, j;

    for( i=0; i<N; i++)
    {
        ThisSum = 0;
        for( j=i; j<N; j++)
        {
            ThisSum += A[j];    //对于相同的i，不同的j，只要在j-1次循环的基础上累加1项即可
            if( ThisSum > MaxSum)
            {
                MaxSum = ThisSum;
            }
        }
    }
    return MaxSum;
}
```

算法2的时间复杂度为$T(N)=O(N^2)$

算法3：分而治之

```c
/*
分而治之思想的算法，代码暂空
*/
```

算法3的时间复杂度为$T(N)=O(NlogN)$

算法4：在线处理

```c
int MaxSubseqSum4( int A[], int N)
{
    int ThisSum, MaxSum;
    int i;

    ThisSum = MaxSum = 0;
    for( i=0; i<N; i++)
    {
        ThisSum += A[i];    //向右累加
        if( ThisSum > MaxSum)
        {
            MaxSum = ThisSum;   //若当前子列和更大，则更新最大子列和
        }
        else if( ThisSum < 0)   //若当前子列和为负数，就不可能使后面的部分增大，
        {
            ThisSum = 0;    //只可能使后面部分更小，所以舍弃前面的部分，当前子列和归零
        }
    }
}
```

算法4的时间复杂度为$T(N)=O(N)$