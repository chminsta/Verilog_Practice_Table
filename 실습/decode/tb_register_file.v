module tb_register_file; 
    reg clk;
    reg rstn;
    reg RegWrite;
    reg [4:0] R_reg1;
    reg [4:0] R_reg2;
    reg [4:0] W_reg;
    reg [31:0] W_data;
    reg [31:0] R_data1;
    reg [31:0] R_data2;
    
    always begin
        #5 clk = ~clk;
    end

register_file register_file1(
    .clk(clk),
    .rstn(rstn),
    .RegWrite(RegWrite),
    .R_reg1(R_reg1),
    .R_reg2(R_reg2),
    .W_reg(W_reg),
    .W_data(W_data),
    .R_data1(R_data1),
    .R_data2(R_data2)
);

initial begin
    $readmemh("reg_file.mem", register_file1.reg_file);
end

initial begin
    clk = 0; rstn = 1; RegWrite = 1;
    #5 R_reg1 = 5'd1; R_reg2 = 5'd0; W_reg = 5'd2; W_data = 32'd0;
    #10 R_reg1 = 5'd2; R_reg2 = 5'd2; W_reg = 5'd2; W_data = 32'd10;
    #10 R_reg1 = 5'd3; R_reg2 = 5'd4; W_reg = 5'd2; W_data = 32'd11;
    #10 R_reg1 = 5'd4; R_reg2 = 5'd6; W_reg = 5'd2; W_data = 32'd100;
    #10 $stop;
    
end

endmodule