module fetch (
    input i_clk, i_rstn, PCSrc,
    input [31:0] imm_PC,
    output [31:0] o_instruction, o_PC
);

wire[31:0] i_PC;
wire[31:0] PC_out;
parameter MEM_DEPTH = 32;

//input pcin output pcout
PC PC(
    .i_clk(i_clk),
    .i_rstn(i_rstn),
    .i_PC(i_PC),
    .o_PC(PC_out)
)
//input  output instruction
iMEM#(
    .MEM_DEPTH(MEM_DEPTH)
) iMEM (
    .i_PC(PC_out),
    .o_instruction(o_instruction)
);

mux mux(
    .i_PC(o_PC),
    .i_imm(imm_PC),
    .PCSrc(PCSrc),
    .o_PC(i_PC)
);

//adder
assign o_PC = PCout+4;

endmodule