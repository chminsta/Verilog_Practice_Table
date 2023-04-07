

module ALU_1bit(a_in, b_in, Ainvert_in, Binvert_in, carry_in, less_in, op_in, result_out, carry_out);
    input a_in, b_in, Ainvert_in, Binvert_in, carry_in, less_in;
    input [1:0] op_in;
    output carry_out;
    output reg result_out;
    
    wire w_a;
    wire w_b;
    
    assign w_a = Ainvert_in ? ~a_in : a_in;
    assign w_b = Binvert_in ? ~b_in : b_in;

    always @(*)
    begin
        case(op_in)
            2'b00 : result_out = w_a & w_b;
            2'b01 : result_out = w_a | w_b;
            2'b10 : result_out = w_a + w_b + carry_in;
            2'b11 : result_out = less_in;
        endcase
    end

    assign carry_out = (((w_a ^ w_b) & carry_in) | (w_a & w_b));
    
endmodule