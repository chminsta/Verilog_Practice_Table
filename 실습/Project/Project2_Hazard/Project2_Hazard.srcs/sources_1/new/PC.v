`timescale 1ns/10ps
module PC(
    input clk, // clk signal using when positive edge
    input rst_n, // reset when 0
    input IF_Stall, // stall when 1
    input [31:0] PC_in, // next instruction adderss
    output reg [31:0] PC_out // current instruction adderss
);

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n) PC_out <= 0;
    else if(IF_Stall) PC_out <= PC_out;
    else PC_out <= PC_in;
end
endmodule