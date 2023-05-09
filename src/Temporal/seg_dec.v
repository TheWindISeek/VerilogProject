/*
 * @Author: TheWindISeek FAIZ030612@163.com
 * @Date: 2023-05-09 16:23:33
 * @LastEditors: TheWindISeek FAIZ030612@163.com
 * @LastEditTime: 2023-05-09 16:32:38
 * @FilePath: \VerilogProject\src\seg_dec.v
 * @Description: 七段码译码器
 */

 module seg_dec (
    num,
    a_g
 );
    
    input[3:0] num;
    output[6:0] a_g;//->{a,b,c,d,e,f,g}

reg [6:0]  a_g;
always @(num) begin
    case (num)
        4'd0:begin
            a_g <= 7'b111_1110;
        end 
        4'd1:begin
            a_g <= 7'b011_0000;
        end 
        4'd2:begin
            a_g <= 7'b110_1110;
        end 
        4'd3:begin
            a_g <= 7'b111_1001;
        end 
        4'd4:begin
            a_g <= 7'b011_0011;
        end 
        4'd5:begin
            a_g <= 7'b101_0011;
        end 
        4'd6:begin
            a_g <= 7'b101_1111;
        end
        4'd7:begin
            a_g <= 7'b111_0000;
        end 
        4'd8:begin
            a_g <= 7'b111_1111;
        end 
        4'd9:begin
            a_g <= 7'b111_1011;
        end   
        default: 
        begin
            a_g <= 7'b000_0001;//中杠显示超过的
        end
    endcase
end

 endmodule

 