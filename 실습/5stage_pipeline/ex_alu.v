module ALU (
    input signed [31:0] a_in, b_in,
    input [3:0] ALUCtrl,
    output reg signed [31:0] result,
    output zero
);

//ALUctrl 정보
//add=4'b0010
//sub=4'b0110
//and=4'b0000
//or=4'b0001
//slt=4'b0111
    always @(*) begin
        case(ALUCtrl) 
        4'b0010:    result = a_in + b_in;
        4'b0110:    result = a_in - b_in;
        4'b0000:    result = a_in & b_in;
        4'b0001:    result = a_in | b_in;
        4'b0111:    result = a_in < b_in;      
        

        endcase
    end
    assign zero = !(a_in-b_in) ? 1:0;          //a-b=0이면 1, 나머진 0
endmodule



