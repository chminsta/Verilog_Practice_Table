
module register_file(
	input clk,				
	input rstn,
	input RegWrite,            //control signal 
	input [4:0] R_reg1,        //read register1
	input [4:0] R_reg2,	       //read register2
	input [4:0] W_reg,		   //write register	
	input [31:0] W_data,	   //write data
	output [31:0] R_data1, //read data1
	output [31:0] R_data2  //read data2
);
	reg [31:0] reg_file [0:31];
	integer i;
	
	assign R_data1 = reg_file[R_reg1];
	assign R_data2 = reg_file[R_reg2];
	
	always @(posedge clk, negedge rstn)
	begin
		if(!rstn)
		begin
			//for(i=0; i<32; i=i+1)
			//	reg_file[i] <= 32'd0;
		end
		else
		begin
			//write operation
			if(RegWrite == 1'b1)
				reg_file[W_reg] <= W_data;
		end
	end
endmodule

