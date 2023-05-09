/*
 * @Author: TheWindISeek FAIZ030612@163.com
 * @Date: 2023-05-09 19:12:06
 * @LastEditors: TheWindISeek FAIZ030612@163.com
 * @LastEditTime: 2023-05-09 19:19:00
 * @FilePath: \VerilogProject\src\Examples\D copy2.v
 * @Description: 带使能端的D触发器
 */

module dff (
    input       clk,
    input       en,
    input       din,
    output reg  q
);
always @(posedge clk) begin
    if(en) 
    begin
        q <= din;
    end
end

endmodule