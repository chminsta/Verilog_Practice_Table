// Code your testbench here
module tb;
    reg clk, rstn;
    initial begin
        rstn = 1;
        #10 rstn = 0;
        #20 rstn = 1;
    end

    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0,tb);
        #500 $finish            //영원히 가니까 끝내기
    end

endmodule



//design.sv

module moduleName (
    ports
);
    
endmodule
