/*
문제1) 4비트 카운터를 만들어라
*/
module 4bitcounter;
    reg[3:0] = num;

    initial begin
        num = 0;
    
    end

    initial begin
        forever #10 num++;
    end
    
    initial begin
        $dumpfile("wave vcd");
        $dumpvars(0, 4bitcounter);
    end
endmodule
//
//고칠점 모듈이름 4로 시작하면 안된다.

//////////////////////////////////////////////////////////////

//정답



//실험해보니까 testbench 에 있는 변수랑 design의 변수랑 같지 않아도 된다

//design.sv
module counter_4bit (
    input   clk, rstn,
    output  reg [3:0] cnt
);
    always @(posedge clk ,negedge rstn) begin
        if(!rstn)   cnt <=0;
        else        cnt <= cnt + 1;

    end
    
endmodule

//testbench.sv
module tb;

    reg clk, rstn; //인풋값
    wire [3:0] cnt; //아웃풀값으로 필요한데 없으므로 wire

    initial begin //클락 만들기
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin //리셋 임의로 설정하기
        rstn = 1;
        #10 rstn = 0;
        #20 rstn = 1;
        
    end

    initial begin //영원히 가니까 끝내기
        #100 $finish;
    end

    counter_4bit u_counter_4bit(clk, rstn, cnt);

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0,tb);
    end
endmodule





/*
문제2) 시계를 만들어라.
*/

//design.sv
module clock (
	input clk,rstn,
	output reg[4:0]hour,
	output reg[5:0]min, sec
);


    always @(posedge clk ,negedge rstn) begin

        if (!rstn) begin
            hour<=0;
            min<=0;
            sec<=0; 
        end
        else begin
            
            forever begin
                
            
                while (hour<24)begin
                  while(min<60)begin
                    	while (sec<60)begin
                            #1
                            sec=sec+1;
                        end
                        sec = 0;
                        min=min+1;
                    end
                    min = 0;
                    hour=hour+1;
                end
                hour = 0; 
            end    
        
        end
    end    

endmodule

//testbench.sv

module tb2;
    reg [4:0] hour;
    reg [5:0] min,sec;

    initial begin
        hour <= 0;
        min <= 0;
        sec <= 0;
        
    end

    clock u_clock(clk,rstn,hour,min,sec)

    initial begin //클락 만들기
        clk = 0;
        forever #5 clk = ~clk;
    end

        initial begin //리셋 임의로 설정하기
        rstn = 1;
        #10 rstn = 0;
        #20 rstn = 1;
        
    end

        initial begin //영원히 가니까 끝내기
        #1000000 $finish;
    end

        initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0,tb);
    end
endmodule


//틀려서 chatgpt로 고쳐보았고 성공은함

module tb2;

  reg clk,rstn;
  wire [4:0] hour;
  wire [5:0] min, sec;

  clock u_clock(clk,rstn,hour,min,sec);

  initial begin //Create the clock
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin //Arbitrarily set the reset
    rstn = 1;
    #10 rstn = 0;
    #20 rstn = 1;
  end

  initial begin //End forever loop
    #1000000 $finish;
  end

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, tb2);
  end
endmodule


//그래서 정답은?
//design.sv
module watch (
    input clk,rstn,
    output reg [3:0] hour,
    output reg [5:0] minute
    
);

always @(posedge clk,negedge rstn) 
    if(!rstn)   minute <=0;
    else begin
        if (minute == 59) minute<=0;
        else minute <= minute+1;
    end
    
always @(posedge clk, negedge rstn) begin
    if (!rstn)  hour <= 0;
    else begin
        if (hour == 11 && minute == 59) hour <=0;
        else if (minute == 59) hour <= hour +1;
    end
end

endmodule

//testbench.sv

module tb3;

    reg clk, rstn; //인풋값
    wire [3:0] hour; //아웃풀값으로 필요한데 없으므로 wire
    wire [5:0] minute;
    initial begin //클락 만들기
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin //리셋 임의로 설정하기
        rstn = 1;
        #10 rstn = 0;
        #20 rstn = 1;
        
    end

    initial begin //영원히 가니까 끝내기
        #30000 $finish;
    end

    watch u_watch(clk, rstn, hour, minute);

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0,tb);
    end
endmodule


//실험결과 잘 나온다!