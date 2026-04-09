---
title: maven标签
date: 2022-08-22 10:33:04
tags:
- maven
categories:
- 工具
cover: /images/background/18.jpeg
coverWidth: 1200
coverHeight: 320
---

maven

<!-- more -->

#### dependencie

#### groupId<font color="red">*</font>

一般都是公司的标识，比如com.alibaba

#### artifactId<font color="red">*</font>

项目名称，比如 fastjson，mysql

#### version<font color="red">*</font>

版本号

#### scope

用于标注依赖的范围

**compile**

默认值；compile表示被依赖包需要参与当前项目的编译，包括后续的测试，运行周期也参与其中，是一个比较强的依赖；打包的时候通常需要

**provided**

类型的scope只会在项目的`编译`、`测试`阶段起作用；可以认为在目标容器中已经提供了这个依赖，无需在提供，但是在编写代码或者编译时可能会用到这个依赖；`依赖不会被打入到项目jar包中`。

**runtime**

`runtime`与`compile`比较相似，区别在于`runtime` 跳过了`编译`阶段，打包的时候通常需要包含进去。

**test**

在一般的编译和运行时都不需要，它们只有在测试编译和测试运行阶段可用，`不会被打包到项目jar包中`，同时如果项目A依赖于项目B，项目B中的`test`作用域下的依赖不会被继承。

**system**

表示使用本地系统路径下的jar包，需要和一个systemPath一起使用，如下：

```xml
<!--引用-->
		<dependency>
			<groupId>xxxx</groupId>
			<artifactId>xxx</artifactId>
			<systemPath>${basedir}/lib/xxxxx.jar</systemPath>
			<scope>system</scope>
			<version>1.4.12</version>
		</dependency>

```

**import**

`import` 只能在pom文件的`<dependencyManagement>`中使用,从而引入其他的pom文件中引入依赖
