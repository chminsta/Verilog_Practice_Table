module tb_Control_unit;

reg [5:0] op;
wire MemtoReg, MemWrite, MemRead, Branch, 
wire ALUSrc, RegDst, RegWrite,
wire [1:0] ALUOp

Control_Unit Control_Unit(
    .op(op),
    .MemtoReg(MemtoReg),
    .MemWrite(MemWrite),
    .MemRead(MemRead),
    .Branch(Branch),
    .ALUSrc(ALUSrc),
    .RegDst(RegDst),
    .RegWrite(RegWrite),
    .ALUOp(ALUOp)
);

initial begin
    #5 op= 6'b000000; //R타입
    #5 op= 6'b100011; //LW
    #5 op= 6'b101011; //SW
    #5 op= 6'b000100; //beq
    #5 op= 6'b000000; //R타입
    #5 op= 6'b100011; //LW
    #5 op= 6'b101011; //SW
    #5 op= 6'b000100; //beq
    #5 $stop;

    
end 
endmodule