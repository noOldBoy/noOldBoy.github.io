---
title: mac配置host
date: 2022-08-22 10:33:04
tags:
- host
categories:
- 工具
cover: /images/background/18.jpeg
coverWidth: 1200
coverHeight: 320
---

mac配置host

<!-- more -->

##### 修改 hosts

sudo vi /etc/hosts

##### 刷新DNS

sudo killall -HUP mDNSResponder

##### 其他版本

我的mac 系统版本 12.2.1

各版本命令仅供参考
Mac OS X 10.7 – 10.8：sudo killall -HUP mDNSResponder

Mac OS X 10.5 – 10.6：dscacheutil -flushcache

Mac OS X 10.4：lookupd -flushcache
