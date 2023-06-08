module Reg_File(
    input clk, rst_n, 
    input RegWrite, // set 1 if the computed data will be written in register
    input [4:0] rs, rt, rd, // matched input of instruction field rs, rt, rd
    input [31:0] W_data, // used when RegWrite 1
    output [31:0] R_data1, // save data in register rs
    output [31:0] R_data2, // save data in register rt
    output [31:0] R1, R4, R6, R9
);

reg [31:0] register_file [0:31];

always @(posedge clk or negedge rst_n) begin
if (!rst_n) begin
    register_file[0] <= 32'd0;
    register_file[1] <= 32'd1;
    register_file[2] <= 32'd2;
    register_file[3] <= 32'd3;
    register_file[4] <= 32'd4;
    register_file[5] <= 32'd5;
    register_file[6] <= 32'd6;
    register_file[7] <= 32'd7;
    register_file[8] <= 32'd8;
    register_file[9] <= 32'd9;
    register_file[10] <= 32'd10;
    register_file[11] <= 32'd11;
    register_file[12] <= 32'd12;
    register_file[13] <= 32'd14; // modulation to infinite branch taken
    register_file[14] <= 32'd14;
    register_file[15] <= 32'd15;
    register_file[16] <= 32'd16;
    register_file[17] <= 32'd17;
    register_file[18] <= 32'd18;
    register_file[19] <= 32'd19;
    register_file[20] <= 32'd20;
    register_file[21] <= 32'd21;
    register_file[22] <= 32'd22;
    register_file[23] <= 32'd23;
    register_file[24] <= 32'd24;
    register_file[25] <= 32'd25;
    register_file[26] <= 32'd26;
    register_file[27] <= 32'd27;
    register_file[28] <= 32'd28;
    register_file[29] <= 32'd29;
    register_file[30] <= 32'd30;
    register_file[31] <= 32'd31;
    end
else begin
if(RegWrite) register_file[rd] <= W_data;
end
end

assign R_data1 = register_file[rs];
assign R_data2 = register_file[rt];
assign R1 = register_file[1];
assign R4 = register_file[4];
assign R6 = register_file[6];
assign R9 = register_file[9];

endmodule