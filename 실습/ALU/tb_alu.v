module tb_alu;

reg signed [31:0] a_in;
reg signed [31:0] b_in;
reg [1:0] ALUOp;
reg [5:0] funct;
wire [3:0] ALUCtrl;
wire signed [31:0] result;
wire zero;

ALU_Control alucontrol(ALUOp,funct,ALUCtrl);

ALU alu(a_in, b_in, ALUCtrl, result, zero);

initial begin
    a_in = 32'd222; b_in = 32'd444; ALUOp=2'b00; funct=6'b100000;       //LW,SW
    #10 ALUOp=2'b01;    //be, a!=b
    #10 a_in = 32'd444; //be, a=b
    #10 ALUOp=2'b10;    //add 444+444
    #10 funct=6'b100010;    //sub 444-444
    #10 a_in=32'h0f0f; b_in=32'h00ff funct=6'b100100; //0f0f and 00ff 예상:000f
    #10 funct=6'b100101;    //0f0f of 00ff 예상:0fff
    #10 funct=6'b101010;    //0f0f>00ff 예상:0
    #10 a_in=32'h0001;      //0001<00ff 예상:1


end
endmodule

