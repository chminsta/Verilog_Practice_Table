module ALU_Control(
    input [1:0] ALUOp,
    input [5:0] funct,
    output reg [3:0] ALUctrl
);

always @(*) begin
case(ALUOp)
2'b00: ALUctrl = 4'b0010;
2'b01: ALUctrl = 4'b0110;
2'b10: 
case(funct)
6'b100000: ALUctrl = 4'b0010; //add
6'b100010: ALUctrl = 4'b0110; //subtract
6'b100100: ALUctrl = 4'b0000; //AND
6'b100101: ALUctrl = 4'b0001; //OR
6'b101010: ALUctrl = 4'b0111; //slt
default : ALUctrl = 4'b0000;
endcase
default : ALUctrl = 4'b0000;
endcase
end
endmodule