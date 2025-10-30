module MUX8para8(S, A, B, SLCT);
    output [7:0] S;     // Saída de 8 bits
    input  [7:0] A;     // Entrada 'A' de 8 bits (selecionada se SLCT=0)
    input  [7:0] B;     // Entrada 'B' de 8 bits (selecionada se SLCT=1)
    input  SLCT;        // O sinal de seleção


    // Bit 0
    Mux1por1 mux_bit0 (
        .S(S[0]), 
        .A(A[0]), 
        .B(B[0]), 
        .Op(SLCT) 
    );

    // Bit 1
    Mux1por1 mux_bit1 (
        .S(S[1]), 
        .A(A[1]), 
        .B(B[1]), 
        .Op(SLCT)
    );

    // Bit 2
    Mux1por1 mux_bit2 (
        .S(S[2]), 
        .A(A[2]), 
        .B(B[2]), 
        .Op(SLCT)
    );

    // Bit 3
    Mux1por1 mux_bit3 (
        .S(S[3]), 
        .A(A[3]), 
        .B(B[3]), 
        .Op(SLCT)
    );

    // Bit 4
    Mux1por1 mux_bit4 (
        .S(S[4]), 
        .A(A[4]), 
        .B(B[4]), 
        .Op(SLCT)
    );

    // Bit 5
    Mux1por1 mux_bit5 (
        .S(S[5]), 
        .A(A[5]), 
        .B(B[5]), 
        .Op(SLCT)
    );

    // Bit 6
    Mux1por1 mux_bit6 (
        .S(S[6]), 
        .A(A[6]), 
        .B(B[6]), 
        .Op(SLCT)
    );

    // Bit 7
    Mux1por1 mux_bit7 (
        .S(S[7]), 
        .A(A[7]), 
        .B(B[7]), 
        .Op(SLCT)
    );

endmodule