//============================================================
// MUX OCTAL/HEXA - 21 saídas (7 segmentos x 3 displays)
// Estrutural puro, sem assign, sem módulos auxiliares
//============================================================
module mux_octal_hex(
    input [7:0] BIN,
    input sel, // 0 = octal, 1 = hexadecimal

    output [2:0] A, B, C, D, E, F, G // 7 segmentos x 3 displays
);

    // -------------------------
    // Fios internos
    // -------------------------
    wire [2:0] Ao, Bo, Co, Do, Eo, Fo, Go; // octal
    wire [2:0] Ah, Bh, Ch, Dh, Eh, Fh, Gh; // hexadecimal (preenchido para 3 bits)

    // -------------------------
    // Instancia os conversores
    // -------------------------
    ConversorOctal octal_conv(
        .BIN(BIN),
        .A(Ao),
        .B(Bo),
        .C(Co),
        .D(Do),
        .E(Eo),
        .F(Fo),
        .G(Go)
    );

    ConversorHexa hex_conv(
        .BIN(BIN),
        .Ah(Ah[1:0]),
        .Bh(Bh[1:0]),
        .Ch(Ch[1:0]),
        .Dh(Dh[1:0]),
        .Eh(Eh[1:0]),
        .Fh(Fh[1:0]),
        .Gh(Gh[1:0])
    );

    // Preenche o 3º bit dos displays hexadecimais com 0 (GND)
    and (Ah[2], 1'b0, 1'b0);
    and (Bh[2], 1'b0, 1'b0);
    and (Ch[2], 1'b0, 1'b0);
    and (Dh[2], 1'b0, 1'b0);
    and (Eh[2], 1'b0, 1'b0);
    and (Fh[2], 1'b0, 1'b0);
    and (Gh[2], 1'b0, 1'b0);

    // -------------------------
    // Negação do seletor
    // -------------------------
    not (nsel, sel);

    // -------------------------
    // Multiplexagem estrutural: Y = (~sel & octal) | (sel & hex)
    // -------------------------
    // Segmento A
    and (andA0, nsel, Ao[0]);
    and (andA1, sel, Ah[0]);
    or  (A[0], andA0, andA1);

    and (andA2, nsel, Ao[1]);
    and (andA3, sel, Ah[1]);
    or  (A[1], andA2, andA3);

    and (andA4, nsel, Ao[2]);
    and (andA5, sel, Ah[2]);
    or  (A[2], andA4, andA5);

    // Segmento B
    and (andB0, nsel, Bo[0]);
    and (andB1, sel, Bh[0]);
    or  (B[0], andB0, andB1);

    and (andB2, nsel, Bo[1]);
    and (andB3, sel, Bh[1]);
    or  (B[1], andB2, andB3);

    and (andB4, nsel, Bo[2]);
    and (andB5, sel, Bh[2]);
    or  (B[2], andB4, andB5);

    // Segmento C
    and (andC0, nsel, Co[0]);
    and (andC1, sel, Ch[0]);
    or  (C[0], andC0, andC1);

    and (andC2, nsel, Co[1]);
    and (andC3, sel, Ch[1]);
    or  (C[1], andC2, andC3);

    and (andC4, nsel, Co[2]);
    and (andC5, sel, Ch[2]);
    or  (C[2], andC4, andC5);

    // Segmento D
    and (andD0, nsel, Do[0]);
    and (andD1, sel, Dh[0]);
    or  (D[0], andD0, andD1);

    and (andD2, nsel, Do[1]);
    and (andD3, sel, Dh[1]);
    or  (D[1], andD2, andD3);

    and (andD4, nsel, Do[2]);
    and (andD5, sel, Dh[2]);
    or  (D[2], andD4, andD5);

    // Segmento E
    and (andE0, nsel, Eo[0]);
    and (andE1, sel, Eh[0]);
    or  (E[0], andE0, andE1);

    and (andE2, nsel, Eo[1]);
    and (andE3, sel, Eh[1]);
    or  (E[1], andE2, andE3);

    and (andE4, nsel, Eo[2]);
    and (andE5, sel, Eh[2]);
    or  (E[2], andE4, andE5);

    // Segmento F
    and (andF0, nsel, Fo[0]);
    and (andF1, sel, Fh[0]);
    or  (F[0], andF0, andF1);

    and (andF2, nsel, Fo[1]);
    and (andF3, sel, Fh[1]);
    or  (F[1], andF2, andF3);

    and (andF4, nsel, Fo[2]);
    and (andF5, sel, Fh[2]);
    or  (F[2], andF4, andF5);

    // Segmento G
    and (andG0, nsel, Go[0]);
    and (andG1, sel, Gh[0]);
    or  (G[0], andG0, andG1);

    and (andG2, nsel, Go[1]);
    and (andG3, sel, Gh[1]);
    or  (G[1], andG2, andG3);

    and (andG4, nsel, Go[2]);
    and (andG5, sel, Gh[2]);
    or  (G[2], andG4, andG5);

endmodule