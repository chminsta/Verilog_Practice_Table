/*
fork-
    join        :   all the parallel statements finish before join
    join_any    :   any of the parrallel statements finishes before join_any
    join_none   :   none of the parallel statements need to finishes before join_none

*/

//example

initial begin
    $display("befor fork");
    fork
        #10 $display("parallel 1"); 
        #20 $display("parallel 1");
        #30 $display("parallel 1");
    join
    #40 $display("after join");     //30+40 = 70ns
end

initial begin
    $display("befor fork");
    fork
        #10 $display("parallel 1"); 
        #20 $display("parallel 1");
        #30 $display("parallel 1");
    join_any
    #40 $display("after join");     //10+40 = 50ns
end

initial begin
    $display("befor fork");
    fork
        #10 $display("parallel 1"); 
        #20 $display("parallel 1");
        #30 $display("parallel 1");
    join_none
    #40 $display("after join");     //그냥 바로 40ns
end


//아쉽게 vs code에서 join_any 랑 join_none은 색깔이 안나온다.