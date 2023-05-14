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
    wire [31:0] PCin_IF //PC
    wire [31:0] PCout_IF; //PC output
    wire [31:0] PCplus4_IF; //PC+4
    wire [31:0] PCbranch_MEM; //Branch Address
    wire [31:0] Instruction_IF; //instruction
    wire    PCSrc_WB;   //Control signal

    //ID
    wire [31:0] Instruction_ID;
    wire [31:0] PCplus4_ID;
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