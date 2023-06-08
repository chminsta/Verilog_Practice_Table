module ID_EX(
    input clk, rst_n,
    input [8:0] i_ControlSignal, // 8-7 : ALUOp, 6: ALUSrc, 5: RegDst / 4: Branch, 3: MemRead, 2: MemWrite / 1: RegWrite, 0: MemtoReg
    // The order is sorted so that MSB must be firstly used each stage. 
    input [31:0] i_PCnext,
    input [31:0] i_Rdata1, i_Rdata2,
    input [31:0] i_SignedImme,
    input [4:0] i_rt, i_rd,
    output reg [8:0] o_ControlSignal,
    output reg [31:0] o_PCnext,
    output reg [31:0] o_Rdata1, o_Rdata2,
    output reg [31:0] o_SignedImme,
    output reg [4:0] o_rt, o_rd
);

always @(posedge clk, negedge rst_n) begin
if(!rst_n)
    {o_ControlSignal, o_PCnext, o_Rdata1, o_Rdata2, o_SignedImme, o_rt, o_rd} <= 142'b0;
else 
    {o_ControlSignal, o_PCnext, o_Rdata1, o_Rdata2, o_SignedImme, o_rt, o_rd} 
    <= {i_ControlSignal, i_PCnext, i_Rdata1, i_Rdata2, i_SignedImme, i_rt, i_rd};
end

endmodule