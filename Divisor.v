module Divisor(S, Resto_final, Div0, A, B);
    input  [7:0] A;
    input  [7:0] B;
    output [7:0] S;
    output [7:0] Resto_final;
    output wire  Div0;

    // --- Fios Internos ---
    wire [7:0] Sub0, Sub1, Sub2, Sub3, Sub4, Sub5, Sub6, Sub7; 
    wire [7:0] Resto0, Resto1, Resto2, Resto3, Resto4, Resto5, Resto6, Resto7;
    wire [7:0] Bout; // Um bit de "borrow-out" para cada estágio
    wire gnd_wire; // Fio constante '0'
    
    // Fios para checagem de Div0
    wire [7:0] nB;
    wire t0_div0, t1_div0;

    // --- PEÇA 0: Gerador de GND (Constante 0) ---
    xor u_gnd (gnd_wire, A[0], A[0]);

    // --- PEÇA 1: Checagem de Divisão por Zero ---
    // Div0 = 1 se B == 00000000 (Lógica NOR de 8 entradas)
    not(nB[0], B[0]); not(nB[1], B[1]); not(nB[2], B[2]); not(nB[3], B[3]);
    not(nB[4], B[4]); not(nB[5], B[5]); not(nB[6], B[6]); not(nB[7], B[7]);
    and(t0_div0, nB[0], nB[1], nB[2], nB[3]);
    and(t1_div0, nB[4], nB[5], nB[6], nB[7]);
    and(Div0, t0_div0, t1_div0);

    // --- PEÇA 2: 8 Estágios de Divisão ---

    // Etapa 0 (A[7])
    SubComp8bits Calc0(
        .S(Sub0), 
        .Bout(Bout[0]), 
        .A({gnd_wire, gnd_wire, gnd_wire, gnd_wire, gnd_wire, gnd_wire, gnd_wire, A[7]}), 
        .B(B), 
        .Bin(gnd_wire)
    );
    MUX8para8 Decisao0( // (Assumindo que MUX8para8 é o seu MUX de 8 bits)
        .S(Resto0), 
        .A(Sub0), 
        .B({gnd_wire, gnd_wire, gnd_wire, gnd_wire, gnd_wire, gnd_wire, gnd_wire, A[7]}), 
        .SLCT(Bout[0])
    );
    or (S[7], Bout[0], gnd_wire); // S[7] = Bout[0] (Lógica CORRIGIDA)

    // Etapa 1 (A[6])
    SubComp8bits Calc1(
        .S(Sub1), 
        .Bout(Bout[1]), 
        .A({Resto0[6:0], A[6]}), // Desloca o resto anterior e "puxa" A[6]
        .B(B), 
        .Bin(gnd_wire)
    );
    MUX8para8 Decisao1(
        .S(Resto1), 
        .A(Sub1), 
        .B({Resto0[6:0], A[6]}), 
        .SLCT(Bout[1])
    );
    or (S[6], Bout[1], gnd_wire); // S[6] = Bout[1]

    // Etapa 2 (A[5])
    SubComp8bits Calc2(
        .S(Sub2), 
        .Bout(Bout[2]), 
        .A({Resto1[6:0], A[5]}), 
        .B(B), 
        .Bin(gnd_wire)
    );
    MUX8para8 Decisao2(
        .S(Resto2), 
        .A(Sub2), 
        .B({Resto1[6:0], A[5]}), 
        .SLCT(Bout[2])
    );
    or (S[5], Bout[2], gnd_wire); // S[5] = Bout[2]

    // Etapa 3 (A[4])
    SubComp8bits Calc3(
        .S(Sub3), 
        .Bout(Bout[3]), 
        .A({Resto2[6:0], A[4]}), 
        .B(B), 
        .Bin(gnd_wire)
    );
    MUX8para8 Decisao3(
        .S(Resto3), 
        .A(Sub3), 
        .B({Resto2[6:0], A[4]}), 
        .SLCT(Bout[3])
    );
    or (S[4], Bout[3], gnd_wire); // S[4] = Bout[3]

    // Etapa 4 (A[3])
    SubComp8bits Calc4(
        .S(Sub4), 
        .Bout(Bout[4]), 
        .A({Resto3[6:0], A[3]}), 
        .B(B), 
        .Bin(gnd_wire)
    );
    MUX8para8 Decisao4(
        .S(Resto4), 
        .A(Sub4), 
        .B({Resto3[6:0], A[3]}), 
        .SLCT(Bout[4])
    );
    or (S[3], Bout[4], gnd_wire); // S[3] = Bout[4]

    // Etapa 5 (A[2])
    SubComp8bits Calc5(
        .S(Sub5), 
        .Bout(Bout[5]), 
        .A({Resto4[6:0], A[2]}), 
        .B(B), 
        .Bin(gnd_wire)
    );
    MUX8para8 Decisao5(
        .S(Resto5), 
        .A(Sub5), 
        .B({Resto4[6:0], A[2]}), 
        .SLCT(Bout[5])
    );
    or (S[2], Bout[5], gnd_wire); // S[2] = Bout[5]

    // Etapa 6 (A[1])
    SubComp8bits Calc6(
        .S(Sub6), 
        .Bout(Bout[6]), 
        .A({Resto5[6:0], A[1]}), 
        .B(B), 
        .Bin(gnd_wire)
    );
    MUX8para8 Decisao6(
        .S(Resto6), 
        .A(Sub6), 
        .B({Resto5[6:0], A[1]}), 
        .SLCT(Bout[6])
    );
    or (S[1], Bout[6], gnd_wire); // S[1] = Bout[6]

    // Etapa 7 (A[0])
    SubComp8bits Calc7(
        .S(Sub7), 
        .Bout(Bout[7]), 
        .A({Resto6[6:0], A[0]}), 
        .B(B), 
        .Bin(gnd_wire)
    );
    MUX8para8 Decisao7(
        .S(Resto7), 
        .A(Sub7), 
        .B({Resto6[6:0], A[0]}), 
        .SLCT(Bout[7])
    );
    or (S[0], Bout[7], gnd_wire); // S[0] = Bout[7]

    // --- PEÇA 3: Saída Final do Resto ---
    // (Conecta a saída do último MUX à porta de saída)
    or (Resto_final[0], Resto7[0], gnd_wire);
    or (Resto_final[1], Resto7[1], gnd_wire);
    or (Resto_final[2], Resto7[2], gnd_wire);
    or (Resto_final[3], Resto7[3], gnd_wire);
    or (Resto_final[4], Resto7[4], gnd_wire);
    or (Resto_final[5], Resto7[5], gnd_wire);
    or (Resto_final[6], Resto7[6], gnd_wire);
    or (Resto_final[7], Resto7[7], gnd_wire);
    
endmodule