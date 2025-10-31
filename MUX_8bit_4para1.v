module MUX_8bit_4para1(Y, I0, I1, I2, I3, S);
    output [7:0] Y;
    input  [7:0] I0, I1, I2, I3;
    input  [1:0] S;
    wire   [7:0] MuxLo, MuxHi;

    // Estágio 1
    MUX_8bit_2para1 Mux01(MuxLo, I0, I1, S[0]);
    MUX_8bit_2para1 Mux23(MuxHi, I2, I3, S[0]);
    // Estágio 2
    MUX_8bit_2para1 MuxFinal(Y, MuxLo, MuxHi, S[1]);
endmodule