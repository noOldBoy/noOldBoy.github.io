---
title: volatile伪共享问题
date: 2024-09-19 15:39:30
tags:
- java
- volatile
categories:
- 后端
cover: /images/headimg/001.jpeg
coverWidth: 1200
coverHeight: 320
---

volatile详解跟伪共享问题

<!-- more -->

##### 并发编程的三个核心特性

原子性：一个或多个操作在CPU中执行时，要么全部执行且在执行过程中不被任何因素打断，要么全部不执行

可见性：当多个线程访问同一个变量时，一个线程改变了这个变量的值，其他线程能够立即看到修改的值

有序性：程序执行的顺序按照代码的先后顺序执行。JVM存在指令重排，所以存在有序性问题

##### volatile详解

保障可见性跟有序性，不保障原子性。使用`volatile`修饰的字段

##### demo

线程B休眠1秒，用于保障线程A先执行。线程A读到flg的变化后退出循环

```java
public class volatileDemo {

    private static boolean flg = false;

    public static void main(String[] args) {

        //线程A
        new Thread(() -> {
            while (true) {
                if (flg) {
                    System.out.println("线程A读到了修改  结束");
                    break;
                }
            }
        }).start();
        
        //线程B
        new Thread(() -> {
            try {
                Thread.sleep(1000); // 等待 1 秒钟，确保线程A先运行
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
            flg = true;
        }).start();
    }

}

```

![image-20240919162057110](./volatile%E4%BC%AA%E5%85%B1%E4%BA%AB%E9%97%AE%E9%A2%98/image-20240919162057110-6734059.png)

运行后可以发现，项目不会结束 线程A陷入死循环，读不到线程B的修改。这个时候需要使用`volatile`保障线程之前的可见性

##### 伪共享

###### 一致性协议

人们设计了各种模型和协议，如MSI、MESI、write-once等等协议，我们现在用的比较多的是MESI协议。简单理解就是内存中有一块共享的主存，修改后主存把修改广播到各个线程缓存块之间

##### demo

尝试多次运行 volatile跟不加的运行结果  比较后 加上关键字跟不加速度相差50倍

```java
class Pointer {
    volatile long x;
    volatile long y;
}
```

```java
public class CacheSharedTest {

    public static void main(String[] args) throws InterruptedException {
        testPointer(new Pointer());
    }

    private static void testPointer(Pointer pointer) throws InterruptedException {
        long start = System.currentTimeMillis();
        Thread t1 = new Thread(() -> {
            for (int i = 0; i < 100000000; i++) {
                pointer.x++;
            }
        });

        Thread t2 = new Thread(() -> {
            for (int i = 0; i < 100000000; i++) {
                pointer.y++;
            }
        });
        t1.start();
        t2.start();
        t1.join();
        t2.join();

        System.out.println(pointer.x+","+pointer.y);

        System.out.println(System.currentTimeMillis() - start);
    }
}

class Pointer {
     long x;
     long y;
}
```

造成这个现象的原因是：以`MESI`内存一致性协议为例，行是内存的基本单位，一个内存行被分为了64个字节，我们知道一个long类型占用8个字节。所以一个long类型x不能占满一行，他会跟y共用一个内存行。线程1中更改了x的变量后，变量x对应的缓存行就会失效，线程2就不能直接从缓存行中 来直接读取y，需要再次从主存加载进缓存，y的更改也会影响x的使用，就造成了变量x和y相互影响的情况，就导致了异常耗时。

###### 解决方式

@Contended可以作用于类上，也可以作用于变量上。它也是通过填充缓存行来避免伪共享

占满一个内存行
