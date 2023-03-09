//design.sv


module mux #(
    input sel[1:0] ,a[3:0],b[3:0],c[3:0],d[3:0]
    output Out[3:0]
); (
    always @(*) begin
        

    if (sel==2'b00) begin
        Out=a;
    end
    else if (sel==2'b01) begin
        Out=b;
    end
    
    else if(sel==2'b10) begin
        Out=c;
    end
    
    else (sel==2'b11) begin
        Out=d;
    end
    end
);
    
endmodule