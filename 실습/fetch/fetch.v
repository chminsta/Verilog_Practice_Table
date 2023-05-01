module fetch (
    input i_clk, i_rstn, PCSrc,             //mux 0 or 1
    input [31:0] PC_immed, i_PC                  //mux 1이면 PC=PC+PC_immed

    output reg [31:0] o_instruction
);
wire [31:0] plus4;
wire [31:0] newPC

    always @(posedge i_clk, negedge i_rstn) begin
        plus4=i_PC+4;
        if (PCSrc) newPC<=PC_immed;
        else newPC<=plus4;
        i_PC=newPC
    end

    always @(posedge i_clk, negedge i_rstn ) begin
        iMEM #(
        .MEM_DEPTH(MEM_DEPTH)
        )iMEM(
        .i_clk(i_clk),
        .i_rstn(i_rstn),
        .i_PC(i_PC),
        .o_instruction(o_instruction)
    )        
    end
endmodule