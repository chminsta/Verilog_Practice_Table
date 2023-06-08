module EX_MEM(
    input clk, rst_n,
    input [4:0] i_ControlSignal,
    // 8-7 : ALUOp, 6: ALUSrc, 5: RegDst / 4: Branch, 3: MemRead, 2: MemWrite / 1: RegWrite, 0: MemtoReg
    input i_zero,
    input [31:0] i_Branchaddr, i_ALUResult, i_Rdata2,
    input [4:0] i_RegDst,
    output reg [4:0] o_ControlSignal,
    output reg o_zero,
    output reg [31:0] o_Branchaddr, o_ALUResult, o_Wdata,
    output reg [4:0] o_RegDst
);

always @(posedge clk, negedge rst_n) begin
if (!rst_n)
    {o_ControlSignal, o_zero, o_Branchaddr, o_ALUResult, o_Wdata, o_RegDst} <= 107'b0;
else
    {o_ControlSignal, o_zero, o_Branchaddr, o_ALUResult, o_Wdata, o_RegDst} 
    <= {i_ControlSignal, i_zero, i_Branchaddr, i_ALUResult, i_Rdata2, i_RegDst};
end
endmodule