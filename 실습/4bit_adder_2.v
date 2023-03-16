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
    input [0:3] x, y,
    output reg [0:3] sum
);
    
    reg [0:3] c;
    c[0] = 0;
    
    always @* begin
        for (int i = 0; i < 4; i = i + 1) begin
            full_adder_1bit f_a_1b(
                .x(x[i]),        
                .y(y[i]),        
                .c_in(c[i]),     
                .sum(sum[i]),    
                .c_out(c[i+1])   
            );
        end
    end

endmodule


module testbench;
    
    reg [0:3] x, y;
    wire [0:3] sum;
    
    full_adder_4bit f_a_4b(.x(x), .y(y), .sum(sum));
    
    // testbench code goes here
    
endmodule

