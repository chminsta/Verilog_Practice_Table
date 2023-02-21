// Code your testbench here
// or browse Examples
module dump_example;
  reg a,b;
  
  initial begin
    a=0; b=0;
    #10	a=1;b=0;
    #10	a=0;b=1;
    #10	a=1;b=1;
    #10 $finish;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1,dump_example);
    $display("dump test");
  end
  
  
  
endmodule


//adder

module design_d(
    input   clk,
    input   rstn,
    input[3:0]  in,
    output[3:0] out
);
    wire [3:0]a;
    reg[3:0] b;

    assign  a = in+1;

always  @(posedge clk, negedge rstn) begin
    if(!rstn) b<=0;
    else    b<=a;
end

assign  out=b;
endmodule


module parameter_EX3 #(
    parameter   N=4,
    parameter   M=8
) (
    input   clk,
    input   rstn,

    input [N-1:0]   in_1,
    input [M-1:0]   in_2,
    output [N-1:0]   out_1,
    output [M-1:0]  out_2

);
    defparam u_EX3_1.N=N; //parameter 4
    parameter_EX3_1 u_EX3_1 (in_a,out_a);
    parameter_EX3_1 #(.N(M)) u_EX3_2 (in_a,out_a); //parameter8

endmodule

module parameter_EX3_1 #(
    parameter   N=8
) (
    input [N-1:0]   in,
    output [N-1:0]  out
);
    localparam K=32 ;
    //code for Parameter_EX3_1

endmodule


`define seq_logic
module Define_EX #(
    parameter   N=8
) (
`ifdef seq_logic
    input   clk,
    input   rstn
`endif
    input [N-1:0]   in;
    output [N-1:0]   out;
    
);

`ifndef seq_logic
    assign  out=in;
`else
    reg [N-1:0] out;

    always @ (posedge clk, negedge rstn)
    if (!rstn) out <=0;
    else    out<=in;
        
    `endif
    
endmodule

module mux_gatelevel (
    input   a,b,
    input   A,B,C,D,
    output q
 );
    wire a_not, b_not;
    wire A_pick,B_pick,C_pick,D_pick;

    not(a_not , a);
    not(b_not , b);
    
    and(A_pick, a_not,b_not,A);
    and(B_pick, a, b_not,B);
    and(C_pick, a_not,b,C);
    and(D_pick, a_not,b,D);
    
    or(Q,A_pick,B_pick,C_pick,D_pick);

 endmodule

module practice_gatelevel (
    input   a_0,b_0,a_1,b_1,
    output  sum_0,sum_1,carry_out

);
    wire and1,xor3,and2,and3;

    and(and1,a_0,b_0);
    xor(xor3,a_1,b_1);
    and(and3,a_0,b_0);
    and(and2,and1,xor3);

    xor(sum_0,a_0,b_0);
    xor(sum_1,and1,xor3);
    or(carry_out,and2,and3);

    
endmodule

module adder_gatelevel (
    input [1:0] a,b,
    output [1:0] sum,
    output  carry_out
);
    wire and1_out;
    wire xor3_out;
    wire and2_out, and3_out; //따로쓰는것과 한줄에 쓰는것이 어떤의미가 있나??

    xor(sum[0],a[0],b[0]);
    and(and1_out,a[0],b[0]);
    xor(sum[1],and1_out,xor3_out);
    xor(xor3_out, a[1], b[1]);
    and(and2_out,and1_out,xor3_out);
    and(and3_out,a[1],b[1]);
    or (carry_out,and2_out,and3_out);

    
endmodule


module mux_dataflow (
    input   a,b,
    input   A,B,C,D,
    output q

 );
    wire sel_0,sel_1,sel_2,sel_3;
    assign sel_0 = ~a & ~b;
    assign sel_1 = a & ~b;
    assign sel_2 = ~a & b;
    assign sel_3 = a & b;
    
    assign  q = sel_0 ? A;
                sel_1 ? B;
                sel_2 ? C;
                sel_3 ? D; 0; //0은뭐지?? 디폴트?

    /*
    assign  q = ~a & ~b ? A;
                a & ~b ? B;
                ~a & b ? C;
                a & b ? D; 0;
    */
                

 endmodule

module practice_dataflow (
    input   a_0,b_0,a_1,b_1,
    output  sum_0,sum_1,carry_out

 );
    assign sum_0 = a_0 xor b_0;

    wire and1,xor3,and2,and3;

    assign and1 = a_0 & b_0;
    assign xor3 = a_1 xor b_1;
    assign and2 = and1 & xor3;
    assign and3 = a_1 & b_1;

    assign carry_out = and2 + and3 ? 1; 0;



    assign sum_1

endmodule

module adder_dataflow1 (
    input [1:0] a,b,
    output [1:0] sum,
    output carry_out

);
    wire [2:0] sum_3bit; //a=2,b=2라면 sum은 4이므로 3비트가 필요함. 실수 주의 

    assign sum_3bit=a+b;
    assign sum=sum_3bit[1:0]; //0,1
    assign carry_out=sum_3bit[2]; //2만


endmodule

module adder_dataflow2 (
    input [1:0] a,b,
    output [1:0] sum,
    output carry_out

 );
    assign {carry_out,sum}= a+b;

    
endmodule

module mux_behaviour (
    input   a,b,
    input   A,B,C,D,
    output q
 );
    reg q;

    always @* begin
        case ({b,a})
            'b00    : q=A; 
            'b01    : q=B; 
            'b10    : q=C; 
            'b11    : q=D; 
            
            default: q=0;
        endcase
        
    end


endmodule
//

module practice_behaviour (
    input   a_0,b_0,a_1,b_1,
    output  sum_0,sum_1,carry_out 
);
    reg sum_0, sum_1, carry_out;
    always @* begin
        case ({a_0,b_0})
            'b00    : sum_0 = 0;
            'b01    : sum_0 = 1;
            'b10    : sum_0 = 1;
            'b11    : sum_0 = 0;
            
            default: sum_0=0;
        endcase
    
        case ({a_0,b_0,a_1,b_1})
            'b0000    : sum_1 = 0;
            'b0001    : sum_1 = 1;
            'b0010    : sum_1 = 1;
            'b0011    : sum_1 = 0;
            'b0100    : sum_1 = 0;
            'b0101    : sum_1 = 1;
            'b0110    : sum_1 = 1;
            'b0111    : sum_1 = 1;
            'b1000    : sum_1 = 0;
            'b1001    : sum_1 = 1;
            'b1010    : sum_1 = 1;
            'b1011    : sum_1 = 0;
            'b1100    : sum_1 = 1;
            'b1101    : sum_1 = 0;
            'b1110    : sum_1 = 0;
            'b1111    : sum_1 = 1;
            
            default: sum_1=0;
        endcase

        case ({a_0,b_0,a_1,b_1})
            'b0000    : carry_out = 0;
            'b0001    : carry_out = 0;
            'b0010    : carry_out = 0;
            'b0011    : carry_out = 0;
            'b0100    : carry_out = 0;
            'b0101    : carry_out = 0;
            'b0110    : carry_out = 0;
            'b0111    : carry_out = 1;
            'b1000    : carry_out = 0;
            'b1001    : carry_out = 0;
            'b1010    : carry_out = 0;
            'b1011    : carry_out = 0;
            'b1100    : carry_out = 0;
            'b1101    : carry_out = 1;
            'b1110    : carry_out = 1;
            'b1111    : carry_out = 1;
            
            default: sum_1=0;
        endcase


        
    end
endmodule

module adder_behavior (
    input [1:0] a,b,
    output reg [1:0] sum, //always 에 들어갈려면 output에 reg를 할당 해야댐!!
    output reg carry_out

 );
    always @* begin
        {carry_out,sum}=a+b;
    end

    
endmodule

module adder_testbench;
    reg [1:0] a[2:0], b[2:0];
    wire [1:0] sum[2:0];
  	wire        carry_out[2:0];

    adder_gatelevel u_adder_gatelevel(a[0],b[0],sum[0],carry_out[0]);
    adder_dataflow2 u_adder_dataflow2(a[1],b[1],sum[1],carry_out[1]);
    adder_behavior u_adder_behavior(a[2],b[2],sum[2],carry_out[2]);
    
    initial begin
        a[0]=0; b[0]=2;
        a[1]=1; b[1]=3;
        a[2]=2; b[2]=3;
    end

    initial begin
      
      $monitor("gatelevel:a %d, b %d, sum %d, carry %d", a[0],b[0],sum[0],carry_out[0]);
      $monitor("dataflow2:a %d, b %d, sum %d, carry %d", a[1],b[1],sum[1],carry_out[1]);
      $monitor("behavior:a %d, b %d, sum %d, carry %d", a[2],b[2],sum[2],carry_out[2]);
    end
endmodule

// Code your design here
module adder_gatelevel (
    input [1:0] a,b,
    output [1:0] sum,
    output  carry_out
 );
    wire and1_out;
    wire xor3_out;
    wire and2_out, and3_out; //따로쓰는것과 한줄에 쓰는것이 어떤의미가 있나??

    xor(sum[0],a[0],b[0]);
    and(and1_out,a[0],b[0]);
    xor(sum[1],and1_out,xor3_out);
    xor(xor3_out, a[1], b[1]);
    and(and2_out,and1_out,xor3_out);
    and(and3_out,a[1],b[1]);
    or (carry_out,and2_out,and3_out);
endmodule

module adder_dataflow1 (
    input [1:0] a,b,
    output [1:0] sum,
    output carry_out

 );
    wire [2:0] sum_3bit; //a=2,b=2라면 sum은 4이므로 3비트가 필요함. 실수 주의 

    assign sum_3bit=a+b;
    assign sum=sum_3bit[1:0]; //0,1
    assign carry_out=sum_3bit[2]; //2만


endmodule

module adder_dataflow2 (
    input [1:0] a,b,
    output [1:0] sum,
    output carry_out

 );
    assign {carry_out,sum}= a+b;

    
endmodule


module adder_behavior (
    input [1:0] a,b,
    output reg [1:0] sum, //always 에 들어갈려면 output에 reg를 할당 해야댐!!
    output reg carry_out

 );
    always @* begin
        {carry_out,sum}=a+b;
    end

endmodule 