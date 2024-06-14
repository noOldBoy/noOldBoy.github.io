---
title: excal导出字体问题大坑
date: 2022-08-05 10:55:26
tags:
- excal
categories:
- 后端
cover: /images/background/14.jpeg
coverWidth: 1200
coverHeight: 320
---

easyExcal导出无字体大坑

<!-- more -->

使用easyExcal做了一个导出，返回流的方式下载

在本地测试返回是ok的发布了线上就挂了，没有任何返回 也没有报错

试了很多种方案，没法解决 以为是服务器问题，所以尝试写到远程oss里，但是也不行

所以问题在代码执行时   写了78个导出的demo最后定位到 是<font color="red">jdk缺少了所需要的字体导致</font>

本地：

![843A55E6-648C-4545-80D1-ABC02BE14C50](excal导出字体问题大坑/843A55E6-648C-4545-80D1-ABC02BE14C50.png)

线上

![image-20220805112930051](excal导出字体问题大坑/image-20220805112930051.png)

##### 解决方案：

安装字体

- 安装字体（推荐）

  - 看下服务器是否安装了字体，jdk8字体需要自己安装请安装字体：dejavu-sans-fonts 和 fontconfig 在dockerfile中增加字体安装命令： `RUN yum install dejavu-sans-fonts fontconfig -y`
  - 普通的线上环境直接运行： `yum install dejavu-sans-fonts fontconfig -y`

- 开启内存处理模式（不推荐，1W数据以内可以考虑，大了很容易OOM）

```java
          EasyExcel
          .write(fileName, DemoData.class)
          // 核心这个配置 开始内存处理模式
          .inMemory(Boolean.TRUE)
          .sheet("模板")
          .doWrite(data());
