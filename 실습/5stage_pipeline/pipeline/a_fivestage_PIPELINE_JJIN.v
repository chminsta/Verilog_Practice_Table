module MIPS_pipeline (
    input i_clk,
    input i_rstn,
    output [31:0] ALUresult,
    output [31:0] Instruction,
    output [31:0] Read_Data1,
    output [31:0] Read_Data2,
    output [4:0] Reg_Dst
);
//[1]fetch-----------------------------------------------------------------------------------------------------------------------------------------------------------
//(a)wires
    wire [31:0] PCplus4_IF; //(PC+4) ,o_PC -> i_PCplus4
    wire [31:0] Instruction_IF; //instruction ,o_instruction -> i_instruction
//(b)fetch
    fetch f(i_clk, i_rstn, (Branch_MEM & zero_MEM) , PCbranch_MEM, Instruction_IF, PCplus4_IF);
//(c)flip-flop
    IF_ID fd(i_clk, i_rstn, PCplus4_IF, Instruction_IF, PCplus4_ID, Instruction_ID);


//[2]decode-----------------------------------------------------------------------------------------------------------------------------------------------------------
//(a)wires
    wire [31:0] Instruction_ID; // 0_instruction -> [5:0] Control_Unit [5:0] op ,[10:6], [15:11] register_file R_reg1, R_reg2
    wire [31:0] PCplus4_ID; //0_PCplus4 -> ID/EX pipeline
    wire [31:0] Immediate_ID;//Control_Unit -> ID/EX pipeline
    wire MemtoReg_ID; // Control_Unit -> ID/EX pipeline i_MemtoReg
    wire MemWrite_ID; // Control_Unit -> ID/EX pipeline i_MemWrite
    wire MemRead_ID; // Control_Unit -> ID/EX pipeline i_MemRead
    wire Branch_ID; // Control_Unit -> ID/EX pipeline i_Branch
    wire ALUSrc_ID; // Control_Unit -> ID/EX pipeline i_ALUSrc
    wire RegDst_ID; // Control_Unit -> ID/EX pipeline i_RegDst
    wire RegWrite_ID; // Control_Unit -> ID/EX pipeline 
    wire [1:0] ALUOp_ID; // Control_Unit -> ID/EX pipeline
    wire [31:0] Rdata1_ID; //register_file R_data1 -> ID/EX pipeline
    wire [31:0] Rdata2_ID; //register_file R_data2 -> ID/EX pipeline
//(b)decode
    Control_Unit cu(Instruction_ID[31:26], MemtoReg_ID, MemWrite_ID, MemRead_ID, Branch_ID, ALUSrc_ID, RegDst_ID, RegWrite_ID, ALUOp_ID);
    register_file rf(i_clk, i_rstn, RegWrite_ID, Instruction_ID[25:21], Instruction_ID[20:16], Reg_Dst, Write_data_WB, Rdata1_ID, Rdata2_ID);
    sign_extent se(Instruction_ID[15:0], Immediate_ID);
//(c)flip-flop
    ID_EX idex(i_clk, i_rstn, MemRead_ID, MemWrite_ID, MemRead_ID, Branch_ID, ALUSrc_ID, RegDst_ID, RegWrite_ID, ALUOp_ID, PCplus4_ID, Rdata1_ID, Rdata2_ID,
    Immediate_ID, Instruction_ID[20:16], Instruction_ID[15:11], MemtoReg_EX, MemWrite_EX, MemRead_EX, Branch_EX, ALUSrc_EX, Reg_Dst_EX, RegWrite_EX, ALUop_EX,
    PCplus4_EX, Rdata1_EX, Rdata2_EX, Immediate_EX, Reg_Dst1_EX, Reg_Dst2_EX);


//[3]Execution-----------------------------------------------------------------------------------------------------------------------------------------------------------
//(a)wires
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
//(b)execution
    ALU_Control ac(ALUop_EX, Immediate_EX[5:0], ALUctrl_EX);
    ALU a(Rdata1_EX, Rdata2_EX, ALUctrl_EX, ALUresult_EX, zero_EX);
//(c)flip-flop  
    EX_MEM em(i_clk, i_rstn, MemtoReg_EX, MemRead_EX, MemWrite_EX, Branch_EX, RegWrite_EX, zero_EX,((Immediate_EX<<2)+PCplus4_EX), 
    ALUresult_EX, Rdata2_EX, RegDst_EX?Reg_Dst1_EX:Reg_Dst2_EX, MemtoReg_MEM, MemRead_MEM, MemWrite_MEM, Branch_MEM, RegWrite_MEM, 
    zero_MEM, PCbranch_MEM, ALUresult_MEM, MemWriteData_MEM, Reg_Dst_MEM);

//[4]Memory-----------------------------------------------------------------------------------------------------------------------------------------------------------
//(a)wires
    wire MemtoReg_MEM;  //다음pipeline
    wire MemRead_MEM;   /////////////////
    wire MemWrite_MEM;  ////////////////
    wire Branch_MEM;    //PCSrc_WB = Branch_MEM & zero_MEM
    wire zero_MEM;   
    wire RegWrite_MEM;  //다음pipeline
    wire signed [31:0] ALUresult_MEM;  //Memaddr, 다음 pipeline
    wire [31:0] MemWriteData_MEM; //MemWriteData
    wire [4:0] Reg_Dst_MEM; //다음 pipeline
    wire [31:0] MemReadData_MEM; //
    wire [31:0] PCbranch_MEM; //Branch Address ,imm_PC
//(b)memory
    Data_memory dm(i_clk, i_rstn, MemWrite_MEM, MemRead_MEM, ALUresult_MEM, MemWriteData_MEM, MemReadData_MEM);
//(c)flip-flop
    MEM_WB mw(i_clk, i_rstn, MemtoReg_MEM, RegWrite_MEM, MemReadData_MEM, ALUresult_MEM, Reg_Dst_MEM, MemtoReg_WB, RegWrite_WB, Rdata_WB, ALUresult_WB, Reg_Dst_WB);


//[5]Writeback-----------------------------------------------------------------------------------------------------------------------------------------------------------
//(a)wires
    wire MemtoReg_WB;
    wire RegWrite_WB;
    wire [31:0] Rdata_WB;
    wire [31:0] ALUresult_WB;
    wire [4:0] Reg_Dst_WB;
    wire [31:0] Write_data_WB; //MEM reg [31:0] MemReadData -> register_file [31:0] W_data
//(b)wb   
    mux mux4(ALUresult, MemReadData, MemtoReg, Write_data_WB);

//EZ
   
endmodule