/*
使用always语句配合case语句实现组合逻辑

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
    input[1:0] sel;
    output y;

// assign y <= sel ? (a&b) : (a^b);
//用always语句块实现组合逻辑

reg y;

//敏感变量一定要写全 否则会出现match
always @(a or b or sel) begin
    // if (sel == 1) begin
    //     y <= a & b;
    // end
    // else begin
    //     y <= a ^ b;
    // end
    case (sel)
       2'b00 : begin
        y <= a & b;
       end 
       2'b01 : begin
        y <= a | b;
       end
       2'b10 : begin
        y <= a ^ b;
       end
       2'b11 : begin
        y <= ~(a ^ b);
       end
        default: 
    endcase
end

endmodule

module fn_sw_tb;
//为了在testbench 中改变变量的值 输入需要定义为reg型 输出要定义为wire型
// reg aa, bb;
// reg[1:0] sel;
reg[3:0] absel;

wire y;

fn_sw fn_sw(
    //低0位给a 低1位给b 高两位给sel
    .a(absel[0]),.b(absel[1]),
    .sel(absel[3:2]),
    .y(y)
);

initial begin

    absel <= 0;

    #200
        $stop;
end

//没过10ns就加1
always #10 absel <= absel + 1;


endmodule