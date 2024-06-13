---
title: dubbo分布式架构一.
date: 2022-06-24 15:49:43
tags:
- dubbo
categories:
- 架构
cover: /images/background/xiaomai8.jpeg
coverWidth: 1200
coverHeight: 320
author: 不二
---

dubbo项目简介and搭建

<!-- more -->

### 为什么要用dubbo

在互联网的发展过程中，在以前，我们只需要一个服务器，将程序全部打包好就可以，但是，随着流量的增大，常规的垂直应用架构已无法应对，所以，架构就发生了演变。

1 单一应用架构

2 应用和数据库单独部署

3 应用和数据库集群部署

4 数据库压力变大，读写分离

5 使用缓存技术加快速度

6 数据库分库分表

7 应用分为不同的类型拆分

发展到这个阶段的时候，我们发现，应用与应用之间的关系已经十分的复杂了，就会出现以下几个问题（以下摘录于官网）：

① 当服务越来越多时，服务 URL 配置管理变得非常困难，F5 硬件负载均衡器的单点压力也越来越大。
② 当进一步发展，服务间依赖关系变得错踪复杂，甚至分不清哪个应用要在哪个应用之前启动，架构师都不能完整的描述应用的架构关系。
③ 接着，服务的调用量越来越大，服务的容量问题就暴露出来，这个服务需要多少机器支撑？什么时候该加机器？

为了解决这由于架构的演变所产生的问题几个问题，于是，dubbo 产生了。当然，解决这个问题的技术不止 dubbo 。

### 什么是Dubbo？

Dubbo 是阿里开源的远程服务调用(RPC)的分布式框架，提供了 SOA 服务治理方案;它的架构主要有五个角色/核心组件，分为是 Container(容器)、Provider(服务的提供方)、Registry(注册中心)、Consumer(服务的消费方)、Monitor(监控中心)。

容器主要负责启动、加载、运行服务提供者;

同时服务提供者在启动时，向注册中心注册自己提供的服务;

消费者向注册中心订阅自己的服务;注册中心返回服务提供者列表给消费者，如果有变更，注册中心将基于长连接推送变更数据给消费者;

对于服务消费者，从提供者地址列表中，基于软负载均衡算法，选一台提供者进行调用，如果调用失败，再选另外一台调用;

服务消费者和提供者，在内存中累计调用次数和调用时间，定时每分钟发送一次统计数据到监控中心;

### RPC的简介

##### RPC(Remote Procedure Call Protocol)：远程过程调用

两台服务器A、B，分别部署不同的应用a,b。当A服务器想要调用B服务器上应用b提供的函数或方法的时候，由于不在一个内存空间，不能直接调用，需要通过网络来表达调用的语义传达调用的数据。
说白了，就是你在你的机器上写了一个程序，我这边是无法直接调用的，这个时候就出现了一个远程服务调用的概念。

RPC是一种通过网络从远程计算机程序上请求服务，而不需要了解底层网络技术的协议。RPC协议假定某些传输协议的存在，如TCP或UDP，为通信程序之间携带信息数据。在OSI网络通信模型中，RPC跨越了传输层和应用层。RPC使得开发包括网络分布式多程序在内的应用程序更加容易。
RPC采用客户机/服务器模式。请求程序就是一个客户机，而服务提供程序就是一个服务器。首先，客户机调用进程发送一个有进程参数的调用信息到服务进程，然后等待应答信息。在服务器端，进程保持睡眠状态直到调用信息到达为止。当一个调用信息到达，服务器获得进程参数，计算结果，发送答复信息，然后等待下一个调用信息，最后，客户端调用进程接收答复信息，获得进程结果，然后调用执行继续进行。

### RPC需要解决的问题

通讯问题：主要是通过在客户端和服务器之间建立TCP连接，远程过程调用的所有交换的数据都在这个连接里传输。连接可以是按需连接，调用结束后就断掉，也可以是长连接，多个远程过程调用共享同一个连接。
寻址问题：A服务器上的应用怎么告诉底层的RPC框架，如何连接到B服务器（如主机或IP地址）以及特定的端口，方法的名称名称是什么，这样才能完成调用。比如基于Web服务协议栈的RPC，就要提供一个endpoint URI，或者是从UDDI服务上查找。如果是RMI调用的话，还需要一个RMI Registry来注册服务的地址。
序列化 与 反序列化：当A服务器上的应用发起远程过程调用时，方法的参数需要通过底层的网络协议如TCP传递到B服务器，由于网络协议是基于二进制的，内存中的参数的值要序列化成二进制的形式，也就是序列化（Serialize）或编组（marshal），通过寻址和传输将序列化的二进制发送给B服务器。
同理，B服务器接收参数要将参数反序列化。B服务器应用调用自己的方法处理后返回的结果也要序列化给A服务器，A服务器接收也要经过反序列化的过程。

### Doubbo源码and官方demo

##### 官网地址：

https://github.com/apache/dubbo

##### 拉取代码：

![image-20220625132620209](/Users/guoshuai/Documents/life/pre/blog/source/_posts/dubbo分布式架构/image-20220625132620209.png)

##### 切换到稳定分支2.7

git checkout -b dubbo-2.7.15 dubbo-2.7.15

##### 使用mvn编译项目，并且跳过测试

mvn clean install -Dmaven.test.skip=true 

![image-20220625143548382](/Users/guoshuai/Documents/life/pre/blog/source/_posts/dubbo分布式架构/image-20220625143548382.png)

需要时间可能比较久，中途终止的话可以使用  "mvn -U idea:idea"继续下载

### 源码官方demo

官方源码给出了三种基础的示例程序在 dubbo-demo 模块下

这四个子模块分别为 dubbo-demo-interface（demo 的api抽象）、demo-api（使用 api 配置）、demo-xml（xml 方式配置）、demo-annotation（注解配置）。

![image-20220625144649288](/Users/guoshuai/Documents/life/pre/blog/source/_posts/dubbo分布式架构/image-20220625144649288.png)

## ZooKeeper注册中心搭建

源码`https://archive.apache.org/dist/zookeeper/zookeeper-3.4.14/`

我装在了虚拟机里，也可以直接装到本机使用

![image-20220625144001065](/Users/guoshuai/Documents/life/pre/blog/source/_posts/dubbo分布式架构/image-20220625144001065.png)



### 项目搭建

#### xml方式

1.新建一个maven父项目，删掉src文件夹

![image-20220624164208527](/Users/guoshuai/Documents/life/pre/blog/source/_posts/dubbo分布式架构/image-20220624164208527.png)



2.新建两个`boot`子项目，服务暴露方创建一个简单接口提供调用

![image-20220717133753939](/Users/guoshuai/Documents/life/pre/blog/source/_posts/dubbo分布式架构/image-20220717133753939.png)

**接口**

```java
public interface ProviderService {

    /**
     * xml方式服务提供者接口
     * @return
     */
    String SayHello();
}
```

**实现**

```java
public class ProviderServiceImpl implements ProviderService {


    /**
     * xml方式服务提供者实现类
     */
    public String SayHello() {
        return "hi";
    }
}
```

3.加入maven依赖

```xml
<dependencies>
		<dependency>
			<groupId>junit</groupId>
			<artifactId>junit</artifactId>
			<version>3.8.1</version>
			<scope>test</scope>
		</dependency>
		<!-- https://mvnrepository.com/artifact/com.alibaba/dubbo -->
		<dependency>
			<groupId>com.alibaba</groupId>
			<artifactId>dubbo</artifactId>
			<version>2.6.6</version>
		</dependency>
		<dependency>
			<groupId>org.apache.zookeeper</groupId>
			<artifactId>zookeeper</artifactId>
			<version>3.4.10</version>
		</dependency>
		<dependency>
			<groupId>com.101tec</groupId>
			<artifactId>zkclient</artifactId>
			<version>0.5</version>
		</dependency>
		<dependency>
			<groupId>io.netty</groupId>
			<artifactId>netty-all</artifactId>
			<version>4.1.32.Final</version>
		</dependency>
		<dependency>
			<groupId>org.apache.curator</groupId>
			<artifactId>curator-framework</artifactId>
			<version>2.8.0</version>
		</dependency>
		<dependency>
			<groupId>org.apache.curator</groupId>
			<artifactId>curator-recipes</artifactId>
			<version>2.8.0</version>
		</dependency>

		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter</artifactId>
		</dependency>

		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-test</artifactId>
			<scope>test</scope>
			<exclusions>
				<exclusion>
					<groupId>org.junit.vintage</groupId>
					<artifactId>junit-vintage-engine</artifactId>
				</exclusion>
			</exclusions>
		</dependency>

	</dependencies>
```

这里使用的dubbo的版本是2.6.6，需要注意的是，如果你只导入dubbo的包的时候是会报错的，找不到netty和curator的依赖，所以，在这里我们需要把这两个的依赖加上，就不会报错了。

另外，这里我们使用 zookeeper作为注册中心。

到目前为止，dubbo 需要的环境就已经可以了，下面，我们就把上面刚刚定义的接口暴露出去。

4.暴露接口（xml方式）

首先，我们在我们项目的`resource`目录下创建 `META-INF.spring` 包，然后再创建 `provider.xml` 文件，名字可以任取哦，如下图所示

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:dubbo="http://code.alibabatech.com/schema/dubbo"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans.xsd
http://code.alibabatech.com/schema/dubbo http://code.alibabatech.com/schema/dubbo/dubbo.xsd">

    <!--当前项目在整个分布式架构里面的唯一名称，计算依赖关系的标签-->
    <dubbo:application name="provider-xml" owner="guo">
        <dubbo:parameter key="qos.enable" value="true"/>
        <dubbo:parameter key="qos.accept.foreign.ip" value="false"/>
        <dubbo:parameter key="qos.port" value="55555"/>
    </dubbo:application>

    <dubbo:monitor protocol="registry"/>

    <!--dubbo这个服务所要暴露的服务地址所对应的注册中心-->
    <!--<dubbo:registry address="N/A"/>-->
    <dubbo:registry address="N/A" />

    <!--当前服务发布所依赖的协议；webserovice、Thrift、Hessain、http-->
    <dubbo:protocol name="dubbo" port="20880"/>

    <!--服务发布的配置，需要暴露的服务接口-->
    <dubbo:service
            interface="com.guo.providerxml.service.IXmlService"
            ref="IXmlService"/>

    <!--Bean bean定义-->
    <bean id="IXmlService" class="com.guo.providerxml.service.impl.IXmlServiceImpl"/>
</beans>
```

**说明：**

1、上面的文件其实就是类似 spring的配置文件，而且，dubbo 底层就是 spring。
2、节点：dubbo:application
就是整个项目在分布式架构中的唯一名称，可以在name属性中配置，另外还可以配置owner字段，表示属于谁。
下面的参数是可以不配置的，这里配置是因为出现了端口的冲突，所以配置。
3、节点：dubbo:monitor
监控中心配置， 用于配置连接监控中心相关信息，可以不配置，不是必须的参数。
4、节点：dubbo:registry
配置注册中心的信息，比如，这里我们可以配置 zookeeper 作为我们的注册中心。address 是注册中心的地址，这里我们配置的是 N/A 表示由 dubbo自动分配地址。或者说是一种直连的方式，不通过注册中心。
5、节点：dubbo:protocol
服务发布的时候 dubbo 依赖什么协议，可以配置dubbo、webservice、http等协议。
6、节点：dubbo:service
这个节点就是我们的重点了，当我们服务发布的时候，我们就是通过这个配置将我们的服务发布出去的。interface是接口的包路径，ref是第 ⑦ 点配置的接口的bean。
7、最后，我们需要像配置spring的接口一样，配置接口的 bean。

到这一步，关于服务端的配置就完成了

5.发布接口

```java
import org.springframework.context.support.ClassPathXmlApplicationContext;
import java.io.IOException;

public class App {

    public static void main( String[] args ) throws IOException {
        //加载xml配置文件启动
        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("META-INF/spring/provider.xml");
        context.start();
        System.in.read(); // 按任意键退出
    }

}
```

发布接口非常简单，因为dubbo底层就是依赖 spring 的，所以，我们只需要通过 ClassPathXmlApplicationContext拿到我们刚刚配置好的 xml，然后调用 context.start()方法就启动了。

看到下面的截图，就算是启动成功了，接口也就发布出去了。

