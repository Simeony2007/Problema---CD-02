// ===================================================================
// == MÓDULO: DoubleDabble (Bin-8 para BCD-3)
// == VERSÃO CORRIGIDA (100% ESTRUTURAL)
// == Engenheiro-Chefe: Gemini
// ===================================================================
module DoubleDabble(BIN, H, T, O);
    input  [7:0] BIN;
    output [3:0] H; // Centenas
    output [3:0] T; // Dezenas
    output [3:0] O; // Unidades

    // Fios APENAS para as saídas dos estágios de ajuste
    wire [3:0] h_adj1, t_adj1, o_adj1;
    wire [3:0] h_adj2, t_adj2, o_adj2;
    wire [3:0] h_adj3, t_adj3, o_adj3;
    wire [3:0] h_adj4, t_adj4, o_adj4;
    wire [3:0] h_adj5, t_adj5, o_adj5;
    wire [3:0] h_adj6, t_adj6, o_adj6;
    wire [3:0] h_adj7, t_adj7, o_adj7;
    wire [3:0] h_adj8, t_adj8, o_adj8;
    
    // Fio de constante 0
    wire gnd;
    and(gnd_gate, gnd, 1'b0, 1'b0); // Drive gnd to 0

    // --- Estágio 1: Ajusta {0,0,0}, prepara para deslocar BIN[7] ---
    // A entrada para o primeiro estágio é sempre 0
    Add3_if_gte5 adj_h1(.BCD_out(h_adj1), .BCD_in({gnd, gnd, gnd, gnd}));
    Add3_if_gte5 adj_t1(.BCD_out(t_adj1), .BCD_in({gnd, gnd, gnd, gnd}));
    Add3_if_gte5 adj_o1(.BCD_out(o_adj1), .BCD_in({gnd, gnd, gnd, gnd}));

    // --- Estágio 2: Ajusta e desloca BIN[7] ---
    // A entrada é a saída do estágio anterior, deslocada, com BIN[7]
    Add3_if_gte5 adj_h2(.BCD_out(h_adj2), .BCD_in({h_adj1[2:0], t_adj1[3]}));
    Add3_if_gte5 adj_t2(.BCD_out(t_adj2), .BCD_in({t_adj1[2:0], o_adj1[3]}));
    Add3_if_gte5 adj_o2(.BCD_out(o_adj2), .BCD_in({o_adj1[2:0], BIN[7]}));

    // --- Estágio 3: Ajusta e desloca BIN[6] ---
    Add3_if_gte5 adj_h3(.BCD_out(h_adj3), .BCD_in({h_adj2[2:0], t_adj2[3]}));
    Add3_if_gte5 adj_t3(.BCD_out(t_adj3), .BCD_in({t_adj2[2:0], o_adj2[3]}));
    Add3_if_gte5 adj_o3(.BCD_out(o_adj3), .BCD_in({o_adj2[2:0], BIN[6]}));

    // --- Estágio 4: Ajusta e desloca BIN[5] ---
    Add3_if_gte5 adj_h4(.BCD_out(h_adj4), .BCD_in({h_adj3[2:0], t_adj3[3]}));
    Add3_if_gte5 adj_t4(.BCD_out(t_adj4), .BCD_in({t_adj3[2:0], o_adj3[3]}));
    Add3_if_gte5 adj_o4(.BCD_out(o_adj4), .BCD_in({o_adj3[2:0], BIN[5]}));
    
    // --- Estágio 5: Ajusta e desloca BIN[4] ---
    Add3_if_gte5 adj_h5(.BCD_out(h_adj5), .BCD_in({h_adj4[2:0], t_adj4[3]}));
    Add3_if_gte5 adj_t5(.BCD_out(t_adj5), .BCD_in({t_adj4[2:0], o_adj4[3]}));
    Add3_if_gte5 adj_o5(.BCD_out(o_adj5), .BCD_in({o_adj4[2:0], BIN[4]}));

    // --- Estágio 6: Ajusta e desloca BIN[3] ---
    Add3_if_gte5 adj_h6(.BCD_out(h_adj6), .BCD_in({h_adj5[2:0], t_adj5[3]}));
    Add3_if_gte5 adj_t6(.BCD_out(t_adj6), .BCD_in({t_adj5[2:0], o_adj5[3]}));
    Add3_if_gte5 adj_o6(.BCD_out(o_adj6), .BCD_in({o_adj5[2:0], BIN[3]}));

    // --- Estágio 7: Ajusta e desloca BIN[2] ---
    Add3_if_gte5 adj_h7(.BCD_out(h_adj7), .BCD_in({h_adj6[2:0], t_adj6[3]}));
    Add3_if_gte5 adj_t7(.BCD_out(t_adj7), .BCD_in({t_adj6[2:0], o_adj6[3]}));
    Add3_if_gte5 adj_o7(.BCD_out(o_adj7), .BCD_in({o_adj6[2:0], BIN[2]}));

    // --- Estágio 8: Ajusta e desloca BIN[1] ---
    Add3_if_gte5 adj_h8(.BCD_out(h_adj8), .BCD_in({h_adj7[2:0], t_adj7[3]}));
    Add3_if_gte5 adj_t8(.BCD_out(t_adj8), .BCD_in({t_adj7[2:0], o_adj7[3]}));
    Add3_if_gte5 adj_o8(.BCD_out(o_adj8), .BCD_in({o_adj7[2:0], BIN[1]}));

    // --- Ajuste Final (após o último shift com BIN[0]) ---
    // A entrada aqui é o resultado do último "shift"
    Add3_if_gte5 adj_hf(.BCD_out(H), .BCD_in({h_adj8[2:0], t_adj8[3]}));
    Add3_if_gte5 adj_tf(.BCD_out(T), .BCD_in({t_adj8[2:0], o_adj8[3]}));
    Add3_if_gte5 adj_of(.BCD_out(O), .BCD_in({o_adj8[2:0], BIN[0]}));

endmodule