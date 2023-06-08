`timescale 1ns/10ps
module MEM_WB(
    input clk, rst_n,
    input [1:0] ControlSignal_MEM,
    input [31:0] Rdata_MEM, ALUResult_MEM,
    input [4:0] RegDst_MEM,
    output reg [1:0] WB_ControlSignal,
    output reg [31:0] WB_Rdata, WB_ALUResult,
    output reg [4:0] WB_RegDst
    );
    
always @(posedge clk, negedge rst_n) begin
if(!rst_n) {WB_ControlSignal, WB_Rdata, WB_ALUResult, WB_RegDst} <= 0;
else 
{WB_ControlSignal, WB_Rdata, WB_ALUResult, WB_RegDst} 
<= {ControlSignal_MEM, Rdata_MEM, ALUResult_MEM,RegDst_MEM};
end
endmodule
