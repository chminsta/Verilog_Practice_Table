`timescale 1ns/10ps
module IF_ID(
    input clk, rst_n,
    input [31:0] PCnext_IF,
    input [31:0] Inst_IF,
    input PCSrc, // for clear
    input ID_Stall, // for stall
    output reg [31:0] ID_PCnext,
    output reg [31:0] ID_Inst
);
always@(posedge clk, negedge rst_n) begin
if(!rst_n) {ID_PCnext, ID_Inst} <= 0;
else begin

if(ID_Stall) {ID_PCnext, ID_Inst} <= {ID_PCnext, ID_Inst};
else  begin
if(PCSrc) {ID_PCnext, ID_Inst} <= 0;
else {ID_PCnext, ID_Inst} <= {PCnext_IF, Inst_IF};
end

end

end
endmodule