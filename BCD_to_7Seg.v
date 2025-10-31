module BCD_to_7Seg(A, B, C, D, E, F, G, BCD);
    output A, B, C, D, E, F, G;
    input  [3:0] BCD;
    wire   n0, n1, n2, n3;
    wire   d0, d1, d2, d3, d4, d5, d6, d7, d8, d9;

    not(n0, BCD[0]);
    not(n1, BCD[1]);
    not(n2, BCD[2]);
    not(n3, BCD[3]);

    // Minterms para 0-9
    and(d0, n3, n2, n1, n0); // 0
    and(d1, n3, n2, n1, BCD[0]); // 1
    and(d2, n3, n2, BCD[1], n0); // 2
    and(d3, n3, n2, BCD[1], BCD[0]); // 3
    and(d4, n3, BCD[2], n1, n0); // 4
    and(d5, n3, BCD[2], n1, BCD[0]); // 5
    and(d6, n3, BCD[2], BCD[1], n0); // 6
    and(d7, n3, BCD[2], BCD[1], BCD[0]); // 7
    and(d8, BCD[3], n2, n1, n0); // 8
    and(d9, BCD[3], n2, n1, BCD[0]); // 9

    // Lógica (ativo alto)
    or(A, d0, d2, d3, d5, d6, d7, d8, d9);
    or(B, d0, d1, d2, d3, d4, d7, d8, d9);
    or(C, d0, d1, d3, d4, d5, d6, d7, d8, d9);
    or(D, d0, d2, d3, d5, d6, d8, d9);
    or(E, d0, d2, d6, d8);
    or(F, d0, d4, d5, d6, d8, d9);
    or(G, d2, d3, d4, d5, d6, d8, d9);
endmodule