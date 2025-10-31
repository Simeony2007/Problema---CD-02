module Decoder_3para8(Y, S);
    output [7:0] Y;
    input  [2:0] S;
    wire   nS0, nS1, nS2;

    not(nS0, S[0]);
    not(nS1, S[1]);
    not(nS2, S[2]);

    and(Y[0], nS2, nS1, nS0); // 000
    and(Y[1], nS2, nS1, S[0]); // 001
    and(Y[2], nS2, S[1], nS0); // 010
    and(Y[3], nS2, S[1], S[0]); // 011
    and(Y[4], S[2], nS1, nS0); // 100
    and(Y[5], S[2], nS1, S[0]); // 101
    and(Y[6], S[2], S[1], nS0); // 110
    and(Y[7], S[2], S[1], S[0]); // 111
endmodule