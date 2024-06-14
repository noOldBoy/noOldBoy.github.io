---
title: spring日志级别
date: 2022-06-22 10:21:21
tags:
- springBoot
categories:
- 后端
cover: /images/background/xiaomai1.jpg
coverWidth: 1200
coverHeight: 320
author: 不二
---

spring日志级别

<!-- more -->

1.启动项目的时候发现成功启动后，后台没有打印端口号这些日志

![image-20220623140825715](./spring%E6%97%A5%E5%BF%97%E7%BA%A7%E5%88%AB/image-20220623140825715-5964511-5964513-5964515.png)

检查配置发现 日志级别配置为WARN（警告）

```javascript
# 日志配432
logging:
  level:
    com.guo: debug
    org.springframework: WARN
```

2.日志级别

- OFF   | 关闭：最高级别，不打印日志。 
- FATAL | 致命：指明非常严重的可能会导致应用终止执行错误事件。
- ERROR | 错误：指明错误事件，但应用可能还能继续运行。 
- WARN | 警告：指明可能潜在的危险状况。 
- INFO | 信息：指明描述信息，从粗粒度上描述了应用运行过程。 
- DEBUG | 调试：指明细致的事件信息，对调试应用最有用。
- TRACE | 跟踪：指明程序运行轨迹，比DEBUG级别的粒度更细。 
- ALL | 所有：所有日志级别，包括定制级别。

\> 日志级别由低到高:  `日志级别越高输出的日志信息越多

 
