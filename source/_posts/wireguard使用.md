---
title: wireguard使用记录
date: 2022-08-19 15:58:40
tags:
- wireguard
categories:
- 工具
cover: /images/cha/17.jpeg
coverWidth: 1200
coverHeight: 320
---

mac wireguard使用记录详解

<!-- more -->

##### 安装：

sudo brew install wireguard-tools

##### 基本配置：

###### 创建文件夹 (以管理员身份)
sudo mkdir /etc/wireguard

###### 设置文件夹权限 (以管理员身份)
sudo chmod 777  /etc/wireguard

###### 切入到创建的目录下
cd /etc/wireguard

###### 生成公钥与私钥
wg genkey | tee privatekey | wg pubkey > publickey

##### vpn配置

###### 创建虚拟网卡配置文件

touch wg0.conf  (名字自定义,最好跟其他文件放到一起)

###### 查看配置

wg-quick strip wg0 

###### 编辑虚拟网卡配置文件内容
vi wg0.conf（进如你配置文件路径，或者绝对路径）

示例：

在wg0.conf文件中写入如下内容，需要注意的是，需要自己修改文件内容，保持可用。

```
[Interface]
Address = 10.130.222.3/32
PrivateKey = 客户端的私钥（刚刚生成的privatekey文件的内容）
DNS = 10.130.222.1

[Peer]
PublicKey = 服务器的公钥(需要去服务器查看服务器的公钥)
Endpoint = 服务器的物理ip地址:41821
AllowedIPs = 0.0.0.0/0
PersistentKeepalive = 21

```

##### 启动客户端的网卡

wg-quick up wg0（wg0为你配置的网卡文件名）

##### 停止网卡cwg-quick down wg0 

wg-quick down wg0 

##### 查看所有支持的命令

 wg-quick 
