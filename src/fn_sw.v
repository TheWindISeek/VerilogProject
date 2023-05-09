/*
采用?:实现组合逻辑
*/


`timescale 1ns/10ps
module  fu_sw (
    a,
    b,
    sel,
    y
);
    input a;
    input b;
    input sel;
    output y;

assign y <= sel ? (a&b) : (a^b);
endmodule

module fn_sw_tb;
//为了在testbench 中改变变量的值 输入需要定义为reg型 输出要定义为wire型
reg aa, bb;
reg sel;

wire y;

fn_sw fn_sw(
    .a(aa),.b(bb),
    .sel(sel),
    .y(y)
);

initial begin
        a <= 0; 
        b <= 0;
        sel <= 0;
    #10
        a <= 0;
        b <= 0;
        sel <= 1;
    #10
        a <= 0;
        b <= 1;
        sel <= 0;
    #200
        $stop;
end