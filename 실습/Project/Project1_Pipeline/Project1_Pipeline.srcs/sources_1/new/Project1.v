module Project1(
    input clk, rst_n,
    output [15:0] LED,
    output reg [1:0] i_clk
    );
wire [31:0] R1, R4, R6, R9;
wire [31:0] mem_16;
wire branch;
wire [31:0] ALUResult_EX;
wire [31:0] Rdata_MEM;

MIPS_5stage AA(i_clk[1], rst_n, branch, R1, R4, R6, R9, mem_16, ALUResult_EX, Rdata_MEM);

always @(posedge clk or negedge rst_n) begin
if(!rst_n) begin
i_clk <= 0;
end
else begin
i_clk <= i_clk + 1;
end
end

assign LED[0] = branch;
assign LED[1] = i_clk[1];
assign LED[2] = ~i_clk[1];
assign LED[3] = rst_n;
assign LED[4] = (R1 == 32'd5);
assign LED[5] = (R4 == 32'd10);
assign LED[6] = (R6 == 32'hFFFFFFFF);
assign LED[7] = (R9 == 32'd14);
assign LED[8] = (mem_16 == 32'd11);
assign LED[9] = (Rdata_MEM == 32'd14);
assign LED[10] = (ALUResult_EX == 32'd5);
assign LED[11] = (ALUResult_EX == 32'd10);
assign LED[12] = (ALUResult_EX == 32'hFFFFFFFF);
assign LED[13] = (ALUResult_EX == 32'd14);
assign LED[14] = (ALUResult_EX == 32'd16);
assign LED[15] = (ALUResult_EX == 32'd0);

endmodule
