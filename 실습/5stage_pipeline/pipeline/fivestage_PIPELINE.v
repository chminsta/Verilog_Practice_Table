module MIPS_pipeline (
    input i_clk,
    input i_rstn,
    output [31:0] ALUresult,
    output [31:0] Instruction,
    output [31:0] Read_Data1,
    output [31:0] Read_Data2,
    output [4:0] Reg_Dst
);
    //IF
/////////////////////////////////////////
//    module fetch (
//    input i_clk, i_rstn, PCSrc,
//    input [31:0] imm_PC,
//    output [31:0] o_instruction, o_PC
//);
//  wire[31:0] i_PC;
//  wire[31:0] PC_out;
//////////////////////////////////////////

    wire [31:0] PCin_IF //i_PC
    wire [31:0] PCout_IF; //PC_out
    wire [31:0] PCplus4_IF; //(PC+4) ,o_PC -> i_PCplus4
    wire [31:0] PCbranch_MEM; //Branch Address ,imm_PC
    wire [31:0] Instruction_IF; //instruction ,o_instruction -> i_instruction
    wire PCSrc_WB;   //Control signal ,PCSrc

///////////////////////////////////////
//  #IF_ID_pipeline
//    input i_clk, i_rstn,
//    input[31:0] i_PCplus4, i_instruction,
//    output reg [31:0] 0_PCplus4,
//    output reg [31:0] 0_instruction
//////////////////////////////////////////

    //ID
    wire [31:0] Instruction_ID; // 0_instruction
    wire [31:0] PCplus4_ID; //0_PCplus4 -> 
    wire [31:0] Immediate_ID;
    wire MemtoReg_ID;
    wire MemWrite_ID;
    wire MemRead_ID;
    wire Branch_ID;
    wire ALUSrc_ID;
    wire RegDst_ID;
    wire RegWrite_ID;
    wire [1:0] ALUOp_ID;
    wire [31:0] Write_data_WB;
    wire [31:0] Rdata1_ID;
    wire [31:0] Rdata2_ID;
    
    //EX
    
endmodule