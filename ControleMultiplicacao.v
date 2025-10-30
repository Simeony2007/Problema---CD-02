module ControleMultiplicacao(
    output Finalizado,
    output ativCont,
    output limpaCont,
    output acumula,
    input Clk,
    input Rst,
    input Start,
    input [2:0]contador);
    
    // --- Fios Internos ---
    wire SFF;     // O "Start Guardado"
    wire EntFF;   // O "Próximo Estado"
    wire nSFF;    // NOT(SFF)
    wire contador_fim;
    wire nContador_fim;
    wire T1_Ligar, T2_Manter;
    
    // --- PEÇA 1: O FLIP-FLOP DE ESTADO ("Cérebro") ---
    FlipFlopD Iniciar(
        .s(SFF),
        .a(EntFF),
        .clk(Clk),
        .reset(Rst)
    );
    
    // --- PEÇA 2: LÓGICA DO PRÓXIMO ESTADO (Calcula 'EntFF') ---
    and And0_fim(contador_fim, contador[2], contador[1], contador[0]);
    
    not u_nSFF (nSFF, SFF);
    not u_nContador_fim (nContador_fim, contador_fim);

    and u_T1_Ligar (T1_Ligar, nSFF, Start);
    and u_T2_Manter (T2_Manter, SFF, nContador_fim);
    
    or u_D_calc_final (EntFF, T1_Ligar, T2_Manter);
    
    // --- PEÇA 3: LÓGICA DAS SAÍDAS (CORRIGIDA) ---
    
    and And_Finalizado(Finalizado, SFF, contador_fim);
    
    // 'acumula' (Op do MUX, 1=Parar) = 1 SE (Ocioso OU Terminou)
    or Or_acumula(acumula, nSFF, contador_fim);
    
    // 'ativCont' (Op do MUX, 1=Parar) = 1 SE (Ocioso OU Terminou)
    or Or_ativCont(ativCont, nSFF, contador_fim);

    // 'limpaCont' (Reset do Contador, Ativo-ALTO = 1=Zerar)
    // Lógica: limpaCont = NOT SFF
    not Not_limpaCont(limpaCont, SFF); // <-- CORRIGIDO AQUI
    
endmodule