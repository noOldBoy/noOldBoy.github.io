---
title: java8
date: 2023-04-17 15:14:48
tags:
- java8
categories:
- 后端
cover: /images/cha/20.jpeg
coverWidth: 1200
coverHeight: 320
---

java8学习

<!-- more -->

#### 函数式接口

函数式接口在Java中是指：**有且仅有一个抽象方法的接口**



##### **@FunctionalInterface注解**

该注解用来检测该接口是否为函数式接口，若接口中没有抽象方法或抽象方法的个数大于1那么就会报错，反之通过

```java
@FunctionalInterface
public interface Demo1 {
    public abstract String a1 (String parm1);
}
```



##### 日期



##### Lambda表达式

被誉为Java8最大的特性。Lambda 表达式方便了函数式编程，大大简化了开发。Lambda表达式由逗号分隔的`参数列表`、`->符号`和`语句块`三部分组成 。







##### Stream流

###### 创建流的三种方式

```java
public static void main(String[] args) {
    //通过集合
    ArrayList<Object> list = new ArrayList<>();
    Stream<Object> stream = list.stream();
    //通过数组
    Integer[] integers = new Integer[]{};
    Stream<Integer> stream1 = Arrays.stream(integers);
    //静态方法Stream.of
    Stream<String> eqwewq = Stream.of("eqwewq", "qwe");
}
```

###### 示例结构

```java
public class Demo1 {
  
    static List<User> list = new ArrayList<>();
  
    static {
        list.add(new User(3, "李白"));
        list.add(new User(1, "花木兰"));
        list.add(new User(2, "千年之狐"));
        list.add(new User(2, "剑舞者"));
        list.add(new User(2, "青春决赛季"));
        list.add(new User(2, "青春决赛季"));
    }
}
```

###### 过滤filter

```java
System.out.println("过滤");
list.stream().filter(u -> u.id == 1).forEach(System.out::println);
```

###### 分页limit

```java
System.out.println("分页");
list.stream().limit(2).forEach(System.out::println);
```

###### 跳过skip

```java
System.out.println("跳过");
list.stream().skip(3).forEach(System.out::println);
```

###### 去重distinct

是通过equals和hashCode，所以要重写这两个方法

```java
 list.stream().distinct().forEach(System.out::println);
```

###### 中间操作map

```java
List<String> nameList = list.stream().map(u -> u.name).collect(Collectors.toList());
```

###### 排序sorted

```
//数组排序
        int[] ints = new int[]{4, 453, 35, 6564, 75634, 3};
        Arrays.stream(ints).sorted().forEach(System.out::println);
        //集合中的对象排序
        list.stream().map(u -> u.id).sorted(Integer :: compareTo).forEach(System.out::println);
```

###### 判断Match

```java
//是否都满足条件
boolean b = list.stream().allMatch(user -> user.id == 3);
System.out.println(b);
//是否有一个满足条件
boolean b2 = list.stream().anyMatch(user -> user.id == 3);
System.out.println(b2);
//是否都不满足
boolean b3 = list.stream().noneMatch(user -> user.id == 4);
System.out.println(b3);
```

###### 返回元素

```java
//返回第一个
System.out.println(list.stream().findFirst().get());
//返回数据个数
System.out.println(list.stream().count());
//返回最大值
System.out.println(list.stream().map(user -> user.id).max(Integer::compareTo).get());
//返回最小值
System.out.println(list.stream().map(user -> user.id).min(Integer::compareTo).get());
```
###### 规约

```java
System.out.println(list.stream().map(e -> e.name).reduce((e1,e2) -> e1 + e2));
System.out.println(list.stream().map(e -> e.name).reduce("a:", (e1,e2) -> e1 + e2));
```

###### 收集

```java
Map<String, List<User>> collect = list.stream().collect(Collectors.groupingBy(e -> e.name));
collect.keySet().forEach(System.out::println);
```

##### Optional

###### 创建方式

```java
//方式1 参数不能为null
Optional<String> 参数 = Optional.of("参数");

//方式2 参数可以为null
Optional<Object> o = Optional.ofNullable(null);

//方式三 创建一个参数为null的Optional对象
Optional<Object> empty = Optional.empty();
```
