/*procedure block
initial : execute only once at time zero
always  : execute over and over, with condition defined at @

begin-end : sequential executes
fork-join :parallel executes
*/

//initial
initial begin
    a=0;
    a=~a;

end


//always
always @(posedge clk, negedge rstn ) begin
    if  (!rstn) a<=0;
    else    a<=~a;

end

initial begin
    #10 a=1; //time 10:a=1
    #20 b=1; //time 30:b=1
    #30 c=1; //time 60:c=1
    
end

initial begin
    a=0; b=0; c=0;
    fork // 동시에, 포크처럼
    #10 a=1; //time 10:a=1
    #20 b=1; //time 20:b=1
    #30 c=1; //time 30:c=1
    join
end

//net type can not be used in precedure block
//reg, int, real 같은 variable

//Every procedure block executes concurrent.

/***********중요
*Block assignment   =
순서대로 실행
이전라인이 다음라인을 Block
a=b;

*Non-Blocking assingment    <=
parallel 하게 실행
이전라인이 다음라인을 Block 하지 않음
a<=b;

중요! Do not mix blocking & non-blocking in a procedure!!
*/


initial begin
    #10 a=0;
    #20 a=1; //30초
end

initial begin
    #10 b<=0;
    #20 b<=1; //30초
end

initial begin
    c = #10 0;
    c = #20 1; //30초
end

initial begin
    b <= #10 0;
    b <= #20 1; //20초
end



//a,b를 스왑?

initial begin
    a=0; b=1;
    #10
    a <= b;
    b <= a; //성공 a=1,b=0
end

initial begin
    c=0; d=1;
    #10
    c = d;
    d = c; //실패 c=1,d=0
end

//실험

module swap_test 
    reg blk_a,blk_b;
    reg nbk_a,nbk_b;

    initial begin
        blk_a=0; blk_b=1;
        #10;
        blk_a = blk_b;
        blk_b = blk_a;
        #5;
    end

    initial begin
        nbk_a=0; nbk_b=1;
        #10;
        nbk_a <= nbk_b;
        nbk_b <= nbk_a;
        #5;
    end    
    
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0,swap_test);
    end
endmodule

//결과 non blocking이 성공적이다.


//실험2 blocking 과 non blocking을 같이 쓰면? 안쓰는게 좋긴함

initial begin
    e=0; f=1;
    #12
    e <= f; //e=1, block안함
    f = e; //f=0
end

initial begin
    g=0; h=1;
    #13
    g = h; //g=1, 막힘
    h <= g;//h=1

end


initial begin
    i=0; j=1;
    #14
    i<=j;   //i=1
    #1      //1초 딜레이 때문에 i=1적용
    j<=i;   //h=i
end



/* 
*always@

    always @(a,b)               when a or b changes
    always @(*)                 any signal event who affects output of this procedure

    always @(posedge clk)       clk rising
    always @(negedge rstn)      rstn falling 

    *많이 쓰는거
    always @*                   어떤 시그널이든 반응, like a [Combinational logic]
    always @ (posedge clk, negedge rstn)    ','는 or라는 의미, like a [sequential logic (FF)]

*/

//always 실험

module always_test;
    reg [2:0] blk_a, blk_b, blk_c, blk_d, blk_e;
    reg [2:0] nbk_a, nbk_b, nbk_c, nbk_d, nbk_e;


    initial begin
        blk_a=0;nbk_a=0;
        #10;
        blk_a=1;nbk_a=1;
        #10;
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0,always_test);
    end
    always @(*) begin       //순차적으로 ,각각 한번씩
        blk_b = blk_a+1;
        blk_c = blk_b+1;
        blk_d = blk_c+1;
        blk_e = blk_d+1;
        
    end

    always @(*) begin       //순차적으로 , 마지막은 4번트리거
        nbk_b <= nbk_a+1;
        nbk_c <= nbk_b+1;
        nbk_d <= nbk_c+1;
        nbk_e <= nbk_d+1;
        
    end
endmodule

//결과 모두 0,1,2,3,4 에서  1,2,3,4,5로 올라감!

//always 실험2

module always_test2;
    reg [2:0] blk_a, blk_b, blk_c, blk_d, blk_e;
    reg [2:0] nbk_a, nbk_b, nbk_c, nbk_d, nbk_e;


    initial begin
        blk_a=0;nbk_a=0;
        #10;
        blk_a=1;nbk_a=1;
        #10;
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0,always_test2);
    end
    always @(blk_a) begin       
        blk_c = blk_b+1;
        blk_d = blk_c+1;
        blk_e = blk_d+1;
        
    end

    always @(nbk_a) begin       
        nbk_b <= nbk_a+1;
        nbk_c <= nbk_b+1;
        nbk_d <= nbk_c+1;
        nbk_e <= nbk_d+1;
        
    end
endmodule

//결과 차이를 보임


//always실험3 sequential logic

module always_test3; 
    reg [2:0]   blk_a, blk_b, blk_c, blk_d, blk_e;
    reg [2:0]   nbk_a, nbk_b, nbk_c, nbk_d, nbk_e;
    reg         clk, rstn;

    initial begin
        clk=0;
        forever #5 clk=~clk
            
    end
    
    initial begin
        rstn = 1;
        #10 rstn = 0;
        #20 rstn = 1;
    end
    always @(posedge clk, negedge rstn) begin
        if(!rstn){blk_a,blk_b,blk_c,blk_d,blk_e}=0;
        else begin
            blk_a = 1;
            blk_b = blk_a + 1;
            blk_c = blk_b + 1;
            blk_d = blk_c + 1;
            blk_e = blk_d + 1;
             
        end
        
    end

    always @(posedge clk, negedge rstn) begin
        if(!rstn){nbk_a,nbk_b,nbk_c,nbk_d,nbk_e}=0;
        else begin
            nbk_a <= 1;
            nbk_b <= nbk_a + 1;
            nbk_c <= nbk_b + 1;
            nbk_d <= nbk_c + 1;
            nbk_e <= nbk_d + 1;
             
        end
        
    end

    initial begin
        $dumpfile("wave vcd");
        $dumpvars(0, always_test3);
    end

endmodule

