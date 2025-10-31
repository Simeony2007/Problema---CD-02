module MUX_8bit_2para1(Y, A, B, S);
    output [7:0] Y;
    input  [7:0] A, B;
    input  S;

    MUX_1bit_2para1 m0(Y[0], A[0], B[0], S);
    MUX_1bit_2para1 m1(Y[1], A[1], B[1], S);
    MUX_1bit_2para1 m2(Y[2], A[2], B[2], S);
    MUX_1bit_2para1 m3(Y[3], A[3], B[3], S);
    MUX_1bit_2para1 m4(Y[4], A[4], B[4], S);
    MUX_1bit_2para1 m5(Y[5], A[5], B[5], S);
    MUX_1bit_2para1 m6(Y[6], A[6], B[6], S);
    MUX_1bit_2para1 m7(Y[7], A[7], B[7], S);
endmodule