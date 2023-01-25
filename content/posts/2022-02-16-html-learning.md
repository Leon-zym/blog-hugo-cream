---
title: HTML 基础
date: 2022-02-16
categories: Programming
tags: [HTML]
---

# HTML标签及语义

- <html></html>    HTML根标签
- <head></head>    文档的头部
- <title></title>    文档的标题
- <body></body>    文档的主体

- <!DOCTYPE html>    文档类型声明标签，html5
- <html lang=”zh-CN”>    告诉搜索引擎和浏览器此网页的语言 en / zh-CN
- <meta charset=”UTF-8”>    文字保存的编码方式

- <h1>一级标题</h1>
- <h2>二级标题</h2>
- <h3>三级标题</h3>
- <h4>四级标题</h4>
- <h5>五级标题</h5>
- <h6>六级标题</h6>
- 标题独占一行，一共六级，依次递减

- <p>段落标签</p>    段落内文本会根据浏览器窗口的大小自动换行，段落之间会有一定空隙
- <br>    强制换行，单标签
- <strong>加粗</strong>    <b>加粗</b>
- <em>倾斜</em>    <i>倾斜</i>
- <del>删除线</del>    <s>删除线</s>
- <ins>下划线</ins>    <u>下划线</u>

- <div></div>
- <span></sapn>
- 盒子，用来布局

- <img src=”URL”>    图像标签，必要属性src指定图片路径（相对路径/绝对路径/网址）
- 其他属性：alt=”替换文本”  title=”提示文本”  width=”图像宽度px”  height=”图像高度px”  border=”图像的边框粗细px”
- 图像标签可有多个属性，属性顺序无区别，均以空格分开，属性采取键值对的格式  属性=“属性值”

- <a href=”URL”>文本或图像</a>    超链接标签，必要属性href指定链接目标的URL地址
- 其他属性：target=“链接页面的打开方式”，其中_self为默认值，在当前页面中打开，_blank为在新窗口中打开
- URL地址可以为外部链接 http://
- 也可以是内部链接（路径）
- 也可以是空链接“#”作为占位符，跳转自己
- 也可以是指向某个文件的下载链接
- 也可以是锚点链接（跳转到页面的特定位置）”#id”，并在目标位置的标签里添加一个id属性 id=””

- <!- - 注释标签 - ->
- 特殊字符
  
    ![Untitled](https://leon-blog-assets.oss-cn-hangzhou.aliyuncs.com/images/html-learning-1.png)
    
- &nbsp; 空格
- &lt; 小于号<
- &gt; 大于号>

- <table>表格</table>
- <tr>行</tr>
- <td>单元格</td>
- <th>表头单元格</th>
  
    ```html
    <table>
      <tr>
        <th>table head</th>
        <td>table data</td>
      <tr>
    </table>
    ```
    
- 表格属性（不常用，常用css设置）：
- 表格相对于周围元素的对齐方式 align=“left” “center” “right”，默认为左
- 表格单元格的边框粗细 border=“px”，默认为空
- 单元格边框与内容间的距离 cellpadding=“px”，默认1px
- 单元格之间的距离 cellspacing=“px”，默认为2px
- 表格的宽度高度 width=“px”，height=“px”
- 表格的头部区域<thead></thead>
- 表格的主体区域<tbody></tbody>
  
    ```html
    <table>
      <thead>
        <tr>
          <th>table head</th>
        <tr>
      <tbody>
        <tr>
          <td>table data</td>
        <tr>
      </table>
    ```
    
- 合并单元格：跨行合并rowspan=“合并个数”，跨列合并colspan=“合并个数”
- 左边的、上边的是目标单元格，合并代码在目标单元格内
- 删除多余单元格

- <ul>无序列表</ul>
- <ol>有序列表</ol>
- <li>列表项</li>
  
    ```html
    <ul>
      <li>无序列表项1</li>
      <li>无序列表项2</li>
    </ul>
    ```
    
- <dl>自定义列表</dl>
- <dt>标题</dt>
- <dd>内容项</dd>
  
    ```html
    <dl>
      <dt>标题</dt>
      <dd>内容项</dd>
      <dd>内容项</dd>
    </dl>
    ```
    
- <form>表单</form>
- 属性：action=“服务器URL地址”，method=“提交方式POST / GET”，name=”表单名称（后台）”

- <input type=”属性值”>    输入元素，必要属性type指定输入的属性值，type=“text” 文本，“password“ 密码，字符会被掩码，”radio“ 单选按钮，以实现多选一，“checkbox” 复选框
- 其他属性：name=“元素名称（后台）”，value=“元素的值（后台）”，要求单选按钮和复选框需要有同样的name
- 单选按钮和复选框可以加上checked=“checked”，以实现页面打开就默认勾选状态
- maxlength=“输入字符的最大长度，正整数”

- type=“submit”，提交按钮，将form里面的元素提交给后台服务器
- type=“reset”，重置按钮，还原表单元素的默认状态
- type=“button”，普通按钮，结合js使用
- type=“file”，文件域，上传文件
- <label>标签，增加用户体验，for属性应当与相关元素的id属性相同
  
    ```html
    <label for=“id”>标签</label>
    <input type="" name="" id="id">
    ```
    
- <select>下拉列表</select>
- <option selected=”selected”> 该属性将当前项设为默认状态
  
    ```html
    <select>
      <option>选项1</option>
      <option>选项2</option>
    </select>
    ```
    
- <textarea>文本域</textarea>  作大量文字输入
- cols=”每行显示的文字数”，rows=”可显示的行数，超出则出现滚动条”