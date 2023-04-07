module ALU32bit(
  input [31:0] a,
  input [31:0] b,
  input [3:0] op_in,

  output wire [31:0] result_out,
  output reg zero,
  output reg overflow
);
wire[31:0] carry_out;


wire set; 
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
    
alu_1bit alu1(.a_in(a[1]), .b_in(b[1]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[0]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[1]), .carry_out(carry_out[1]));
alu_1bit alu2(.a_in(a[2]), .b_in(b[2]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[1]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[2]), .carry_out(carry_out[2]));
alu_1bit alu3(.a_in(a[3]), .b_in(b[3]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[2]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[3]), .carry_out(carry_out[3]));
alu_1bit alu4(.a_in(a[4]), .b_in(b[4]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[3]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[4]), .carry_out(carry_out[4]));
alu_1bit alu5(.a_in(a[5]), .b_in(b[5]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[4]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[5]), .carry_out(carry_out[5]));
alu_1bit alu6(.a_in(a[6]), .b_in(b[6]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[5]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[6]), .carry_out(carry_out[6]));
alu_1bit alu7(.a_in(a[7]), .b_in(b[7]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[6]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[7]), .carry_out(carry_out[7]));
alu_1bit alu8(.a_in(a[8]), .b_in(b[8]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[7]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[8]), .carry_out(carry_out[8]));
alu_1bit alu9(.a_in(a[9]), .b_in(b[9]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[8]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[9]), .carry_out(carry_out[9]));
alu_1bit alu10(.a_in(a[10]), .b_in(b[10]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[9]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[10]), .carry_out(carry_out[10]));
alu_1bit alu11(.a_in(a[11]), .b_in(b[11]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[10]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[11]), .carry_out(carry_out[11]));
alu_1bit alu12(.a_in(a[12]), .b_in(b[12]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[11]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[12]), .carry_out(carry_out[12]));
alu_1bit alu13(.a_in(a[13]), .b_in(b[13]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[12]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[13]), .carry_out(carry_out[13]));
alu_1bit alu14(.a_in(a[14]), .b_in(b[14]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[13]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[14]), .carry_out(carry_out[14]));
alu_1bit alu15(.a_in(a[15]), .b_in(b[15]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[14]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[15]), .carry_out(carry_out[15]));
alu_1bit alu16(.a_in(a[16]), .b_in(b[16]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[15]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[16]), .carry_out(carry_out[16]));
alu_1bit alu17(.a_in(a[17]), .b_in(b[17]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[16]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[17]), .carry_out(carry_out[17]));
alu_1bit alu18(.a_in(a[18]), .b_in(b[18]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[17]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[18]), .carry_out(carry_out[18]));
alu_1bit alu19(.a_in(a[19]), .b_in(b[19]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[18]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[19]), .carry_out(carry_out[19]));
alu_1bit alu20(.a_in(a[20]), .b_in(b[20]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[19]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[20]), .carry_out(carry_out[20]));
alu_1bit alu21(.a_in(a[21]), .b_in(b[21]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[20]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[21]), .carry_out(carry_out[21]));
alu_1bit alu22(.a_in(a[22]), .b_in(b[22]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[21]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[22]), .carry_out(carry_out[22]));
alu_1bit alu23(.a_in(a[23]), .b_in(b[23]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[22]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[23]), .carry_out(carry_out[23]));
alu_1bit alu24(.a_in(a[24]), .b_in(b[24]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[23]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[24]), .carry_out(carry_out[24]));
alu_1bit alu25(.a_in(a[25]), .b_in(b[25]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[24]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[25]), .carry_out(carry_out[25]));
alu_1bit alu26(.a_in(a[26]), .b_in(b[26]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[25]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[26]), .carry_out(carry_out[26]));
alu_1bit alu27(.a_in(a[27]), .b_in(b[27]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[26]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[27]), .carry_out(carry_out[27]));
alu_1bit alu28(.a_in(a[28]), .b_in(b[28]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[27]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[28]), .carry_out(carry_out[28]));
alu_1bit alu29(.a_in(a[29]), .b_in(b[29]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[28]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[29]), .carry_out(carry_out[29]));
alu_1bit alu30(.a_in(a[30]), .b_in(b[30]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[29]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[30]), .carry_out(carry_out[30]));



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

/////////////


// Code your testbench here
// or browse Examples
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
  .result_out(result_out), 
    .zero(zero),
  .overflow(overflow)
);
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