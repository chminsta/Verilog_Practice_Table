`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/30 16:24:25
// Design Name: 
// Module Name: mul8_uns
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mul8_uns (
input [3:0] a,          
input [3:0] b,          
input clk, rstn, start,
output reg [7:0] result,
output reg done
);
localparam IDLE = 3'b000,
            START = 3'b001,
            LSB = 3'b010,
            ADD = 3'b011,
            SHIFT = 3'b100,
            DONE = 3'b101;

reg [7:0] r_multiplicand, r_product;
reg [3:0] r_multiplier;
reg [2:0] r_state;
reg [1:0] r_count;


always @(posedge clk, negedge rstn) begin
        if (!rstn) begin
            r_multiplicand <=0;
            r_multiplier <=0;
            r_product <=0;
            r_count<=4;
           
            result <=0;
            done<=0;
        end
end

always @(*) begin
    case(r_state)
        IDLE:
        begin
            if (start) r_state = START;      //start 신호가 들어오면 시작
        end
        START:
        begin
            r_multiplicand={4'b0000,a};
            r_multiplier=b;
            r_state=LSB;
        end
        LSB:
        begin
            if (!r_multiplier[0]) r_state=SHIFT;
            else r_state=ADD;
        end
        ADD:
        begin
            r_product=r_multiplicand+r_product;
        end
        SHIFT:
        begin
            r_multiplicand=r_multiplicand << 1;      //shift left
            r_multiplier=r_multiplier >> 1;         //shift right
            r_count = r_count - 1;
            if (r_count) r_state = DONE;
            else r_state = LSB;

        end        
        DONE:
        begin
            result = r_product;
            done = 1;
        end
    endcase
end
endmodule

///////////////////////////////////////////////////gpt

`timescale 1ns / 1ps

module mul8_uns (
  input [3:0] a,          
  input [3:0] b,          
  input clk, rstn, start,
  output reg [7:0] result,
  output reg done
);

  localparam IDLE = 3'b000,
            START = 3'b001,
            LSB = 3'b010,
            ADD = 3'b011,
            SHIFT = 3'b100,
            DONE = 3'b101;

  reg [7:0] r_multiplicand, r_product;
  reg [3:0] r_multiplier;
  reg [2:0] r_state,next_state;
  reg [1:0] r_count;

always @(posedge clk, negedge rstn) begin
    if (!rstn) r_state <= IDLE;        
    else state<=next_state;
end
always @(*) begin
    case(state)
    IDLE:
    begin
        if (start) begin
            next_state = START;
        end
        else begin
            next_state=IDLE;
        end
    end
    START:begin
        next_state=LSB;
    end
    LSB:begin
        if(r_multiplier[0]) next_state = ADD;
        else next_state = SHIFT;
    end
    ADD: begin 
        next_state = SHIFT;
    end
    SHIFT:begin
        if(r_count != 0)next_state=LSB;
        else next_state = DONE;
    end
    DONE:begin
        next_state= IDLE;
    end
    default:begin
        next_state= IDLE;
    end
    endcase
end
always @(posedge clk, negedge rstn) begin
    if (!rstn) begin
      r_multiplicand <= 0;
      r_multiplier <= 0;
      r_product <= 0;
      r_count <= 4;
      result <= 0;
      done <= 0;
    end
    else begin
      case (next_state)
        IDLE:
            r_multiplicand <= 0;
            r_multiplier <= 0;
            r_product <= 0;
            r_count <= 4;
            result <= 0;
            done <= 0;
        START:
        begin
            r_multiplicand <= {4'b0000, a};
            r_multiplier = b;
            r_product <= 0;
            r_count <= 4;
            result <= 0;
            done <= 0;
        end
        LSB:
            r_multiplicand <= r_multiplicand; //순차회로에서 자기자신을 기억해라
            r_multiplier <= r_multiplier;
            r_count<=r_count -1;
            r_product <= 0;
            result <= 0;
            done <= 0;

        ADD:
          begin
            r_product = r_multiplicand + r_product;
          end
        SHIFT:
          begin
            r_multiplicand = r_multiplicand << 1;
            r_multiplier = r_multiplier >> 1;
            
          end
        DONE:
          begin
            result = r_product;
            done = 1;
          end
      endcase
    end
  end

endmodule

//testbench
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/30 17:24:16
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb;
    reg clk, rstn, start;
    reg [3:0] a,b;

    wire [7:0]result;
    wire done;

    initial begin
        clk=0;
        forever begin
            #5 clk=!clk;
        end    
    end

    mul8_uns mul8_uns(a,b,clk, rstn, start, result, done);

    
    initial begin
        a=0; b=0;
    #10 a=1; b=1;
    #10 a=3; b=5;
    #10 a=12; b=5;
    #10 a=14; b=13;
    #10 a=8;b=4;
    #10 a=2; b=7;
    #10 a=3; b=2;
    #10 a=4; b=7;
    #10 a=2; b=4;
    #10 a=10; b=10;
    #10 a=11; b=15;
    #10 a=12; b=12;
    #10 a=13; b=15;
    #10 a=2; b=2;
    #10 $finish;
    end

    initial begin
        rstn = 1;
        #10 rstn=0;
    end

    initial begin
        start = 0;
        #20 start = 1;
    end

endmodule


/////////////gpt

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/30 17:24:16
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb;
    reg clk, rstn, start;
    reg [3:0] a,b;

    wire [7:0]result;
    wire done;

    mul8_uns mul8_uns(a,b,clk, rstn, start, result, done);

    initial begin
        clk=0;
        forever begin
            #5 clk=!clk;
        end    
    end

    initial begin
        a=0; b=0;
        rstn = 0;
        #10 rstn=1;
        #20 start = 1;
        #100;
        #10 start = 0;
        #100;
        a=1; b=1;
        #200;
        a=3; b=5;
        #200;
        a=12; b=5;
        #200;
        a=14; b=13;
        #200;
        a=8;b=4;
        #200;
        a=2; b=7;
        #200;
        a=3; b=2;
        #200;
        a=4; b=7;
        #200;
        a=2; b=4;
        #200;
        a=10; b=10;
        #200;
        a=11; b=15;
        #200;
        a=12; b=12;
        #200;
        a=13; b=15;
        #200;
        a=2; b=2;
        #200;
        $finish;
    end

endmodule
