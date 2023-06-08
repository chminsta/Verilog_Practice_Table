module Execute(
    input [31:0] A_in, B_in,
    input [1:0] ALUOp,
    input [5:0] funct,
    output [31:0] result,
    output zero
);
wire [3:0] ALUctrl;

ALU_Control ALUCONTROL(ALUOp, funct, ALUctrl);
ALU ALU(A_in, B_in, ALUctrl, result, zero);
endmodule