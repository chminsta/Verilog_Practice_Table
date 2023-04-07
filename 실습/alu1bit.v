module alu_1bit (
    input a_in, b_in, Ainvert_in, Binvert_in, carry_in, less_in, 
    input[1:0] op_in,
    output reg result_out
    output carry_out
);

//assign을 쓴다면
//wire w_a;
//wire w_b;
//assign w_a = Ainvert_in ? ~a_in : a_in;
//assign w_b = Binvert_in ? ~b_in : b_in;

//always를 쓴다면
reg r_a;
reg r_b;
always @(*) begin
    if (Ainvert_in) r_a=!a_in;
    else r_a=a_in;

    if (Binvert_in) r_b=!b_in;
    else r_b=b_in;
end

always @(*) begin
    case(op_in)
        2'b00:  result_out = r_a & r_b;
        2'b01:  result_out = r_a | r_b;
        2'b10:  result_out = r_a + r_b + carry_in
        2'b11:  result_out = less_in;
        
endcase
end
assign carry_out = (r_a ^ r_b)&carry_in | (r_a & r_b);
endmodule




//testbench

module tb;
reg a_in, b_in, Ainvert_in, Binvert_in, carry_in, less_in;
reg[1:0] op_in;
wire result_out, carry_out;


alu_1bit alu(
    .a_in(a_in),
    .b_in(b_in), 
    .Ainvert_in(Ainvert_in),
    .Binvert_in(Binvert_in), 
    .carry_in(carry_in), 
    .less_in(less_in),
    .op_in(op_in),
    .result_out(result_out), 
    .carry_out(carry_out);
)
initial begin
    a_in=0; b_in=0;
    Ainvert_in=0;
    Binvert_in=0;
    carry_in=0;
    less_in=0;
    op_in=0;
    #10 a_in = 1; b_in=1; //AND
    #10 a_in = 1; b_in = 0; op_in=2'b01;//OR
    #10 a_in = 1; b_in = 1; carry_in = 1; op_in=2'b01;
    #10 less_in = 1; op_in=2'b11;
    #10 $finish
    
end
initial begin
    $monitor("a+in= %b b_in= %b carry_in= %b op_in = %b less_than = %b carry_out = %b result_out = %b",a_in, b_in, Ainvert_in, Binvert_in, carry_in, op_in, less_in, carry_out, result_out);
end
    
endmodule