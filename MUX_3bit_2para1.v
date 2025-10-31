module MUX_3bit_2para1(Y, A, B, S);
    output [2:0] Y;
    input  [2:0] A, B;
    input  S;

    MUX_1bit_2para1 m0(Y[0], A[0], B[0], S);
    MUX_1bit_2para1 m1(Y[1], A[1], B[1], S);
    MUX_1bit_2para1 m2(Y[2], A[2], B[2], S);
endmodule