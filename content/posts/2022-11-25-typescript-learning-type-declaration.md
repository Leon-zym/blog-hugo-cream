---
title: TypeScript 学习 类型声明
date: 2022-11-25
categories: Programming
tags: [TypeScript]
---

## 类型声明

通过类型声明可以指定 TS 中变量的类型，包括函数参数的类型。指定类型后，当为变量赋值时，TS 编译器会自动检查值是否符合类型声明，不符合则会报错：

```ts
let a: number
let b: boolean = false

a = 12
a = 'hello' // 报错
b = 'hello' // 报错
```

如果变量的声明和赋值操作是同时完成的，则 TS 可以自动进行变量类型检测，不需要手动进行类型声明了：

```ts
let c = 'foo'

c = 12 // 报错
```

在函数定义时，也可以为形参进行类型声明，指定形参的类型和个数：

```ts
function sum(d: number, e: number) {
    return d + e
}

sum(43, 675)
sum(54, '98') // 报错
sum(4, 54, 564) // 报错
sum(55) // 报错
```

同时，也可以指定函数返回值的类型：

```ts
function fn(name: string, age: number): boolean {
    return 'foo' // 报错
    return false
}

let result = fn('Leon', 18) // 可以检测到 result 应为 Boolean 类型
```

## 基本数据类型的声明

变量的类型除了可以声明为上面几种基本类型以外，还可以声明为下面一些基本类型：

使用 `字面量` 声明类型，变量的值只能为其类型本身：

```ts
// gender 只能为 male 或者 female
let gender: 'male' | 'female'

gender = 'male'
gender = 'female'
gender = 'people' // 报错
```

使用 `any` 声明类型，表示任意类型，相当于对该变量关闭了类型检测：

```ts
let foo: any

foo = 'hello'
foo = 12
foo = false

let bar // 只声明而不指定类型，也不赋值，则自动隐式声明为 any

bar = 'world'
bar = 32
bar = true
```

如果不确定变量的具体类型，则更推荐使用 `unknown` 声明类型：

```ts
let foo: unknown

foo = 'jet'
foo = 564
foo = true
```

`any` 和 `unknown` 的区别：

```ts
let foo: any
let bar: unknown

foo = 56
bar = 43

let test: string
test = foo // 不会报错
test = bar // 报错
```

> unknown 实际上就是一个类型安全的 any，unknown 类型的变量不能直接赋值给其他变量。所以在变量具体类型不确定的时候，更推荐使用。

那如果需要将 unknown 类型的变量赋值给其他变量，则可以先使用 if 判断一下变量类型，或在赋值时使用类型断言：

```ts
let foo: unknown
let bar: string

foo = 'hello'
bar = foo // 报错

// if 判断
if(typeof foo === 'string') {
    bar = foo
}

// 类型断言
bar = foo as string
// 另一种形式
bar = <string>foo
```

使用 `void` 声明类型，用来表示空。用于函数即表示函数没有返回值，或者返回的是 undefined 或 null：

```ts
function fn(): void {
    return false // 报错
}
```

使用 `never` 声明类型，表示函数永远不会返回结果。一般用于处理错误的函数，调用后就报错退出执行，永远不会返回结果：

```ts
function error(): never{
    throw new Error('something went wrong...')
}
```

## 引用数据类型的声明

使用 `object` 声明对象类型，但其包括了对象和函数，更推荐使用 `类似对象字面量及其属性` 的形式来声明对象：

```ts
let obj: object

obj = {}
obj = function (){ }

// ===============================

let obj2: {name: string}

obj2 = {} // 报错
obj2 = {name: 'Leon'}
obj2 = {name: 'Leon', age: 18} // 报错

// ===============================

let obj3: {name: string, age?: number} // ? 表示该属性可选

obj3 = {name: 'Leon', age: 18}
obj3 = {name: 'Leon'}

// ===============================

let obj4: {name: string, [propName: string]: any} // 表示对象必须包含 name 属性，其他属性不做限制

obj4 = {name: 'Leon', gender: 'male', age: 18}
```

同样更推荐使用 `类似箭头函数字面量` 的形式声明函数结构：

```ts
let fn: (a: number, b: string) => boolean

fn = function (foo, bar) {
    return false
}
```

使用 `type[]` 的形式声明存储 `type` 类型的数组：

```ts
let arr: number[]
arr = [2, 443, 434, 'abc'] // 报错

let arr2: string[]
arr2 = ['Leon', 'Mike', 54] // 报错

// 另一种形式
let arr3: Array<number>
let arr4: Array<string>
```

## 新增的数据类型的声明

使用 `[type1, type2, ...]` 的形式声明 tuple 元组类型（固定长度的数组），其中元素的类型依次为 `type1, type2, ...`：

```ts
let tuple: [number, number, string]

tuple = [12, 432, 'hello']
tuple = [23, 3432, 'foo', 'bar'] // 报错
tuple = ['abc', 3432, 'foo'] // 报错
tuple = [23, 32] // 报错
```

使用 `Enum{}` 声明 enum 枚举类型：

```ts
// 声明一个枚举类型
enum Gender {
    Male,
    Female
}

let person: {name: string, gender: Gender} // 使用枚举类型作为变量类型

// 变量的值可以是枚举类型中的某个
person = {name: 'Leon', gender: Gender.Male}
person = {name: 'Elli', gender: Gender.Female}
```

## 其他

可以使用 `|` 和 `&` 联合进行类型声明：

```ts
let foo: number | string

foo = 15
foo = 'hello'

let bar: {name: string} & {age: number}

bar = {name: 'Leon', age: 18}
bar = {name: 'Jack'} // 报错
```

可以给类型起别名：

```ts
type validNumber = 1 | 3 | 5 | 7 | 9

let num1: validNumber = 3
let num1: validNumber = 4 // 报错
```

