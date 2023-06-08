module tb_MIPS();
    reg clk, rst_n;
    wire [31:0] R1, R4, R6, R9;
    wire [31:0] mem_16;
    wire branch;
    wire [31:0] ALUResult_EX;
    wire [31:0] Rdata_MEM;
    wire [1:0] WB_ControlSignal;
    
MIPS_5stage MIPS5(clk, rst_n, branch, R1, R4, R6, R9, mem_16, ALUResult_EX, Rdata_MEM, WB_ControlSignal);

initial begin
    clk=0; rst_n=0;
    #1 rst_n=1;
    #1 rst_n=0;
    #1 rst_n=1;
    forever #1 clk=!clk;
end

endmodule
