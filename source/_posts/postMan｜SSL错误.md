---
title: postMan｜SSL错误
date: 2022-07-19 09:41:44
tags:
- postMan
categories:
- 工具
cover: /images/background/10.jpeg
coverWidth: 1200
coverHeight: 320
---

Postman 报错SSL Error: Self signed certificate Disable SSL Verification

<!-- more -->

Postman 报错SSL Error: Self signed certificate Disable SSL Verification

![image-20220719094656814](./postMan%EF%BD%9CSSL%E9%94%99%E8%AF%AF/image-20220719094656814-8195220.png)

一开始以为可能是mac地址白名单问题，其实不是。而是postman设置问题

settings | ssl certificate verification ，点击off，关闭即可

![image-20220719094922817](./postMan%EF%BD%9CSSL%E9%94%99%E8%AF%AF/image-20220719094922817.png)
