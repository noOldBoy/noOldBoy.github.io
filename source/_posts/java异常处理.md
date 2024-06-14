---
title: java异常处理
date: 2022-08-10 10:29:39
tags:
- 异常
categories:
- 后端
cover: /images/background/16.jpeg
coverWidth: 1200
coverHeight: 320
---

java异常处理详解

<!-- more -->

#### 一、异常介绍

##### 什么是异常

异常是指程序在运行过程中发生的，由于外部问题导致的程序运行异常事件，异常的发生往往会中断程序的运行。在 Java 面向对象的编程语言中，万物都是对象，异常本身也是一个对象，程序发生异常就会产生一个异常对象。

##### 异常常见原因

1.java内部异常，也就是java虚拟机自身产生了异常

2.代码中抛出的异常，例如常见的<font color=red>空指针，数组越界</font>

3.throw我们捕获的异常，可以针对捕获的异常，做一些自定义的处理，比如封装一个有好的提示，或者例如捕获类似超时的异常以后去重新尝试调用

##### 异常分类

![image-20220810113511439](java异常处理/image-20220810113511439-0102516.png)

###### Throwable

**概念：**

1.Throwable是java中所有错误跟异常的顶层类，其他异常类也都是继承自该类。也就是只有当对象是此类或其子类的实例时，才能通过 Java 虚拟机或者 Java throw 语句抛出

2.Throwable 对象中包含了其线程创建时线程执行堆栈的快照，它还包含了给出有关错误更多信息的消息字符串

###### **Error**

**概念：**

Error 是 Throwable 的子类，Error 是程序运行时无法处理的严重错误。

按照规范来说，不应该去捕获该异常，你捕获了也什么都做不了。你当前的系统已经有了致命错误，一般指的是 JVM 错误，如堆栈溢出。

###### Exception

**非运行时异常：**

是在你项目启动或者编译时候，抛出。语法错误，或者是某些配置有问题，一般是比较明确的，你不处理，你项目也跑不起来

**运行时异常：**

最常见的异常，代码运行时异常，如 NullPointerException、IndexOutOfBoundsException 等，这些异常是不检查异常，程序中可以选择捕获处理，也可以不处理。这些异常一般由程序逻辑错误引起，程序应该从逻辑角度尽可能避免这类异常的发生。

我们一般说的异常处理、捕获，一般就是指就是处理这一块的异常

##### 一个简单的异常示例

###### 代码：

```java
public class Test {
    private int a = 1;
    private int b = 2;

    public static void main(String[] args) {
        Test t1 = new Test();
        Test t2 = null;
        System.out.println(t1.a);
        System.out.println(t2.a);
        System.out.println(t1.c());
    }

    public String c() {
        return "ccc";
    }
}
```

###### 运行结果：

输出t1.a以后t2.a因为t2是一个null实际，所以空指针报错，行数12行，程序也就终止了

![image-20220810140143928](java异常处理/image-20220810140143928.png)

#### 三、异常处理机制

##### 1.常用方式

- 使用**try…catch…finally…」** 语句块处理
- 在方法中使用 **「throws/throw」** 关键词将异常交给方法调用者去处理（尽量不要在最外层抛出）

##### 2.**try...catch...finally… 关键字**

###### 语法：

```java
try {
    ...
} catch (IOException ioException) {
    ...
} catch (Exception exception) {
    ...
} finally {
    ...
}
```

###### try

- 放你要执行的代码

- 如果try顺利执行完没有异常，他会执行你`try`后面`finally`中的and`finally`后面的代码。

- 如果执行抛出异常，他会去匹配`catch`，执行完`catch`程序执行`finally`块

###### catch

- 跟在`try`块的后面，可以有多个`catch`块且单个`catch`可以指定捕获多种类异常
- 你应该在这里截止程序，避免程序出现更多问题
- 如果`try`运行没有异常，所有的`catch`块都会被跳过
- 各个`catch`块是相互独立的，里面变量都是局部变量，不可共享
- 匹配方式是顺序的，自上而下
- 发生的异常`catch`匹配不到的话，则会直接执行`finally`,异常会抛给外层调用方
- 注意：一般外层例如Controller层，catch最后一层建议直接多捕获一层，直接捕获超类`Exception`或者`RuntimeException`(运行时异常)用来兜底。


###### **finally **

- finally块不是必须的，通常是可选的
- 无论异常是否发生，异常是否匹配被处理，finally中的代码都会执行。
- inally块不管异常是否发生，只要对应的try执行了，则它一定也执行。只有一种方法让finally块不执行：**「System.exit()」**

##### 3.try...catch示例

###### 示例1代码正常执行无异常

执行顺序：

try>finally>外层代码

**示例代码：**

```java
public static void main(String[] args) {
        try {
            System.out.println("try中代码");
            Test t1 = new Test();
            Test t2 = null;
            System.out.println(t1.a);
//            System.out.println(t2.a);
        } catch (NullPointerException e) {
            System.out.println("catch空指针异常捕获");
        } catch (Exception e) {
            System.out.println("捕获所有运行时Exception");
        } finally {
            System.out.println("finally执行");
        }
        System.out.println("成功执行");
    }
```

运行结果：

![image-20220810144809934](java异常处理/image-20220810144809934.png)

###### 示例2代码正常执行被捕获

执行顺序：

try>catch>finally

示例代码

```java
public static void main(String[] args) {
        try {
            System.out.println("try中代码");
            Test t2 = null;
            System.out.println(t2.a);
        } catch (NullPointerException e) {
            System.out.println("catch空指针异常捕获");
        } catch (Exception e) {
            System.out.println("捕获所有运行时Exception");
        } finally {
            System.out.println("finally执行");
        }
    }
```

运行结果：

![image-20220810145525658](java异常处理/image-20220810145525658.png)

###### 示例3**代码调用外层捕获**

代码：

```java
public static void main(String[] args) {
        try {
            c();
        } catch (NullPointerException e) {
            System.out.println("catch空指针异常捕获");
        } catch (IndexOutOfBoundsException e) {
            System.out.println("catch数组越界异常捕获");
        } catch (Exception e) {
            System.out.println("捕获所有运行时Exception");
        } finally {
            System.out.println("入口类finally执行");
        }
    }

    public static String c() {
        try {
            ArrayList<String> list = new ArrayList<>();
            list.add("一");
            System.out.println(list.get(1));
        } catch (NullPointerException e) {
            System.out.println("catch空指针异常捕获");
        } finally {
            System.out.println("方法c（）finally执行");
        }
        return "c";

    }
```

结果：

![image-20220810151043622](java异常处理/image-20220810151043622.png)

分析：

main入口调用的`c()`这个方法，很明显会抛出数据越界异常。但是方法`c（）`中的`catch`块匹配不到报错的异常，所以只执行了`finally`块，抛出的异常由调用入口匹配

##### 4.**throws/throw 关键字**

###### **throws**

- 向外抛出异常，抛向调用方
- 写在接口类参数的后面，后面需要指定抛出的异常可以是多个
- throws 也是一种处理异常的方式，它不同于try…catch…finally…，throws 关键字仅仅是将方法中可能出现的异常向调用者抛出，而自己则不具体处理。
- 你抛出的异常，你的调用方必须要处理你抛出的异常，当然他也可以抛出去，给他的调用方。你不处理编译是不通过的，直到最外层。没其他接口调用，前端调用的话，抛给前端，再到用户。

语法：

```java
public static String c() throws NullPointerException, IOException {}
```

###### **throw**

- 我们也可以通过 throw 语句手动显式的抛出一个异常，throw语句的后面必须是一个异常对象

语法：

```java
finally {
    throw new Exception("抛出异常");
}
```

#### 四、自定义异常

Java 的异常机制中所定义的所有异常不可能预见所有可能出现的错误，某些特定的情境下，则需要我们自定义异常类型来向上报告某些错误信息。

##### 继承方式

异常本身就是一个类，你可以选择继承 Throwable，Exception 或它们的子类。

**按照规范，自定义的异常应该总是包含如下的构造函数：**

- 一个无参构造函数
- 一个带有String参数的构造函数，并传递给父类的构造函数。
- 一个带有String参数和Throwable参数，并都传递给父类构造函数
- 一个带有Throwable 参数的构造函数，并传递给父类的构造函数。

例：

```java
public class MyError extends Exception {

    public MyError() {
        super();
    }

    public MyError(String message) {
        super(message);
    }

    public MyError(String message, Throwable cause) {
        super(message, cause);
    }

    public MyError(Throwable cause) {
        super(cause);
    }

}
```

使用：

```java
public static void main(String[] args) throws MyError {
        if (true) {
            throw new MyError("长得太丑了");
        }
    }
```

效果：

![image-20220810160136986](java异常处理/image-20220810160136986.png)

#### 五、**异常的注意事项**

1.当子类重写父类带有`throws`声明的函数的时候，不可大于父类可处理的异常

2.Java程序可以是多线程的。每一个线程都是一个独立的执行流，独立的函数调用栈。如果程序只有一个线程，那么没有被任何代码处理的异常 会导致程序终止。如果是多线程的，那么没有被任何代码处理的异常仅仅会导致异常所在的线程结束。

3.不应该把异常吐给用户，这是无意义的。兜底捕获异常返回一个友好提示才是最好的选择。
