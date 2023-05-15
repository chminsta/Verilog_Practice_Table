module sign_extent (
    input [15:0] imm_value,
    output [31:0] result
);
//16비트를 32비트로 확장, sign비트를 끝까지 연장
    assign result = {{16{imm_value[15]}}, imm_value[15:0]};
endmodule