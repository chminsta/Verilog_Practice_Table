module MIPS_pipeline (
    input i_clk,
    input i_rstn,
    output [31:0] ALUresult,
    output [31:0] Instruction,
    output [31:0] Read_Data1,
    output [31:0] Read_Data2,
    output [4:0] Reg_Dst
);

/////////////////////////////////////////
//  #IF
//    module fetch (
//    input i_clk, i_rstn, PCSrc,
//    input [31:0] imm_PC,
//    output [31:0] o_instruction, o_PC
//);
//  wire[31:0] i_PC;
//  wire[31:0] PC_out;
//////////////////////////////////////////

//    wire [31:0] PCin_IF //i_PC
//    wire [31:0] PCout_IF; //PC_out
    wire [31:0] PCplus4_IF; //(PC+4) ,o_PC -> i_PCplus4
    wire [31:0] PCbranch_MEM; //Branch Address ,imm_PC
    wire [31:0] Instruction_IF; //instruction ,o_instruction -> i_instruction
    //wire PCSrc_WB;   //Control signal ,PCSrc = Branch_MEM & zero_MEM

    fetch f(i_clk, i_rstn, (Branch_MEM & zero_MEM) , PCbranch_MEM, Instruction_IF, PCplus4_IF);
///////////////////////////////////////
//  #IF_ID_pipeline
//    input i_clk, i_rstn,
//    input[31:0] i_PCplus4, i_instruction,
//    output reg [31:0] 0_PCplus4,
//    output reg [31:0] 0_instruction
//////////////////////////////////////////
    IF_ID fd(i_clk, i_rstn, PCplus4_IF, Instruction_IF, PCplus4_ID, Instruction_ID);
//
//  #ID
//module Control_Unit (
//    input [5:0] op,
//    output reg MemtoReg, MemWrite, MemRead, Branch, 
//    output reg ALUSrc, RegDst, RegWrite,
//    output reg [1:0] ALUOp
//
    Control_Unit cu(Instruction_ID[31:26], MemtoReg_ID, MemWrite_ID, MemRead_ID, Branch_ID, ALUSrc_ID, RegDst_ID, RegWrite_ID, ALUOp_ID);
//);/////////////////////////////////////////////////////////////
//module register_file(
//	input clk,				
//	input rstn,
//	input RegWrite,            //control signal 
//	input [4:0] R_reg1,        //read register1
//	input [4:0] R_reg2,	       //read register2
//	input [4:0] W_reg,		   //write register	
//	input [31:0] W_data,	   //write data
//	output [31:0] R_data1, //read data1
//	output [31:0] R_data2  //read data2
//);
//	reg [31:0] reg_file [0:31];
//	integer i;
//////////////////////////////////////////////////////////////
    register_file rf(i_clk, i_rstn, RegWrite_ID, Instruction_ID[25:21], Instruction_ID[20:16], Reg_Dst, Write_data_WB, Rdata1_ID, Rdata2_ID);
//module sign_extent (
//   input [15:0] imm_value,
//    output [31:0] result
//);
    sign_extent se(Instruction_ID[15:0], Immediate_ID);
/////////////////////////////맞는지 몰겟음************************************

    wire [31:0] Instruction_ID; // 0_instruction -> [5:0] Control_Unit [5:0] op ,[10:6], [15:11] register_file R_reg1, R_reg2
    wire [31:0] PCplus4_ID; //0_PCplus4 -> ID/EX pipeline
    wire [31:0] Immediate_ID;//Control_Unit -> ID/EX pipeline
    wire MemtoReg_ID; // Control_Unit -> ID/EX pipeline i_MemtoReg
    wire MemWrite_ID; // Control_Unit -> ID/EX pipeline i_MemWrite
    wire MemRead_ID; // Control_Unit -> ID/EX pipeline i_MemRead
    wire Branch_ID; // Control_Unit -> ID/EX pipeline i_Branch
    wire ALUSrc_ID; // Control_Unit -> ID/EX pipeline i_ALUSrc//////////////////////
    wire RegDst_ID; // Control_Unit -> ID/EX pipeline i_RegDst/////////////////////////
    wire RegWrite_ID; // Control_Unit -> ID/EX pipeline 
    wire [1:0] ALUOp_ID; // Control_Unit -> ID/EX pipeline//////////////////////////
    wire [31:0] Write_data_WB; //MEM reg [31:0] MemReadData -> register_file [31:0] W_data
    wire [31:0] Rdata1_ID; //register_file R_data1 -> ID/EX pipeline
    wire [31:0] Rdata2_ID; //register_file R_data2 -> ID/EX pipeline
    

    /////창민아 너 여기까지 했고 idex 해야되는데 wire가 개판이라서 이름 다시 만들고 idex에 넣는거 부터 시작하면 돼
    /////넌 할 수 있어! 파이팅! 오예
    
///////////////////////////////////////////////////
//ID_EX pipeline register
//module ID_EX(
//input i_clk, i_rstn, i_MemtoReg,
//input i_MemWrite, i_MemRead,
//input i_Branch, i_ALUSrc,
//input i_RegDst, i_RegWrite,
//input [1:0] i_ALUOP, 
//input [31:0] i_PCplus4, 
//input [31:0] i_Rdata1, 
//input [31:0] i_Rdata2,
//input [31:0] i_signextImmediate,
//input [4:0] i_RegDst1,
//input [4:0] i_RegDst2,
//output reg o_MemtoReg,
//output reg o_MemWrite,
//output reg o_MemRead
//output reg o_Branch,
//output reg o_ALUSrc,
//output reg o_RegDst,
//output reg o_RegWrite,
//output reg [1:0] o_ALUOP,
//output reg [31:0] o_PCplus4,
//output reg [31:0] o Rdatal,
//output reg [31:0] o Rdata2,
//output reg [31:0] o_signextImmediate,
//output reg [4:0] o_RegDst1,
//output reg [4:0] o_RegDst2
//);

    ID_EX idex(i_clk, i_rstn, MemRead_ID, MemWrite_ID, MemRead_ID, Branch_ID, ALUSrc_ID, RegDst_ID, RegWrite_ID, ALUOp_ID, PCplus4_ID, Rdata1_ID, Rdata2_ID,
    Immediate_ID, Instruction_ID[20:16], Instruction_ID[15:11], MemtoReg_EX, MemWrite_EX, MemRead_EX, Branch_EX, ALUSrc_EX, Reg_Dst_EX, RegWrite_EX, ALUop_EX,
    PCplus4_EX, Rdata1_EX, Rdata2_EX, Immediate_EX, Reg_Dst1_EX, Reg_Dst2_EX);

    ALU_Control ac(ALUop_EX, Immediate_EX[5:0], ALUctrl_EX);
    ALU a(Rdata1_EX, Rdata2_EX, ALUctrl_EX, ALUresult_EX, zero_EX);
///////////////////////////////////////////////
//EX
//module ALU_Control (
//    input [1:0] ALUOp,
//    input [5:0] funct,
//    output reg [3:0] ALUCtrl
//);
///////////////////////////////////////////
//module ALU (
//    input signed [31:0] a_in, b_in,
//    input [3:0] ALUCtrl,
//    output reg signed [31:0] result,
//    output zero
//);


    wire RegDst_EX;
    wire ALUSrc_EX;
    wire [31:0] Immediate_EX;
    wire [1:0] ALUop_EX;
    wire [3:0] ALUctrl_EX;

    wire zero_EX;
    wire MemtoReg_EX;
    wire MemRead_EX;
    wire MemWrite_EX;
    wire Branch_EX;
    wire RegWrite_EX;
    wire signed [31:0] ALUresult_EX;
    wire signed [31:0] Rdata1_EX;
    wire signed [31:0] Rdata2_EX;
    wire [4:0] Reg_Dst1_EX;
    wire [4:0] Reg_Dst2_EX
    wire [31:0] PCplus4_EX;
    
    EX_MEM em(i_clk, i_rstn, MemtoReg_EX, MemRead_EX, MemWrite_EX, Branch_EX, RegWrite_EX, zero_EX,((Immediate_EX<<2)+PCplus4_EX), 
    ALUresult_EX, Rdata2_EX, RegDst_EX?Reg_Dst1_EX:Reg_Dst2_EX, MemtoReg_MEM, MemRead_MEM, MemWrite_MEM, Branch_MEM, RegWrite_MEM, 
    zero_MEM, PCbranch_MEM, ALUresult_MEM, MemWriteData_MEM, Reg_Dst_MEM);

    wire MemtoReg_MEM;  //다음pipeline
    wire MemRead_MEM;   /////////////////
    wire MemWrite_MEM;  ////////////////
    wire Branch_MEM;    //Branchaddr, zero랑 and 해서 PCSrc_WB
    //PCSrc_WB = Branch_MEM & zero_MEM
    wire RegWrite_MEM;  //다음pipeline
    wire zero_MEM;    //
    //wire [31:0] PCbranch_MEM; Fetch_mux로 보냄
    wire signed [31:0] ALUresult_MEM;  //Memaddr, 다음 pipeline
    wire [31:0] MemWriteData_MEM; //MemWriteData
    wire [4:0] Reg_Dst_MEM; //다음 pipeline
    wire [31:0] MemReadData_MEM; //

    Data_memory dm(i_clk, i_rstn, MemWrite_MEM, MemRead_MEM, ALUresult_MEM, MemWriteData_MEM, MemReadData_MEM);

/////////////////////////////////////////////////////
//module EX_MEM(
//output reg o_MemtoReg,
//output reg o_MemRead,
//output reg o_MemWrite,
//output reg o_Branch,
//output reg o_RegWrite,
//output reg o_Zero,
//output reg [31:0] o_BranchAddr,
//output reg [31:0] o_ALUresult,
//output reg [31:0] o_Rdata2,
//output reg [4:0] o_Reg_Dst
//);
////////////////////////////////////////////////
//module Data_memory (
//    input i_clk, i_rstn, MemWrite, MemRead,
//    input [31:0] Memaddr, MemWriteData
//    output reg [31:0] MemReadData
//);
////////////////////////////////////////////////

    MEM_WB mw(i_clk, i_rstn, MemtoReg_MEM, RegWrite_MEM, MemReadData_MEM, ALUresult_MEM, Reg_Dst_MEM, MemtoReg_WB, RegWrite_WB, Rdata_WB, ALUresult_WB, Reg_Dst_WB);
    wire MemtoReg_WB;
    wire RegWrite_WB;
    wire [31:0] Rdata_WB;
    wire [31:0] ALUresult_WB;
    wire [4:0] Reg_Dst_WB;
///////////////////////////////////////////////////
//MEM WB pipeline register
//module MEM WB (
//input i_clk
//input i_rstn,
//input i_MemtoReg,
//input i_RegWrite,
//input [31:0] i_Rdata, //data memory
//input [31:0] i_ALUresult,
//input [4:0] i_Reg_Dst,
//output reg o_MemtoReg,
//output reg o_RegWrite,
//output reg [31:0] o_Rdata, //data memory
//output reg [31:0] o__ALUresult,
//output reg [4:0] o_Reg_Dst
//);
///////////////////////////////////////////////////

    //wire [31:0] Write_data_WB;
    //mux(0[32],1[32],src,결과[32])
    
    mux mux4(ALUresult, MemReadData, MemtoReg, Write_data_WB);


   
endmodule