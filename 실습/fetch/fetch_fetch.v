module fetch (
    input i_clk, i_rstn, PCSrc,
    input [31:0] imm_PC,
    output [31:0] o_instruction, o_PC
);

wire[31:0] PC_in;
wire[31:0] PC_out;
wire[31:0] PC_added;
parameter MEM_DEPTH = 32;

//input pcin output pcout
PC PC(
    .i_clk(i_clk),
    .i_rstn(i_rstn),
    .i_PC(PC_in),
    .o_PC(PC_out)
)
//input pcin output instruction
iMEM#(
    .MEM_DEPTH(MEM_DEPTH)
) iMEM (
    .i_clk(i_clk),
    .i_rstn(i_rstn),
    .i_PC(PC_in),
    .o_instruction(o_instruction)
);

mux mux(
    .i_PC(w_PCadded),
    .i_imm(imm_PC),
    .PCSrc(PCSrc),
    .o_PC(w_PCin)
);

adder pcadder(
    .i_PC(w_PCout),
    .o_PC(w_PCadded)   
);

assign o_PC = w_PCout;

endmodule