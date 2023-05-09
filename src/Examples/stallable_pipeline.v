/*
 * @Author: TheWindISeek FAIZ030612@163.com
 * @Date: 2023-05-09 19:44:25
 * @LastEditors: TheWindISeek FAIZ030612@163.com
 * @LastEditTime: 2023-05-09 20:03:31
 * @FilePath: \VerilogProject\src\Examples\stallable_pipeline.v
 * @Description: 带阻塞的流水线 使用D触发器中使能信号的控制完成 一级流水线向后传递信息并向前反馈 
 pipeX_valid 第X级流水的有效位
 从第X级传递给第X-1级的信号
 */

module stallable_pipeline #(
    parameter WIDTH = 100
) (
    input       clk,
    input       rst,
    input       validin,
    input[WIDTH-1:0]    datain,
    input       out_allow,
    output  validout,
    output[WIDTH-1:0]   dataout
);
    
    reg pipe1_valid;
    reg pipe2_valid;
    reg pipe3_valid;

    reg [WIDTH-1:0] pipe1_data;
    reg [WIDTH-1:0] pipe2_data;
    reg [WIDTH-1:0] pipe3_data;

    //pipeline stage1
    wire        pipe1_allowin;
    wire        pipe1_ready_go;
    wire        pipe1_to_pipe2_valid;
    assign pipe1_ready_go = 1'b1; //书中这块为 = ....
    assign pipe1_allowin = !pipe1_valid || !pipe1_ready_go && pipe2_allowin;
    assign pipe1_to_pipe2_valid = pipe1_valid && pipe1_ready_go;
    always @(posedge clk) begin
        if(rst) begin
            pipe1_valid <= 1'b0;
        end
        else if (pipe1_allowin) begin
            pipe1_valid <= validin;
        end

        if(validin && pipe1_allowin) begin
            pipe1_data <= datain;
        end
    end


    //pipeline stage2
    wire        pipe2_allowin;
    wire        pipe2_ready_go;
    wire        pipe2_to_pipe3_valid;
    assign pipe2_ready_go = 1'b1;//书中这块为 = ....
    assign pipe2_allowin = !pipe2_valid || !pipe2_ready_go && pipe3_allowin;
    assign pipe2_to_pipe3_valid = pipe2_valid && pipe2_ready_go;
    always @(posedge clk) begin
        if(rst) begin
            pipe2_valid <= 1'b0;
        end
        else if (pipe2_allowin) begin
            pipe2_valid <= pipe1_to_pipe2_valid;
        end

        if(pipe1_to_pipe2_valid && pipe2_allowin) begin
            pipe2_data <= pipe1_data;
        end
    end


    //pipeline stage3
    wire        pipe3_allowin;
    wire        pipe3_ready_go;
    assign pipe3_ready_go = 1'b1;//书中这块为 = ....
    assign pipe3_allowin = !pipe3_valid || pipe3_ready_go && out_allow;
    always @(posedge clk) begin
        if(rst) begin
            pipe3_valid <= 1'b0;
        end
        else if (pipe3_allowin) begin
            pipe3_valid <= pipe2_to_pipe3_valid;
        end

        if(pipe2_to_pipe3_valid && pipe3_allowin) begin
            pipe3_data <= pipe2_data;
        end
    end  


    assign validout = pipe3_valid && pipe3_ready_go;
    assign dadatout = pipe3_data;

endmodule