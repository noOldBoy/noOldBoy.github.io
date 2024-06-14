---
title: JavaScript详解学习
date: 2022-11-22 18:14:30
tags:
- javaScript
categories:
- 前端
cover: /images/background/1.jpeg
coverWidth: 1200
coverHeight: 320
---

JavaScript全解

<!-- more -->

#### 第一章 JavaScript简介

html，css，js算是接触的最早的语言，但是因为后来工作后前后端分离，各种框架，再加上工作内容都是java后端开发，导致最近想用js作为前端语言搭建自己的一个应用时进度缓慢，所以重新捡一遍，也可以 当作字典，以后查阅



##### 1.1、JavaScript的起源

JavaScript诞生于1995年，它的出现主要是用于处理网页中的前端验证。所谓的前端验证，就是指检查用户输入的内容是否符合一定的规则。比如：用户名的长度，密码的长度，邮箱的格式等。

历史事件发展表：

![image-20201012142902870](./JavaScript%E8%AF%A6%E8%A7%A3%E5%AD%A6%E4%B9%A0/34ceed720299546a8161deab88fe16aa.png)

##### 1.2、JavaScript的组成

ECMAScript是一个标准，而这个标准需要由各个厂商去实现，不同的浏览器厂商对该标准会有不同的实现。

![image-20201012144015831](./JavaScript%E8%AF%A6%E8%A7%A3%E5%AD%A6%E4%B9%A0/584d9295990909d32b3338dbbbe9c037.png)

我们已经知道ECMAScript是JavaScript标准，所以一般情况下这两个词我们认为是一个意思。但是实际上JavaScript的含义却要更大一些。一个完整的JavaScript实现应该由以下三个部分构成：

![image-20201012144120964](./JavaScript%E8%AF%A6%E8%A7%A3%E5%AD%A6%E4%B9%A0/fafb929ac005ed0e9e2dedb433fe8eab.png)

##### 1.3、JavaScript的特点很

###### 解释型语言

JavaScript是一门解释型语言，所谓解释型值语言是指不需要被编译为机器码在执行，而是直接执行。由于少了编译这一步骤，所以解释型语言开发起来尤为轻松，但是解释型语言运行较慢也是它的劣势。不过解释型语言中使用了JIT技术，使得运行速度得以改善。

###### 动态语言

JavaScript是一门动态语言，所谓的动态语言可以暂时理解为在语言中的一切内容都是不确定的。比如一个变量，这一时刻是个整型，下一时刻可能会变成字符串了。当然这个问题我们以后再谈。不过在补充一句动态语言相比静态语言性能上要差一些，不过由于JavaScript中应用的JIT技术，所以JavaScript可能是运行速度最快的动态语言了。

###### 类似于 C 和 Java 的语法结构

JavaScript的语法结构与C和Java很像，向for、if、while等语句和Java的基本上是一模一样的。所以有过C和Java基础的同学学习起来会轻松很多。不过JavaScript和与Java的关系也仅仅是看起来像而已。

###### 基于原型的面向对象

JavaScript是一门面向对象的语言。啥是对象？下次聊。

Java也是一门面向对象的语言，但是与Java不同JavaScript是基于原型的面向对象。啥是原型？下次聊。

###### 严格区分大小写

**JavaScript是严格区分大小写的**，也就是abc和Abc会被解析器认为是两个不同的东西。

##### 1.4、JavaScript的使用

###### 1.4.1、标签引用

在HTML中在script标签中就可以编写JavaScript代码，以下是一个简单演示。

```js
 alert("弹窗Hello,World!");
```

###### 1.4.2、文件引用

在一个单独的js文件中也可以编写JavaScript代码，然后在HTML文件中使用script标签进行引用，以下是一个简单演示。

main.html

```js
<script src="main.js"></script>
```

main.js

```
alert("引用弹窗Hello,222222!");
```

##### 1.5、JavaScript的输出

###### 1.5.1、页面输出

如何使用JavaScript向页面输出一句话，请参考以下代码。

```js
<script>
   document.write("页面Hello,World!")
</script>
```

###### 1.5.2、控制台输出

如何使用JavaScript向控制台输出一句话，请参考以下代码。

<script>
    console.log("输出一条日志");//最常用
    console.info("输出一条信息");
    console.warn("输出一条警告");
    console.error("输出一条错误");
</script>

##### 1.6、JavaScript的注释

注释中的内容不会被解析器解析执行，但是会在源码中显示，我们一般会使用注释对程序中的内容进行解释。

JS中的注释和Java的的一致，分为两种：

- 单行注释：`// 注释内容`

- 多行注释：`/* 注释内容 */`

###### 1.6.1、单行注释

<script>
    // 这是注释内容
    console.log("Hello,World!");
</script>

###### 1.6.2、多行注释

<script>
    /**
     * 这是注释内容
     */
    console.log("Hello,World!");
</script>

#### 第二章 JavaScript基础语法

##### 2.1、标识符

所谓标识符，就是指给变量、函数、属性或函数的参数起名字。

标识符可以是按照下列格式规则组合起来的一或多个字符：

第一个字符必须是一个字母、下划线（ _ ）或一个美元符号（ $ ）。
其它字符可以是字母、下划线、美元符号或数字。
按照惯例，ECMAScript 标识符采用驼峰命名法。
标识符不能是关键字和保留字符。

**关键字：**

![image-20201012215759481](./JavaScript%E8%AF%A6%E8%A7%A3%E5%AD%A6%E4%B9%A0/06bab955dce3d478eb0ee1880efdbf13.png)

**保留字符：**

![image-20201012215835171](./JavaScript%E8%AF%A6%E8%A7%A3%E5%AD%A6%E4%B9%A0/321c5fb7e148d7fa99e59440083b0a4b.png)

**其它不建议使用的标识符：**

![image-20201012215902568](./JavaScript%E8%AF%A6%E8%A7%A3%E5%AD%A6%E4%B9%A0/612f0462d3cde3f2fa410ccd8b6da15b.png)

**单个单词的标识符举例：**

```apl
name、age、gender、hobby
```

**多个单词的标识符举例：**

```api
studentName、studentAge、studentGender、studentHobby
```

##### 2.2、字面量和变量

###### 2.2.1、字面量

字面量实际上就是一些固定的值，比如：1、2 、3、true、false、null、NaN、“hello”，字面量都是不可以改变的，由于字面量不是很方便使用，所以在JavaScript中很少直接使用字面量，使用的而是变量。

###### 2.2.2、变量

变量的作用是给某一个值或对象标注名称。比如我们的程序中有一个值123，这个值我们是需要反复使用的，这个时候 我们最好将123这个值赋值给一个变量，然后通过变量去使用123这个值。

变量的声明： 使用var关键字声明一个变量。
```js
var a;
```

**变量的赋值：** 使用=为变量赋值。

```api 
a = 123;
```

##### 2.3、数据类型

###### 2.3.1、类型分类

数据类型决定了一个数据的特征，比如：123和”123”，直观上看这两个数据都是123，但实际上前者是一个数字，而后者是一个字符串。

对于不同的数据类型我们在进行操作时会有很大的不同。

JavaScript中一共有5种基本数据类型：

字符串型（String）
数值型（Number）
布尔型（Boolean）
undefined型（Undefined）
null型（Null）

<font color = red> 这5种之外的类型都称为Object，所以总的来看JavaScript中共有六种数据类型。</font>

###### 2.3.2、typeof运算符

使用typeof操作符可以用来检查一个变量的数据类型。

**使用方式：**

```js
typeof 数据
```

**运行结果**

``` js
console.log(typeof 123);
console.log(typeof "Hello,World!");
console.log(typeof true);
console.log(typeof undefined);
console.log(typeof null);
```

###### 2.3.3、String

String用于表示一个字符序列，即字符串。字符串需要使用 **单引号** 或 **双引号** 括起来。

**转义字符：**

![image-20201013085608008](./JavaScript%E8%AF%A6%E8%A7%A3%E5%AD%A6%E4%B9%A0/8cd27bded82d24387ae42b8444f0d25e.png)

###### 2.3.4、Number

Number 类型用来表示整数和浮点数，最常用的功能就是用来表示10进制的整数和浮点数。

Number表示的数字大小是有限的，如果超过了这个范围，则会返回 ±Infinity。

最大值：+1.7976931348623157e+308
最小值：-1.7976931348623157e+308
0以上的最小值：5e-324

**特殊的数字：**

- Infinity：正无穷
- -Infinity：负无穷
- NaN：非法数字（Not A Number）

**其它的进制：**

- 二进制：0b 开头表示二进制，但是，并不是所有的浏览器都支持
- 八进制：0 开头表示八进制
- 十六进制：0x 开头表示十六进制
- 

###### 2.3.5、Boolean

布尔型也被称为逻辑值类型或者真假值类型。

布尔型只能够取真（true）和假（false）两种数值。除此以外， 其它的值都不被支持。

###### 2.3.6、Undefined

Undefined 类型只有一个值，即特殊的 undefined。

在使用 var 声明变量但未对其加以初始化时，这个变量的值就是 undefined。

###### 2.3.7、Null

Null 类型是第二个只有一个值的数据类型，这个特殊的值是 null。

undefined值实际上是由null值衍生出来的，所以如果比较undefined和null是否相等，会返回true。

##### 2.4、强制类型转换

强制类型转换指将一个数据类型强制转换为其它的数据类型。一般是指，将其它的数据类型转换为String、Number、Boolean。

###### 2.4.1、转换为String类型

将其它数值转换为字符串有三种方式：toString()、String()、 拼串。

方式一：调用被转换数据类型的toString()方法，该方法不会影响到原变量，它会将转换的结果返回，但是注意：null和undefined这两个值没有toString()方法，如果调用它们的方法，会报错。

方式二：调用String()函数，并将被转换的数据作为参数传递给函数，使用String()函数做强制类型转换时，对于Number和Boolean实际上就是调用的toString()方法，但是对于null和undefined，就不会调用toString()方法，它会将 null 直接转换为 “null”，将 undefined 直接转换为 “undefined”。

方式三：为任意的数据类型 `+""`

代码示例

```html
<script>
        var a = 123;
        var a2 = 456;
        var a3 = 678;
        console.log(typeof a)
        a = String(a);
        console.log("String()方法"+typeof a)
        var a2 = a2.toString();
        console.log("toString()方法"+typeof a2)
        a2 = a2 + "";
        console.log("字符拼接"+typeof a)
    </script>
```

结果

![image-20220724150125776](/image-20220724150125776-8646087.png)

###### 2.4.2、转换为Number类型

有三个函数可以把非数值转换为数值：Number()、parseInt() 和parseFloat()。Number()可以用来转换任意类型的数据，而后两者只能用于转换字符串。parseInt()只会将字符串转换为整数，而parseFloat()可以将字符串转换为浮点数。

方式一：使用Number()函数

字符串 --> 数字
如果是纯数字的字符串，则直接将其转换为数字
如果字符串中有非数字的内容，则转换为NaN
如果字符串是一个空串或者是一个全是空格的字符串，则转换为0
布尔 --> 数字
true 转成 1
false 转成 0
null --> 数字
null 转成 0
undefined --> 数字
undefined 转成 NaN
方式二：这种方式专门用来对付字符串，parseInt() 把一个字符串转换为一个整数

###### 2.4.3转换为Boolean类型

数字->布尔

除了0和NaN，其余的都是true

示例：

```js
 <script>
    var a = 0;
    var a1 = 100
    document.write(Boolean(a))
    document.write(Boolean(a1))
   </script>
```

结果：

![image-20221124102900805](./JavaScript%E8%AF%A6%E8%A7%A3%E5%AD%A6%E4%B9%A0/image-20221124102900805-9256942.png)

字符串->布尔

只有空字符串都是true，<font color="red">包括字符串false</font>

示例：

```js
  <script>
    var a = "abc";
    var a1 = "false";
    var a2 = "";
    document.write(Boolean(a));
    document.write(Boolean(a1));
    document.write(Boolean(a2));
   </script>
```

结果：

![image-20221124103434725](./JavaScript%E8%AF%A6%E8%A7%A3%E5%AD%A6%E4%B9%A0/image-20221124103434725.png)

**其他**

null和undefined都会转换为false

对象会转换为true

##### 2.5代码块

###### 2.5.1语句

代码块是在大括号 {} 中所写的语句，以此将多条语句的集合视为一条语句来使用。

示例：

```js
{
        var a = 123;
        a++;
        alert(a);
    }
```

##### 2.6条件语句

###### 2.6.1 if...else

示例：

```js
<script>
        var age = 18;
        if (age < 18) {
            document.writeln("小于18岁了");
        } else if (age == 18) {
            document.writeln("已经18岁了");
        } else {
            document.writeln("大于18岁了")
        }

    </script>
```

##### 2.6.2、switch…case

需要注意的是一旦符合case的条件程序会一直运行到结束，所以我们一般会在case中添加break作为语句的结束。

示例：

```js
<script>
        var age = 18;
        switch (age) {
            case age < 18:
                document.writeln("小于18岁了");
                break;
            case age = 18:
                document.writeln("小于18岁了");
                break;
            case age > 18:
                document.writeln("小于18岁了");
                break;
            default:
                document.write("输入错误");
        }
    </script>
```



结果：

![image-20221124105148042](./JavaScript%E8%AF%A6%E8%A7%A3%E5%AD%A6%E4%B9%A0/image-20221124105148042.png)

##### 2.7循环

###### 2.7.1、while

语法：

while （循环条件）{

操作

}

示例：

```js
<script>
        var i = 1;
        while (i <= 10) {
            document.writeln(i);
            i++;
        }
    </script>
```

结果：

![image-20221124105720027](./JavaScript%E8%AF%A6%E8%A7%A3%E5%AD%A6%E4%B9%A0/image-20221124105720027-9258641.png)

###### 2.7.2 do...while

do…while和while非常类似，只不过它会在循环的尾部而不是顶部检查表达式的值，因此，do…while循环会至少执行一次。相比于while，do…while的使用情况并不 是很多。

语法：

do{
    语句...
}while(条件表达式);

示例：

```js
<script>
        var i = 1;
        do {
            document.writeln(i);
        } while (i == 2); 
    </script>
```

结果：

i = 2 是不成立的  但是依旧只行了一次

![image-20221124110141159](./JavaScript%E8%AF%A6%E8%A7%A3%E5%AD%A6%E4%B9%A0/image-20221124110141159.png)

###### 2.7.3、for

语法：

for(初始化表达式 ; 条件表达式 ; 更新表达式){
    语句...
}

示例：

```js
<script>
        var i = 1;
        for (i; i <= 10; i++) {
            document.writeln(i);
        }
    </script>
```

结果：

![image-20221124110625152](./JavaScript%E8%AF%A6%E8%A7%A3%E5%AD%A6%E4%B9%A0/image-20221124110625152.png)

##### 2.7.4、跳转控制

- break：结束最近的一次循环，可以在循环和switch语句中使用。
- continue：结束本次循环，执行下一次循环，只能在循环中使用。

##### 2.8 JS对象

###### 2.8.1简介

Object类型，我们也称为一个对象，是JavaScript中的引用数据类型。

###### 2.8.2对象创建

方式一：

```js
<script>
       var user = new Object();
       user.name = "李白";
       user.age = 32;
       document.write(user.name);
       document.write(user.age);
    </script>
```

方式二：

```js
<script>
       var user = {
        name : "李白",
        age : 32
       }
       document.write(user.name);
       document.write(user.age);
    </script>
```

###### 2.8.3访问属性

方式一：对象.属性

方式二：对象['属性']

示例：

```js
<script>
       var user = {
        name : "李白",
        age : 32
       }
       console.log(user.name);
       console.log(user['age']);
    </script>
```



结果：

![image-20221124114420802](./JavaScript%E8%AF%A6%E8%A7%A3%E5%AD%A6%E4%B9%A0/image-20221124114420802.png)

###### 2.8.4删除对象属性

示例：

```js
<script>
       var user = {
        name : "李白",
        age : 32
       }

       delete user.age;

       console.log(user);
    </script>
```

结果：

输出对象只剩name字段

![image-20221124113938477](./JavaScript%E8%AF%A6%E8%A7%A3%E5%AD%A6%E4%B9%A0/image-20221124113938477.png)

###### 2.8.5 遍历对象

语法

```js
for (var 变量 in 对象) {
}
```

示例

```js
<script>
       var user = {
        name : "李白",
        age : 32
       }
      for (var key in user) {
        var val = user[key];
        console.log(key+"="+val)
      }
    </script>
```

结果

![image-20221124155024190](./JavaScript%E8%AF%A6%E8%A7%A3%E5%AD%A6%E4%B9%A0/image-20221124155024190.png)

###### 2.8.6 工厂模式创建对象

使用函数的方式创建对象

**示例：**

``` js
<script>
        function createUser (name, age) {
            //创建一个object对象
            var user = new Object();
            //设置对象属性
            user.name = name;
            user.age = age ;
            //返回对象
            return user;
        }
        var user1 = createUser("李白",12);
        var user2 = createUser("花木兰",32);
        console.log(user1);
        console.log(user2);
    </script>
```

###### 2.8.7 构造函数创建对象（推荐）

上面方式方式已经可以复用创建对象，但是发现创建的对象其实实际是为Object的对象，我们想要的其实是User，改进一下

示例：

``` js
  <script>
        function User (name, age) {
            this.name = name;
            this.age = age ;
        }
        var user1 = new User("李白",12);
        var user2 = new User("花木兰",32);
        console.log(user1);
        console.log(user2);
    </script>
```





##### 2.9函数

函数是由一连串的子程序（语句的集合）所组成的，可以被外部程序调用，向函数传递参数之后，函数可以返回一定的值。通常情况下，JavaScript代码是自上而下执行的，不过函数体内部的代码则不是这样。如果只是对函数进行了声明，其中的代码并不会执行，只有在调用函数时才会执行函数体内部的代码。

###### 2.9.1函数创建

**语法：**

**方式一** **使用函数对象创建函数**

``` js
js var 函数名 = new Function("执行语句");
```

**方式二** **函数声明**

```js
function 函数名 （参数）{
  函数体
}
```

**方式三** **函数表达式**

```js
var 函数名 = function (参数) {
  方法体
}
```

**示例：**

```js
 <script>
     var fun1 = new Function (document.writeln("函数对象创建函数"));
     function fun2 (name) {
        document.writeln("函数声明创建的函数:name="+name)
     }
     var fun3 = function (name, age) {
        document.writeln("函数表达式创建函数:name="+name)
     }
    </script>
```

###### 2.9.2函数调用

**语法：**

```js
函数名（参数）;
```

**示例**：****

```js
<script>
     var fun1 = new Function (document.writeln("函数对象创建函数"));
     function fun2 (name) {
        document.writeln("函数声明创建的函数:name="+name)
     }
     var fun3 = function (name) {
        document.writeln("函数表达式创建函数:name="+name)
     }
     fun1();
     fun2("李白");
     fun3("杜甫");
    </script>
```

**运行结果**：****

![image-20221124170703109](./JavaScript%E8%AF%A6%E8%A7%A3%E5%AD%A6%E4%B9%A0/image-20221124170703109-9280824.png)

###### 2.9.3 函数参数

<font color= red>注：</font>

js在调用函数时不会检查参数的数量,多余实参不会被赋值，如果实参的数量少于形参的数量，则没有对应实参的形参将是undefined

###### 2.9.4 函数返回值

可以使用 return 来设置函数的返回值，return后的值将会作为函数的执行结果返回，可以定义一个变量，来接收该结果。

> 注意：在函数中return后的语句都不会执行，如果return语句后不跟任何值就相当于返回一个undefined，如果函数中不写return，则也会返回undefined，return后可以跟任意类型的值

**示例：******

```js
 <script>
        function fun (a,b) {
            return a+b;
        }
        var c = fun(1,2);
        alert(c);
    </script>
```

结果：

![image-20221124173156771](./JavaScript%E8%AF%A6%E8%A7%A3%E5%AD%A6%E4%B9%A0/image-20221124173156771.png)

###### 2.9.5 函数嵌套

嵌套的函数只能在函数内部使用示例：

```js
function fu() {
    function zi() {
        console.log("我是儿子")
    }
    zi();
}
fu();
```

###### 2.9.6 匿名函数

匿名函数：没有名字的函数就是匿名函数，它可以让一个变量来接收，也就是用 “函数表达式” 方式创建和接收

示例：

```js
var fun = function () {
    alert("我是一个匿名函数");
}
fun();

```

###### 2.9.7 立即执行函数

进入页面立即执行不需要手动调用

```js
 <script>
        (function () {
            document.writeln("立即执行函数")

        }) ()
    </script>
```

###### 2.9.8 对象中的函数

对象中的属性可以是任何数据类型，也可以是个函数

如果一个函数作为对象的属性保存，那么我们称这个函数是这个对象的方法

示例：****

```js
<script>
       var user = {
        name : "张三",
        age : 12,
        thisDate : function () {
            var date = new Date();
            document.writeln("时间："+date )
        }
       }
       console.log (user.name);
       user.thisDate();      
 </script>
```

###### 2.9.10 this对象

<font color="blue">函数式调用，this为当前window对象</font>

<font color="blue">方法调用时，就是当前方法</font>

**示例：**

```js
 <script>
       var name = "全局名称name";
       var user = {
        name : "user对象名称",
        subNmae : fun

       }
       function fun () {
        console.log(this.name);
       }
       fun();
       user.subNmae();
    </script>
```

**效果：**

![image-20221230155119465](./JavaScript%E8%AF%A6%E8%A7%A3%E5%AD%A6%E4%B9%A0/image-20221230155119465.png)

###### 2.10 toString方法

类似于java的toString方法，将当前对象或者数组等数据类型转换为字符串类型，该方法是Object的方法，几乎所有的对象都继承了Object类，所以几乎所有的示例对象都可以使用该方法

**示例：**

```js
// 字符串
var str = "Hello";
console.log(str.toString());

// 数字
var num = 15.26540;
console.log(num.toString());

// 布尔
var bool = true;
console.log(bool.toString());

// Object
var obj = {name: "张三", age: 18};
console.log(obj.toString());

// 数组
var array = ["CodePlayer", true, 12, -5];
console.log(array.toString());

// 日期
var date = new Date(2013, 7, 18, 23, 11, 59, 230);
console.log(date.toString());

// 错误
var error = new Error("自定义错误信息");
console.log(error.toString());

// 函数
console.log(Function.toString());

```

#### 第三章 JavaScript常用对象

##### 3.1数组对象

​                                                   
