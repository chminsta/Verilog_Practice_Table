// design
module meely_fsm_bychangmin (
    input clk,     // clk 
    input rstn,     // 리셋
    input din_bit,  //input, 0110이여야함
    
    output wire detect_out  // output 
);

// ST state를 나타내는 파라미터 정의, START를 state0으로 정의
parameter ST0 = 0, ST1 = 1, ST2 = 2, ST3 = 3, ST4 = 4;

// curr_state 정의, 초기는 ST0
  reg [2:0] curr_state = ST0;

// 다음 state 정하기
always @(posedge clk , negedge rstn) begin
    case (curr_state)
        ST0: if (rstn) curr_state = ST0; else if(!din_bit) curr_state=ST1; else curr_state = ST0; 
        //리셋이 1이면 start, input 0 이면 다음 state, input이 1이면 start에서 유지
        ST1: if (rstn) curr_state = ST0; else if(din_bit) curr_state=ST2; else curr_state = ST1;
        //리셋이 1이면 start, input 1 이면 다음 state, input이 0이면 st1에서 유지, st1인 이유는 다음 0110의 시작이 될 수 있기 때문
        ST2: if (rstn) curr_state = ST0; else if(din_bit) curr_state=ST3; else curr_state = ST1;
        //리셋이 1이면 start, input 1 이면 다음 state, input이 0이면 st1로 돌아감, st1인 이유는 다음 0110의 시작이 될 수 있기 때문
        ST3: if (rstn) curr_state = ST0; else if(!din_bit) curr_state=ST4; else curr_state = ST0;
        //리셋이 1이면 start, input 0 이면 다음 state, input이 1이면 start로 돌아감
        ST4: if (rstn) curr_state = ST0; else if(din_bit) curr_state=ST2; else curr_state = ST0;
        //리셋이 1이면 start, input 1 이면 state2, input이 0이면 start로 돌아감
    endcase
end

// detect_out 정의
always @(curr_state) begin
    case (curr_state)
        ST0: detect_out = 0;
        ST1: detect_out = 0;
        ST2: detect_out = 0;
        ST3: detect_out = 0;
        ST4: detect_out = 1;
    endcase
end

endmodule







//testbench
module tb;
    reg clk, rstn, din_bit;
    wire detect_out;

    initial begin
        clk=0;
        forever begin
            #10 clk=~clk;
        end    
    end

    meely_fsm_bychangmin meely_fsm_bychangmin(clk, rstn, din_bit, detect_out);
    
    
    initial begin
        din_bit=0;
    #10 din_bit=1;
    #10 din_bit=0;
    #10 din_bit=1;
    #10 din_bit=1;
    #10 din_bit=0;
    #10 din_bit=0;
    #10 din_bit=1;
    #10 din_bit=0;
    #10 din_bit=0;
    #10 din_bit=1;
    #10 din_bit=1;
    #10 din_bit=0;
    #10 din_bit=1;
    #10 din_bit=1;
    #10 din_bit=0;
    #10 $finish;
    end

    initial begin
        rstn = 1;
        #5 rstn=0;
    end

    initial begin
        $dumpfile("dump.vcd"); 
        $dumpvars;
    end
endmodule