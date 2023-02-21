//if else: c랑 같은데 {}이 begin, end.
//case(sel)
//mux 생각하면 if else는 2대1 mux를 여러개, case는 n대1 mux

/*  [for]
    for(...) begin ... end


    ex)
    for (i=0;i<8;i++) begin
        a[i]<=0;
    end
*/

/*  [while]
    while (...) begin ... end


    ex)
    while (ready ==0) begin
        valid<=1;    
    end
*/

/*  [forever]
    무한반복, 클락에 많이 씀, 딜레이 줘야댐

    ex)
    initial begin
        clk=0;
        forever #5 clk=~clk;    
    end

*/

/*  [repeat]

    initial begin
        x=0;
        repeat(10) #5 x++;

    end

*/


/* [cf. CLK, RST]

    initial begin
        clk=0;
        forever #5 clk=~clk;    
    end

    initial begin
        rstn = 1;
        #10 rstn = 0;
        #20 rstn = 1;
    end
*/

