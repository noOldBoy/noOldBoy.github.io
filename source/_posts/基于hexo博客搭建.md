---
title: 基于hexo博客搭建
date: 2022-05-24 19:29:00
tags:
- hexo
categories:
- 前端
cover: /images/background/xiaomai7.jpeg
coverWidth: 1200
coverHeight: 320

---
这篇博客搭建

<!-- more -->

#### 开始搭建

1. 因为 hexo 是基于 node 框架的，所以呢，我们首先需要下载安装node，下载地址：[nodejs](https://wistbean.github.io/nodejs.cn)
2. 安装完之后，我们打开命令窗口，输入 `node -v` ，如果返回下图所示，那么就说明你安装 node 成功了。

![img](https://ask.qcloudimg.com/http-save/yehe-7723642/q6zr2g8kl1.png?imageView2/2/w/1620)

node 版本

1. 安装成功后，我们在命令行窗口运行如下命令来安装hexo： npm install hexo-cli -g 
2. 初始化博客目录： hexo init wistbean.github.io (这里的wistbean换成你自己的英文名) 
3. 初始化完成后，我们就进入我们的目录： cd wistbean.github.io 
4. 安装 npm install 
5. clean一下，然后生成静态页面 hexo clean hexo g 

> g 就是`generate` ,生成的意思

1. 把你的网站运行起来 hexo s

> s 就是`server` ,在服务器运行的意思

1. 打开你的浏览器，输入 `localhost:4000` 。 自此，你的个人网站就这么速度的搭建起来了！
