---
title: mysql
date: 2023-05-14 15:36:58
tags:
- mysql
categories:
- 数据库
cover: /images/cha/30.jpeg
coverWidth: 1200
coverHeight: 320
---

msyql

<!-- more -->

##### 进入linux`docker`容器中的mysql

docker exec -it {容器id｜容器名称} bash

```dockerfile
 docker exec -it d75789dff2d4 bash;
 docker exec -it mysql-test  bash;
```

##### 登陆mysql

mysql -u{用户名} -p{密码} 

```sql
mysql -ugs -p990522
```

##### 创建mysql用户

用户表位置是在安装的mysql中msyql库中的user表中。官方推荐使用`create user`m命令创建用户,这张表主键PRIMARY KEY (`Host`,`User`)，`User`为用户名称,`Host`是用户的范围`%`表示全局，`localhost`表示只能在本地使用

```sql
create user 'gs' identified by '990522';

create user 'gs' @'localhost' identified by '990522';
```

![image-20230514154916592](mysql/image-20230514154916592.png)

##### 刷新权限

```sql
flysh privileges;
```

##### sql执行记录开关

默认为0不开启，1开启

```sql
 select @@profilin；
 set profiling = 1;
```

##### 查看当前存储引擎

```sql
show engines；
```

#### mysql变量

##### 系统变量

###### 全局系统变量

```sql
#查看全部系统变量
SHOW GLOBAL VARIABLES;
#修改系统变量的值 !!!只针对当前数据库实例，数据库重启变量会重新初始化
SET GLOBAL max_connections = 152;
SET @@global. max_connections = 151;
```

###### 会话系统变量

```sql
#查看回话系统变量
SHOW  VARIABLES;
SHOW SESSION VARIABLES;
#模糊查询系统变量
SHOW SESSION VARIABLES LIKE '%activate%'; 
#查看某一个系统变量
SELECT @@GLOBAL.admin_port;
#不写修饰符默认先查询回话再查询全局
SELECT @@admin_port;
#修改会话变量 ！！！只作用在当前回话，重新连接会重新初始化
SET SESSION character_set_client = 'gbk'
SET @session.character_set_client = 'utf8mb4';
```

##### 用户变量

###### 用户回话变量

```sql
#设置用户变量
SET @m = 1;                                                                                        1;
SET @m2 := 2; 
set @m3 := @m + @m2;
#查询用户变量
SELECT @m3;
# 加入sql
SELECT @count := COUNT(*) FROM book;
SELECT @count;
```

###### 用户局部变量

