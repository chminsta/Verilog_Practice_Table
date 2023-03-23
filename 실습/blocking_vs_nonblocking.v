module blk1 (clk,d,q3);
    input clk;
    input d;
    output q3;
    reg q0,q1, q2, q3;

    always @(posedge clk)begin
        q0=d;
        q1=q0;
        q2=q1;
        q3=q2;
    end
endmodule
//blk1은 결과적으로 q0,q1,q2,q3에 모두 d가 들어간다.

module blk2 (clk,d,q3);
    input clk;
    input d;
    output q3;
    reg q0,q1, q2, q3;

    always @(posedge clk)begin
        q3=q2;
        q2=q1;
        q1=q0;
        q0=d;    
    end
endmodule
//blk1은 결과적으로 q0,q1,q2,q3에 모두 q3가 들어간다.

module non_blk1 (clk,d,q3);
    input clk;
    input d;
    output q3;
    reg q0,q1, q2, q3;

    always @(posedge clk)begin
        q0<=d;
        q1<=q0;
        q2<=q1;
        q3<=q2;
    end
endmodule
//non_blk1은 결과적으로 q0에 d, q1에 q2...로 들어간다. 즉 q3는 q2가 됨

module non_blk2 (clk,d,q3);
    input clk;
    input d;
    output q3;
    reg q0,q1, q2, q3;

    always @(posedge clk)begin
        q3<=q2;
        q2<=q1;
        q1<=q0;
        q0<=d;    
    end
endmodule
//non_blk2은 non_blk1와 같다.

module blk_vs_nblk;
    reg clk,d1,d2,d3,d4;
    wire out1,out2,out3,out4;
    
    blk1 blk1(clk,d1,q1);
    blk2 blk2(clk,d2,q2);
    non_blk1 non_blk1(clk,d3,q3);
    non_blk2 non_blk2(clk,d4,q4);

    initial begin
        clk=0;
        forever begin
            #10 clk=~clk;
        end    
    end

    initial begin
        d1=1; d2=1; d3=1; d4=1;
    #50 d1=0; d2=0; d3=0; d4=0;
    #50 d1=1; d2=1; d3=1; d4=1;
    #50 $finish;
    end
endmodule