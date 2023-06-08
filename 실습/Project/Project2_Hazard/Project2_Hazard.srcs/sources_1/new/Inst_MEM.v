`timescale 1ns/10ps
module Inst_MEM
(
    input rst_n, // reset when 0
    input [31:0] addr, // input the address of instruction
    output wire [31:0] inst // output the instruction correspond to the address of input
);

reg [31:0] Inst_mem [0:19]; // need $readmemh to assign address to instruction

always @(negedge rst_n) 
begin
Inst_mem[0] <= 32'h8c410004;
Inst_mem[4] <= 32'h00222020;
Inst_mem[8] <= 32'h00294025;
Inst_mem[12] <= 32'h110afffc;

//0x8c410004
//0x222020
//0x294025
//0x110afffc
end

assign inst = Inst_mem[addr];
endmodule