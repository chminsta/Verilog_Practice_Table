module ALU(
    input signed [31:0] a_in,
    input signed [31:0] b_in, // 32bit input
    input [3:0] ALUctrl, // control signal from ALUControl
    output reg signed [31:0] result,
    output zero // set when result is zero
);
always @(*) begin
    case(ALUctrl)
    4'b0010: result = a_in + b_in;
    4'b0110: result = a_in - b_in;
    4'b0000: result = a_in & b_in;
    4'b0001: result = a_in | b_in;
    4'b0111: result = (a_in < b_in) ? 1:0;
    default: result = 32'b0;
    endcase
end

assign zero = !result;
endmodule

