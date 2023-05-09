/*
 * @Author: TheWindISeek FAIZ030612@163.com
 * @Date: 2023-05-09 19:28:01
 * @LastEditors: TheWindISeek FAIZ030612@163.com
 * @LastEditTime: 2023-05-09 19:31:50
 * @FilePath: \VerilogProject\src\Examples\non_stall_pipeline.v
 * @Description: 非阻塞流水线
 */

module non_stall_pipelie #(
    parameter WIDTH = 100;
) 
(
    input       clk,
    input[WIDTH-1:0]    datain,
    output[WIDTH-1:0]   dataout
);
    
reg [WIDTH-1:0] pipe1_data;
reg [WIDTH-1:0] pipe2_data;
reg [WIDTH-1:0] pipe3_data;

always @(posedge clk) begin
    pipe1_data <= datain;
end

always @(posedge clk) begin
    pipe2_data <= pipe1_data;
end

always @(posedge clk) begin
    pipe3_data <= pipe2_data;
end

assign dataout = pipe3_data;
endmodule