module register_file (
    input clk,
    input rstn,
    input RegWrite,
    input [4:0] R_reg1,
    input [4:0] R_reg2,
    input [4:0] W_reg,
    input [31:0] W_data,
    output reg [31:0] R_data1,
    output reg [31:0] R_data2
    
);
    reg[31:0] reg_file [0:31];
    integer i;

    always @(posedge clk, negedge rstn) begin
        if(!rstn)
        begin
            for (i=0; i<32; i=i+1)
            begin
                regfile[i] <= 32'd0;
            end
        end
        else
        begin
            R_data1 <= reg_file[R_reg1];
            R_ddata2 <= reg_file[R_reg2];
            if (RegWrite) begin
                reg_file[W_reg] <= W_data;
            end
        end
    end
endmodule