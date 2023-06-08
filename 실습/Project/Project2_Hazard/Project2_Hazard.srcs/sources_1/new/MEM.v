`timescale 1ns/10ps
module MEM (
    input rst_n,
    input MemWrite,
    input [31:0] addr, MemWritedata,
    output [31:0] Rdata
);
reg [31:0] mem [0:12];

always @(negedge rst_n)
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
end

always @(MemWrite, addr, MemWritedata)
if(MemWrite)
    mem[addr] = MemWritedata;

assign Rdata = mem[addr];
endmodule