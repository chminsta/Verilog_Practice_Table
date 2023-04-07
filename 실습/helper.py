for i in range(1, 31):
    print(f"alu_1bit alu{i}(.a_in(a[{i}]), .b_in(b[{i}]), .Ainvert_in(op_in[3]), .Binvert_in(op_in[2]), .carry_in(carry_out[{i-1}]), .less_in(0), .op_in(op_in[1:0]), .result_out(result_out[{i}]), .carry_out(carry_out[{i}]));")
