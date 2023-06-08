`timescale 1ns/10ps
module SignExtend(imm_value, result);
input [15:0] imm_value;
output [31:0] result;

assign result = {{16{imm_value[15]}},imm_value};
endmodule