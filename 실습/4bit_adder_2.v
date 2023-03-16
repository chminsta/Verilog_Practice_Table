    module half_adder_1bit (
        input x, y,
        output reg sum, c
    );
        
        always @* begin
            {c, sum} = x + y;
        end
        
    endmodule


    module full_adder_1bit (
        input x, y, c_in,
        output reg sum, c_out
    );
        
        wire s1, c1, s2;
        
        half_adder_1bit ha1(.x(x), .y(y), .sum(s1), .c(c1));          
        half_adder_1bit ha2(.x(s1), .y(c_in), .sum(s2), .c(c_out));
        
        assign sum = s2;
        
    endmodule


    module full_adder_4bit (
        input [3:0] x, y,
        input cin,
        output reg [3:0] sum
    );
        
        wire c1,c2,c3,c4;
        
        
        always @(x,y) begin
            full_adder_1bit full1(.x(x[0]),.y(y[0]),.c_in(cin),.sum(sum[0]),.c_out(c1));
            full_adder_1bit full2(.x(x[1]),.y(y[1]),.c_in(c1),.sum(sum[1]),.c_out(c2));
            full_adder_1bit full3(.x(x[2]),.y(y[2]),.c_in(c2),.sum(sum[2]),.c_out(c3));
            full_adder_1bit full4(.x(x[3]),.y(y[3]),.c_in(c3),.sum(sum[3]),.c_out(c4));
        end

    endmodule


module testbench;
    
    reg [0:3] x, y;
    wire [0:3] sum;
    
    full_adder_4bit f_a_4b(.x(x), .y(y), .sum(sum));
    
    // testbench code goes here
    
endmodule

