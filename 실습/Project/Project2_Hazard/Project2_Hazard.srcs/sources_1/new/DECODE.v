`timescale 1ns/10ps
module DECODE(
    input clk, rst_n,
    input [31:0] ID_Inst,
    input RegWrite,
    input [31:0] W_Data,
    input [4:0] RegDst,
    output [8:0] ControlSignal_ID,
    output [31:0] Rdata1_ID, Rdata2_ID,
    output [31:0] SignImme_ID,
    output [31:0] R1, R4, R8
);

ControlUnit CU_ID(ID_Inst[31:26], ID_Inst[5:0], ControlSignal_ID);
Reg_File RF_ID(clk, rst_n, RegWrite, ID_Inst[25:21], ID_Inst[20:16], RegDst, W_Data, Rdata1_ID, Rdata2_ID, R1, R4, R8);
SignExtend SIGNEX_ID(ID_Inst[15:0], SignImme_ID);

endmodule