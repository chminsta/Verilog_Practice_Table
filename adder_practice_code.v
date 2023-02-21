// Code your testbench here
// or browse Examples
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