`timescale 1ns/10ps

module tb_MIPSS();
    reg clk, rst_n;
    wire [31:0] R1, R4, R8;
    wire branch;
    wire PCSrc;
    wire Stall;
    wire [31:0] ALU_A, ALU_B;
    wire [31:0] PC_out;
    wire [4:0] Dst_EX, MEM_Dst, WB_Dst;

MIPS MIPS_Hazard(clk, rst_n, R1, R4, R8, branch ,PCSrc, Stall, ALU_A, ALU_B, PC_out, Dst_EX, MEM_Dst, WB_Dst);

initial begin
    clk=0; rst_n=0;
    #1 rst_n=1;
    #1 rst_n=0;
    #1 rst_n=1;
    forever #1 clk=!clk;
end
endmodule