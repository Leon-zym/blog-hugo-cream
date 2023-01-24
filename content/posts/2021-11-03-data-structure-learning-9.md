---
title: 《浙大 数据结构》二叉搜索树
date: 2021-11-03T11:00:00
categories: Programming
tags: [CS]
---

# 什么是二叉搜索树

二叉搜索树（BST, Binary Search Tree）也称二叉排序树或二叉查找树。

二叉搜索树可以为空，若不为空，则满足：

1. 非空左子树的所有键值小于其根节点的键值
2. 非空右子树的所有键值大于其根节点的键值
3. 左右子树都是二叉搜索树

**操作的函数:**

1. Position Find( ElementType X, BinTree BST ): 从二叉搜索树BST 中查找元素X，返回其所在结点的地址;
2. Position FindMin( BinTree BST ): 从二叉搜索树BST中查找并返回 最小元素所在结点的地址;
3. Position FindMax( BinTree BST ) : 从二叉搜索树BST中查找并返回 最大元素所在结点的地址。
4. BinTree Insert( ElementType X, BinTree BST )：插入
5. BinTree Delete( ElementType X, BinTree BST )：删除

# 二叉搜索树的查找操作：Find

- 递归实现：

```c
Position Find( ElementType X, BinTree BST ) {
    if( !BST )  return NULL; /*查找失败*/ 
    if( X > BST->Data )
        return Find( X, BST->Right ); /*在右子树中继续查找*/
    Else if( X < BST->Data )
        return Find( X, BST->Left ); /*在左子树中继续查找*/
    else 
        /* X == BST->Data */
        return BST; /*查找成功，返回结点的找到结点的地址*/
}
```

<aside>
💡 尾递归，一般尾递归都可以用迭代实现，执行效率更高。

</aside>

- 迭代实现：

```c
Position IterFind( ElementType X, BinTree BST ) {
    while( BST ) 
    {
        if( X > BST->Data )
            BST = BST->Right; /*向右子树中移动，继续查找*/ 
        else if( X < BST->Data )
            BST = BST->Left; /*向左子树中移动，继续查找*/ 
        else /* X == BST->Data */
            return BST; /*查找成功，返回结点的找到结点的地址*/ 
    }
        return NULL; /*查找失败*/
}
```

# 查找最大和最小元素

<aside>
💡 最大值一定在最右分支的端点上，最小值一定在最左分支的端点上。

</aside>

```c
Position FindMax( BinTree BST )
{
    if(BST ) // 结点不空
    {
        while( BST->Right ) // 右儿子不空
            BST = BST->Right; // 则往右
    }
    return BST;
}    //迭代实现
```

```c
Position FindMin( BinTree BST )
{
    if( !BST ) return NULL;  /*空的二叉搜索树，返回NULL*/
    else if( !BST->Left )
        return BST;  /*找到最左叶结点并返回*/
    else 
        return FindMin( BST->Left );  /*沿左分支继续查找*/
        //递归实现
```

<aside>
💡 都既可以用递归实现，也可以用迭代实现。

</aside>

# 二叉搜索树的插入

<aside>
💡 关键是要找到元素应该插入的位置，可以采用与Find类似的方法。

</aside>

```c
BinTree Insert( ElementType X, BinTree BST ) {
    if( !BST ) /*若原树为空，生成并返回一个结点的二叉搜索树*/
    { 
        BST = malloc(sizeof(struct TreeNode)); 
        BST->Data = X;            
        BST->Left = BST->Right = NULL;
    }
    else /*开始找要插入元素的位置*/ 
    {
        if( X < BST->Data )
            BST->Left = Insert( X, BST->Left); /*递归插入左子树*/
        else if( X > BST->Data )
            BST->Right = Insert( X, BST->Right); /*递归插入右子树*/
    /* else X已经存在，什么都不做 */
    /* 否则最后BST->LEFT或者BST->RIGHT一定为NULL，然后执行创建新结点的操作并逐级返回
    }
    return BST;
}
```

# 二叉树的删除

**三种情况：**

1. 删除叶结点：直接删除，并修改其父结点的指针为null
2. 删除只有一个孩子的结点：将其父结点的指针指向要删除结点的孩子结点
3. 删除有左右两颗子树的结点：用右子树的最小元素或者左子树的最大元素替代要删除的结点

实现：

```c
BinTree Delete( BinTree BST, ElementType X ) 
{ 
    Position Tmp; 
 
    if( !BST ) 
        printf("要删除的元素未找到"); 
    else {
        if( X < BST->Data ) 
            BST->Left = Delete( BST->Left, X );   /* 从左子树递归删除 */
        else if( X > BST->Data ) 
            BST->Right = Delete( BST->Right, X ); /* 从右子树递归删除 */
        else { /* BST就是要删除的结点 */
            /* 如果被删除结点有左右两个子结点 */ 
            if( BST->Left && BST->Right ) {
                /* 从右子树中找最小的元素填充删除结点 */
                Tmp = FindMin( BST->Right );
                BST->Data = Tmp->Data;
                /* 从右子树中删除最小元素 */
                BST->Right = Delete( BST->Right, BST->Data );
            }
            else { /* 被删除结点有一个或无子结点 */
                Tmp = BST; 
                if( !BST->Left )       /* 只有右孩子或无子结点 */
                    BST = BST->Right; 
                else                   /* 只有左孩子 */
                    BST = BST->Left;
                free( Tmp );  //记得将结点释放
            }
        }
    }
    return BST;
}
```