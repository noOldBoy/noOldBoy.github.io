---
title: 本地项目集成git
date: 2022-06-15 16:41:24
tags:
- git
categories:
- 工具
cover: /images/cha/2.jpeg
coverWidth: 1200
coverHeight: 320
---

本地项目集成到远程仓库（以gitee为例）

<!-- more -->

1.登录giteehttps://gitee.com/先创建一个远程仓库(要跟本地项目名字保持一致，不然推送不上去)

![image-20220615164835051](/image-20220615164835051.png)

2.进去要上传项目位置的终端使用 git init  初始化git管理项目

![image-20220615171516788](/image-20220615171516788.png)

3.给本地仓库关联远程仓库

git remote add origin 你的远程git地址

![image-20220615171449504](/image-20220615171449504.png)

4.先更新本地仓库

git pull origin master

![image-20220615171726850](/image-20220615171726850.png)

5.推送本地仓库代码到远程仓库

$ git add .（添加所有文件，由git管理）
$ git commit -m "第一次提交"(提交到暂存区）
$ git push origin master（推送远程仓库）

![image-20220615171852102](/image-20220615171852102.png)
