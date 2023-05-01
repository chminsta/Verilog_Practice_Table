module tb_sign_extent
    reg [15:0] imm_value;
    wire [31:0] result;

sign_extent sign_extent(
    .imm_value(imm_value),
    .result(result)
);

initial begin
    #5 imm_value = 16'h0001;
    #5 imm_value = 16'hffff;
    #5 imm_value = 16'hf0f0;
    #5 imm_value = 16'h0f0f;
    #5 imm_value = 16'hf00f;
    #5 $stop;
    
end

endmodule