module MEM_WB(
    input clk, rst_n,
    input [1:0] i_ControlSignal,
    // 8-7 : ALUOp, 6: ALUSrc, 5: RegDst / 4: Branch, 3: MemRead, 2: MemWrite / 1: RegWrite, 0: MemtoReg
    input [31:0] i_Rdata, i_ALUresult,
    input [4:0] i_RegDst,
    output reg [1:0] o_ControlSignal,
    output reg [31:0] o_Rdata, o_ALUresult,
    output reg [4:0] o_RegDst
);

always @(posedge clk, negedge rst_n) begin
if(!rst_n) 
    {o_ControlSignal, o_Rdata, o_ALUresult, o_RegDst} <= 71'b0;
else
    {o_ControlSignal, o_Rdata, o_ALUresult, o_RegDst} 
    <= {i_ControlSignal, i_Rdata, i_ALUresult, i_RegDst};
end
endmodule