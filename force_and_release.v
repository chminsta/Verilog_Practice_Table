//force, release
module tb_counter;
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        rstn = 1;
        #10 rstn = 0;
        #20 rstn = 1;
        
    end
    initial begin
        #50 force u_counter.en = 0;
        #50 release u_counter.en;
    
    end
    
    counter u_counter(clk,rstn,1);
endmodule

module counter (
    input clk, rstn, en
);
    reg [3:0]   cnt ;

    always @(posedge clk, negedge rstn)
    if  (!rstn) cnt <=0;
    else if (en) cnt<=cnt+1;

endmodule

//etc

//$random, $random(seed)
//readmemh, $readmemb

