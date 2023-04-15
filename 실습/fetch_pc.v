module PC (     //program counter 설계
    input i_clk, i_rstn,
    input [31:0] i_PC,
    output reg [31:0] o_PC
);
//clk마다 rstn이 1이면 i_PC에 o_PC로 출력
    always @(posedge clk, negedge i_rstn) begin
        begin
            if(!i_rstn)
            begin
                o_PC <= 32'd0;
            end
            else
            begin
                o_PC <= i_PC;
            end
        end
    end
endmodule







