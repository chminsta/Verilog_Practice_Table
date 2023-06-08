`timescale 1ns/10ps

module MIPS(
    input clk, rst_n,
    output [31:0] R1, R4, R8,
    output branch,
    output PCSrc,
    output Stall,
    output [31:0] ALUResult_EX,
    output [1:0] EX_FWA, EX_FWB
);

//////// wiring protocol /////////
// XX_A : wired input of XX stage named A except IF
// A_XX : wired output of XX stage named A

//wire for IF//
wire [31:0] PCnext_IF, Inst_IF;

//wire for ID//
wire [31:0] ID_PCnext, ID_Inst;
wire [31:0] Rdata1_ID, Rdata2_ID;
wire [31:0] SignedImme_ID;
wire [8:0] ControlSignal_ID;
assign branch = ControlSignal_ID[8];
//wire PCSrc;
// Control Signal vector which is ordered in the way that MSB is used first
// 8 : Branch __ 7-5 : ALUCtrl  4: ALUSrc  3: RegDst __ 2: MemWrite __ 1: RegWrite  0: MemtoReg

//MemtoReg// 1: output of data memory be write data input of register, 0: output of ALU go to  write data input of register. can be 'x'
//RegWrite// 1: use write register of register file
//MemWrite// 1: data write to data memory
//RegDst// 1: rd field be used to be register input , 0: rt field be used to be register input. can be 'x'
//ALUSrc// 1: second source is immediate value of sign_extended , 0: second source is register2 of register file
//[2:0] ALUCtrl// 3bit control signal to ALU {(bit inverse), (ALUOp)} 00: AND 01: OR 10: ADD
//Branch// 1: branch operation

//wire for EX//
wire [7:0] EX_ControlSignal;
wire [31:0] EX_Rdata1, EX_Rdata2, EX_SignedImme;
wire [4:0] EX_Rs, EX_Rt, EX_Rd;
wire [31:0] Wdata_EX;
wire [4:0] Dst_EX;
assign Dst_EX = (EX_ControlSignal[3])?EX_Rd:EX_Rt;

//wire for MEM//
wire [2:0] MEM_ControlSignal; 
wire [31:0] MEM_ALUResult, MEM_Wdata;
wire [4:0] MEM_Dst;
wire [31:0] Rdata_MEM;

//wire for WB//
wire [1:0] WB_ControlSignal;
wire [31:0] WB_Rdata, WB_ALUResult;
wire [4:0] WB_Dst;

//wire for Hazard Detector//
//wire Stall;
wire ID_FWA, ID_FWB;
//wire [1:0] EX_FWA, EX_FWB;
//////////////////

assign PCSrc = (((ID_FWA)?MEM_ALUResult:Rdata1_ID) == ((ID_FWB)?MEM_ALUResult:Rdata2_ID)) && ControlSignal_ID[8];

FETCH IF(clk, rst_n, PCSrc, ID_PCnext + (SignedImme_ID<<2), Stall, Inst_IF, PCnext_IF);

IF_ID FF1(clk, rst_n, PCnext_IF, Inst_IF, PCSrc, Stall, ID_PCnext, ID_Inst);
DECODE ID(clk, rst_n, ID_Inst, WB_ControlSignal[1], (WB_ControlSignal[0])?WB_Rdata:WB_ALUResult, WB_Dst, 
        ControlSignal_ID, Rdata1_ID, Rdata2_ID, SignedImme_ID, R1, R4, R8);

ID_EX FF2(clk, rst_n, ControlSignal_ID[7:0], Rdata1_ID, Rdata2_ID, ID_Inst[25:21], ID_Inst[20:16], ID_Inst[15:11], SignedImme_ID, Stall,
        EX_ControlSignal, EX_Rdata1, EX_Rdata2, EX_Rs, EX_Rt, EX_Rd, EX_SignedImme);
EXECUTE EX(EX_ControlSignal[7:4], EX_Rdata1, EX_Rdata2, EX_SignedImme, EX_FWA, EX_FWB, (WB_ControlSignal[0])?WB_Rdata:WB_ALUResult, MEM_ALUResult,
        ALUResult_EX, Wdata_EX);

EX_MEM FF3(clk, rst_n, EX_ControlSignal[2:0], ALUResult_EX, Wdata_EX, (EX_ControlSignal[3])?EX_Rd:EX_Rt, 
        MEM_ControlSignal, MEM_ALUResult, MEM_Wdata, MEM_Dst);
MEM MEM_data (rst_n, MEM_ControlSignal[2], MEM_ALUResult, MEM_Wdata, Rdata_MEM);

MEM_WB FF4(clk, rst_n, MEM_ControlSignal[1:0], Rdata_MEM, MEM_ALUResult, MEM_Dst,
        WB_ControlSignal, WB_Rdata, WB_ALUResult, WB_Dst);
        
HazardControl HC(ID_Inst[25:21], ID_Inst[20:16],EX_Rs, EX_Rt, (EX_ControlSignal[3])?EX_Rd:EX_Rt, MEM_Dst, WB_Dst, ControlSignal_ID[8], EX_ControlSignal[1:0], MEM_ControlSignal[1:0], WB_ControlSignal[1:0],
        Stall, ID_FWA, ID_FWB, EX_FWA, EX_FWB);
endmodule