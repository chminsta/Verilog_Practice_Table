//design.sv


module mux #(
    input sel[1:0] ,a[3:0],b[3:0],c[3:0],d[3:0]
    output Out[3:0]
); (
    always @(*) begin
        


    if (sel==2'b00) begin
        Out=a;
    end
    else if (sel==2'b01) begin
        Out=b;
    end
    
    else if(sel==2'b10) begin
        Out=c;
    end
    
    else (sel==2'b11) begin
        Out=d;
    end
    end
);
    
endmodule


//testbench.sv

module tb_mux ()
    reg [1:0] sel;
    reg [3:0] a;
    reg [3:0] b;
    reg [3:0] c;
    reg [3:0] d;
 

    wire [3:0] Out;

    cmjk mux(
        .sel(sel)
        .a(a)
        .b(b)
        .c(c)
        .d(d)
        .Out(Out)
    );

    initial 
    begin
    a=1, b=2, c=3, d=4,

    sel=0
    #20 sel=1
    #20 sel=2
    #20 sel=3
    #20 sel=4
    #20 $stop
    end
    
endmodule