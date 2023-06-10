# 《一个64位操作系统的设计与实现》学习笔记

![1528172698621.png](image/1528172698621.png)

## 本仓库说明

1. 本仓库代码默认运行环境位 CenOS6.4 x64，相关环境搭建参看**《第二章-环境搭建及基础知识》**
2. 尽量做到每个例程用一个run.sh脚本一键运行跑起，目前还在更新中。。随书源码在Mac下开发，乱的一笔，整理一波先。
3. 书才收到没多久，慢慢看，稳稳更新。。
4. 尽可能做到每个实例用脚本启动运行，尽可能添加注释
5. 书的排版其实不适合一章节一个实验跑通，可能更多小实验组成，尝试采用其它方式记录

```
Something I hope you know before go into the coding~
* First, please watch or star this repo, I'll be more happy if you follow me.
* Bug report, questions and discussion are welcome, you can post an issue or pull a request.
```

## 相关站点

1. GitBook地址：<https://yifengyou.gitbooks.io/the-design-and-implementation-of-a-64-bit-os>
2. 图灵社区该书站点：<http://www.ituring.com.cn/book/2450>
3. GitHub仓库地址：<https://github.com/yifengyou/The-design-and-implementation-of-a-64-bit-os>
4. PDF下载地址：<https://www.jb51.net/books/678143.html>

## 目录

* [第1章-操作系统概述](docs/第1章-操作系统概述.md)
* [第2章-环境搭建及基础知识](docs/第2章-环境搭建及基础知识.md)
    * [虚拟机及开发平台介绍](docs/第2章-环境搭建及基础知识/虚拟机及开发平台介绍.md)
    * [汇编语言](docs/第2章-环境搭建及基础知识/汇编语言.md)
    * [C语言](docs/第2章-环境搭建及基础知识/C语言.md)
* [第3章-BootLoader引导启动程序](docs/第3章-BootLoader引导启动程序.md)
    * [Boot引导程序](docs/第3章-BootLoader引导启动程序/Boot引导程序.md)
    * [Loader引导加载程序](docs/第3章-BootLoader引导启动程序/Loader引导加载程序.md)
* [第4章-内核层](docs/第4章-内核层.md)
    * [内核执行头程序](docs/第4章-内核层/内核执行头程序.md)
    * [内核主程序](docs/第4章-内核层/内核主程序.md)
    * [屏幕显示](docs/第4章-内核层/屏幕显示.md)
    * [系统异常](docs/第4章-内核层/系统异常.md)
    * [初级内存管理单元](docs/第4章-内核层/初级内存管理单元.md)
    * [中断处理](docs/第4章-内核层/中断处理.md)
    * [键盘驱动](docs/第4章-内核层/键盘驱动.md)
    * [进程管理](docs/第4章-内核层/进程管理.md)
* [第5章-应用层](docs/第5章-应用层.md)
    * [跳转到应用层](docs/第5章-应用层/跳转到应用层.md)
    * [实现系统调用API](docs/第5章-应用层/实现系统调用API.md)
    * [实现一个系统调用处理函数](docs/第5章-应用层/实现一个系统调用处理函数.md)
* [第6章-处理器体系结构](docs/第6章-处理器体系结构.md)
    * [基础功能与新特性](docs/第6章-处理器体系结构/基础功能与新特性.md)
    * [地址空间](docs/第6章-处理器体系结构/地址空间.md)
    * [实模式](docs/第6章-处理器体系结构/实模式.md)
    * [保护模式](docs/第6章-处理器体系结构/保护模式.md)
    * [IA-32e模式](docs/第6章-处理器体系结构/IA-32e模式.md)
* [第7章-完善BootLoader功能](docs/第7章-完善BootLoader功能.md)
    * [实模式的寻址瓶颈](docs/第7章-完善BootLoader功能/实模式的寻址瓶颈.md)
    * [获取物理地址空间信息](docs/第7章-完善BootLoader功能/获取物理地址空间信息.md)
    * [操作系统引导加载阶段的内存空间划分](docs/第7章-完善BootLoader功能/操作系统引导加载阶段的内存空间划分.md)
    * [U盘启动](docs/第7章-完善BootLoader功能/U盘启动.md)
    * [在物理平台上启动操作系统](docs/第7章-完善BootLoader功能/在物理平台上启动操作系统.md)
    * [细说VBE功能的实现](docs/第7章-完善BootLoader功能/细说VBE功能的实现.md)
* [第8章-内核主程序](docs/第8章-内核主程序.md)
    * [内核主程序功能概述](docs/第8章-内核主程序/内核主程序功能概述.md)
    * [操作系统的Makefile编译脚本](docs/第8章-内核主程序/操作系统的Makefile编译脚本.md)
    * [操作系统的kernel.lds链接脚本](docs/第8章-内核主程序/操作系统的kernel.lds链接脚本.md)
    * [操作系统的线性地址空间划分](docs/第8章-内核主程序/操作系统的线性地址空间划分.md)
    * [获得处理器的固件信息](docs/第8章-内核主程序/获得处理器的固件信息.md)
* [第9章-高级内存管理单元](docs/第9章-高级内存管理单元.md)
    * [SLAB内存池](docs/第9章-高级内存管理单元/SLAB内存池.md)
    * [基于SLAB内存池技术的通用内存管理单元](docs/第9章-高级内存管理单元/基于SLAB内存池技术的通用内存管理单元.md)
    * [调整物理页管理功能](docs/第9章-高级内存管理单元/调整物理页管理功能.md)
    * [页表初始化](docs/第9章-高级内存管理单元/页表初始化.md)
* [第10章-高级中断处理单元](docs/第10章-高级中断处理单元.md)
    * [APIC概述](docs/第10章-高级中断处理单元/APIC概述.md)
    * [Local APIC](docs/第10章-高级中断处理单元/LocalAPIC.md)
    * [I/O APIC](docs/第10章-高级中断处理单元/IOAPIC.md)
    * [中断控制器的模式选择与初始化](docs/第10章-高级中断处理单元/中断控制器的模式选择与初始化.md)
    * [高级中断处理功能](docs/第10章-高级中断处理单元/高级中断处理功能.md)
* [第11章-设备驱动程序](docs/第11章-设备驱动程序.md)
    * [键盘和鼠标驱动程序](docs/第11章-设备驱动程序/键盘和鼠标驱动程序.md)
    * [硬盘驱动程序](docs/第11章-设备驱动程序/硬盘驱动程序.md)
* [第12章-进程管理](docs/第12章-进程管理.md)
    * [进程管理单元功能概述](docs/第12章-进程管理/进程管理单元功能概述.md)
    * [多核处理器](docs/第12章-进程管理/多核处理器.md)
    * [进程调度器](docs/第12章-进程管理/进程调度器.md)
    * [内核同步方法](docs/第12章-进程管理/内核同步方法.md)
    * [完善进程管理单元](docs/第12章-进程管理/完善进程管理单元.md)
* [第13章-文件系统](docs/第13章-文件系统.md)
    * [文件系统概述](docs/第13章-文件系统/文件系统概述.md)
    * [解析FAT32文件系统](docs/第13章-文件系统/解析FAT32文件系统.md)
    * [虚拟文件系统](docs/第13章-文件系统/虚拟文件系统.md)
* [第14章-系统调用API库](docs/第14章-系统调用API库.md)
    * [系统调用API结构](docs/第14章-系统调用API库/系统调用API结构.md)
    * [基于POSIX规范实现系统调用](docs/第14章-系统调用API库/基于POSIX规范实现系统调用.md)
* [第15章-Shell命令解析器及命令](docs/第15章-Shell命令解析器及命令.md)
    * [Shell命令解析器](docs/第15章-Shell命令解析器及命令/Shell命令解析器.md)
    * [基础命令](docs/第15章-Shell命令解析器及命令/基础命令.md)
* [第16章-一个彩蛋](docs/第16章-一个彩蛋/第16章-一个彩蛋.md)
* [勘误](docs/勘误.md)
* [吐槽](docs/吐槽.md)
* [附录-术语表](docs/附录-术语表.md)
* [参考资料](docs/参考资料.md)
* [Linux内核模型机-演示内核工作原理](docs/Linux内核模型机-演示内核工作原理/Linux内核模型机-演示内核工作原理.md)
* [操作系统为什么那么难](docs/操作系统为什么那么难/操作系统为什么那么难.md)
* [内存管理为什么那么难](docs/内存管理为什么那么难/内存管理为什么那么难.md)
* [如何降低OS入门门槛](docs/如何降低OS入门门槛/如何降低OS入门门槛.md)

## 该书简介

本书讲述了一个64位多核操作系统的自制过程。此操作系统自制过程是先从虚拟平台构筑起一个基础框架，随后再将基础框架移植到物理平台中进行升级、完善与优化。为了凸显64位多核操作系统的特点，物理平台选用搭载着**Intel Core-i7**处理器的笔记本电脑。与此同时，本书还将Linux内核的源码精髓、诸多官方白皮书以及多款常用协议浓缩于其中，可使读者在读完本书后能够学以致用，进而达到理论联系实际的目的。

本书既适合在校学习理论知识的初学者，又适合在职工作的软件工程师或有一定基础的业余爱好者。

## 作者简介

![1528023934602.png](image/1528023934602.png)

一个执着研究操作系统内核的骨灰级程序员，希望在这里找到可以一起讨论的朋友，共同进步。

如果有可能，为什么我们不做一个中国版的linux呢？

这就是我写《一个64位操作系统的实现》的初衷。不求改变世界，但求，可以帮助在学习《操作系统》这门课程上艰难前行的同志们。

**失败不可怕，害怕失败才真正可怕；当你意识到失败只是弯路，那么你就已经走在成功的直道上了。**

## 该书特点

1. 基于Intel Core i7处理器的64位多核操作系统
2. 引入诸多Linux内核的设计精髓
3. 既可在Bochs虚拟机中执行，又可通过U盘引导运行于台式机、笔记本电脑

## 技术交流

### QQ群：144571173

![20190822_120729_91](image/20190822_120729_91.png)

* 《一个64位操作系统的设计与实现》交流群
* 群主即为该书作者，有问题直接怼他就行
* 不需要添加好友瞎逼逼

### QQ群：148177180

![1528023577132.png](image/1528023577132.png)

* 《操作系统真象还原》交流群

### QQ群：361934810

![20190822_121204_11](image/20190822_121204_11.png)

* 《大话计算机》交流群