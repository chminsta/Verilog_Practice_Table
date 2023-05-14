module IF_ID (
    input i_clk, i_rstn,
    input[31:0] i_PCplus4, i_instruction,
    output reg [31:0] 0_PCplus4,
    output reg [31:0] 0_instruction
);
    always @(posedge i_clk, negedge i_rstn ) begin
        if (!i_rstn) begin
            o_PCplus4   <= 32'd0;
            o_instruction   <= 32'd0;
            
        end
        else
        begin
            o_PCplus4 <= i_PCplus4;
            o_instruction <= i_instruction;
            
        end
    end
endmodule