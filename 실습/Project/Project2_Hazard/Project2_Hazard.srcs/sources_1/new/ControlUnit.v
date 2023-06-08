`timescale 1ns/10ps
module ControlUnit(
input [5:0] OP, Funct,
output reg [8:0] ControlSignal
);
// 8 : Branch __ 7-5 : ALUCtrl  4: ALUSrc  3: RegDst __ 2: MemWrite __ 1: RegWrite  0: MemtoReg
//MemtoReg// 1: output of data memory be write data input of register, 0: output of ALU go to  write data input of register. can be 'x'
//RegWrite// 1: use write register of register file
//MemWrite// 1: data write to data memory
//RegDst// 1: rd field be used to be register input , 0: rt field be used to be register input. can be 'x'
//ALUSrc// 1: second source is immediate value of sign_extended , 0: second source is register2 of register file
//[2:0] ALUCtrl// 3bit control signal to ALU {(bit inverse), (ALUOp)} 00: AND 01: OR 10: ADD
//Branch// 1: branch operation

reg [2:0] ALUctrl;

always @(*) begin
    case(OP)
    6'b000000 : // R-type
    begin
    case(Funct)
        6'b100000: ALUctrl = 3'b010; //add
        6'b100010: ALUctrl = 3'b110; //subtract
        6'b100100: ALUctrl = 3'b000; //AND
        6'b100101: ALUctrl = 3'b001; //OR
        6'b101010: ALUctrl = 3'b111; //slt
        default : ALUctrl = 3'b000;
    endcase
    ControlSignal = {1'b0,ALUctrl,5'b01_0_10};
    end
    6'b100011 : // lw (35)
    ControlSignal = 9'b0_010_10_0_11;
    
    6'b101011 : // sw (43)
    ControlSignal = 9'b0_010_10_1_00;
    
    6'b000100 : // beq (4)
    ControlSignal = 9'b1_000_00_0_00;
    
    6'b001000 : // addi (8)
    ControlSignal = 9'b0_010_10_0_10;
    
    default : 
    ControlSignal = 0;
    endcase
end
endmodule