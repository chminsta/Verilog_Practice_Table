module MIPS_5stage(
    input clk, rst_n,
    output branch,
    output [31:0] R1, R4, R6, R9,
    output [31:0] mem_16,
    output [31:0] ALUResult_EX,
    output [31:0] Rdata_MEM
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
// Control Signal vector which is ordered in the way that MSB is used first
// 8-7 : ALUOp, 6: ALUSrc, 5: RegDst / 4: Branch, 3: MemRead, 2: MemWrite / 1: RegWrite, 0: MemtoReg
//MemtoReg// 1: output of data memory be write data input of register, 0: output of ALU go to  write data input of register. can be 'x'
//RegWrite// 1: use write register of register file
//MemWrite// 1: data write to data memory
//MemRead// 1: data read from data memory
//Branch// 1: branch operation
//RegDst// 1: rd field be used to be register input , 0: rt field be used to be register input. can be 'x'
//ALUSrc// 1: second source is immediate value of sign_extended , 0: second source is register2 of register file
//[1:0] ALUOp // 2bit control to ALU

//wire for EX//
wire [8:0] EX_ControlSignal;
wire [31:0] EX_PCnext, EX_Rdata1, EX_Rdata2, EX_SignedImme;
wire [4:0] EX_rt, EX_rd;
wire zero_EX;
//output wire [31:0] ALUResult_EX;

//wire for MEM//
wire [4:0] MEM_ControlSignal; 
wire MEM_zero;
wire [31:0] MEM_Branchaddr, MEM_ALUResult, MEM_Wdata;
wire [4:0] MEM_RegDst;
//output wire [31:0] Rdata_MEM;

//wire for WB//
wire [1:0] WB_ControlSignal;
wire [31:0] WB_Rdata, WB_ALUResult;
wire [4:0] WB_RegDst;
wire [31:0] Wdata;
//////////////////

assign Wdata = (WB_ControlSignal[0])? WB_Rdata:WB_ALUResult;
assign branch = MEM_ControlSignal[4] && MEM_zero;

fetch IF(clk, rst_n, branch, MEM_Branchaddr, PCnext_IF, Inst_IF);
IF_ID FF1(clk, rst_n, PCnext_IF, Inst_IF, ID_PCnext, ID_Inst);

ControlUnit CONTROL(ID_Inst[31:26], ControlSignal_ID);
Reg_File REG_FILE(clk, rst_n, WB_ControlSignal[1], ID_Inst[25:21], ID_Inst[20:16], WB_RegDst, 
        Wdata, Rdata1_ID, Rdata2_ID, R1, R4, R6, R9);
sign_extend SIGN_EX(ID_Inst[15:0], SignedImme_ID);
ID_EX FF2(clk, rst_n, ControlSignal_ID, ID_PCnext, Rdata1_ID, Rdata2_ID, SignedImme_ID, ID_Inst[20:16], ID_Inst[15:11],
        EX_ControlSignal, EX_PCnext, EX_Rdata1, EX_Rdata2, EX_SignedImme, EX_rt, EX_rd);

Execute EXE(EX_Rdata1, (EX_ControlSignal[6])?EX_SignedImme:EX_Rdata2, EX_ControlSignal[8:7], EX_SignedImme[5:0], ALUResult_EX, zero_EX);
EX_MEM FF3(clk, rst_n, EX_ControlSignal[4:0], zero_EX, EX_PCnext + (EX_SignedImme<<2), ALUResult_EX, EX_Rdata2, (EX_ControlSignal[5])?EX_rd:EX_rt,
        MEM_ControlSignal, MEM_zero, MEM_Branchaddr, MEM_ALUResult, MEM_Wdata, MEM_RegDst);

Data_memory data_mem(clk, rst_n, MEM_ControlSignal[2], MEM_ControlSignal[3], MEM_ALUResult, MEM_Wdata, Rdata_MEM, mem_16);
MEM_WB FF4(clk, rst_n, MEM_ControlSignal[1:0], Rdata_MEM, MEM_ALUResult, MEM_RegDst,
        WB_ControlSignal, WB_Rdata, WB_ALUResult, WB_RegDst);

endmodule