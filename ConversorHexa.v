//============================================================
// BINÁRIO (8 bits) -> 2 DISPLAYS HEXADECIMAIS (7 segmentos x 2)
//============================================================
module ConversorHexa(
    input  [7:0] BIN,
    output [1:0] Ah, Bh, Ch, Dh, Eh, Fh, Gh
);

    // -------------------------
    // DIGITO menos significativo (H0)
    // -------------------------
    wire H0_3, H0_2, H0_1, H0_0;
    and (H0_3, BIN[3], 1'b1);
    and (H0_2, BIN[2], 1'b1);
    and (H0_1, BIN[1], 1'b1);
    and (H0_0, BIN[0], 1'b1);

    not (n0_3,H0_3);
    not (n0_2,H0_2);
    not (n0_1,H0_1);
    not (n0_0,H0_0);

    // Minterms para H0
    wire d0_0,d0_1,d0_2,d0_3,d0_4,d0_5,d0_6,d0_7,d0_8,d0_9,d0_A,d0_B,d0_C,d0_D,d0_E,d0_F;
    and (d0_0, n0_3,n0_2,n0_1,n0_0); //0
    and (d0_1, n0_3,n0_2,n0_1,H0_0); //1
    and (d0_2, n0_3,n0_2,H0_1,n0_0); //2
    and (d0_3, n0_3,n0_2,H0_1,H0_0); //3
    and (d0_4, n0_3,H0_2,n0_1,n0_0); //4
    and (d0_5, n0_3,H0_2,n0_1,H0_0); //5
    and (d0_6, n0_3,H0_2,H0_1,n0_0); //6
    and (d0_7, n0_3,H0_2,H0_1,H0_0); //7
    and (d0_8, H0_3,n0_2,n0_1,n0_0); //8
    and (d0_9, H0_3,n0_2,n0_1,H0_0); //9
    and (d0_A, H0_3,n0_2,H0_1,n0_0); //A
    and (d0_B, H0_3,n0_2,H0_1,H0_0); //B
    and (d0_C, H0_3,H0_2,n0_1,n0_0); //C
    and (d0_D, H0_3,H0_2,n0_1,H0_0); //D
    and (d0_E, H0_3,H0_2,H0_1,n0_0); //E
    and (d0_F, H0_3,H0_2,H0_1,H0_0); //F

    // Segmentos H0
    or (Ah[0], d0_0,d0_2,d0_3,d0_5,d0_6,d0_7,d0_8,d0_9,d0_A,d0_C,d0_E,d0_F);
    or (Bh[0], d0_0,d0_1,d0_2,d0_3,d0_4,d0_7,d0_8,d0_9,d0_A,d0_D);
    or (Ch[0], d0_0,d0_1,d0_3,d0_4,d0_5,d0_6,d0_7,d0_8,d0_9,d0_B,d0_C,d0_D,d0_E,d0_F);
    or (Dh[0], d0_0,d0_2,d0_3,d0_5,d0_6,d0_8,d0_9,d0_B,d0_D,d0_E);
    or (Eh[0], d0_0,d0_2,d0_6,d0_8,d0_A,d0_B,d0_E,d0_F);
    or (Fh[0], d0_0,d0_4,d0_5,d0_6,d0_8,d0_9,d0_A,d0_B,d0_C,d0_E,d0_F);
    or (Gh[0], d0_2,d0_3,d0_4,d0_5,d0_6,d0_8,d0_9,d0_A,d0_B,d0_D,d0_E,d0_F);

    // -------------------------
    // DIGITO mais significativo (H1)
    // -------------------------
    wire H1_3,H1_2,H1_1,H1_0;
    and (H1_3, BIN[7], 1'b1);
    and (H1_2, BIN[6], 1'b1);
    and (H1_1, BIN[5], 1'b1);
    and (H1_0, BIN[4], 1'b1);

    not (n1_3,H1_3);
    not (n1_2,H1_2);
    not (n1_1,H1_1);
    not (n1_0,H1_0);

    // Minterms para H1
    wire d1_0,d1_1,d1_2,d1_3,d1_4,d1_5,d1_6,d1_7,d1_8,d1_9,d1_A,d1_B,d1_C,d1_D,d1_E,d1_F;
    and (d1_0, n1_3,n1_2,n1_1,n1_0); //0
    and (d1_1, n1_3,n1_2,n1_1,H1_0); //1
    and (d1_2, n1_3,n1_2,H1_1,n1_0); //2
    and (d1_3, n1_3,n1_2,H1_1,H1_0); //3
    and (d1_4, n1_3,H1_2,n1_1,n1_0); //4
    and (d1_5, n1_3,H1_2,n1_1,H1_0); //5
    and (d1_6, n1_3,H1_2,H1_1,n1_0); //6
    and (d1_7, n1_3,H1_2,H1_1,H1_0); //7
    and (d1_8, H1_3,n1_2,n1_1,n1_0); //8
    and (d1_9, H1_3,n1_2,n1_1,H1_0); //9
    and (d1_A, H1_3,n1_2,H1_1,n1_0); //A
    and (d1_B, H1_3,n1_2,H1_1,H1_0); //B
    and (d1_C, H1_3,H1_2,n1_1,n1_0); //C
    and (d1_D, H1_3,H1_2,n1_1,H1_0); //D
    and (d1_E, H1_3,H1_2,H1_1,n1_0); //E
    and (d1_F, H1_3,H1_2,H1_1,H1_0); //F

    // Segmentos H1
    or (Ah[1], d1_0,d1_2,d1_3,d1_5,d1_6,d1_7,d1_8,d1_9,d1_A,d1_C,d1_E,d1_F);
    or (Bh[1], d1_0,d1_1,d1_2,d1_3,d1_4,d1_7,d1_8,d1_9,d1_A,d1_D);
    or (Ch[1], d1_0,d1_1,d1_3,d1_4,d1_5,d1_6,d1_7,d1_8,d1_9,d1_B,d1_C,d1_D,d1_E,d1_F);
    or (Dh[1], d1_0,d1_2,d1_3,d1_5,d1_6,d1_8,d1_9,d1_B,d1_D,d1_E);
    or (Eh[1], d1_0,d1_2,d1_6,d1_8,d1_A,d1_B,d1_E,d1_F);
    or (Fh[1], d1_0,d1_4,d1_5,d1_6,d1_8,d1_9,d1_A,d1_B,d1_C,d1_E,d1_F);
    or (Gh[1], d1_2,d1_3,d1_4,d1_5,d1_6,d1_8,d1_9,d1_A,d1_B,d1_D,d1_E,d1_F);

endmodule