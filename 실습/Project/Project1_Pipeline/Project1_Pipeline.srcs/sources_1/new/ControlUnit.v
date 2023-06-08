module ControlUnit(
input [5:0] op,
output reg [8:0] ControlSignal
// 8-7 : ALUOp, 6: ALUSrc, 5: RegDst __ 4: Branch, 3: MemRead, 2: MemWrite __ 1: RegWrite, 0: MemtoReg
);
//MemtoReg// 1: output of data memory be write data input of register, 0: output of ALU go to  write data input of register. can be 'x'
//RegWrite// 1: use write register of register file
//MemWrite// 1: data write to data memory
//MemRead// 1: data read from data memory
//Branch// 1: branch operation
//RegDst// 1: rd field be used to be register input , 0: rt field be used to be register input. can be 'x'
//ALUSrc// 1: second source is immediate value of sign_extended , 0: second source is register2 of register file
//[1:0] ALUOp // 2bit control to ALU
always @(*) begin
    case(op)
    6'b000000 : // R-type
    ControlSignal = 9'b10_01_000_10;
    
    6'b100011 : // lw (35)
    ControlSignal = 9'b00_10_010_11;
    
    6'b101011 : // sw (43)
    ControlSignal = 9'b00_10_001_00;
    
    6'b000100 : // beq (4)
    ControlSignal = 9'b01_00_100_00;
    
    6'b001000 : // addi (8)
    ControlSignal = 9'b00_10_000_10;
    
    default : 
    ControlSignal = 9'b00_00_000_00;
    endcase
end
endmodule
