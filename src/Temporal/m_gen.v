/*
 * @Author: TheWindISeek FAIZ030612@163.com
 * @Date: 2023-05-09 16:45:55
 * @LastEditors: TheWindISeek FAIZ030612@163.com
 * @LastEditTime: 2023-05-09 16:55:55
 * @FilePath: \VerilogProject\src\m_gen.v
 * @Description: 伪随机码发生器
 */
`timescale 1ns/10ps

module m_gen (
    clk,
    res,
    y
);
    
    input clk;
    input res;
    output y;

    reg [3:0] d;
    assign y = d[0];

    always @(posedge clk or negedge res) begin
        if (~res) begin
            d <= 4'b1111;
        end
        else begin
            d[2:0] <= d[3:1];//右移一位
            d[3] <= d[3] + d[0];//模二加
        end
    end
endmodule

//test bench of m_gen
module m_gen_tb;

reg clk, res;
wire[3:0] y;

m_gen  m_gen (
    .clk(clk),
    .res(res),
    .y(y)
);

initial begin
    clk <= 0;//初值需要在initial中赋值
    res <= 0;
    #17
    res <= 1;
    #6000
    $stop;
end

always #5 clk <= ~clk;
endmodule