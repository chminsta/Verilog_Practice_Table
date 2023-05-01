module adder (
    input [31:0] i_PC,
    output [31:0] o_PC
);
assign o_PC = i_PC + 4;    
endmodule