module Data_memory(
    input clk, rst_n,
    input MemWrite,
    input MemRead,
    input [31:0] addr, MemWritedata,
    output reg [31:0] Readdata,
    output [31:0] mem_16
);
reg [31:0] mem [0:16];

always @(posedge clk or negedge rst_n) begin
if(!rst_n) begin
    mem[0] <= 32'd0;
    mem[1] <= 32'd1;
    mem[2] <= 32'd2;
    mem[3] <= 32'd3;
    mem[4] <= 32'd4;
    mem[5] <= 32'd5;
    mem[6] <= 32'd6;
    mem[7] <= 32'd7;
    mem[8] <= 32'd8;
    mem[9] <= 32'd9;
    mem[10] <= 32'd10;
    mem[11] <= 32'd11;
    mem[12] <= 32'd12;
    mem[13] <= 32'd13;
    mem[14] <= 32'd14;
    mem[15] <= 32'd15;
    mem[16] <= 32'd16;
end
else begin
if(MemWrite) mem[addr] <= MemWritedata;
end
end

always @(MemRead or addr) begin
if(MemRead) Readdata = mem[addr];
else Readdata = 32'd0;
end

assign mem_16 = mem[16];
endmodule