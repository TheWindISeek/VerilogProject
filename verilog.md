<!--
 * @Author: TheWindISeek FAIZ030612@163.com
 * @Date: 2023-05-09 16:56:52
 * @LastEditors: TheWindISeek FAIZ030612@163.com
 * @LastEditTime: 2023-05-09 20:51:43
 * @FilePath: \VerilogProject\verilog.md
-->
计数器设计
伪随机码发生器设计
触发器的敏感变量为时钟沿和复位沿
时序逻辑的代码结构
寄存器右移
模二加
test bench 中时钟和复位写法


要用一个变量的时候
先用他
然后去rst信号那里给他清零
然后去声明他

https://blog.csdn.net/u011816009/article/details/104228223

wire与reg变量的区别

wire 搭配 assign

reg 在时序逻辑中使用
还在初始化时使用

# 代码格式
模块实例化采用 .名字 的端口赋值方式
两个模块对接，两边的模块采用同样的名字
模块调用，按照接口顺序一一对应（直接CV代码）
所有input类接口被调用时不允许悬空

所有的always中时序逻辑只允许采用<=非阻塞赋值


# 异常处理方法
## 信号为Z
Z表示高阻
电路断路就会出现高阻
### 导致原因
1.RTL里声明的wire变量从未被赋值
2.模块调用的信号未连接导致信号悬空
    显示未调用
        .c()
    隐式未调用
        调用模块的时候忘记了还存在这个信号
        因此没有写.c()
    input和output对为赋值处理情况不一样
        output为空，可能是主模块确实不需要 它存在一个默认值
        input悬空 结果就是Z
    100ns后才为Z
        最开始就为Z说明是一开始就没有赋值
        之后才为Z说明是之后用到的时候才给其赋值 出现了这种情况
### 修改思路
一旦发现一个信号为Z，向前追溯产生该信号的因子信号，一直追踪到该模块的input接口
如果只出现在某向量信号的某几位上，这时也应该采取同样的追溯方式 如果存在宽度不匹配的问题，也会出现Z
## 信号为X
X表示不定值
### 导致原因
1.RTL声明为reg的变量从未被赋值
2.RTL里存在多驱动的代码
    assign c = a_r & b_r;
    assign c = a_r + b_r;
### 修改思路
前向追溯
因子没有X 可能是多驱动
寄存器信号没有复位值 复位阶段可能是X
X和1进行或结果为1，X和0进行与运算结果为0

## 波形停止
仿真在某一阶段停止，再也无法前进分毫，仿真还在进行
RTL中存在组合环路

仿真通过
上板失败
### 导致原因
存在环路
wire c_t;
assign c_t = a_r & b_r + c;
assign c = a_r + c_t;

### 修改思路
一旦波形停止，先对设计进行综合
查看综合产生的error和critical warning提示

## 越沿采样
被采样的信号在一个上升沿到了其上升沿后的值
```verilog
always@(posedge clk)
begin
    if(!resetn)
        a_r = 1'b0;
    else
        a_r = a;
end

always@(posedge clk)
begin
    a_r_r <= a_r;
end
```
当clk上升沿来临的时候，就会出现越沿采样的问题。
假如我们串行看待这份代码
a = 1
a_r = 0
a_r = a;
a_r_r = a_r;
那么a_r, a_r_r 都会为1
但当我们并行看待代码，其实我们期待这份代码的预期输出是a_r = 1, a_r_r = 0

造成这种情况的原因是阻塞赋值(=)与非阻塞赋值混用(<=)
a_r采用阻塞赋值
a_r_r采用非阻塞赋值

第一次赋值分为两步
1.计算等式右侧的表达式
2.赋值给左侧的信号

当一个上升沿到来时，所有由上升沿驱动的信号按以下顺序进行处理
1.先处理阻塞赋值 完成计算和赋值
    同一信号完成计算后立刻完成赋值
    同一always块里阻塞赋值从上到下按顺序串行执行
    不同always块根据工具实现确定顺序的串行执行
2.进行非阻塞赋值的计算
    对于所有非阻塞赋值
    其等式左侧的值同时计算好
3.上升沿结束时
    所有非阻塞赋值同时完成最终的赋值动作


## 波形怪异
所有想不到的波形问题都是波形怪异

观察出错的信号  分享是RTL错误还是工具错误

实在找不到是什么错误，先综合，看综合之后的error, critical warning, warning提示


# vivado 使用
## RAM
project manager -> ip catalog -> memories and storage elements -> rams & roms & bram -> block memory generator
页数66
