//`timescale 1ns/10ps
//module Reg_File(
//    input clk, rst_n, 
//    input RegWrite, // set 1 if the computed data will be written in register
//    input [4:0] rs, rt, Rdst, // matched input of instruction field rs, rt, rd
//    input [31:0] W_data, // used when RegWrite 1
//    output reg [31:0] R_data1, // save data in register rs
//    output reg [31:0] R_data2,  // save data in register rt
//    output [31:0] R1, R2, R3, R4, R8
//);

//reg [31:0] register_file [0:31];
//integer i;

//always @(*)
//begin
//if (!rst_n) begin
//    register_file[0] = 32'd0;
//    register_file[1] = 32'd1;
//    register_file[2] = 32'd2;
//    register_file[3] = 32'd3;
//    register_file[4] = 32'd4;
//    register_file[5] = 32'd5;
//    register_file[6] = 32'd6;
//    register_file[7] = 32'd7;
//    register_file[8] = 32'd8;
//    register_file[9] = 32'd9;
//    register_file[10] = 32'hF;
//    register_file[11] = 32'd0;
//    register_file[12] = 32'd0;
//    register_file[13] = 32'd0;
//    register_file[14] = 32'd0;
//    register_file[15] = 32'd0;
//    register_file[16] = 32'd0;
//    register_file[17] = 32'd0;
//    register_file[18] = 32'd0;
//    register_file[19] = 32'd0;
//    register_file[20] = 32'd0;
//    register_file[21] = 32'd0;
//    register_file[22] = 32'd0;
//    register_file[23] = 32'd0;
//    register_file[24] = 32'd0;
//    register_file[25] = 32'd0;
//    register_file[26] = 32'd0;
//    register_file[27] = 32'd0;
//    register_file[28] = 32'd0;
//    register_file[29] = 32'd0;
//    register_file[30] = 32'd0;
//    register_file[31] = 32'd0;
//    R_data1 = 0;
//    R_data2 = 0;
//    end
//else 
//    if(RegWrite) register_file[Rdst] = W_data;
//end

//always @(negedge clk)
//begin
//R_data1 <= register_file[rs];
//R_data2 <= register_file[rt];
//end

//assign R1 = register_file[1];
//assign R2 = register_file[2];
//assign R3 = register_file[3];
//assign R4 = register_file[4];
//assign R8 = register_file[8];

//endmodule

module Reg_File(
	input clk,				
	input rstn,
	input RegWrite,            //control signal 
	input [4:0] R_reg1,        //read register1
	input [4:0] R_reg2,	       //read register2
	input [4:0] W_reg,		   //write register	
	input [31:0] W_data,	   //write data
	output [31:0] R_data1, //read data1
	output [31:0] R_data2,  //read data2
	output [31:0] R1, R4, R8
//	output reg [31:0] R_data1,
//	output reg [31:0] R_data2
);
    wire w_clk;
    assign w_clk = ~clk;
    
	reg [31:0] reg_file [0:31];
	//integer i;
	//
	assign R_data1 = reg_file[R_reg1];
	assign R_data2 = reg_file[R_reg2];
	
	always @(posedge w_clk, negedge rstn)
	begin
		if(!rstn)
		begin
			reg_file[0] <= 32'd0;
            reg_file[1] <= 32'd5;   // 23
            reg_file[2] <= 32'd8;
            reg_file[3] <= 32'd10;  // 34
            reg_file[4] <= 32'd11;
            reg_file[5] <= 32'd20;  // 66
            reg_file[6] <= 32'd43;   
            reg_file[7] <= 32'd24;
            reg_file[8] <= 32'd4;
            reg_file[9] <= 32'd5;
            reg_file[10] <= 32'd13; // modulate to make infinite loop  
            reg_file[11] <= 32'd17;
            reg_file[12] <= 32'd21;
            reg_file[13] <= 32'd10;
            reg_file[14] <= 32'd22;
            reg_file[15] <= 32'd1;
            reg_file[16] <= 32'd2;
            reg_file[17] <= 32'd2;
            reg_file[18] <= 32'd3;
            reg_file[19] <= 32'd3;
            reg_file[20] <= 32'd6;
            reg_file[21] <= 32'd7;
            reg_file[22] <= 32'd9;
            reg_file[23] <= 32'd0;
            reg_file[24] <= 32'd154;
            reg_file[25] <= 32'd145;
            reg_file[26] <= 32'd111;
            reg_file[27] <= 32'd100;
            reg_file[28] <= 32'd101;
            reg_file[29] <= 32'd98;
            reg_file[30] <= 32'd87;
            reg_file[31] <= 32'd76;
		end
		else
		begin
//			write operation
			if(RegWrite)
				reg_file[W_reg] <= W_data;
//		    else
//		        reg_file[W_reg] <= reg_file[W_reg];
//	        reg_file <= reg_file;	  

		end
	end
//	always @(negedge clk, negedge rstn)
//	begin
//	    if(!rstn)
//	    begin
//	        R_data1 <= 32'd0;
//	        R_data2 <= 32'd0;
//	    end
//	    else
//	    begin
//	        R_data1 <= reg_file[R_reg1];
//	        R_data2 <= reg_file[R_reg2];
//	    end
//	end
    assign R1 = reg_file[1];
    assign R4 = reg_file[4];
    assign R8 = reg_file[8];
endmodule
