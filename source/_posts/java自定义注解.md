---
title: java自定义注解
date: 2023-03-21 09:56:40
tags:
- java
- 自定义注解
categories:
- 后端
cover: /images/background/b384ee3b4655dff7e9411aa6eefdf3e1.jpeg
coverWidth: 1200
coverHeight: 320
---

java自定义注解

<!-- more -->

#### 一、注解简介

注解`Annontation`,java5引入的新特性，位于java.long,annotation中。提供了一种安全的类似注释的机制，用来将任何的信息或元数据（metadata）与程序元素（类、方法、成员变量等）进行关联。是一种说明、配置、描述性的信息，与具体业务无关，也不会影响正常的业务逻辑。但我们可以用反射机制来进行校验、赋值等操作。

##### 自定义注解基础语法

```java
public @interface 注解名 {定义体}
```

#### 二、Annotation提供的元注解

元注解的作用是负责注解其他注解。Java5.0定义了4个标准的meta-annotation类型，它们被用来提供对其它 annotation类型作说明，java5提供了4个元注解，jdk8加入了`Repeatable`、`Native`注解

##### Target

**作用：**用于描述注解的使用范围

###### 取值

备注：例如@Target(ElementType.METHOD)，标志的注解使用在方法上，但是我们在这个注解标志在类上，就会报错

| **Target类型**              | 描述                                                         |
| :-------------------------- | ------------------------------------------------------------ |
| ElementType.TYPE            | 应用于类、接口（包括注解类型）、枚举                         |
| ElementType.FIELD           | 应用于属性（包括枚举中的常量）                               |
| ElementType.METHOD          | 应用于方法                                                   |
| ElementType.PARAMETER       | 应用于方法的形参                                             |
| ElementType.CONSTRUCTOR     | 应用于构造函数                                               |
| ElementType.LOCAL_VARIABLE  | 应用于局部变量                                               |
| ElementType.ANNOTATION_TYPE | 应用于注解类型                                               |
| ElementType.PACKAGE         | 应用于包                                                     |
| TYPE_PARAMETER              | 类型参数声明，JavaSE8引进，可以应用于类的泛型声明之处        |
| TYPE_USE                    | JavaSE8引进，此类型包括类型声明和类型参数声明，是为了方便设计者进行类型检查，例如，如果使用@Target（ElementType.TYPE_USE）对@NonNull进行标记，则类型检查器可以将@NonNull class C {...} C类的所有变量都视为非null |

##### Retention

**作用**：表明注解的生命周期

| 生命周期类型            | 描述                                             |
| ----------------------- | ------------------------------------------------ |
| RetentionPolicy.SOURCE  | 编译时被丢弃，不包含在类文件中                   |
| RetentionPolicy.CLASS   | JVM加载时被丢弃，包含在类文件中，默认值          |
| RetentionPolicy.RUNTIME | 由JVM 加载，包含在类文件中，在运行时可以被获取到 |

##### Inherited

**作用：**定义该注解和子类的关系，使用此注解声明出来的自定义注解，在使用在类上面时，子类会自动继承此注解，否则，子类不会继承此注解。注意，使用Inherited声明出来的注解，只有在类上使用时才会有效，对方法，属性等其他无效。

##### **Documented**

**作用**：表明该注解标记的元素可以被Javadoc 或类似的工具文档化

##### Repeatable

**作用**：是否可重复注解，jdk1.8引入	允许在相同的程序元素中重复注解，在需要对同一种注解多次使用时，往往需要借助 @Repeatable 注解。Java 8 版本以前，同一个程序元素前最多只能有一个相同类型的注解，如果需要在同一个元素前使用多个相同类型的注解，则必须使用注解“容器”

##### Native

 **作用：**注解修饰成员变量，则表示这个变量可以被本地代码引用，常常被代码生成工具使用。对于 @Native 注解不常使用，了解即可

#### 三、注解的使用场景示例

