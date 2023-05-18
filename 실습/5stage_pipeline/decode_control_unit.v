module Control_Unit (
    input [5:0] op,
    output reg MemtoReg, MemWrite, MemRead, Branch, 
    output reg ALUSrc, RegDst, RegWrite,
    output reg [1:0] ALUOp

);
    always @(*) begin
        case (op)
            6'b000000 : //R 타입인 경우
            begin
                RegWrite = 1'b1;
                RegDst = 1'b1;
                ALUSrc = 1'b0;
                Branch = 1'b0;
                MemWrite = 1'b0;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                ALUOp = 2'b10;
            end 
            6'b100011 : //LW 인 경우
            begin
                RegWrite = 1'b1;
                RegDst = 1'b0;
                ALUSrc = 1'b1;
                Branch = 1'b0;
                MemWrite = 1'b0;
                MemRead = 1'b1;
                MemtoReg = 1'b1;
                ALUOp = 2'b00;
            end
            6'b101011 : //SW 인 경우
            begin
                RegWrite = 1'b0;
                RegDst = 1'bx;
                ALUSrc = 1'b1;
                Branch = 1'b0;
                MemWrite = 1'b1;
                MemRead = 1'b0;
                MemtoReg = 1'bx;
                ALUOp = 2'b00;
            end
            6'b000100 : //beq 인 경우
            begin
                RegWrite = 1'b0;
                RegDst = 1'bx;
                ALUSrc = 1'b0;
                Branch = 1'b1;
                MemWrite = 1'b0;
                MemRead = 1'b0;
                MemtoReg = 1'bx;
                ALUOp = 2'b01;
            end
            6'b001000 : //addi 인 경우
            begin
                RegWrite = 1'b1;
                RegDst = 1'b0;
                ALUSrc = 1'b1;
                Branch = 1'b0;
                MemWrite = 1'b0;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                ALUOp = 2'b00;               
            end  
            
            default: 
            begin
                RegWrite = 1'bx;
                RegDst = 1'bx;
                ALUSrc = 1'bx;
                Branch = 1'bx;
                MemWrite = 1'bx;
                MemRead = 1'bx;
                MemtoReg = 1'bx;
                ALUOp = 2'bxx;
            end  
        endcase
    end
endmodule