module ALU_Control (
    input [1:0] ALUOp,
    input [5:0] funct,
    output reg [3:0] ALUCtrl
);

always @(*) begin
    if (ALUOp==2'b00 || (ALUOp==2'b10 && funct==6'b100000)) ALUCtrl=4'b0010;         //LW,SW,add->add
    else if(ALUOp==2'b01 || (ALUOp==2'b10 && funct==6'b100010)) ALUCtrl=4'b0110;     //be,subtract->sub
    else if(ALUOp==2'b10 && funct==6'b100100) ALUCtrl=4'b0000;                       //and->and
    else if(funct==6'b100101) ALUCtrl=4'b0001;                                       //ALUOp는 이미 10, or
    else ALUCtrl=4'b0111;                                                            //slt

end    
endmodule