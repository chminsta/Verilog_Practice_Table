
//MEM WB pipeline register
module MEM WB (
input i_clk
input i_rstn,
input i_MemtoReg,
input i_RegWrite,
input [31:0] i_Rdata, //data memory
input [31:0] i_ALUresult,
input [4:0] i_Reg_Dst,
output reg o_MemtoReg,
output reg o_RegWrite,
output reg [31:0] o_Rdata, //data memory
output reg [31:0] o__ALUresult,
output reg [4:0] o_Reg_Dst
);

always @(posedge i_clk, negedge i_rstn) begin
if(!i rstn)
begin
o_MemtoReg <= 1'b0;
o_RegWrite <= 1'b0;
o_Rdata <= 32'd0;
o_ALUresult<= 32'd0;
o_Reg_Dst <= 5'd0;
end
else
begin
o_MemtoReg <= i_MemtoReg; 
o_RegWrite <= i_RegWrite;
o_Rdata<= i_Rdata;
o_ALUresult<= i_ALUresult;
o_Reg_Dst <= i_Reg_Dst;
end
end
endmodule
