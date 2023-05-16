//ID_EX pipeline register
module ID_EX(
input i_clk, i_rstn, i_MemtoReg,
input i_MemWrite, i_MemRead,
input i_Branch, i_ALUSrc,
input i_RegDst, i_RegWrite,
input [1:0] i ALUOP, 
input [31:0] i_PCplus4, 
input [31:0] i_Rdata1, 
input [31:0] i_Rdata2,
input [31:0] i_signextImmediate,
input [4:0] i_RegDst1,
input [4:0] i_RegDst2,
output reg o_MemtoReg,
output reg o_MemWrite,
output reg o_MemRead
output reg o_Branch,
output reg o_ALUSrc,
output reg o_RegDst,
output reg o_RegWrite,
output reg [1:0] o_ALUOP,
output reg [31:0] o_PCplus4,
output reg [31:0] o_Rdatal,
output reg [31:0] o_Rdata2,
output reg [31:0] o_signextImmediate,
output reg [4:0] o_RegDst1,
output reg [4:0] o_RegDst2
);

always @(posedge i_clk, negedge i_rstn)
begin
if(!i_rstn) begin
o_MemtoReg <= 1'b0; 
o_MemWrite <= 1'b0; 
o_MemRead <= 1'b0; 
o_Branch <= 1'b0; 
o_ALUSrc <=1'b0;
o_RegDst <= 1'b0; 
o_RegWrite <= 1'b0; 
o_ALUOP <= 2'b00; 
o_PCplus4 <= 32'd0;
o_Rdatal <= 32'd0;
o_Rdata2 <= 32'd0;
o_signextImmediate <= 32'd0;
o_RegDst1<= 5'd0;
o_RegDst2 <= 5'd0;

end
else begin

o_MemtoReg <= i_MemtoReg; 
o_MemWrite <= i_MemWrite; 
o_MemRead <= i_MemRead; 
o_Branch <= i Branch; 
o_ALUSrc <= i ALUSrc; 
o_RegDst <= i_RegDst; 
o_RegWrite <= i_RegWrite; 
o_ALUOP <= i_ALUOp; 
o_PCplus4 <= i_PCplus4; 
o_Rdata1 <= i_Rdata1; 
o_Rdata2 <= i Rdata2;
o_signextImmediate <= i_signextImmediate; 
o_RegDst1 <= i_RegDst1;
o_RegDst2 <= i RegDst2;
end
end
endmodule