---
title: TypeScript 学习 面相对象的相关特性
date: 2022-12-07T10:00:00
categories: Programming
tags: [TypeScript]
---

## TypeScript 中的面相对象

Object-Oriented 面向对象的语言，其必然有三大特点：封装、继承、多态。而 JavaScript 是 Object-Based 基于对象的语言，并不完全算是面向对象的，特别是 ES6 之前，其缺乏完善的继承和多态特性。

而 TypeScript 就是标准的面相对象的语言了。

## class 类

```ts
class Person {
  // 定义实例属性和方法
  name: string = 'Leon'
  sayHi() {
    console.log('Hi~')
  }

  // 定义类属性和类方法(静态属性和静态方法)
  static gender: string = 'male'
  static sayBye() {
    console.log('Bye~')
  }
}

const person1 = new Person()
console.log(person1.name)
person1.sayHi()

console.log(Person.gender)
Person.sayBye()
```

## constructor 构造函数

```ts
class Dog {
  name: string
  age: number

  // 定义构造函数，会在实例对象被 new 出来时调用，this 指向实例对象
  constructor(name: string, age: number) {
    this.name = name
    this.age = age
  }
}

const dog1 = new Dog('paipai', 3)
const dog2 = new Dog('doudou', 2)

console.log(dog1.name, dog1.age)
console.log(dog2.name, dog2.age)
```

## extends 继承

```ts
// 定义父类
class Animal {
  name: string
  age: number

  // 定义构造函数，会在实例对象被 new 出来时调用，this 指向实例对象
  constructor(name: string, age: number) {
    this.name = name
    this.age = age
  }

  sayHi() {
    console.log('Hi~')
  }
}

// 定义子类，继承后将会拥有父类所有的属性和方法
class Dog extends Animal {
  // 可以新增属性和方法
  eat() {
    console.log('I eat dog food')
  }

  // 也可以方法重写
  sayHi() {
    console.log('wang wang wang')
  }
}

class Cat extends Animal {
  // 方法重写
  sayHi() {
    console.log('miao miao miao')
  }
}

const dog = new Dog('paipai', 5)
const cat = new Cat('doudou', 3)
dog.sayHi()
cat.sayhi()
```

## super 关键字

```ts
// 定义父类
class Animal {
  name: string
  age: number

  // 定义构造函数
  constructor(name: string, age: number) {
    this.name = name
    this.age = age
  }

  sayHi() {
    console.log('Hi~')
  }
}

// 定义子类
class Dog extends Animal {
  // super 代表当前子类的父类，可以访问到父类
  super.sayHi()

  // 如果在子类中要重写 constructor 构造函数，则在子类的 constructor 中必须要调用一下父类的 constructor，否则父类的 constructor 会被直接覆盖掉
  constructor(name: string, age: number, gender: string) {
    // super() 即调用父类的 constructor
    super()
    this.gender = gender
  }
}
```

## abstract 抽象类

```ts
// abstract 关键字表示该类属于抽象类，即只能被其他类继承，而不能用来实例化创建对象
abstract class Animal {
  sayHi() {
    console.log('Hi~')
  }

  // 抽象方法，只能定义在抽象类中。该方法在抽象类中不作具体实现，而在继承的子类中必须被重写实现
  abstract run(): void
}

class Dog extends Animal {
  // 必须重写 run 方法
  run() {
    console.log('running~')
  }
}

const dog = new Animal() // 报错
```

## interface 接口

```ts
// interface 关键字可以当作类型声明去使用，类似使用 type 给类型起别名
interface objInterface {
  name: string
  age: number
}

const obj1: objInterface = {
  name: 'Leon',
  age: 18
}

// =============================

// interface 接口主要作用就是限制类的结构，接口中的属性没有具体的值，方法也都是抽象方法
interface classInterface {
  name: string
  sayHi(): void
}

// 在定义类时，使用 implements 去实现一个接口，即按照接口的结构来定义类
class Cat implements classInterface {
  name: string

  constructor(name: string) {
    this.name = name
  }

  sayHi() {
    console.log('Hi~')
  }
}
```

## 属性的封装

属性的修饰符有：

- public：默认可省略，属性可以在任意位置被访问和修改
- private：私有属性，只能在当前类的内部访问和修改。但可以定义 getter 和 setter 方法使得在外部可以访问和修改私有属性。
- protected：受保护的属性，只能在当前类和当前类的子类中访问和修改

定义私有属性：

```ts
class Animal {
  private _name: string = 'Leon'
  private _age: number = 18

  getName() {
    return this._name
  }
  setName(name: string) {
    this.name = name
  }

  // getter 和 setter 的另一种简化形式
  get age() {
    return this._age
  }
  set age(value: number) {
    if(value >= 0) {
      this._age = value
    }
  }
}

const instance = new Animal()
console.log(instance.name) // 报错，不能访问到私有属性

const foo = instance.getName()
instance.setName('Mike')

// 实际访问的是对应的 getter 和 setter
const bar = instance.age
instance.age = 24
```

定义受保护的属性：

```ts
class Animal {
  protected name: string = 'Paipai'
}

const instance = new Animal()
console.log(instance.name) // 报错

class Dog extends Animal {
  console.log(this.name)
}
```

## 泛型

```ts
// 泛型，可以代表任意类型。用以在类型不明确的时候提前使用该类型
function fn<T>(value: T): T {
  // 接收一个类型 T 的值，返回一个类型的 T 的值
  return value
}

const res1 = fn(12) // 不指定泛型，TS 会对类型自动推断。res 的类型也为 number
const res2 = fn<string>('Hiiii') // 手动指定泛型。res 的类型也为 string

// 泛型也可以跟 interface 接口配合使用，用以同时指定多个类型。略……
```

