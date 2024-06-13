---
title: CDN加速
date: 2022-07-20 10:50:21
tags:
- cdn
- git
categories:
- 工具
cover: /images/cha/7.jpeg
coverWidth: 1200
coverHeight: 320
author: 不二
---

CDN加速域名github为例
<!-- more -->

#### 前提

假设你已经建好了绑定了域名的 [Github](https://so.csdn.net/so/search?q=Github&spm=1001.2101.3001.7020) Pages/Coding Pages （若没有，则参考[该链接](https://www.buer.shop/2022/07/04/%E8%87%AA%E5%AE%9A%E4%B9%89%E5%9F%9F%E5%90%8D%E4%BD%BF%E7%94%A8/)，请忽略后面添加 Cloudflare [CDN](https://so.csdn.net/so/search?q=CDN&spm=1001.2101.3001.7020) 的内容）

#### 原因

Github Page 在设置自定义域名时 source 文件下放的 CNAME 文件已经将 yourname.github.io 解析到了要加速的域名 www.xxx.com，如果这里源站信息仍然选择 yourname.github.io 就等于让 CDN 去 www.xxx.com 请求资源，而它是需要要加速的域名。在官方文档上，这四个 IP 是 Github Page 的 DNS IP 地址：

![在这里插入图片描述](/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBA5oao5oaoY29kaW5n,size_20,color_FFFFFF,t_70,g_se,x_16.png)

#### 网站测速

https://www.boce.com/

这里可以测试国内网站访问速度 一片红

![image-20220720110846862](/image-20220720110846862-8286528.png)

#### 解决方法

1.开通服务

开通阿里云 CDN (其他厂家也可，一致基本)服务，计费方式自己选择

阿里云 CDN 域名管理面板添加域名：

2.加速域名

![image-20220720111518596](/image-20220720111518596-8286920.png)

加速域名：填自己买的并且备案了的域名（假如你要在国内加速的话😝）


业务类型：视情况选择，一般默认


源站信息：推荐选源站域名，填上你的 Github Pages 域名（注意：不是你买的那个域名）


端口：如果你的 Github Pages 开启了 Enforce HTTPS（强制HTTPS），那就选 443 端口，否则 80


加速区域：视自己情况定



