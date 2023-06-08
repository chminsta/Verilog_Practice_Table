`timescale 1ns/10ps
module FETCH(
    input clk, rst_n,
    input PCSrc,
    input [31:0] Branchaddr,
    input IF_Stall, 
    output [31:0] Inst_IF, PCnext_IF
);
wire [31:0] PC_out;

PC PC_IF(clk, rst_n, IF_Stall, (PCSrc)?Branchaddr:PCnext_IF, PC_out);
Inst_MEM IMEM_IF(rst_n, PC_out, Inst_IF);

assign PCnext_IF = PC_out + 4;

endmodule