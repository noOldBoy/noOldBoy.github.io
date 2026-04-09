---
title: sqLite本地化数据库
date: 2022-05-30 16:40:16
tags:
- sqlite
- springBoot
categories:
- 数据库
cover: /images/background/xiaomai2.jpeg
coverWidth: 1200
coverHeight: 320
author: 不二
---

sqLite数据库SpringBoot整合&二进制文件存储读取
<!-- more -->

## 一.什么是sqLite？

1.SQLite是一个进展中的库，它实现了一个自给自足，无服务器，零配置，事务SQL数据库引擎。

2.占用空间少，可直接嵌入到应用中,大致13万行C代码, 4.43M

3.支持多个系统，多种常用计算机语言交互

4.支持数据库大小至2TB

5.比一些流行的数据库在大部分普通数据库操作要快

<u>6.！写入修改时候会锁定整个数据库！！！</u>

### 二.sqLite适用场景

1.嵌入式设备和物联网

2.申请文件格式

3.小型网站

4.资料传输格式

5.文件档案和/或数据容器

### 三.sqLite下载

官网：https://www.sqlite.org/index.html

![image-20220531101801314](./sqLite%E6%9C%AC%E5%9C%B0%E5%8C%96%E6%95%B0%E6%8D%AE%E5%BA%93/image-20220531101801314.png)

解压即可使用，打开当前位置的控制台，嫌麻烦可以配一个环境变量

![](./sqLite%E6%9C%AC%E5%9C%B0%E5%8C%96%E6%95%B0%E6%8D%AE%E5%BA%93/image-20220531102657917.png)

### 四.sqLite的使用

打开安装sqlite的文件夹，新建一个此位置的控制台窗口

##### 1.sqlite提示符

```
输入sqlite3 进入sqlite提示符模式，在 SQLite 命令提示符下，可以使用各种 SQLite 命令。
```

可以使用 SQLite **.quit** 命令退出 sqlite 提示符

![image-20220531112538357](./sqLite%E6%9C%AC%E5%9C%B0%E5%8C%96%E6%95%B0%E6%8D%AE%E5%BA%93/image-20220531112538357.png)

##### 2.数据库创建

```
sqlite3 "数据库名字"
```

![image-20220531113042477](./sqLite%E6%9C%AC%E5%9C%B0%E5%8C%96%E6%95%B0%E6%8D%AE%E5%BA%93/image-20220531113042477.png)

另外我们也可以使用 **.open** 来建立新的数据库文件：打开已存在数据库也是用 **.open** 命令，以上命令如果 **test.db** 存在则直接会打开，不存在就创建它

```
sqlite>.open test.db
```

###### 查看创建的数据库 **.databases**

在**sqlite>** 提示符下使用 .databases

![image-20220531113607077](./sqLite%E6%9C%AC%E5%9C%B0%E5%8C%96%E6%95%B0%E6%8D%AE%E5%BA%93/image-20220531113607077.png)

###### .dump 命令 数据库导出

你可以在命令提示符中使用 SQLite **.dump** 点命令来导出完整的数据库在一个文本文件中

```
$sqlite3 testDB.db .dump > testDB.sql
```

上面的命令将转换整个 **testDB.db** 数据库的内容到 SQLite 的语句中，并将其转储到 ASCII 文本文件 **testDB.sql** 中。可以通过简单的方式从生成的 testDB.sql 恢复

```
$sqlite3 testDB.db < testDB.sql
```

##### 3.sqlite的数据类型

| NULL    | 值是一个 NULL 值。                                           |
| ------- | ------------------------------------------------------------ |
| INTEGER | 值是一个带符号的整数，根据值的大小存储在 1、2、3、4、6 或 8 字节中。 |
| REAL    | 值是一个浮点值，存储为 8 字节的 IEEE 浮点数字。              |
| TEXT    | 值是一个文本字符串，使用数据库编码（UTF-8、UTF-16BE 或 UTF-16LE）存储。 |
| BLOB    | 值是一个 blob 数据，完全根据它的输入存储。                   |

###### SQLite 亲和(Affinity)类型

SQLite支持列的亲和类型概念。任何列仍然可以存储任何类型的数据，当数据插入时，该字段的数据将会优先采用亲缘类型作为该值的存储方式。SQLite目前的版本支持以下五种亲缘类型：

###### SQLite 亲和类型(Affinity)及类型名称

下表列出了当创建 SQLite3 表时可使用的各种数据类型名称，同时也显示了相应的亲和类型：

| 数据类型                                                     | 亲和类型 |
| :----------------------------------------------------------- | :------- |
| INTINTEGERTINYINTSMALLINTMEDIUMINTBIGINTUNSIGNED BIG INTINT2INT8 | INTEGER  |
| CHARACTER(20)VARCHAR(255)VARYING CHARACTER(255)NCHAR(55)NATIVE CHARACTER(70)NVARCHAR(100)TEXTCLOB | TEXT     |
| BLOBno datatype specified                                    | NONE     |
| REALDOUBLEDOUBLE PRECISIONFLOAT                              | REAL     |
| NUMERICDECIMAL(10,5)BOOLEANDATEDATETIME                      | NUMERIC  |

###### Boolean 数据类型

SQLite 没有单独的 Boolean 存储类。相反，布尔值被存储为整数 0（false）和 1（true）。

###### Date 与 Time 数据类型

SQLite 没有一个单独的用于存储日期和/或时间的存储类，但 SQLite 能够把日期和时间存储为 TEXT、REAL 或 INTEGER 值。

| 存储类  | 日期格式                                                     |
| :------ | :----------------------------------------------------------- |
| TEXT    | 格式为 "YYYY-MM-DD HH:MM:SS.SSS" 的日期。                    |
| REAL    | 从公元前 4714 年 11 月 24 日格林尼治时间的正午开始算起的天数。 |
| INTEGER | 从 1970-01-01 00:00:00 UTC 算起的秒数。                      |

可以以任何上述格式来存储日期和时间，并且可以使用内置的日期和时间函数来自由转换不同格式。

### 五.数据库创建连接

建表使用Navicat客户端工具了，更直观点，选择sqlite方式，然后选择安装目录下的db文件即可

![image-20220613175536741](/博客搭建.png)

##### 5.1数据库创建

CREATE TABLE "user" (
  "user_id" INTEGER NOT NULL,
  "user_name" text,
  "usre_image" text,
  "create_time" DATE,
  "balance" real,
  PRIMARY KEY ("user_id")
);

![image-20220613181253881](./sqLite%E6%9C%AC%E5%9C%B0%E5%8C%96%E6%95%B0%E6%8D%AE%E5%BA%93/image-20220613181253881.png)

##### 5.2增删改查

###### 5.2.1add

INSERT INTO user (user_id, user_name,user_image,create_time_,balance)
VALUES (2,'张三','假装图片1','2022-03-02 12:13:43',3232.34);

###### 5.2.12select

select * FROM user where user_id != 3 GROUP BY user_name ORDER BY user_id 

###### 5.2.3update

UPDATE user SET user_name = '李四' where user_id =1

###### 5.2.4del

DELETE from user where user_id = 1

### 6.springBoot整合

yml

```
spring:
  datasource:
    driver-class-name: org.sqlite.JDBC
    url: jdbc:sqlite:/你的数据库地址
    #    url: jdbc:sqlite:/home/frfile/db/aaa.db
    username:
    password:

mybatis:
  mapper-locations: classpath:mapper/*Mapper.xml
  type-aliases-package: com.guo.sqlite_demo.entity
```

xml

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="com.guo.sqlite_demo.mapper.UserMapper">

    <resultMap id="BaseResultMap" type="com.guo.sqlite_demo.entity.User">
        <result column="user_id"  property="userId"/>
        <result column="user_name"  property="userName"/>
        <result column="user_image"  property="userImage"/>
        <result column="create_time"  property="createTime"/>
        <result column="balance"  property="balance"/>
    </resultMap>


    <select id="findList" resultMap="BaseResultMap">
        select * from user
    </select>

    <insert id="insert" parameterType="com.guo.sqlite_demo.entity.User">
        insert into user(user_name,user_image,create_time,balance)
        values (#{userName},#{userImage},#{createTime},#{balance})
    </insert>
    <update id="update" parameterType="com.guo.sqlite_demo.entity.User">
        update user
        <set>
            <if test="userName != null">
                user_name = #{userName},
            </if>
            <if test="userImage != null">
                user_image = #{userImage},
            </if>
            <if test="createTime != null">
                create_time = #{createTime},
            </if>
            <if test="balance != null">
                balance = #{balance}
            </if>
        </set>
        where user_id = #{userId}
    </update>
    <delete id="delete">
        delete from user where user_id = #{id}
    </delete>
</mapper>
```



Controller

```
@RestController
public class UserController {

    @Resource
    private UserService userService;

    @RequestMapping("/list")
    public List<User> listBy(){
        return userService.findList();
    }

    @PostMapping("/add")
    public Integer add(@RequestBody User user){
        System.out.println(user);
        return userService.insert(user);
    }

    @RequestMapping("/modify")
    public Integer modify(@RequestBody  User user){
        return userService.update(user);
    }

    @GetMapping("/delete/{id}")
    public Integer delete(@PathVariable("id") Integer id){
        return userService.delete(id);
    }

}
```

entity

```
@Data
public class User {

    private int userId;

    private String userName;

    private String userImage;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    private Double balance;

}
```

mapper

```
public interface UserMapper {

    List<User> findList();

    Integer insert(User user);

    Integer update(User user);

    Integer delete(Integer id);
}
```

### 7.项目地址

https://gitee.com/guo0817/sqllte_demo.git
