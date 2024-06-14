---
title: boot项目相互引入大坑
date: 2022-06-20 13:59:35
tags:
- springBoot
categories:
- 后端
cover: /images/background/xiaomai11.jpeg
coverWidth: 1200
coverHeight: 320
author: 不二
---

boot项目引入大坑

<!-- more -->

接手的一个老项目，因为这个问题，兜兜转转花费了一晚上的时间。复盘一次，这个问题我不会遇到了！

事发场景：`boot-b`引入`boot-a`,`boot-a`中有服务WelcomeService

1.新建两个boot项目，boot-a中创建一个接口

![image-20220620143935692](./boot%E6%89%93%E5%8C%85%E5%BC%95%E5%85%A5%E5%A4%A7%E5%9D%91/image-20220620143935692-5707184.png)

2.boot-b引入项目boot-a的gav

![image-20220620144836836](./boot%E6%89%93%E5%8C%85%E5%BC%95%E5%85%A5%E5%A4%A7%E5%9D%91/image-20220620144836836.png)

3.boot-b写个接口实现类实现boot-a中写好的接口

![image-20220620145124953](./boot%E6%89%93%E5%8C%85%E5%BC%95%E5%85%A5%E5%A4%A7%E5%9D%91/image-20220620145124953.png)

4.看起来一切正常，boot-b成功引入了boot-a中的接口，但是你尝试启动一下项目项目是启动不了的，编译一下尝试comlile

![20220620145317956](./boot%E6%89%93%E5%8C%85%E5%BC%95%E5%85%A5%E5%A4%A7%E5%9D%91/image-20220620145317956.png)

编译结果：

![image-20220620145406660](./boot%E6%89%93%E5%8C%85%E5%BC%95%E5%85%A5%E5%A4%A7%E5%9D%91/image-20220620145406660.png)

因为这个问题，百思不得其解。成功引入的表象，误导我  尝试了好多种方式，解决     最后把错误归结到我本地电脑环境问题，心态爆炸      休息一会后尝试重新解决

5.尝试打包boot-a 看看打包的目录 package

<img src="./boot%E6%89%93%E5%8C%85%E5%BC%95%E5%85%A5%E5%A4%A7%E5%9D%91/image-20220620150532011.png" alt="image-20220620150532011" style="zoom:50%;" />



打包后找到目录解压   我们的包变成了`BOOT-INF`   他确实打包打入了你boot-b需要的接口，但是你的maven是引入不到的，

![image-20220620150628669](./boot%E6%89%93%E5%8C%85%E5%BC%95%E5%85%A5%E5%A4%A7%E5%9D%91/image-20220620150628669.png)

6.原因分析

如下，就是在boot-a中springboot的maven插件，用这个插件打包的Jar包可以直接运行，但是不可依赖！（创建boot项目默认会加）

```
<build>
    <plugins>
        <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
        </plugin>
    </plugins>
</build>
```

7.解决方案

在boot-a`configuration`下设置`skip`为`true`

```
<build>
    <plugins>
        <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>

            <configuration>
                <skip>true</skip>
            </configuration>
        </plugin>
    </plugins>
</build>
```

尝试重新打包boot-a

mvn install

解压后新的包，是我们想要的目录

![image-20220620152556517](./boot%E6%89%93%E5%8C%85%E5%BC%95%E5%85%A5%E5%A4%A7%E5%9D%91/image-20220620152556517.png)

尝试重新编译启动，如果报错的话   还是，尝试清理一下缓存，重新生成一下mvn目录

执行命令：mvn : -U idea:idea

成功编译启动

![image-20220620153316105](./boot%E6%89%93%E5%8C%85%E5%BC%95%E5%85%A5%E5%A4%A7%E5%9D%91/image-20220620153316105.png)

