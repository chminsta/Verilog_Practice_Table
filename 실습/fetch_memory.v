module iMEM# (
    parameter MEM_DEPTH = 32
)(
input i_clk, i_rstn,
input [31:0] i_PC,
output reg [31:0] o_instruction
);

//int i

reg [31:0] instruction_mem [0:MEM_DEPTH-1];

always @(posedge i_clk, negedge i_rstn) begin
    //설명
    //for(i=0; i<MEM_DEPTH; i=i+1)
    //begin
    //    instruction_mem[i] <= 32'd0;
    //end
    if(!rstn) o_instruction <= 32'd0;
    else o_instruction <= instruction_mem[i_PC];
end
endmodule

module tb;

parameter MEM_DEPTH = 32;
reg i_rstn;
reg i_clk;
reg[31:0]; i_PC;
wire [31:0] o_instruction;

always #5 begin
    i_clk=~i_clk;
end

iMEM #(
    .MEM_DEPTH(MEM_DEPTH)
)iMEM(
    .i_clk(i_clk),
    .i_rstn(i_rstn),
    .i_PC(i_PC),
    .o_instruction(o_instruction)
)

initial begin
    $readmemh("instruction_memory.mem", iMEM.instruction_mem);
end
initial begin
    i_clk=0;i_rstn;
    #1 i_rstn=1;
    #1 i_rstn=0;
    #1 i_rstn=1;
    #200 $stop;
end

always @(posedge i_clk negedge i_rstn) begin
    if(!i_rstn) i_PC <= 0;
    else i_PC <= i_PC + 4;
end
endmodule