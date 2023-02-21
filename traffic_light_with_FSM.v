/*문제
Implement traffic light with FSM

[1]Red will go to Yellow after 30 cycles
[2]Yellow will go to Green after 5 cycles
[3]Green will go to Red after 20 cycles
[4]The light color will be output

*/

//design.sv

module traffic #(
    localparam [1:0] red = 00, yellow =01, green = 10; 
) (
    input clk, rstn,
    output light
);
    reg [4:0] cnt;


    always @(posedge clk , negedge rstn) begin
        if (!rstn) {light, next_light} = red, cnt=0;
        else begin
            cnt=cnt+1, light=next_light;
        end
    end

    always @(posedge clk , negedge rstn) begin
        next_light = light;
        case (light)
            S00 :   if(cnt==30)     cnt=0, next_light = yellow;
            S01 :   if(cnt==5)      cnt=0, next_light = green;
            S10 :   if(cnt==20)      cnt=0, next_light = red;
            
            default: next_light = red;
        endcase
        
    end

endmodule


module tb;
    reg clk,rstn;
    wire [4:0] light;
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        rstn = 1;
        #10 rstn = 0;
        #20 rstn = 1;
        
    end
    
    initial begin //영원히 가니까 끝내기
        #30000 $finish;
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0,tb);
    end
    traffic u_traffic(clk,rstn,light)
endmodule



//2차

// Code your testbench here
// or browse Examples
module tb;
    reg clk,rstn;
    wire [4:0] light;
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        rstn = 1;
        #10 rstn = 0;
        #20 rstn = 1;
        
    end
    
    initial begin //영원히 가니까 끝내기
        #30000 $finish;
    end
    
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0,tb);
    end
  traffic u_traffic(clk,rstn,light);
endmodule

// Code your design here
module traffic #(
    parameter [1:0] red = 00, yellow =01, green = 10 
) (
    input clk, rstn,
  output reg [1:0] light
);
    reg [4:0] cnt;
 	reg [1:0] next_light;

    always @(posedge clk , negedge rstn) begin
      if (!rstn) begin
        {light, next_light} = red;
        cnt=0;
      end
        else begin
            cnt=cnt+1; light=next_light;
        end
    end

    always @(posedge clk , negedge rstn) begin
        next_light = light;
        case (light)
           00 :   if(cnt==30)     cnt=0; next_light = yellow;
           01 :   if(cnt==5)      cnt=0; next_light = green;
           10 :   if(cnt==20)      cnt=0; next_light = red;
            
            default: next_light = red;
          
        endcase
    
    end

endmodule

//갓피티 첨삭, 성공!!

// Code your design here
module traffic #(
    parameter [1:0] red = 2'b00, yellow = 2'b01, green = 2'b10 
) (
    input clk, rstn,
    output reg [1:0] light
);
    reg [4:0] cnt;
    reg [1:0] next_light;

    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            {light, next_light} = red;
            cnt=0;
        end else begin
            cnt=cnt+1;
            light=next_light;
        end
    end

    always @(posedge clk or negedge rstn) begin
        next_light = light;
        case (light)
            2'b00:   if(cnt==30) begin
                        cnt=0;
                        next_light = yellow;
                      end
            2'b01:   if(cnt==5) begin
                        cnt=0;
                        next_light = green;
                      end
            2'b10:   if(cnt==20) begin
                        cnt=0;
                        next_light = red;
                      end
            default: next_light = red;
        endcase
    end

endmodule

// Code your testbench here
module tb;
    reg clk,rstn;
    wire [1:0] light;
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        rstn = 1;
        #10 rstn = 0;
        #20 rstn = 1;
    end
    
    initial begin //영원히 가니까 끝내기
        #30000 $finish;
    end
    
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0,tb);
    end
    traffic u_traffic(clk,rstn,light);
endmodule
