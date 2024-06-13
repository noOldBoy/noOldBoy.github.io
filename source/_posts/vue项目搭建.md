---
title: vue2实战一.
date: 2022-07-22 14:26:22
tags:
- vue
categories:
- 前端
cover: /images/cha/12.jpeg
coverWidth: 1200
coverHeight: 320
---

vue项目搭建and详解

<!-- more -->

#### 一.vue介绍

在前端项目开发中，我们可以根据实际情况不同程度地使用 Vue。利用 Vue CLI（或写成 vue-cli，即 Vue 脚手架）搭建出来的项目，是最能体现 Vue 的特性的。这点在接下来的内容中我们可以慢慢感受。

关于项目的构建其实类似的文章网上有很多，但我还是重新写了一下，一是为了确保项目能够运行成功，二是对几个细节作了解释，三是加入了使用 IDE 的构建方法。

在动手操作之前，我希望大家已经清楚什么是 “前后端分离” ，什么是 “单页面应用” 。

简单地说，前后端分离 的核心思想是前端页面通过 ajax 调用后端的 restuful api 进行数据交互，而 单页面应用（single page web application，SPA），就是只有一张页面，并在用户与应用程序交互时动态更新该页面的 Web 应用程序。

**附上 Vue 的官方教程：**

https://cn.vuejs.org/v2/guide/

#### 二.vue安装

`node`   `npm  ` `cnpm` `vue-cli`

个人理解

node 服务端的 JavaScript，前后端分离以后，类似于tomcat一样的一个启动器

npm 类似于`java`中的maven，管理外部的包

cnpm 其实就是一个改成了中文镜像的maven，使用国内下载地址下载包更快呗

vue-cli 框架类似于java中的spring

因为需要使用 npm 安装 Vue CLI，而 npm 是集成在 Node.js 中的，所以第一步我们需要安Node.js，访问官网 [Node.js官网](https://nodejs.org/en/)，首页即可下载。建议不要下载最新版本，一般推前半年前的版本最为稳定。

![image-20220722143253624](/image-20220722143253624-8471575.png)

图中左边是长期支持版本，右边是当前版本，下载哪个都行，我一般选择长期支持版本。

下载完成后运行安装包，一路下一步就行。然后在 终端 中输入 `node -v`，检查是否安装成功

如图，出现了版本号（根据下载时候的版本确定），说明已经安装成功了。同时，npm 包也已经安装成功，可以输入 `npm -v` 查看版本号

![image-20220722143550147](/image-20220722143550147-8471751.png)

之后可以选择安装 cnpm，即 npm 的国内镜像。使用 cnmp 的好处是在日后下载内容时会比较快，但是下载的包可能不是最新的。

安装 cnpm 的命令为 ：

npm install -g cnpm --registry=https://registry.npm.taobao.org

完成后就可以使用 cnpm 替代 npm 了，我不太喜欢用 cnpm，喜欢用的小伙伴注意一点，cnpm 不要与 npm 混合使用，一个项目用 cnpm 就从头用到底，不要中途敲错命令，否则就会出现混乱。不过万一遇到这种情况也不用慌，把项目的 node_modules 文件夹删了重新执行 npm/cnpm install 就行了。

最后，使用 `npm install -g vue-cli` 安装脚手架。

![image-20220722145142205](/image-20220722145142205-8472703.png)

#### 三.构建前端项目

后执行命令 `vue init webpack wj-vue`，这里 webpack 是以 webpack 为模板指生成项目，还可以替换为 pwa、simple 等参数，这里不再赘述。 my-utils 是我们的项目名称（White Jotter），可以起别的名字。

在程序执行的过程中会有一些提示，可以按照默认的设定一路回车下去，也可以按需修改，比如下图问我项目名称是不是 my-utils，直接回车确认就行。

这里还会问是否安装 vue-router，一定要选是，也就是回车或按 Y，vue-router 是我们构建单页面应用的关键。其他的可以按照自己需要选择

![image-20220722150005682](/Users/guoshuai/Documents/life/pre/blog/source/_posts/vue项目搭建/image-20220722150005682.png)

![image-20220722150321461](/Users/guoshuai/Documents/life/pre/blog/source/_posts/vue项目搭建/image-20220722150321461.png)

下载完成以后，使用vscode打开刚刚那个目录

![image-20220722151113362](/image-20220722151113362.png)

选择用node.js启动项目，看到输出端口号就是成功了

![image-20220722151246862](/image-20220722151246862.png)

浏览器访问，默认页面

![image-20220722151332338](/image-20220722151332338.png)

#### 四.项目结构分析

打开文件目录

![image-20220722151537492](/image-20220722151537492-8474139.png)

文件解析

![在这里插入图片描述](/2019040120135655.png)

其中我们最常修改的部分就是 components 文件夹了，几乎所有需要手动编写的代码都在其中。

2.x 时代没有创建 view 这个目录，其实加上更加合理，现在我们姑且认为 Vue 把视图也当做“组件”的一部分，有助于初期的理解。

分析几个文件，看看各个部分是怎么联系到一起的

##### **index.html**

首页文件的初始代码如下：

```
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>my-utils</title>
  </head>
  <body>
    <div id="app"></div>
    <!-- built files will be auto injected -->
  </body>
</html>

```

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>my-utils</title>
  </head>
  <body>
    <div id="app"></div>
    <!-- built files will be auto injected -->
  </body>
</html>

就是一个普普通通的 html 文件，让它不平凡的是 ```<div id="app"></div> ```，下面有一行注释，构建的文件将会被自动注入，也就是说我们编写的其它的内容都将在这个 div 中展示。

还有不普通的一点是，整个项目只有这一个 html 文件，所以这是一个 单页面应用，当我们打开这个应用，表面上可以有很多页面，实际上它们都只不过在一个 div 中。

##### App.vue

上面图上我把这个文件称为“根组件”，因为其它的组件又都包含在这个组件中。

.vue 文件是一种自定义文件类型，在结构上类似 html，一个 .vue 文件即是一个 vue 组件。先看它的初始代码

```vue
<template>
  <div id="app">
    <img src="./assets/logo.png">
    <router-view/>
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>

```

家可能注意到了，这里也有一句`<div id="app">` ，但跟 index.html 里的那个是没有关系的。这个 id=app 只是跟下面的 css 对应。

`<script>`标签里的内容即该组件的脚本，也就是 js 代码，export default 是 ES6 的语法，意思是将这个组件整体导出，之后就可以使用 import 导入组件了。大括号里的内容是这个组件的相关属性。

这个文件最关键的一点其实是第四行， `<router-view/>`，是一个容器，名字叫“路由视图”，意思是当前路由（ URL）指向的内容将显示在这个容器中。也就是说，其它的组件即使拥有自己的路由（URL，需要在 router 文件夹的 index.js 文件里定义），也只不过表面上是一个单独的页面，实际上只是在根组件 App.vue 中

##### main.js

前面我们说 App.vue 里的 `<div id="app">` 和 index.html 里的 `<div id="app">` 没有关系，那么这两个文件是怎么建立联系的呢？让我们来看入口文件 main.js 的代码

```js
// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'

Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})

```

这个 js 文件有的同学可能看着不顺眼，比如没有分号（;），因为是 ES6 的语法，不这么写反而会提示错误，虽说可以把 es-lint 改了或者关了，但我想熟悉一下新的规则也挺好。

最上面 import 了几个模块，其中 vue 模块在 node_modules 中，App 即 App.vue 里定义的组件，router 即 router 文件夹里定义的路由。

Vue.config.productionTip = false ,作用是阻止vue 在启动时生成生产提示。

在这个 js 文件中，我们创建了一个 Vue 对象（实例），el 属性提供一个在页面上已存在的 DOM 元素作为 Vue 对象的挂载目标，router 代表该对象包含 Vue Router，并使用项目中定义的路由。components 表示该对象包含的 Vue 组件，template 是用一个字符串模板作为 Vue 实例的标识使用，类似于定义一个 html 标签。
