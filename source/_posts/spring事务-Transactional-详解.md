---
title: spring事务@Transactional详解
date: 2022-08-09 16:50:44
tags:
- spring
- 事务
categories:
- 后端
cover: /images/cha/15.jpeg
coverWidth: 1200
coverHeight: 320
---

本地事务之Transactional详解

<!-- more -->

##### **==前言==**

<font color=blue>1.spring本地事务是作用于本地的，不支持跨库跨系统</font>

<font color=red >2.开始之前，建议先学习mysql事务</font>
点击跳转->{% post_link mysql事务 %}

##### Transactional事务

1.@Transactional是声明式事务管理 编程中使用的注解

2.@Transactional 实质是使用了 JDBC 的事务来进行事务控制的

3.@Transactional 基于 Spring 的动态代理的机制

##### 实现原理

Transactional实现是通过`AOP`实现的

###### 事务开始时：

事务开始时，生成一个代理的connection对象，并将其放入一个容器中，客户代码都应该使用该 connection 连接数据库

##### 添加位置

1.接口实现类

2.public修饰的方法上

##### **事务的隔离级别**

解释：是指若干个并发的事务之间的隔离程度

```apl
1. @Transactional(isolation = Isolation.READ_UNCOMMITTED)：读取未提交数据(会出现脏读,
 不可重复读) 基本不使用
 
2. @Transactional(isolation = Isolation.READ_COMMITTED)：读取已提交数据(会出现不可重复读和幻读)
 
3. @Transactional(isolation = Isolation.REPEATABLE_READ)：可重复读(会出现幻读)
 
4. @Transactional(isolation = Isolation.SERIALIZABLE)：串行化
```





