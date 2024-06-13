---
title: mysql函数function
date: 2023-01-17 17:20:03
tags:
- mysql
categories:
- 数据库
cover: /images/cha/g2.jpeg
coverWidth: 1200
coverHeight: 320
---

MySQL全函数函数amd自定义函数function使用详解使用详解

<!-- more -->

#### MySQL字符串函数

##### ASCII(s)

返回字符串的第一个字符的ASCLL码

```sql
SELECT ASCII("a") 
```

97

##### CHAR_LENGTH(s)

返回字符串的字符数

```sql
SELECT CHAR_LENGTH("花木兰") 
```

3

##### CHARACTER_LENGTH(s)

返回字符串的字符数等同于CHAR_LENGTH

```sql
SELECT CHARACTER_LENGTH("花木兰") 
```

3

##### CONCAT(s1,s2...sn)

拼接字符串多个字符串如果有任何一个参数为null，则返回值为null。

```sql
SELECT CONCAT("花","木兰","是女孩") 
```

花木兰是女孩

##### CONCAT_WS(x, s1,s2...sn)

拼接多个字符串，需要指定分隔符，第一个字符为分隔符，会拼接到每一个字符串的后面

```sql
SELECT CONCAT_WS("-我是分隔符-","木兰","是女孩","花") 
```

木兰-我是分隔符-是女孩-我是分隔符-花

##### FIELD(s,s1,s2...)

返回第一个字符，在后面字符串中出现的位置，注意只能精确匹配第一个字符为要匹配的字符，没有与之匹配的字符串返回为0

```
SELECT FIELD("木兰","花木兰","李白","杜甫","木兰")
```

4

##### FIND_IN_SET(s1,s2)

返回字符串在后续字符串中出现的位置,注意只可以有一个匹配字符串,要匹配的字符串中使用，分割

```sql
SELECT FIND_IN_SET("木兰2","花木兰李白杜甫木兰,jdai,木兰2")
```

3

##### FORMAT(x,n)

将数字x进行格式化，n为格式化后保留的小数点个数，最后一位进行四舍五入,注意两个参数都只能是数字

```
SELECT FORMAT(0.005,2)
```

0.01

##### INSERT(s1,x,len,s2)







