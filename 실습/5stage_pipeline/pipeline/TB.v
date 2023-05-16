module tb;
    reg i_clk;
    reg i_rstn;
    wire [31:0] ALUresult;
    wire [31:0] Instruction;
    wire [31:0] Read_Data1;
    wire [31:0] Read_Data2;
    wire [4:0] Reg_Dst;
    always #5 i_clk = ~i_clk;

    MIPS_pipeline mp(i_clk, i_rstn, ALUresult, Instruction, Read_Data1, Read_Data2, Reg_Dst);


    initial begin
        $readmemh("instruction.txt", mp.f.iMEM.instruction_mem);
    end
    initial begin
        $readmemh("data.txt", mp.dm.mem);
    end


    initial begin
        i_clk = 0; i_rstn = 0;
        #4 i_rstn = 1;
        #1 i_rstn = 0;
        #1 i_rstn = 1;
        #100 i_rstn = 0;
        #1 i_rstn = 1;
        #100 $stop;
        
    end
endmodule

