`timescale 1ns/10ps
module EXECUTE(
    input [3:0] EX_ControlSignal,
    input [31:0] EX_Rdata1, EX_Rdata2,
    input [31:0] EX_SignImme,
    input [1:0] EX_FWA, EX_FWB,
    input [31:0] FWdata_WB, FWdata_MEM,
    output [31:0] ALUResult_EX, Wdata_EX
);
wire [31:0] MX_A;
MUX3 MX_1(EX_FWA, EX_Rdata1, FWdata_WB, FWdata_MEM, MX_A);
MUX3 MX_2(EX_FWB, EX_Rdata2, FWdata_WB, FWdata_MEM, Wdata_EX);

ALU ALU_EX(MX_A, (EX_ControlSignal[0])?EX_SignImme:Wdata_EX, EX_ControlSignal[3:1], ALUResult_EX);
endmodule