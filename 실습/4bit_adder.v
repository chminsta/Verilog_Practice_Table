//design.v

module half_adder_1bit (
    input x,y,
    output reg sum, c
);
    

    
    {c,sum}=x+y;        
    
endmodule

module full_adder_1bit (
    input x,y,c_in,
    output reg sum, c_out
);
    
    half_adder_1bit h_a_1b_1(.x(x), .y(y), .sum(sum1), .c(c1));          //half adder에 x,y를 넣어서 sum1과 c_in을 추출
    half_adder_1bit h_a_1b_2(.x(sum1), .y(c_in), .sum(sum), .c(c2)); //half adder에 c_in,sum1를 넣어서 최종 sum과 c2을 추출

  
  assign carry_out = c1 | c2;       //c1 or c2 하면 최종 c_out이 나옴
endmodule


module full_adder_4bit (
    input [0:3] x,y,
    output reg [0:3] sum
);
    reg [0:3] c;        //loop를 쓰기위한 carry벡터
    c[0]=0;
    always @(x,y) begin
        reg [0:1] i;             //i를 이용하여 loop를 돌릴 것인데 4비트라 0부터 3까지 필요하므로 2비트 벡터로 만들기
        for (i = 0; i < 4; i = i + 1) begin
            full_adder_1bit f_a_1b(
                .x(x[i]),        
                .y(y[i]),        
                .c_in(c[i]),     // 전 단계의 캐리
                .sum(sum[i]),    
                .c_out(c[i+1])   // 다음 단계의 캐리
            );
        end
    end


endmodule



//testbench

a=0, b=0, c_in=0
#10 a=