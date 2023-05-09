/*
 * @Author: TheWindISeek FAIZ030612@163.com
 * @Date: 2023-05-09 19:14:51
 * @LastEditors: TheWindISeek FAIZ030612@163.com
 * @LastEditTime: 2023-05-09 19:17:32
 * @FilePath: \VerilogProject\src\Examples\D copy.v
 * @Description: 带复位的D触发器
 */
module dff (
    input       clk,
    input       rst,
    input       din,
    output reg  q
);
always @(posedge clk) begin
    if(rst) 
    begin
        q <= 1'b0;
    end
    else 
    begin
        q <= din;
    end
end

endmodule