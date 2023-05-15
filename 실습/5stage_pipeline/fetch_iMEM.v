module iMEM#(
    parameter MEM_DEPTH = 32
    )(
    input  [31:0] i_PC,
    output [31:0] o_instruction
    );
    reg [31:0] instruction_mem [0:MEM_DEPTH-1];
	
	assign o_instruction = instruction_mem[i_PC]; 

endmodule
