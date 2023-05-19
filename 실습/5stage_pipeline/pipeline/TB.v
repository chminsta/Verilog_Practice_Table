module tb;
    reg i_clk;
    reg i_rstn;
    wire [31:0] PCplus4;
    always #1 i_clk = ~i_clk;

    MIPS_pipeline mp(i_clk, i_rstn, PCplus4);


    initial begin
        $readmemh("instruction.txt", mp.f.iMEM.instruction_mem);
    end
    initial begin
        $readmemh("data.txt", mp.dm.mem);
    end


    initial begin
        i_clk = 0; i_rstn = 0;
        #1 i_rstn = 1;

        #1000 $stop;
        
    end
endmodule

