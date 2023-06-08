`timescale 1ns/10ps
module MUX3(
    input [1:0] FW,
    input [31:0] EX, WB, MEM,  // the order is of urgency
    output reg [31:0] Operand
    );
    
always @(*)
    case(FW)
    2'b00: Operand = EX;
    2'b01: Operand = WB;
    2'b10: Operand = MEM;
    default: Operand = 0;
    endcase
endmodule