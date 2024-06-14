---
title: mysql数据库锁
date: 2022-07-25 14:33:45
tags:
- mysql
categories:
- 数据库
cover: /images/background/4.jpeg
coverWidth: 1200
coverHeight: 320
---

**mysql锁详解（死锁，表锁，行锁，页锁，共享锁，排他锁等）******

<!-- more -->

#### MySQL锁概述

锁是计算机协调多个进程或线程并发访问某一个资源的机制，在数据库中，除传统的计算资源（CPU、RAM、I/O）的争用以外，数据也是一种供许多用户共享的资源。如何保证数据并发访问的一致性、有效性是所在有数据库必须解决的一个问题，锁冲突也是影响数据库并发访问性能的一个重要因素。从这个角度来说，锁对数据库而言显得尤其重要，也更加复杂。

#### 锁分类

##### 死锁

###### 1.什么是死锁

所谓死锁，是指多个进程在运行过程中因争夺资源而造成的一种僵局，当进程处于这种僵持状态时，若无外力作用，它们都将无法再向前推进

###### 2.产生死锁的必要条件

（1）互斥条件：进程对所分配到的资源不允许其他进程进行访问，若其他进程访问该资源，只能等待，直至占有该资源的进程使用完成后释放该资源
（2）请求和保持条件：进程获得一定的资源之后，又对其他资源发出请求，但是该资源可能被其他进程占有，此事请求阻塞，但又对自己获得的资源保持不放
（3）不可剥夺条件：是指进程已获得的资源，在未完成使用之前，不可被剥夺，只能在使用完后自己释放

（4）环路等待条件：是指进程发生死锁后，必然存在一个进程–资源之间的环形链

###### 3.**处理死锁的基本方法**

(1)预防死锁：通过设置一些限制条件，去破坏产生死锁的必要条件
(2)避免死锁：在资源分配过程中，使用某种方法避免系统进入不安全的状态，从而避免发生死锁
(3)检测死锁：允许死锁的发生，但是通过系统的检测之后，采取一些措施，将死锁清除掉
(4)解除死锁：该方法与检测死锁配合使用

3.1死锁检测
Jstack命令

jstack是java虚拟机自带的一种堆栈跟踪工具。jstack用于打印出给定的java进程ID或core file或远程调试服务的Java堆栈信息。 Jstack工具可以用于生成java虚拟机当前时刻的线程快照。线程快照是当前java虚拟机内每一条线程正在执行的方法堆栈的集合，生成线程快照的主要目的是定位线程出现长时间停顿的原因，如线程间死锁、死循环、请求外部资源导致的长时间等待等。 线程出现停顿的时候通过jstack来查看各个线程的调用堆栈，就可以知道没有响应的线程到底在后台做什么事情，或者等待什么资源。

###### 4.**死锁示例**

（1）创建表`test`,插入id为1跟2的两条数据

```sql
CREATE TABLE `test` (
  `id` int(20) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

INSERT INTO test VALUES (1,"tsst1")
INSERT INTO test VALUES (2,"tsst2")

```

（2）开启事务

`for update`  加锁

InnoDB引擎默认加的是行锁，但是当查询的条件没有携带主键，或者是这条数据不存在的时候就会改为表锁

```sql
-- session1										 
begin;										 	 

select * from test where id = 3 for update;     	

insert into test(id, name) values(3, "test3");    
												
-- session2
begin;
select * from test where id = 4 for update;
insert into test(id, name) values(4, "test4");

```

条件id=3是不存在的,上面两个并发事务一定会发生死锁

##### 锁的区间划分

1、间隙锁（Gap Locks）
2、临键锁（Next-key Locks）

##### 锁的粒度划分

1、表级锁（Table-level lock）
2、行级锁（Record Locks）
3、页级锁

##### 锁级别划分

1、共享锁（share lock，即S锁）

2、排它锁 / 独占锁（exclusive lock，即X锁）
3、意向锁

##### 加锁方式分类

自动锁（ Automatic Locks）
显示锁（LOCK TABLES ）

##### 六、锁的使用方式分类

乐观锁（Optimistic Lock）
悲观锁（Pessimistic Lock）

##### 补充锁的使用

```sql

# 开启s锁/读锁/共享锁
BEGIN;
SELECT * FROM book lock in share mode;
COMMIT;

# 开启x锁/写锁/排他锁
BEGIN;
SELECT * FROM book for update;
COMMIT;

# mysq8 nawait有锁不等待
BEGIN;
SELECT * FROM book for update nawait;

# mysq8 有锁返回没有锁的数据行
BEGIN;
SELECT * FROM book for update skip locked;

```





