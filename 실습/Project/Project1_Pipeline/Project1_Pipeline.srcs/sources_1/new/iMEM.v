module iMEM 
(
    input rst_n, // reset when 0
    input [31:0] i_addr, // input the address of instruction
    output wire [31:0] inst // output the instruction correspond to the address of input
);

reg [31:0] instruction_mem [0:35]; // need $readmemh to assign address to instruction

always @(negedge rst_n)
if(!rst_n) begin
instruction_mem[0] <= 32'h00430820;
instruction_mem[1] <= 32'h0;
instruction_mem[2] <= 32'h0;
instruction_mem[3] <= 32'h0;
instruction_mem[4] <= 32'h20a40005;
instruction_mem[5] <= 32'h0;
instruction_mem[6] <= 32'h0;
instruction_mem[7] <= 32'h0;
instruction_mem[8] <= 32'h00e83022;
instruction_mem[9] <= 32'h0;
instruction_mem[10] <= 32'h0;
instruction_mem[11] <= 32'h0;
instruction_mem[12] <= 32'h8d490004;
instruction_mem[13] <= 32'h0;
instruction_mem[14] <= 32'h0;
instruction_mem[15] <= 32'h0;
instruction_mem[16] <= 32'had8b0004;
instruction_mem[17] <= 32'h0;
instruction_mem[18] <= 32'h0;
instruction_mem[19] <= 32'h0;
instruction_mem[20] <= 32'h11aefffa;
instruction_mem[21] <= 32'h0;
instruction_mem[22] <= 32'h0;
instruction_mem[23] <= 32'h0;
instruction_mem[24] <= 32'h0;
instruction_mem[25] <= 32'h0;
instruction_mem[26] <= 32'h0;
instruction_mem[27] <= 32'h0;
instruction_mem[28] <= 32'h0;
instruction_mem[29] <= 32'h0;
instruction_mem[30] <= 32'h0;
instruction_mem[31] <= 32'h0;
instruction_mem[32] <= 32'h0;
instruction_mem[33] <= 32'h0;
instruction_mem[34] <= 32'h0;
instruction_mem[35] <= 32'h0;
end
    
assign inst = instruction_mem[i_addr];
endmodule