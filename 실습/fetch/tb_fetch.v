module tb_fetch

parameter MEM_DEPTH = 32;

reg i_clk;
reg i_rstn;
reg PCSrc;
reg [31:0] imm_PC;
wire [31:0] o_instruction;
wire [31:0] o_PC;

always #5 i_clk = ~i_clk;

fetch fetch1(
    .i_clk(i_clk),
    .i_rstn(i_rstn),
    .PCSrc(PCSrc),
    .imm_PC(imm_PC),
    .o_instruction(o_instruction),
    .o_PC(o_PC)
);

initial begin
    $readmemh("instruction_memory.mem", fetch1.iMEM.instruction_mem);

end
    
initial begin
    i_clk = 0; i_rstn = 0; PCSrc = 0; imm_PC = 32'd7;
    #4 i_rstn = 1;
    #1 i_rstn = 0;
    #1 i_rstn = 1;
    #100 i_rstn = 0;
    #1 i_rstn = 1;
    #100 $stop;
    
end
endmodule