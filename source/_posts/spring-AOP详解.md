---
title: spring-AOP详解
date: 2023-03-22 15:37:12
tags:
- spring
- aop
categories:
- 后端
cover: /images/background/xiaomai1.jpg
coverWidth: 1200
coverHeight: 320
author: 不二
---

springAOP常见四种实现方式详解

<!-- more -->

#### springAOP介绍

Spring AOP是Spring框架中的一个核心组件，它提供了一种在运行时动态地将代码织入到应用程序中的机制。通过AOP，可以在不修改原始代码的情况下，实现各种横切关注点的功能，例如日志记录、事务管理、安全性等。

#### springAOP实现方式

Spring AOP就是基于动态代理实现的， 分为两种代理，jdk动态代理（基于接口）和cglib代理（基于类的）。如果目标对象实现了接口，就用jdk动态代理，如果未实现接口就用cglib动态代理。

#### jdk&cglib动态代理详解

JDK动态代理只能对实现了接口的类生成代理，而不能针对类 ，使用的是 Java反射技术实现，生成类的过程比较高效。
CGLIB是针对类实现代理，主要是对指定的类生成一个子类，覆盖其中的方法 ，使用asm字节码框架实现，相关执行的过程比较高效，
JDK代理是不需要第三方库支持，只需要JDK环境就可以进行代理，使用条件:实现InvocationHandler + 使用Proxy.newProxyInstance产生代理对象 + 被代理的对象必须要实现接口
CGLib必须依赖于CGLib的类库，但是它需要类来实现任何接口代理的是指定的类生成一个子类，覆盖其中的方法，是一种继承但是针对接口编程的环境下推荐使用JDK的代理

示例：

1.定义用户创建跟新增的两个接口

```java
public interface UserManager {
    //新增用户抽象方法
    void addUser(String userName, String password);
    //删除用户抽象方法
    void delUser(String userName);
}
```

2.实现类

```java
public class UserManagerImpl implements UserManager{

    //重写用户新增方法
    @Override
    public void addUser(String userName, String password) {
        System.out.println("调用了用户新增的方法！");
        System.out.println("传入参数：\nuserName = " + userName +", password = " + password);
    }

    //重写删除用户方法
    @Override
    public void delUser(String userName) {
        System.out.println("调用了删除的方法！");
        System.out.println("传入参数：\nuserName = "+userName);
    }
}
```

3.jdk实现

```java
public class JdkProxy implements InvocationHandler {

    //需要代理的目标对象
    private  Object targetObject;

    public Object getJDKProxy (Object targetObject) {
        //为目标target赋值
        this.targetObject = targetObject;
        //JDK动态代理只能针对实现了接口的类进行代理，newProxyInstance 函数所需参数就可看来
        Object proxyObject = Proxy.newProxyInstance(targetObject.getClass().getClassLoader(), targetObject.getClass().getInterfaces(), this);
        //返回代理对象
        return proxyObject;
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        System.out.println("JDK动态代理，监听开始！");
        // 调用invoke方法，result存储该方法的返回值
        Object result = method.invoke(targetObject,args);
        System.out.println("JDK动态代理，监听结束！");
        return result;
    }
}
```

4.cglib代理

```java
//Cglib动态代理，实现MethodInterceptor接口
public class CglibProxy implements MethodInterceptor {
    private Object target;//需要代理的目标对象

    //重写拦截方法
    @Override
    public Object intercept(Object o, Method method, Object[] args, MethodProxy methodProxy) throws Throwable {
        System.out.println("Cglib动态代理，监听开始！");
        Object result = method.invoke(target,args);//方法执行参数：target 目标对象 arr参数数组
        System.out.println("Cglib动态代理，监听结束！");
        return result;
    }

    //定义获取代理对象的方法
    public UserManager getCglibProxy(Object targetObject) {
        this.target = targetObject;//为目标对象target赋值
        Enhancer enhancer = new Enhancer();
        //设置父类,因为Cglib是针对指定的类生成一个子类，所以需要指定父类
        enhancer.setSuperclass(targetObject.getClass()); //UserManagerImpl
        enhancer.setCallback(this);//设置回调
        Object result = enhancer.create();//创建并返回代理对象
        return (UserManager) result;
    }
}
```

5.测试

```java
import com.proxy.CglibProxy.CglibProxy;
import com.proxy.JDKProxy.JdkProxy;
 
public class ClientTest {
    public static void main(String[] args) {
 
        JdkProxy jdkProxy = new JdkProxy();  //实例化JDKProxy对象
        UserManager userJdk = (UserManager) jdkProxy.getJDKProxy(new UserManagerImpl());   //获取代理对象
        userJdk.addUser("admin","123456");
 
        CglibProxy cglibProxy = new CglibProxy(); //实例化CglibProxy对象
        UserManager userCglib = cglibProxy.getCglibProxy(new UserManagerImpl());//获取代理对象
        userCglib.delUser("admin");
    }
}
```

#### aop的通知方法

前置通知：在我们执行目标方法之前运行

后置通知：在我们目标方法运行结束之后，不管有没有异常

返回通知：在我们的目标方法正常返回值后运行

异常通知：在我们的目标方法出现异常后运行

环绕通知：目标方法的调用由环绕通知决定，即你可以决定是否调用目标方法，joinPoint.procced()就是执行目标方法的代码 。环绕通知可以控制返回对象

#### AOP的几种实现方式

使用到的依赖包

```xml
<dependencies>
    <dependency>
        <groupId>org.ow2.asm</groupId>
        <artifactId>asm</artifactId>
        <version>9.2</version>
    </dependency>

    <dependency>
        <groupId>cglib</groupId>
        <artifactId>cglib</artifactId>
        <version>3.1</version>
    </dependency>

    <dependency>
        <groupId>org.aspectj</groupId>
        <artifactId>aspectjweaver</artifactId>
        <version>1.9.1</version>
    </dependency>

    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-context</artifactId>
        <version>5.3.6</version>
        <scope>test</scope>
    </dependency>
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-aop</artifactId>
        <version>5.3.6</version>
        <scope>compile</scope>
    </dependency>
</dependencies>
```

##### 方式一：XML配置方式

1.定义一个Person类，类中有一个吃饭的方法


```java
public class Person {
    public void Eat() {
        System.out.println("吃饭了");
    }
}
```

2.创建一个两个切面类，实现spring用于aop的接口

| 接口                 | 描述     |
| -------------------- | -------- |
| MethodBeforeAdvice   | 前置通知 |
| AfterAdvice          | 后置通知 |
| AfterReturningAdvice | 返回通知 |
| ThrowsAdvice         | 异常通知 |
| MethodInterceptor    | 环绕通知 |

```java
public class BeforeEat implements MethodBeforeAdvice {

    @Override
    public void before(Method method, Object[] objects, Object o) throws Throwable {
        System.out.println("前置通知===先要做饭");
    }
}

public class AfterEat implements AfterReturningAdvice {

    @Override
    public void afterReturning(Object o, Method method, Object[] objects, Object o1) throws Throwable {
        System.out.println("后置通知===吃完饭刷碗");
    }
}
```

3.配置切面，application.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop.xsd">

    <!--1、注册bean，将实体类注册-->
    <bean id="afterEat" class="demo1.AfterEat"></bean>
    <bean id="beforeEat" class="demo1.BeforeEat"></bean>
    <bean id="person" class="demo1.Person"></bean>

    <!--2、配置AOP切面-->
    <aop:config>
        <!--切入点 expression为表达式，参数为切入的位置，demo1.Person.*表示类中所有方法都切入，*(..)两个点表示不指定参数（任意）-->
        <aop:pointcut id="pointcut" expression="execution(* demo1.Person.*(..))"/>

        <!--配置类切入到哪里:如beforeLog类切入到expression表达式指的位置，即demo1类下的所有方法-->
        <aop:advisor advice-ref="afterEat" pointcut-ref="pointcut"/>
        <aop:advisor advice-ref="beforeEat" pointcut-ref="pointcut"/>
    </aop:config>

</beans>
```

4.测试

```java
public class Test {

    public static void main(String[] args) {
        ApplicationContext context = new ClassPathXmlApplicationContext("application.xml");
        //通过目标的bean id，获得代理对象
        Person person = (Person) context.getBean("person");//获取注册的bean对象，实例对象变成bean对象，就是代理对象
        person.eat();
    }
}
```
5.结果：

```

前置通知==吃饭前做饭
吃饭了
后置通知===吃完饭刷碗

进程已结束,退出代码0
```

##### 方式2：自定义类来实现AOP

1.创建一个自定义切面类

```java
public class diyPointCut {

    public void before(){
        System.out.println("=========方法执行前==========");
    }

    public void after(){
        System.out.println("=========方法执行后==========");
    }
}
```

2.xm配置

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop.xsd">

    <!--1、注册bean，将实体类注册-->
    <bean id="diy" class="demo1.diyPointCut"></bean>
    <bean id="person" class="demo1.Person"></bean>

    <aop:config>
        <!--自定义切面-->
        <aop:aspect ref="diy">
            <!--切入点-->
            <aop:pointcut id="pointcut" expression="execution(* demo1.Person.*(..))"/>
            <!--通知（指定diyPointCut类中的哪个method，aop:before就表示前置）-->
            <aop:before method="before" pointcut-ref="pointcut"></aop:before>
            <aop:after method="after" pointcut-ref="pointcut"></aop:after>
        </aop:aspect>
    </aop:config>

</beans>
```

3.测试

```java
public class Test2 {
    public static void main(String[] args) {
        ApplicationContext context = new ClassPathXmlApplicationContext("application2.xml");
        //通过目标的bean id，获得代理对象
        Person person = (Person) context.getBean("person");//获取注册的bean对象，实例对象变成bean对象，就是代理对象
        person.eat();
    }
}
```

4.结果

```tex
=========方法执行前==========
吃饭了
=========方法执行后==========
```

##### 方式三：基于注解实现

###### aop注解

| 注解            | 描述                                                         |
| --------------- | ------------------------------------------------------------ |
| @Aspect         | **注解用来描述一个切面类，定义切面类的时候需要打上这个注解。** |
| @Order          | 个自定义的`AOP`注解可以对应多个切面类，这些切面类执行顺序由`@Order`注解管理，该注解后的数字越小，所在切面类越先执行。 |
| @Pointcut       | 注解，用来定义一个切点，即上文中所关注的某件事情的入口，切入点定义了事件触发时机。 |
| @Around         | 在方法执行之前和之后都执行通知。                             |
| @Before         | **注解指定的方法在切面切入目标方法之前执行**                 |
| @After          | `@After` 注解和 `@Before` 注解相对应，指定的方法在切面切入目标方法之后执行，也可以做一些完成某方法之后的 Log 处理。 |
| @AfterReturning | 解和 `@After` 有些类似，区别在于 `@AfterReturning` 注解可以用来捕获切入方法执行完之后的返回值，对返回值进行业务逻辑上的增强处理 |
| @AfterThrowing  | 当被切方法执行过程中抛出异常时，会进入 `@AfterThrowing` 注解的方法中执行，在该方法中可以做一些异常的处理逻辑。要注意的是 `throwing` 属性的值必须要和参数一致，否则会报错。该方法中的第二个入参即为抛出的异常。 |

示例

1.新建了一个boot项目

2.依赖包

```xml
 <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-aop</artifactId>
        </dependency>
```

3.切面逻辑

```java
@Aspect
@Component
@Order(0)
public class LogHelp {


    @Pointcut("execution(* com.example.aopdemo2.demo.*.*(..))")
    public void addLog() {
        System.out.println("触发切面方法");
    }


    @Before("addLog()")
    public void logBefore(JoinPoint joinPoint) {
        String methodName = joinPoint.getSignature().getName();
        System.out.println("方法 " + methodName + "前置加强");
    }

    @After("addLog()")
    public void logAfter(JoinPoint joinPoint) {
        String methodName = joinPoint.getSignature().getName();
        System.out.println("方法 " + methodName + "后置加强");
    }

    @Around("addLog()")
    public Object logAround(ProceedingJoinPoint joinPoint) throws Throwable {
        String methodName = joinPoint.getSignature().getName();
        System.out.println("方法 " + methodName + "执行前加强");
        Object result = joinPoint.proceed();
        System.out.println("方法 " + methodName + "执行后加强");
        return result;
    }

    @AfterReturning(pointcut = "addLog()", returning = "result")
    public void logAfterReturning(JoinPoint joinPoint, Object result) {
        String methodName = joinPoint.getSignature().getName();
        System.out.println("方法 " + methodName + "返回值加强");
    }

    @AfterThrowing(pointcut = "addLog()", throwing = "ex")
    public void logAfterThrowing(JoinPoint joinPoint, Exception ex) {
        String methodName = joinPoint.getSignature().getName();
        System.out.println("方法 " + methodName + "报错加强");
    }
}
```

4.调用

```java
@RestController
public class sw {

    @Autowired
    LogHelp logHelp;

    @RequestMapping("d")
    public String a () {
        try {
            ArrayList<Object> objects = new ArrayList<>(2);
            objects.get(10);
            logHelp.addLog();
            return "sadasds";
        } catch (Exception e) {
            return "sadas";
        }
    }
}
```
