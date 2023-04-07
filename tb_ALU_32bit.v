

module tb_ALU_32bit();
    reg [31:0] a_in;
    reg [31:0] b_in;
    reg [3:0] op_in;
    wire [31:0] result_out;
    wire zero_out;
    wire overflow_out;

    ALU_32bit ALU32(
        .a_in(a_in),
        .b_in(b_in),
        .op_in(op_in),
        .result_out(result_out),
        .zero_out(zero_out),
        .overflow_out(overflow_out)
    );

    initial begin
        a_in = 2; b_in = 3; op_in = 4'b0010; 
        #10 a_in = 33; b_in = 63;
        #10 a_in = 7; b_in = 16; op_in = 4'b0000;
        #10 a_in = 6; b_in = 9; op_in = 4'b0001;
        #10 a_in = 42; b_in = 27; op_in = 4'b0110;
        #10 a_in = 42; b_in = 27; op_in = 4'b0111;
        #10 a_in = -42; b_in = 27; op_in = 4'b0111;
        #10 a_in = 24; b_in = 30; op_in = 4'b1100;
        #10 a_in = 32'h7FFFFFFF; b_in = 32'h7FFFFFFF; op_in = 4'b0010;
        #10 $finish;
    end

    initial begin
        $monitor("a_in = %b b_in %b op_in %b result_out %b zero_out %b overflow_out %b"
        , a_in, b_in, op_in, result_out, zero_out, overflow_out);
    end
    
endmodule