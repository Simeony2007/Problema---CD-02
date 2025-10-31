module MUX_1bit_2para1(Y, A, B, S);
    output Y;
    input  A, B, S;
    wire   nS, wA, wB;
    
    not(nS, S);
    and(wA, A, nS);
    and(wB, B, S);
    or(Y, wA, wB);
endmodule