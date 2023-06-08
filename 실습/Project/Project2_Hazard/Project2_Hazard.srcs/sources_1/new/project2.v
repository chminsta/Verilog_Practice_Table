module project2(
    input clk, rst_n,
    output [15:0] LED,
    output reg [1:0] i_clk
);
    
wire [31:0] R1, R4, R8;
wire branch, PCSrc, Stall;
wire [31:0] ALUResult_EX;
wire [1:0] EX_FWA, EXFWB;

MIPS AA(i_clk[1], rst_n, R1, R4, R8, branch, PCSrc, Stall, ALUResult_EX, EX_FWA, EX_FWB);
    
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
    i_clk <= 2'b0;
    end
    else begin
    i_clk <= i_clk + 1;
    end
end

assign LED[0] = branch;
assign LED[1] = PCSrc;
assign LED[2] = Stall;
assign LED[3] = (R1 == 32'd12);
assign LED[4] = (R4 == 32'd20);
assign LED[5] = (R8 == 32'd13);
assign LED[6] = (EX_FWA == 2'b10);
assign LED[7] = (EX_FWA == 2'b01);
assign LED[8] = (EX_FWA == 2'b00);
assign LED[9] = (EX_FWB == 2'b10);
assign LED[10] = (EX_FWB == 2'b01);
assign LED[11] = (EX_FWB == 2'b00);
assign LED[12] = (ALUResult_EX == 32'd12);
assign LED[13] = (ALUResult_EX == 32'd20);
assign LED[14] = (ALUResult_EX == 32'd13);
assign LED[15] = (ALUResult_EX == 32'd0);

endmodule
