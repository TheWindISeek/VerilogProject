module top (
    clk,
    res,
    a_g
);
input clk;
input res;
output[6:0] a_g;
wire[3:0] s_num;
s_counter U1(
    .clk(clk),
    .res(res),
    .s_num(s_num)
);
    
seg_dec U2(
    .s_num(s_num),
    .a_g(a_g)
)
endmodule