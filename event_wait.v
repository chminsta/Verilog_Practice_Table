/*문제
Design timers and simulate with 3 different settings

1.They must start after 50ns (use event)
2.timer_a counts 10 cycles, timer_b counts 15 cycles, timer_c counts 20 cycles (use parameter)
3.simulate will finish when anyone of 3 timers finish its job (use fork)
*/

//gpt 한테 시키니까 에러 계속나오고 본인도 같은거 계속 고치는데 에러 몇개가 반복되는 굴레에서 못빠져나옴... 적어도 이번학기에는 완벽한 코딩을 불가능할듯
//그러므로 내가 어느정도 짜고 gpt한테 봐달라고 하는게 현실적일듯함

//design.sv

module timers (
    input clk, rstn
    output a,b,c
);
    parameter acycle = 10, bcycle = 15, ccycle = 20;
    always @(posedge clk , negedge rstn) begin
        if (!rstn) {a, b, c}= 0;
        else begin
            a = a+1;
            b = b+1;
            c = c+1;
            
        end
    end

    

        
    
endmodule
//포기,,,,


//정답

//design.sv
module moduleName #(
    parameters N=10
) (
    input clk, rstn, enable,
    output done
);
  reg [4:0] cnt;

  always @(posedge clk, negedge rstn) begin
    if(!rstn) cnt <= N;
    else if (cnt==0) cnt<=0;
    else if (enable) cnt<=cnt-1;
    assign done = cnt == 0;
  end  
endmodule



//tb

module tb_timer;

    
endmodule

//어렵다...