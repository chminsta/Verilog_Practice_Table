module tb_project1();
    reg clk, rst_n;
    wire [15:0] LED;
    wire [1:0] i_clk;
Project1 BB(clk, rst_n, LED, i_clk);

initial begin
    clk=0; rst_n=0;
    #1 rst_n=1;
    #1 rst_n=0;
    #1 rst_n=1;
    forever #1 clk=!clk;
end

endmodule
