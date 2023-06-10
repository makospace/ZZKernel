# writing-a-simple-operating-system-from-scratch
从零开始写一个简单的操作系统

该代码是我在学习Nick Blundel的PDF教程时按照教程编写的，分享出来，供OS爱好者参考。

原[PDF教程][pdf]，作者：英国伯明翰大学计算机学院教师 Nick Blundell。

我的[中文翻译版本][translate]，[或看这里][translate2]

编译机：

CentOS Linux 6.6 i386

```
[root@nut32 ~]# uname -a
Linux nut32.nutdomain 2.6.32-504.el6.i686 #1 SMP Wed Oct 15 03:02:07 UTC 2014 i686 i686 i386 GNU/Linux
```

编译环境：

* GNU ld version 2.20.51.0.2-5.43.el6 20100205

* GCC 4.4.7 

* NASM version 2.07

测试内核环境：

* 虚拟机：QEMU emulator version 2.2.1

* 宿主机：Mac OS X 10.10.3


[pdf]:          http://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf
[translate]:    http://xn--37q877g.cn/osdev/writing-a-simple-operating-system-from-scratch-0/
[translate2]:   http://qibing.me/osdev/writing-a-simple-operating-system-from-scratch-0/

