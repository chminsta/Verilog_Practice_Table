module mux (
    input [31:0] i_PC, i_imm,
    input PCSrc,
    output [31:0] o_PC
);
    assign o_PC = PCSrc? i_imm : i_PC;
endmodule