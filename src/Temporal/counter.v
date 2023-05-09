/*
 * @Author: TheWindISeek FAIZ030612@163.com
 * @Date: 2023-05-09 16:35:13
 * @LastEditors: TheWindISeek FAIZ030612@163.com
 * @LastEditTime: 2023-05-09 16:43:44
 * @FilePath: \VerilogProject\src\counter.v
 * @Description: 计数器
 */
 `timescale 1ns/10ps
module counter (
    clk,
    res,
    y
);
    input clk;
    input res;
    output[7:0] y;

    reg [7:0] y;//在always中赋值的一定要用触发器

    // wire [7:0]  sum;//+1运算的结果

    // assign sum = y+1;//组合逻辑部分

    always @(posedge clk or negedge res) begin
        if(~res) begin
            y <= 0;
        end
        else begin
            y <= y + 1;
        end
    end
endmodule

//test bench of counter 

module counter_tb;

reg clk, res;
wire[7:0] y;

counter counter (
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