module PC(
    input clk, // clk signal using when positive edge
    input rst_n, // reset when 0
    input [31:0] PC_in, // next instruction adderss
    output reg [31:0] PC_out // current instruction adderss
);

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n) PC_out <= 32'd0;
    else PC_out <= PC_in;
end
endmodule
