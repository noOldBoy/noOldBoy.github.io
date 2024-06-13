---
title: java23种设计模式详解
date: 2023-03-22 16:33:51
tags:
- java
categories:
- 后端
cover: /images/cha/g3.jpeg
coverWidth: 1200
coverHeight: 320
---

设计模式详解

<!-- more -->

### 创建型模式

#### 1. 简单工厂模式（Simple Factory Pattern）

简单工厂模式的核心是定义一个创建对象的接口，将对象的创建和本身的业务逻辑分离，降低系统的耦合度，使得两个修改起来相对容易些，当以后实现改变时，只需要修改工厂类即可。在简单工厂模式中，我们在创建对象时不会向客户端暴露创建逻辑，而是使用一个共同的接口来创建对象。

##### 不使用工厂写法写法

```java
public class demo1 {

    public  class User {
        public void getGoods() {
            Mose mose = new Mose();
            KeyBoard keyBoard = new KeyBoard();
        }
    }

    public class Mose {
        public Mose() {
            System.out.println("生产出一个鼠标");
        }
    }

    public class KeyBoard {
        public KeyBoard() {
            System.out.println("生产出一个键盘");
        }
    }
}
```

##### 简单工厂方式

```java
public class demo2 {
    
    public class User {
        public void getGoods() {
            Factory factory = new Factory();
            Mose mose = (Mose) factory.createEntity(EntityEnum.MOSE);
            KeyBoard keyboard = (KeyBoard) factory.createEntity(EntityEnum.KEYBOARD);
        }
    }

    public enum EntityEnum {
        MOSE,KEYBOARD
    }

    public class Factory {
        public Object createEntity (EntityEnum entityEnum) {
            if (EntityEnum.MOSE == entityEnum) {
                return new Mose();
            } else if (EntityEnum.KEYBOARD == entityEnum) {
                return new KeyBoard();
            }
            return null;
        }
    }

    public class Mose {
        public Mose() {
            System.out.println("生产出一个鼠标");
        }
    }

    public class KeyBoard {
        public KeyBoard() {
            System.out.println("生产出一个键盘");
        }
    }
    
}
```

###### **优点**

简单工厂模式使用工厂类来统一创建对象，实现了使用和创建的分离。只需知道具体产品类所对应的参数即可，通过引入配置文件，可以在不修改任何客户端代码的情况下更换和增加新的具体产品类，在一定程度上提高了系统的灵活性。

###### **缺点**

 但缺点在于不符合“开闭原则”，每次添加新产品就需要修改工厂类。在产品类型较多时，有可能造成工厂逻辑过于复杂，不利于系统的扩展维护，并且工厂类集中了所有产品创建逻辑，一旦不能正常工作，整个系统都要受到影响。

#### 2. 工厂方法模式（Factory Method Pattern）

工厂方法模式是将工厂类的创建过程抽象出来，每个具体的产品类都有一个对应的工厂类来创建对象。客户端代码只需要调用相应的工厂类来创建对象即可。

```java
public class demo3 {

    abstract class Product {
    }

    public class Mose extends Product {
        public Mose() {
            System.out.println("生产出一个鼠标");
        }
    }

    public class KeyBoard extends Product {
        public KeyBoard() {
            System.out.println("生产出一个键盘");
        }
    }

    interface FactoryProduct {
        Product creatProduct();
    }

    public class MoseFactory implements FactoryProduct {

        @Override
        public Mose creatProduct() {
            return new Mose();
        }
    }

    public class KeyBoardFactory implements FactoryProduct {

        @Override
        public KeyBoard creatProduct() {
            return new KeyBoard();
        }
    }

    void mian () {
        MoseFactory moseFactory = new MoseFactory();
        Mose mose = moseFactory.creatProduct();
        KeyBoardFactory keyBoardFactory = new KeyBoardFactory();
        KeyBoard keyBoard = keyBoardFactory.creatProduct();
    }

    public static void main(String[] args) {
        demo3 demo3 = new demo3();
        demo3.mian();
    }
}
```

###### **优点：**

工厂方法模式将工厂抽象化，并定义了一个创建对象的接口。每次增加新的产品只需要增加该产品跟该产品的工厂类由具体工厂类决定要实例化的产品是哪个，将对象的创建与实例化延迟到子类，这样工厂的设计就符合“开闭原则”了，扩展时不必去修改原来的代码。

###### **缺点：**

但缺点在于，每增加一个产品都需要增加一个具体产品类和实现工厂类，使得系统中类的个数成倍增加，在一定程度上增加了系统的复杂度，同时也增加了系统具体类的依赖。

缺点：

#### 3. 抽象工厂模式（Abstract Factory Pattern）

抽象工厂模式是在工厂方法模式的基础上，将工厂类的抽象化程度再提高一层。抽象工厂模式用于创建一组相关的对象，它提供了一个接口，用于创建一系列的产品。客户端代码不需要关心具体的产品类，只需要知道抽象工厂和抽象产品类即可。

```java
public class demo4 {

    /**
     * 产品抽象类
     */
    abstract class Product {
    }

    /**
     * 鼠标抽象实现类
     */
    public class Mose extends Product {
        public Mose() {
            System.out.println("生产出一个鼠标");
        }
    }

    /**
     * 键盘抽象实现类
     */
    public class KeyBoard extends Product {
        public KeyBoard() {
            System.out.println("生产出一个键盘");
        }
    }

    /**
     * 维修抽象类
     */
    abstract class Maintain {
    }

    public class MaintainMose extends Maintain {
        public MaintainMose() {
            System.out.println("维修一个鼠标");
        }
    }

    public class MaintainKeyBoard extends Maintain {
        public MaintainKeyBoard() {
            System.out.println("维修一个键盘");
        }
    }

    /**
     * 抽象工厂类
     */
    abstract class AbstractFactory {
        public abstract Product createProduct();

        public abstract Maintain createMaintain();
    }


    public class MoseFactory extends AbstractFactory {
        @Override
        public Mose createProduct() {
            return new Mose();
        }

        @Override
        public MaintainMose createMaintain() {
            return new MaintainMose();
        }
    }

    public class KeyBoardFactory extends AbstractFactory {
        @Override
        public KeyBoard createProduct() {
            return new KeyBoard();
        }

        @Override
        public MaintainKeyBoard createMaintain() {
            return new MaintainKeyBoard();
        }
    }

    void mian() {
        MoseFactory moseFactory = new MoseFactory();
        moseFactory.createProduct();
        moseFactory.createMaintain();
        KeyBoardFactory keyBoardFactory = new KeyBoardFactory();
        keyBoardFactory.createProduct();
        keyBoardFactory.createMaintain();
    }

    public static void main(String[] args) {
        demo4 demo3 = new demo4();
        demo3.mian();
    }
}
```

###### **缺点：**

 但该模式的缺点在于添加新的行为时比较麻烦，如果需要添加一个新产品族对象时，需要更改接口及其下所有子类，这必然会带来很大的麻烦。

#### 4. 单例模式（Singleton Pattern）

单例模式是最简单的设计模式之一。在单例模式中，一个类只能创建一个实例，以确保它所有的实例都访问相同的状态。

##### 简单懒汉模式

在第一次创建对象的时候去创建对象，使用static保证只会实例化一次

```java
public class Demo5 {

    private static Demo5 demo5 = null;

    public Demo5() {
    }

    private static Demo5 getDemo() {
        if (null == demo5) {
            demo5 = new Demo5();
        }
        return demo5;
    }

    public static void main(String[] args) {
        Demo5 demo = Demo5.getDemo();
    }
}
```

###### **缺点：**

懒汉式单例的实现是线程不安全的，在并发环境下可能出现多个 Singleton 实例的问题。要实现线程安全，有以下三种方式

###### 方式一

在方法调用上加了同步，虽然线程安全了，但是每次都要同步，会影响性能，毕竟99%的情况下是不需要同步的。

```java
private synchronized static Demo5 getDemo() {
    if (null == demo5) {
        demo5 = new Demo5();
    }
    return demo5;
}
```

###### 方式二

双重检查锁定

```java
public class Demo6 {

    private volatile static Demo6 demo5 = null;

    public Demo6() {
    }

    private  static Demo6 getDemo() {
        if (null == demo5) {
            synchronized (Demo6.class){
                //判断两次空是避免两个线程都通过了第一个"null == demo5"校验，从而创建多次对象
                if (null == demo5) {
                    demo5 = new Demo6();
                }
            }
        }
        return demo5;
    }
}
```

###### 方式三：静态内部类

```
public class Demo7 {

    //静态内部类只会加载一次
    public static class Demo7a {
        private static final Demo7 dmo = null;
    }

    private static Demo7 getDemo() {
        return Demo7a.dmo;
    }
}
```

##### 简单饿汉模式 

饿汉式在类创建的同时就已经创建好一个静态的对象供系统使用，以后不再改变，所以天生是线程安全的。

```java
public class Demo8 {

    private  static Demo8 demo5 = new Demo8();

    private Demo8() {
    }

    private  static Demo8 getDemo() {
        return demo5;
    }
}
```

###### 缺点

因为声明的对象是提前创建好，且申明是静态的，会在类初始化时候创建，在类卸载时候才释放，生命周期过长

#### 5. 原型模式（Prototype Pattern）

原型模式是指创建重复的对象，同时又能保证性能。它通常需要先创建一个原型对象，然后通过复制该对象来创建新的对象。

###### 原型模式的优点与适用场景：

（1）原型模式比 new 方式创建对象的性能要好的多，因为 Object 类的 clone() 方法是一个本地方法，直接操作内存中的二进制流，特别是复制大对象时，性能的差别非常明显；

（2）简化对象的创建

```java
public class Demo9 {

    public static void main(String[] args) throws CloneNotSupportedException {
        Demo9a demo9a = new Demo9a("李白");
        Demo9a clone1 = demo9a.clone();
        System.out.println(demo9a);
        System.out.println(clone1);
        System.out.println(demo9a.equals(clone1)+ "\n" + "=====================================");
        clone1.setName("花木兰");
        System.out.println(demo9a);
        System.out.println(clone1);
        System.out.println(demo9a.equals(clone1)+ "\n" + "=====================================");

    }

}

class Demo9a implements Cloneable {

    private String name;

    @Override
    protected Demo9a clone() throws CloneNotSupportedException {
        return (Demo9a) super.clone();

    }

    public Demo9a() {
    }

    public Demo9a(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    //重新equals跟hashcode方法用来比较对象的值是否相等
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Demo9a demo9a = (Demo9a) o;
        return name.equals(demo9a.name);
    }

    @Override
    public String toString() {
        return "Demo9a{" +
                "name='" + name + '\'' +
                '}';
    }

    @Override
    public int hashCode() {
        return name.hashCode();
    }

}
```

### 结构型模式

#### 6. 适配器模式（Adapter Pattern）

适配器模式是一种结构型模式，它允许一个已经存在的类的接口与另一个接口不兼容的类进行合作。适配器模式主要分成三类：类的适配器模式、对象的适配器模式、接口的适配器模式。

##### 类的适配器模式

```java
public class Demo0 {
    public static void main(String[] args) {
        //加强版
        insa demo0Plas = new Demo0Plas();
        demo0Plas.a();
        //普通版
        insa demo0a = new Demo0a();
        demo0a.a();
    }
}

/**
 * 接口
 */
interface insa{
    public void a();
}

/**
 * 实现类
 */
class Demo0a implements insa{
    public void a(){
        System.out.println("普通方法");
    }
}

/**
 * 加强版pals类方法a
 */
class Demo0s{
    public void a(){
        System.out.println("加强版方法");
    }
}

/**
 * 适配器，同时实现两个类
 */
class  Demo0Plas extends Demo0s implements insa{
    @Override
    public void a() {
        super.a();
    }
}
```

##### 接口的适配器模式

有时我们写的一个接口中有多个抽象方法，当我们写该接口的实现类时，必须实现该接口的所有方法，这明显有时比较浪费，因为并不是所有的方法都是我们需要的，有时只需要某一些，此处为了解决这个问题，我们引入了接口的适配器模式，借助于一个抽象类，该抽象类实现了该接口，实现了所有的方法，而我们不和原始的接口打交道，只和该抽象类取得联系，所以我们写一个类，继承该抽象类，重写我们需要的方法就行。

```java
public class Demo1 {
    public static void main(String[] args) {
        sub1 sub1 = new sub1();
        sub2 sub2 = new sub2();
        sub2.method2();
        sub1.method1();
    }
}

interface a {
    public void method1();
    public void method2();
}

abstract class As implements a{
    @Override
    public void method1() {}

    @Override
    public void method2() {}
}

class sub1 extends As {
    @Override
    public void method1() {
        System.out.println("方法1");
    }
}

class sub2 extends As {
    @Override
    public void method2() {
        System.out.println("方法2");
    }
}
```

#### 7. 桥接模式（Bridge Pattern）

桥接模式是一种结构型模式，它将抽象部分与它的实现部分分离，使它们都可以独立地变化。

##### 场景

咖啡店，有两种咖啡加糖或者加奶

```java
interface CoffeeService{
   void buyCoffee();
}

//加糖咖啡
class CoffeeSugaring implements CoffeeService{
    @Override
    public void buyCoffee() {
        System.out.println("加糖");
    }
}

//加奶咖啡
class MilkSugaring implements CoffeeService{
    @Override
    public void buyCoffee() {
        System.out.println("加奶");
    }
}
```

现在准备加两个容量规格的咖啡，大杯和小杯，当然你可以对应加几个实现类不就得了？

```java
interface CoffeeService{
   void buyCoffee();
}

//加糖咖啡
class MaxCoffeeSugaring implements CoffeeService{
    @Override
    public void buyCoffee() {
        System.out.println("大杯加糖");
    }
}

//加糖咖啡
class MinCoffeeSugaring implements CoffeeService{
    @Override
    public void buyCoffee() {
        System.out.println("小杯加糖");
    }
}

//加奶咖啡
class MaxMilkSugaring implements CoffeeService{
    @Override
    public void buyCoffee() {
        System.out.println("大杯加奶");
    }
}

//加奶咖啡
class MinMilkSugaring implements CoffeeService{
    @Override
    public void buyCoffee() {
        System.out.println("小杯加奶");
    }
}
```

再过几天，你们要上架超大杯很中杯子。。。。。。这时候你的实现类将是M*N所有维度的乘集，这个你需要使用设计模式，让你代码降低耦合

##### 重新设计后代码

M*N 优化后为 M+N

```java
public class Demo4 {

    public static void main(String[] args) {
        CoffeeAbstract coffeeAbstract = new Max();
        //加奶
        coffeeAbstract.setCoffeeService(new MilkSugaring());
        coffeeAbstract.draw();
    }
}

//购买咖啡接口
interface CoffeeService {
    void buyCoffee();
}

class CoffeeSugaring implements CoffeeService {
    @Override
    public void buyCoffee() {
        System.out.println("--加糖");
    }
}

class MilkSugaring implements CoffeeService {
    @Override
    public void buyCoffee() {
        System.out.println("--加奶");
    }
}

//把加材料的抽象出来
abstract class CoffeeAbstract {
    protected CoffeeService coffeeService;

    public CoffeeService getCoffeeService() {
        return coffeeService;
    }

    public void setCoffeeService(CoffeeService coffeeService) {
        this.coffeeService = coffeeService;
    }
    public abstract void draw();
}


class Max extends CoffeeAbstract {
    @Override
    public void draw() {
        System.out.print("大杯");
        coffeeService.buyCoffee();
    }
}

class Min extends CoffeeAbstract {
    @Override
    public void draw() {
        System.out.print("小杯");
        coffeeService.buyCoffee();
    }
}
```

你想增加超大杯跟中杯只需要增加两个实现类

```java
class Centre extends CoffeeAbstract {
    @Override
    public void draw() {
        System.out.print("中杯");
        coffeeService.buyCoffee();
    }
}

class Huge extends CoffeeAbstract {
    @Override
    public void draw() {
        System.out.print("超杯");
        coffeeService.buyCoffee();
    }
}
```

**缺点：**

桥接模式的引入会增加系统的理解与设计难度，由于聚合关联关系建立在抽象层，要求开发者针对抽象进行设计与编程。
桥接模式要求正确识别出系统中两个独立变化的维度，因此其使用范围具有一定的局限性。

#### 8. 装饰器模式（Decorator Pattern）

装饰器模式是一种结构型模式，它允许你通过将对象包装在一个装饰器类中来扩展其行为，而不需要修改其代码。

```java
public class Demo5 {
    public static void main(String[] args) {
        HuaMuLan huaMuLan = new HuaMuLan();
        Pifu pifu = new Pifu(huaMuLan);
        System.out.println(pifu.getIncident());
        System.out.println(pifu.getAttack());
        ZhuangBei zhuangBei = new ZhuangBei(huaMuLan);
        System.out.println(zhuangBei.getIncident());
        System.out.println(zhuangBei.getAttack());

    }
}

abstract class YingXiong{
    //加成栏
    private String incident;

    //攻击力
    private int attack;

    public abstract int getAttack();

    public abstract String getIncident();

}


//选择英雄
class HuaMuLan extends YingXiong{

    @Override
    public int getAttack() {
        return 60;
    }

    @Override
    public String getIncident() {
        return "选择花木兰\n";
    }
}

//一层装饰者 买了皮肤
class Pifu extends HuaMuLan{
    private HuaMuLan huaMuLan;

    public Pifu(HuaMuLan huaMuLan) {
        this.huaMuLan = huaMuLan;
    }

    @Override
    public int getAttack() {
        return huaMuLan.getAttack() + 10;
    }

    @Override
    public String getIncident() {
        return huaMuLan.getIncident()  + "购买皮肤水晶猎龙者\n";
    }
}

//二层装饰 买了装备
class ZhuangBei extends HuaMuLan{
    private HuaMuLan huaMuLan;

    public ZhuangBei(HuaMuLan huaMuLan) {
        this.huaMuLan = huaMuLan;
    }

    @Override
    public int getAttack() {
        return huaMuLan.getAttack() + 10;
    }

    @Override
    public String getIncident() {
        return huaMuLan.getIncident()  + "购买铁剑\n";
    }
}
```

##### 9. 组合模式（Composite Pattern）

组合模式是一种结构型模式，它允许你将对象组合成树形结构来表现“整体/部分”层次结构。

示例：文件夹浏览，我们需要把不同类型的文件兼容到一个窗口

```java
public class Demo2 {
    public static void main(String[] args) {
        Folders zwjj = new Folders("总文件夹");
        
        TextFile aText = new TextFile("a.txt");
        ImagerFile bImager = new ImagerFile("b.jpg");
        Folders cFolders = new Folders("C文件夹");
        zwjj.add(aText);
        zwjj.add(bImager);
        zwjj.add(cFolders);

        //向C文件夹中添加文件：c.txt、c.jpg 
        TextFile cText = new TextFile("c.txt");
        ImagerFile cImage = new ImagerFile("c.jpg");
        cFolders.add(cText);
        cFolders.add(cImage);

         //遍历一级文件夹
        zwjj.getAll();
        System.out.println("-----------------------");
        //遍历C文件夹
        cFolders.getAll();
    }

}

abstract class File {
    String name;

    public File(String name) {
        this.name = name;
    }

    public abstract void getAll();

    @Override
    public String toString() {
        return "File{" +
                "name='" + name + '\'' +
                '}';
    }
}

//文件夹也是一个文件
class Folders extends File {

    List<File> files;

    public Folders(String name) {
        super(name);
        this.files = new ArrayList<>();
        ;
    }

    Boolean add(File file) {
        return files.add(file);
    }

    Boolean del(File file) {
        return files.remove(file);
    }

    @Override
    public void getAll() {
        Iterator<File> iterator = files.iterator();
        while (iterator.hasNext()) {
            System.out.println(iterator.next());
        }
    }
}

class TextFile extends File {

    public TextFile(String name) {
        super(name);
    }

    public void getAll() {
        System.out.println("这是文本文件，文件名：" + super.name);
    }
}

class ImagerFile extends File {

    public ImagerFile(String name) {
        super(name);
    }

    public void getAll() {
        System.out.println("这是图像文件，文件名：" + super.name);
    }
}
```

##### 10. 外观模式（Facade Pattern）

外观模式是一种结构型模式，它提供了一个简单的接口，隐藏了一个复杂的子系统的复杂性。

```java
public class Demo3 {
    public static void main(String[] args) {
        Service1 service1 = new Service1Impl();
        service1.all();
    }
}

interface Service1{
    void all();
}

class Service1Impl implements Service1{
    @Override
    public void all() {
        a();
        b();
        c();
    }
    void a(){
        System.out.println("方法A");
    }
    void b(){
        System.out.println("方法B");
    }
    void c(){
        System.out.println("方法C");
    }
}
```

##### 11. 享元模式（Flyweight Pattern）

Java中的享元模式（Flyweight Pattern）是一种结构型设计模式，它可以在大量的相似对象之间共享尽可能多的数据，从而减少内存的使用量和提高性能。

```java
public class Demo2 {
    public static void main(String[] args) {
        ClassFactory classFactory = new ClassFactory();
        a f1 = classFactory.getFlyweight("key1");
        a f2 = classFactory.getFlyweight("key1");
        a f3 = classFactory.getFlyweight("key2");
        System.out.println(f1);
        System.out.println(f2);
        System.out.println(f3);
    }
}

abstract class a {
    abstract void getThisclass();
}

class b extends a {
    String className;

    public b(String className) {
        this.className = className;
    }

    @Override
    void getThisclass() {
        System.out.println("当前类是" + className);
    }
}

class ClassFactory {
    static HashMap<String, a> map = new HashMap();

    a getFlyweight(String key) {
        a a = map.get(key);
        if (null == a) {
            a = new b(key);
            map.put(key, a);
        }
        return a;
    }
}
```

#### 12. 代理模式（Proxy Pattern）

代理模式是一种结构型模式，它为其他对象提供一种代理以控制对这个对象的访问。

##### 静态代理

静态代理：由程序员创建或特定工具自动生成源代码，也就是**在编译时就已经将接口、被代理类、代理类等确定下来**。在程序运行之前，代理类的.class文件就已经生成。

示例：学生缴纳班费，但是班长代理学生上交班费，班长就是学生的代理。

```java
public class Demo1 {

    //定义一个缴费的接口
    public interface Person {
        public void giveMoney();
    }

    //学生缴费
    public static class Student implements Person {

        private String name;

        public Student(String name) {
            this.name = name;
        }

        @Override
        public void giveMoney() {
            System.out.println(name + "上交班费50元");
        }
    }

    //代理类
    public static class StudentsClassMonitor implements Person {
        //被代理的学生
        Student stu;

        public StudentsClassMonitor(Person stu) {
            // 只代理学生对象
            if (stu.getClass() == Student.class) {
                this.stu = (Student) stu;
            }
        }

        //代理上交班费，调用被代理学生的上交班费行为
        public void giveMoney() {
            stu.giveMoney();
        }
    }

    public static void main(String[] args) {
        //被代理的学生张三，他的班费上交有代理对象monitor（班长）完成
        Student zhangsan = new Student("张三");

        //生成代理对象，并将张三传给代理对象
        Person monitor = new StudentsClassMonitor(zhangsan);

        //班长代理上交班费
        monitor.giveMoney();
    }
}
```

##### 动态代理

#### 行为型模式

##### 13. 责任链模式（Chain of Responsibility Pattern）

责任链模式是一种行为型模式，它允许你将请求沿着处理链进行传递，直到有一个对象处理为止。

##### 14. 命令模式（Command Pattern）

命令模式是一种行为型模式，它将请求封装为对象，从而允许你使用不同的请求、队列或日志来参数化客户端请求。

##### 15. 解释器模式（Interpreter Pattern）

解释器模式是一种行为型模式，它定义了一种语言，然后通过该语言来解释表达式。

##### 16. 迭代器模式（Iterator Pattern）

迭代器模式是一种行为型模式，它允许你在不暴露集合底层表示的情况下遍历集合。

##### 17. 中介者模式（Mediator Pattern）

中介者模式是一种行为型模式，它允许你减少对象之间的直接耦合，通过将它们的通信委托给一个中介者对象来实现。

##### 18. 备忘录模式（Memento Pattern）

备忘录模式是一种行为型模式，它允许你在不暴露对象实现细节的情况下保存和恢复对象的状态。

##### 19. 观察者模式（Observer Pattern）

观察者模式是一种行为型模式，它允许你定义一种订阅机制，以便一个对象的状态发生变化时通知一组对象。

##### 20. 状态模式（State Pattern）

状态模式是一种行为型模式，它允许你在一个对象内部状态发生变化时改变其行为。

##### 21. 策略模式（Strategy Pattern）

策略模式是一种行为型模式，它允许你定义一系列算法，然后将它们封装在一个对象中，以便在运行时动态地选择算法。

```java
public class Demo3 {

    static Map<String, Pull> map = new HashMap<String, Pull>() {{
        put("A", new Cell());
        put("B", new Msg());
    }};

    public static void main(String[] args) {
        String str = "A";
        new Context(map.get(str)).pull();
    }
}

/**
 * 策略类
 */
interface Pull {

    void pull();
}

/**
 * 策略实现类1
 */
class Cell implements Pull {
    @Override
    public void pull() {
        System.out.println("cell 个小电话");
    }
}

/**
 * 策略实现类2
 */
class Msg implements Pull {

    @Override
    public void pull() {
        System.out.println("msg 个小短信");
    }
}

/**
 * 环境类
 */
class Context {
    private Pull pull;

    public Context(Pull pull) {
        this.pull = pull;
    }

    public void pull() {
        System.out.println("msg 个小短信");
    }

}
```

##### 22. 模板方法模式（Template Method Pattern）

模板方法模式是一种行为型模式，它定义了一个算法的步骤，并允许子类为一个或多个步骤提供实现。

##### 23. 访问者模式（Visitor Pattern）

访问者模式是一种行为型模式，它允许你将操作从元素的类中分离出来，将它们封装在一个访问者对象中。

