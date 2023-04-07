

module ALU_1bit_overflow(a_in, b_in, Ainvert_in, Binvert_in, carry_in, less_in, op_in, result_out, set_out, overflow_out);
    input a_in, b_in, Ainvert_in, Binvert_in, carry_in, less_in;
    input [1:0] op_in;
    output reg result_out;
    output set_out;
    output overflow_out;

    wire w_a;
    wire w_b;
    assign w_a = Ainvert_in ? ~a_in : a_in;
    assign w_b = Binvert_in ? ~b_in : b_in;

    wire carry_out;
    assign carry_out = (((w_a ^ w_b) & carry_in) | (w_a & w_b));

    always @(*) begin
        case(op_in)
            2'b00 : result_out = w_a & w_b;
            2'b01 : result_out = w_a | w_b;
            2'b10 : result_out = w_a + w_b + carry_in;
            2'b11 : result_out = less_in;
        endcase
    end

    assign set_out = w_a + w_b + carry_in;
    assign overflow_out = carry_in ^ carry_out;
endmodule