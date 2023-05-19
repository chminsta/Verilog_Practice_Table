//EX_MEM pipeline stage
module EX_MEM(
input i_clk, i_rstn, i_MemtoReg, i_MemRead,
input i_MemWrite, i_Branch, i_RegWrite, i_Zero,
input [31:0] i_BranchAddr, 
input [31:0] i_ALUresult,
input [31:0] i_Rdata2,
input [4:0] i_Reg_Dst,

output reg o_MemtoReg,
output reg o_MemRead,
output reg o_MemWrite,
output reg o_Branch,
output reg o_RegWrite,
output reg o_Zero,
output reg [31:0] o_BranchAddr,
output reg [31:0] o_ALUresult,
output reg [31:0] o_Rdata2,
output reg [4:0] o_Reg_Dst
);


always @(posedge i_clk, negedge i_rstn) begin
if(!i_rstn)
begin
o_MemtoReg <= 1'b0; 
o_MemRead <= 1'b0; 
o_MemWrite <= 1'b0; 
o_Branch <= 1'b0; 
o_RegWrite <= 1'b0; 
o_Zero <= 1'b0;
o_BranchAddr <= 32'd0;
o_ALUresult <= 32'd0;
o_Rdata2 <= 32'd0;
o_Reg_Dst <= 5'd0;
end

else begin
o_MemtoReg <= i_MemtoReg; 
o_MemRead <= i_MemRead; 
o_MemWrite <= i_MemWrite; 
o_Branch <= i_Branch;
o_RegWrite <= i_RegWrite;
o_Zero <= i_Zero;
o_BranchAddr <= i_BranchAddr;
o_ALUresult <= i_ALUresult;
o_Rdata2 <= i_Rdata2;
o_Reg_Dst <= i_Reg_Dst;
end
end
endmodule
