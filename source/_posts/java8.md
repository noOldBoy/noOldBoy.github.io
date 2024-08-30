---
title: java8
date: 2023-04-17 15:14:48
tags:
- java8
categories:
- 后端
cover: /images/background/20.jpeg
coverWidth: 1200
coverHeight: 320
---

java8新加特性

<!-- more -->

##### 函数式接口

函数式接口在Java中是指：**有且仅有一个抽象方法的接口**

###### 常用 的一些函数式接口

```java
public static void main(String[] args) {
        // Consumer 消费型接口 接受一个参数 且不返回值
        Consumer<String> cs =  s -> System.out.println(s);
        cs.accept("我爱java");
        // predicate  接受一个参数返回一个布尔值  可以用于条件判断
        Predicate<String> pc = s -> s.length() > 4;
        System.out.println(pc.test("我爱java"));
        //Function 接受一个参数，有一个返回值
        Function<String, Integer> fc = s -> s.length();
        System.out.println(fc.apply("我爱java"));
        //Supplier  不接受参数，但是返回一个返回值
        Supplier<String> su = () -> "String str";
        System.out.println(su.get());
        //BinaryOperator 接受两个参数 但是只返回一个结果
        BinaryOperator<String> by = (a, b) -> a + b;
        System.out.println(by.apply("李白", "爱java"));
    }
```

###### 自定义的函数式接口

```java
/**
 * 自定义一个函数式接口
 */
public class FctDemo3 {
    public static void main(String[] args) {
        FctDemo3Fun fn3 = arr -> {
            int min = Integer.MIN_VALUE;
            for (int i : arr) {
                if (i > min) {
                    min = i;
                }
            }
            return min;
        };
        System.out.println(fn3.add(new int[]{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}));
    }
}

@FunctionalInterface
interface FctDemo3Fun {
    /**
     * 提供多个整数，返回和
     *
     * @param a int类型的一个数组
     * @return 数组最大值
     */
    Integer add(int[] a);
}
```



###### **@FunctionalInterface注解**

该注解用来检测该接口是否为函数式接口，若接口中没有抽象方法或抽象方法的个数大于1那么就会报错，反之通过

```java
@FunctionalInterface
public interface Demo1 {
    public abstract String a1 (String parm1);
}
```

##### 日期

java8使用了新的日期类来替换之前的date

###### java.util.Date的一些缺点

+ 非线程安全的类

+ 糟糕的设计，每次拿到一整个时间串，需要手动去处理格式化日期

+ 时区问题是date最大没办法规避的的缺点

###### LocalDate日期

```java
  //获取当前日期
        LocalDate today = LocalDate.now();
        System.out.println("当前日期：" + today);
        //获取指定日期
        LocalDate localDate = LocalDate.of(2024, 7, 2);
        System.out.println("一个指定的日期" + localDate);
        //把一个字符串解析为日期
        LocalDate parse = LocalDate.parse("2024-07-02");
        System.out.println("字符串转换的一个日期" + parse);

        LocalDate tomorrow = today.plusDays(1);
        LocalDate nextWeek = today.plusWeeks(1);
        LocalDate nextMonth = today.plusMonths(1);
        System.out.println("Tomorrow: " + tomorrow);
        System.out.println("Next Week: " + nextWeek);
        System.out.println("Next Month: " + nextMonth);

        //日期之间的差距
        long daysBetween = ChronoUnit.DAYS.between(localDate, today);
        System.out.println("Days between: " + daysBetween);
```

###### LocalTime时间

```java
 // 获取当前时间
        LocalTime now = LocalTime.now();
        System.out.println("Current Time: " + now);

        // 创建特定时间
        LocalTime specificTime = LocalTime.of(14, 30, 15);
        System.out.println("Specific Time: " + specificTime);

        // 时间运算
        LocalTime inTwoHours = now.plusHours(2);
        LocalTime minusMinutes = now.minusMinutes(15);
```

###### LocalDateTime

```java
// 获取当前日期和时间
        LocalDateTime now = LocalDateTime.now();
        System.out.println("Current DateTime: " + now);

        // 创建特定日期时间
        LocalDateTime specificDateTime = LocalDateTime.of(2024, 8, 15, 14, 30);
        System.out.println("Specific DateTime: " + specificDateTime);

        // 日期时间运算
        LocalDateTime tomorrowSameTime = now.plusDays(1);
        LocalDateTime nextMonthSameDay = now.plusMonths(1);
```

###### Instant时间戳

```java
  // 获取当前时间戳
        Instant now = Instant.now();
        System.out.println("Current Instant: " + now);

        // 创建特定时间戳
        Instant epochSecond = Instant.ofEpochSecond(0);
        System.out.println("Epoch Second: " + epochSecond);

        // 时间戳运算
        Instant later = now.plusSeconds(3600);
        Duration duration = Duration.between(now, later);
```

###### Duration&Period时间之差

```java
 // Duration: 时间点之间的差   分
        LocalTime start = LocalTime.of(14, 0, 0);
        LocalTime end = LocalTime.of(14, 1, 50);
        Duration duration = Duration.between(start, end);
        System.out.println("Duration: " + duration.toMinutes() + " minutes");

        // Period: 日期之间的差  小时
        LocalDate startDate = LocalDate.of(2024, 1, 1);
        LocalDate endDate = LocalDate.of(2025, 1, 1);
        Period period = Period.between(startDate, endDate);
        System.out.println("Period: " + period.getYears() + " years");
```

###### 日期之间的转换

```java
// 1.LocalDate 转 LocalDateTime
        LocalDate now = LocalDate.now();
        LocalDateTime dateTime = now.atTime(LocalTime.now());
        // 2.LocalDateTime 转 LocalDate LocalTime
        LocalDateTime now2 = LocalDateTime.now();
        LocalDate localDate = now2.toLocalDate();
        LocalTime localTime = now2.toLocalTime();
        //3.LocalDateTime转时间戳   需要时区作为参数
        LocalDateTime now3 = LocalDateTime.now();
        Instant instant = now3.atZone(ZoneId.systemDefault()).toInstant();
        //4.date跟新的日期api之间的转换
        Date date = new Date();
        Instant instant4 = date.toInstant();
```



##### Lambda表达式

被誉为Java8最大的特性。Lambda 表达式方便了函数式编程，大大简化了开发。Lambda表达式由逗号分隔的`参数列表`、`->符号`和`语句块`三部分组成 。当只有一个参数和只有一条语句的时候括号是可以省略的

Lambda表达式的主体，可以是一个单一表达式，也可以是一个代码块。如果是单一表达式，可以省略大括号和`return`关键字；如果是代码块，需要使用大括号，并显式地使用`return`语句（如果有返回值）。

###### 简单demo

```java
 public static void main(String[] args) {
        //无参 
        Runnable lm1 = () -> System.out.println("爱java");
        //有参数
        Consumer<String> lm2 = s -> System.out.println(s + "爱java");
        //有多个参数
        BinaryOperator<Integer> lm3 = (a, b) -> a + b;
    }
```

###### 方法&构造器的引用

通过方法的名字来指向一个方法，可以认为是Lambda表达式的一个语法糖。

```java
  public static void main(String[] args) {
        List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);
        //实例方法引用
        numbers.forEach(System.out::println);
    }
```

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

使用场景

```java
public class OptDateDemo {
    static Datar datar = new Datar(new User(21, "李白"));
    public static void main(String[] args) {

        // 不用流
        if (null == datar || null == datar.getUser() || null == datar.getUser().getName()) 				{
            throw new RuntimeException();
        }
        String name = datar.getUser().getName();
   
        // 优化后
        String s = Optional.ofNullable(datar)
                .map(Datar::getUser)
                .map(User::getName)
                .orElseThrow(RuntimeException::new);
    }
}

```



###### 创建方式

```java
//方式1 参数不能为null
Optional<String> 参数 = Optional.of("参数");

//方式2 参数可以为null
Optional<Object> o = Optional.ofNullable(null);

//方式三 创建一个参数为null的Optional对象
Optional<Object> empty = Optional.empty();
```

###### 判空

```
//1. isPresent 对象是否是null;
System.out.println(opt1.isPresent());
//2.ifPresent 支持在判断的时候接受一个函数 ｜｜ 如果不为空的话 名字改为***
opt1.ifPresent(u -> u.setName("***"));
```

###### 获取对象

```java
 User user = new User(27, "李白");
 Optional<User> opt1 = Optional.ofNullable(user);
 //1.get() 获取Optional中的元素 ！元素为空回报错
 System.out.println(opt1.get());
 //2.orElseGet() 如果获取的元素为空 返回指定的对象
 Optional<User> opt2 = Optional.ofNullable(null);
 opt2.orElseGet(() -> new User(52,"张三"));
 //3.orElse 类似于三目运算  如果对象为空的时候返回指定的对象
 Optional<User> opt3 = Optional.ofNullable(null);
 User user1 = opt3.orElse(new User(32, "花木兰"));
 System.out.println(user1);
 //4.orElseThrow  如果为空的话抛出指定的异常
 Optional<User> opt6 = Optional.ofNullable(null);
 opt6.orElseThrow(RuntimeException::new);
```

###### 过滤

```java
User user = new User(27, "李白");
Optional<User> opt1 = Optional.ofNullable(user);
//过滤名称等于李白的   不为空输出ok
opt1.filter(p -> p.getName().equals("李白")).ifPresent(x -> System.out.println("OK"));
```

###### 映射

```java
   public static void main(String[] args) {
        User user = new User(27, "李白");
        Optional<User> opt1 = Optional.ofNullable(user);
        //1. isPresent 对象是否是null;
        System.out.println(opt1.isPresent());
        //2.ifPresent 支持在判断的时候接受一个函数 ｜｜ 如果不为空的话 名字改为***
        opt1.ifPresent(u -> u.setName("***"));
    }
```

