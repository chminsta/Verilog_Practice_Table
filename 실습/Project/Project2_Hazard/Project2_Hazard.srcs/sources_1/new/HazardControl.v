`timescale 1ns/10ps
module HazardControl(
    input [4:0] ID_Rs, ID_Rt,
    input [4:0] EX_Rs, EX_Rt,
    input [4:0] EX_Dst, MEM_Dst, WB_Dst,
    input Branch,
    input [1:0] EX_ControlSignal, MEM_ControlSignal, WB_ControlSignal,
    // signal[1] = RegWrite : necessary condition for hazard, signal[0] = MemtoReg : Indicating lw instruction.
    output Stall, // Branch, lw stall can be integrated
    output ID_FWA, ID_FWB,
    output reg [1:0] EX_FWA, 
    output reg [1:0] EX_FWB // 00: Select data from EX, 01: Select data from MEM, 10: Select data from WB
);

assign Stall = (EX_ControlSignal[0] && ((ID_Rs == EX_Dst)||(ID_Rt == EX_Dst))) ||
                (Branch && ((EX_ControlSignal[1] && ((ID_Rs == EX_Dst)||(ID_Rt == EX_Dst)))||(MEM_ControlSignal[0] && ((ID_Rs == MEM_Dst)||(ID_Rt == MEM_Dst)))));
assign ID_FWA = !Stall && Branch && MEM_Dst && MEM_ControlSignal[1] && (ID_Rs == MEM_Dst);
assign ID_FWB = !Stall && Branch && MEM_Dst && MEM_ControlSignal[1] && (ID_Rt == MEM_Dst);

always @(*) begin
if(MEM_ControlSignal[1] && MEM_Dst && (EX_Rs == MEM_Dst)) EX_FWA = 2'b10;
else if(WB_ControlSignal[1] && WB_Dst && (EX_Rs == WB_Dst)) EX_FWA = 2'b01;
else EX_FWA = 2'b00;

if(MEM_ControlSignal[1] && MEM_Dst && (EX_Rt == MEM_Dst)) EX_FWB = 2'b10;
else if(WB_ControlSignal[1] && WB_Dst && (EX_Rt == WB_Dst)) EX_FWB = 2'b01;
else EX_FWB = 2'b00;
end

endmodule