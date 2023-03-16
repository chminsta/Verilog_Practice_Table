//design.sv


module mux_ifelse (
    input [1:0] sel,
    input [3:0] a,b,c,d,
    output reg [3:0] Out
); 
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
    
    else begin
        Out=d;
    end
    end

    
endmodule

module mux_case (
    input   a,b,
    input   A,B,C,D,
    output Out
 );
    reg Out;

    always @* begin
        case ({b,a})
            'b00    : Out=A; 
            'b01    : Out=B; 
            'b10    : Out=C; 
            'b11    : Out=D; 
            
            default: Out=0;
        endcase
        
    end

endmodule

module mux_conditional (
    input   a,b,
    input   A,B,C,D,
    output Out

 );
    wire sel_0,sel_1,sel_2,sel_3;
    assign sel_0 = ~a & ~b;
    assign sel_1 = a & ~b;
    assign sel_2 = ~a & b;
    assign sel_3 = a & b;
    
    assign  Out = sel_0 ? A;
                sel_1 ? B;
                sel_2 ? C;
                sel_3 ? D; 0; 


                

 endmodule

//testbench.sv

module tb_mux;
    reg [1:0] sel;
    reg [3:0] a;
    reg [3:0] b;
    reg [3:0] c;
    reg [3:0] d;
 

    wire [3:0] Out1;
    wire [3:0] Out2;
    wire [3:0] Out3;

    mux_ifelse cmjk1(
        .sel(sel),
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .Out1(Out)
    );

    mux_case cmjk2(
        .sel(sel),
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .Out2(Out)
    );

    mux_conditional cmjk3(
        .sel(sel),
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .Out3(Out)
    );
    initial 
    begin
    a=1; b=2; c=3; d=4;

   
    sel=2'b00;
    #20 sel=2'b01;
    #20 sel=2'b10;
    #20 sel=2'b11;
    #20 $stop;
    end
    
<<<<<<< HEAD
endmodule
=======
endmodule
>>>>>>> 5d1094bccd80bbdf01b541688d64fe3423fdebc7
