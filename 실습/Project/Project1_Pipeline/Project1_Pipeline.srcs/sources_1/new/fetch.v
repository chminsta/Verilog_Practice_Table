module fetch(
    input clk, // in positive edge, the module PC and iMEM change their output
    input rst_n, // reset when 0
    input PCSrc, // control signal to determine PC+4 or branch target address
    input [31:0] b_addr, // branch target address
    output [31:0] PCnext, // transfer to register the value of PC+4
    output [31:0] inst // transfer to register the instruction of address PC
);
    wire [31:0] pc_in;
    wire [31:0] pc_out;

    assign PCnext = pc_out + 4;
    assign pc_in = (PCSrc)? b_addr:PCnext;

    PC pc(clk, rst_n, pc_in, pc_out);
    iMEM imem(rst_n, pc_out, inst);
endmodule
