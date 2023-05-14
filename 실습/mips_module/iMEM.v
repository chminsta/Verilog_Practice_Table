`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/07 13:54:22
// Design Name: 
// Module Name: iMEM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module iMEM#(
    parameter MEM_DEPTH = 32
    )(
    input  [31:0] i_PC,
    output [31:0] o_instruction
    );
    reg [31:0] instruction_mem [0:MEM_DEPTH-1];
	
	assign o_instruction = instruction_mem[i_PC]; 

endmodule
