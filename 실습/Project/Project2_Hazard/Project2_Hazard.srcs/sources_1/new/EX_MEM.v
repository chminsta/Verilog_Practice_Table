`timescale 1ns/10ps
module EX_MEM(
    input clk, rst_n,
    input [2:0] ControlSignal_EX,
    input [31:0] ALUResult_EX, Wdata_EX,
    input [4:0] RegDst_EX,
    output reg [2:0] MEM_ControlSignal,
    output reg [31:0] MEM_ALUResult, MEM_Wdata,
    output reg [4:0] MEM_RegDst
);

always @(posedge clk, negedge rst_n) begin
if (!rst_n)
    {MEM_ControlSignal, MEM_ALUResult, MEM_Wdata, MEM_RegDst} <= 0;
else
    {MEM_ControlSignal, MEM_ALUResult, MEM_Wdata, MEM_RegDst}
    <= {ControlSignal_EX, ALUResult_EX, Wdata_EX, RegDst_EX};
end
endmodule