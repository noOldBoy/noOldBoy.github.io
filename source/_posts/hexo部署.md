---
title: hexo部署
date: 2024-09-24 13:46:43
tags:
- hexo
categories:
- 
cover: /images/headimg/002jihua.jpeg
coverWidth: 1200
coverHeight: 320
---

服务器检测git变化，去更新部署hexo
<!-- more -->

gitee关闭了page服务，使用github部署一段时间以后，因为github服务器在国外，非常卡，打不开。所以想部署在服务器，使用服务器监测github的变化，变化以后重新部署。其实感觉在国内使用gitee更好但是因为我的服务器在国外。

##### 1.服务器安装npm&node

```ts
# 更新软件包列表
sudo yum update

# 安装 Node.js 和 npm（假设使用的是 CentOS）
sudo yum install -y nodejs npm

# 验证安装
node -v
npm -v

```

##### 2.安装hexo & 编译项目环境

###### 全局安装 Hexo CLI

```sh
sudo npm install -g hexo-cli
```

###### 编译项目

把项目拉取下来

```sh
npm install hexo
npm install
npm install hexo-deployer-git
```

