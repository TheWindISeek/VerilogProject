/*
 * @Author: TheWindISeek FAIZ030612@163.com
 * @Date: 2023-05-09 19:12:06
 * @LastEditors: TheWindISeek FAIZ030612@163.com
 * @LastEditTime: 2023-05-09 19:14:57
 * @FilePath: \VerilogProject\src\Examples\D.v
 * @Description: D触发器
 */

module dff (
    input       clk,
    input       din,
    output reg  q
);
always @(posedge clk) begin
    q <= din;
end

endmodule