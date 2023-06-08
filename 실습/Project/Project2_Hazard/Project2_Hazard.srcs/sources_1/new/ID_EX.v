`timescale 1ns/10ps
module ID_EX(
    input clk,rst_n,
    input [7:0] ControlSignal_ID,
    input [31:0] Rdata1_ID, Rdata2_ID,
    input [4:0] Rs_ID, Rt_ID, Rd_ID,
    input [31:0] SignImme_ID,
    input CLR, // for Flush
    output reg [7:0] EX_ControlSignal,
    output reg [31:0] EX_Rdata1, EX_Rdata2,
    output reg [4:0] EX_Rs, EX_Rt, EX_Rd,
    output reg [31:0] EX_SignImme
);

always @(posedge clk or negedge rst_n) begin
    if(!rst_n || CLR) {EX_ControlSignal, EX_Rdata1, EX_Rdata2, EX_Rs, EX_Rt, EX_Rd, EX_SignImme} <= 0;
    else {EX_ControlSignal, EX_Rdata1, EX_Rdata2, EX_Rs, EX_Rt, EX_Rd, EX_SignImme} 
    <= {ControlSignal_ID, Rdata1_ID, Rdata2_ID, Rs_ID, Rt_ID, Rd_ID, SignImme_ID};
end
endmodule