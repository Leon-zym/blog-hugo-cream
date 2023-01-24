---
title: TypeScript 学习 编译选项
date:  2022-11-30
categories: Programming
tags: [TypeScript]
---

## 使用 tsconfig.json 配置编译选项

使用 tsc 进行 TS 代码的编译时，可以在项目根目录下使用 tsconfig.json 来配置编译选项。

常用配置项：

```json
{
  "include": [
    "./src/**/*"
  ],
  "exclude": [
    "./src/temp/**/*"
  ],
  
  "compilerOptions": {
    // 目标 JS 版本
    "target": "es2015",
    // 要使用的模块化规范
    "module": "es2015",
    // 编译产物所在目录
    "outDir": "./dist",
    
    // 是否编译 JS 文件
    "allowJs": true,
    // 是否检查 JS 文件的语法
    "checkJs": true,
    // 是否移除注释
    "removeComments": true,
    // 当有错误则不生成编译产物
    "noEmmitOnError": true,
    // 编译后的 JS 是否使用严格模式
    "alwaysStrict": true,
    
    // 是否允许隐式 any 类型
    "noImplicitAny": true,
    // 是否允许不明确类型的 this
    "noImplicitThis": true,
    // 是否严格检查空值
    "strictNullChecks": true,
    // 整体控制是否严格检查
    "strict": true,
  }
}
```

## 使用 webpack 打包 TS 项目

步骤：

1. 初始化项目，配置 package.json
2. 需要安装的 npm 包：`webpack` `webpack-cli` `typescript` `ts-loader` `html-webpack-plugin`
3. 在根目录使用 webpack.config.js 配置 webpack 打包
4. 在根目录使用 tsconfig.json 配置 TS 编译

webpack.config.js 基本配置：

```js
const path = require('path')
const HTMLWebpackPlugin = require('html-webpack-plugin')

module.exports = {
  entry: './src/idnex.ts',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist')
  },

  module: {
    rules: [
      {
        test: /\.ts$/,
        use: 'ts-loader',
        exclude: /node_modules/
      }
    ]
  },

  plugins: [
    new HTMLWebpackPlugin({})
  ]
}
```

tsconfig.json 基本配置：

```json
{
  "compilerOptions": {
    "module": "es2015",
    "target": "es2015",
    "strict": true
  }
}
```

## 拓展

在 webpack 打包的时候，还可以配置使用其他的一些 loader 和 plugin，以及使用 babel 进行 JS 代码转换等。

略……