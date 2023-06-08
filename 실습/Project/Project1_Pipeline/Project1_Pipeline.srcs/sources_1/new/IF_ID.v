module IF_ID(
    input clk, rst_n,
    input [31:0] i_PCnext,
    input [31:0] i_inst,
    output reg [31:0] o_PCnext,
    output reg [31:0] o_inst
);
always@(posedge clk, negedge rst_n) begin
if(!rst_n) {o_PCnext, o_inst} <= 64'b0;
else {o_PCnext, o_inst} <= {i_PCnext, i_inst};
end
endmodule