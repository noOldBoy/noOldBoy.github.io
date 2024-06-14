---
title: docker常用名令
date: 2022-10-25 16:06:24
tags:
- docker
categories:
- 工具
cover: /images/background/7714970095cf64702de2c9adb677ff00.jpeg
coverWidth: 1200
coverHeight: 320
author: 不二
---

docker使用
<!-- more -->

#### docker 基础命令

##### 安装cocker

yum install docker

##### 开机自启动

service docker start

##### 启动docker

systemctl start docker

##### 关闭docker

systemctl stop docker

##### 重启docker

systemctl restart docker

##### docker设置随服务启动而自启动

systemctl enable docker

##### 查看docker 运行状态

systemctl status docker

##### 查看docker 版本号信息

docker version
docker info

#### docker 镜像命令

**查看自己服务器中docker 镜像列表**

```shell
docker images
```

**搜索镜像**

```shell
docker search 镜像名
```

**拉取镜像** 

不加tag(版本号) 即拉取docker仓库中 该镜像的最新版本latest 加:tag 则是拉取指定版本

```shell
docker pull 镜像名 
docker pull 镜像名:tag
```

**删除镜像** ------当前镜像没有被任何容器使用才可以删除

###### 删除一个

docker rmi -f 镜像名/镜像ID

###### 删除多个 其镜像ID或镜像用用空格隔开即可 

docker rmi -f 镜像名/镜像ID 镜像名/镜像ID 镜像名/镜像ID

###### 删除全部镜像  -a 意思为显示全部, -q 意思为只显示ID

docker rmi -f $(docker images -aq)

###### **强制删除镜像**

docker image rm 镜像名称/镜像ID

#### docker 容器命令

##### 查看正在运行容器列表

docker ps

##### 查看所有容器 -----包含正在运行 和已停止的

docker ps -a

##### 重启容器

docker restart 9299415df7f8

