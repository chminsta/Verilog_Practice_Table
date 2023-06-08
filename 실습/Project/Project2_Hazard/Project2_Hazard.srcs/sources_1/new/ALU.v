`timescale 1ns/10ps
module ALU(
    input signed [31:0] a_in,
    input signed [31:0] b_in, // 32bit input
    input [2:0] ALUctrl, // control signal from ALUControl
    output reg signed [31:0] result
);
always @(*)     
case(ALUctrl)
3'b010: result = a_in + b_in;
3'b110: result = a_in - b_in;
3'b000: result = a_in & b_in;
3'b001: result = a_in | b_in;
3'b111: result = (a_in < b_in) ? 1:0;
default: result = 0;
endcase
endmodule

