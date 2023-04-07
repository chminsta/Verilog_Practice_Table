module ALU32bit(
  input [31:0] a,
  input [31:0] b,
  input [3:0] op_in,

  output reg [31:0] result,
  output reg zero,
  output reg overflow
);
wire[31:0] carry_out;

wire less_in;
wire set=0; 
always @(*) begin
    alu_1bit alu0(
        .a_in(a[0]), 
        .b_in(b[0]),
        .Ainvert_in(op_in[3]), 
        .Binvert_in(op_in[2]),
        .carry_in(op_in[1]), 
        .less_in(set), 
        .op_in(op_in[1:0]), 
        .result_out(result_out[0]), 
        .carry_out(carry_out[0]));    
    
    genvar i = 1;
    while (i<31) begin
        alu_1bit alu(
            .a_in(a[i]), 
            .b_in(b[i]),
            .Ainvert_in(op_in[3]), 
            .Binvert_in(op_in[2]),
            .carry_in(carry_out[i-1]), 
            .less_in(0), 
            .op_in(op_in[1:0]), 
            .result_out(result_out), 
            .carry_out(carry_out[i]));
        i = i - 1;
    end

    ALU_1bitoverflow alu31(

    .a_in(a[31]), 
    .b_in(b[31]),
    .Ainvert_in(op_in[3]), 
    .Binvert_in(op_in[2]),
    .carry_in(carry_out[30]), 
    .less_in(0), 
    .op_in(op_in[1:0]), 
    .result_out(result_out), 
    .carry_out(carry_out[31]),
    .set_out(set),
    .overflow_out(overflow));



end


always @(*) begin

  
  // Zero check
  if (result == 0) begin
    zero = 1;
  end else begin
    zero = 0;
  end
  
end

endmodule


module alu_1bit (
    input a_in, b_in, Ainvert_in, Binvert_in, carry_in, less_in, 
    input[1:0] op_in,
    output reg result_out,
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
        2'b10:  result_out = r_a + r_b + carry_in;
        2'b11:  result_out = less_in;
        
endcase
end
assign carry_out = (r_a ^ r_b)&carry_in | (r_a & r_b);
endmodule


module ALU_1bitoverflow(
    input a_in, b_in,
    input Ainvert_in, Binvert_in, carry_in, less_in,
    input [1:0] op_in,
    output reg result_out,
    //output carry_out,
    output set_out,
    output overflow_out
    );

wire w_a, w_b;
assign w_a = Ainvert_in ? ~a_in : a_in;
assign w_b = Binvert_in ? ~b_in : b_in;

wire carry_out; // not an output
assign carry_out = ((w_a^w_b) & carry_in | (w_a & w_b));

always @(*)
    begin
        case(op_in)
            2'b00: result_out = w_a & w_b;
            2'b01: result_out = w_a | w_b;
            2'b10: result_out = w_a + w_b + carry_in;
            2'b11: result_out = less_in;
        endcase
    end
   
    assign set_out = w_a + w_b + carry_in;
    assign overflow_out = carry_in ^ carry_out;
    
endmodule













//////////////
module tb;
reg [31:0] a, b; 
reg[3:0] op_in;
wire [31:0]result_out;
wire zero, overflow;

localparam op_and = 4'b0000,
op_orr=4'b0001,
op_add=4'b0010,
op_sub=4'b0110,
op_slt=4'b0111,
op_nor=4'b1100;
alu_32bit alu(
    .a(a),
    .b(b),  
    .op_in(op_in),
    .result(result), 
    .zero(zero),
    .overflow(overflow);
)
initial begin
    a=13; 
    b=13;
    op_in=op_sub;
    #100 a = 32'b11111111111111111111111111111111; b=32'b11111111111111111111111111111111; //AND
    #100 a = 14; b = 24; op_in=op_nor;//OR
    #100 op_in=op_slt;
    #100 
    #100 $finish
    
end
initial begin
    $monitor("a= %b b= %b op_in = %b result = %b zero = %b overflow = %b",a, b, op_in, result, zero, overflow);
end
    
endmodule