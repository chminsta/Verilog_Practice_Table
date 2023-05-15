module Data_memory (
    input i_clk, i_rstn, MemWrite, MemRead,
    input [31:0] Memaddr, MemWriteData
    output reg [31:0] MemReadData
);
    integer i;
    reg [31:0] mem [0:127];
    always @(posedge i_clk, negedge i_rstn ) begin
        if (i_rstn) begin
            for(i=0; i<128; i=i+1)
            begin
                mem[i]<=32'd0;
            end
            MemReadData <=32'd0;
        end
        else
        begin
            if(MemWrite)
                mem[Memaddr] <= MemWriteData;
            else if(MemRead) MemReadData <= mem[Memaddr];
            
        end
    end
endmodule