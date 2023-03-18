//design.v

module half_adder_1bit (
    input x,y,
    output reg sum, c
);
    

    always @(*) begin
    {c,sum}=x+y;        
    end
endmodule

module full_adder_1bit (
    input x,y,c_in,
    output sum, c_out
);
    wire c1,c2,sum1;
    
    half_adder_1bit h_a_1b_1(.x(x), .y(y), .sum(sum1), .c(c1));          //half adder에 x,y를 넣어서 sum1과 c_in을 추출
    half_adder_1bit h_a_1b_2(.x(sum1), .y(c_in), .sum(sum), .c(c2)); //half adder에 c_in,sum1를 넣어서 최종 sum과 c2을 추출

  
  assign c_out = c1 || c2;       //c1 or c2 하면 최종 c_out이 나옴
endmodule


module full_adder_4bit (
    input [3:0] x, y,
    input cin,
    output reg [3:0] sum
);
    
    wire c1,c2,c3,c4;
    
    
    always @(*) begin
        full_adder_1bit full1(.x(x[0]), .y(y[0]), .c_in(cin), .sum(sum[0]), .c_out(c1));
        full_adder_1bit full2(.x(x[1]),.y(y[1]),.c_in(c1),.sum(sum[1]),.c_out(c2));
        full_adder_1bit full3(.x(x[2]),.y(y[2]),.c_in(c2),.sum(sum[2]),.c_out(c3));
        full_adder_1bit full4(.x(x[3]),.y(y[3]),.c_in(c3),.sum(sum[3]),.c_out(c4));
    end

endmodule



//testbench

module testbench;
    
    reg [0:3] x, y;
    wire [0:3] sum;
    
    full_adder_4bit f_a_4b(.x(x), .y(y), .sum(sum));
    
    // testbench code goes here
    
endmodule