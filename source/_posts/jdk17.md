---
title: jdk17
date: 2024-09-03 16:52:54
tags:
- jdk
categories:
- 后端
cover: /images/background/20.jpeg
coverWidth: 1200
coverHeight: 320
---

jdk8 - jdk17的一些新语法

<!-- more -->

##### switch表达式

主要变化

+ 可以接收返回值
+ 支持了lambda表达式
+ `yield`作为返回的关键字
+ 模式匹配即类型匹配推断
+ 便签组合

```java
 public static void main(String[] args) {
        int a = 1;
        // 之前的switch语法
        switch (a) {
            case 0:
                System.out.println("输入0");
                break;
            case 1:
                System.out.println("输入1");
                break;
            case 2:
                break;
            default:
                System.out.println("不合法的输入");
        }

        // jdk17 switch
        String str = switch (a) {
            case 0, 1, 2 -> {
                yield "输入" + a;
            }
            default -> {
                yield "不合法输入";
            }
        };

    }
```

##### 文本块

三个双引号可以定义一个文本块，结束的三个双引号不能和开始的在同一行。

```java
   // 旧版本json字符串
        String text = "{\n" +
                "  \"name\": \"李白\",\n" +
                "  \"age\": 18,\n" +
                "}";


        // 文本块
        String text2 = """
                {
                    "name": "李白",
                    "age" : 32
                }
                """;
        System.out.println(text2);
```

##### instanceof模式匹配

```java
 public static void main(String[] args) {
        //老版本
        if (obj instanceof String) {
            String str = (String) obj;
            System.out.println(str);
        }

        //jdk17
        if (obj instanceof String str) {
            System.out.println(str);
        }

    }
```

#####  新的垃圾收集器

ZGC垃圾收集器 & Shenandoah

##### 类型推断

```java
var date = new Date();
```
