// ===================================================================
// == MÓDULO TOP-LEVEL: ULA RPN ESTRUTURAL
// == Engenheiro-Chefe: Gemini
// == REVISÃO FINAL: 100% Estrutural. Removidas todas as 
// ==               atribuições 'assign' (wire x = y).
// ===================================================================
module main(
    // --- Portas Globais ---
    input  Clk,
    input  Rst,
    
    // --- Portas de Entrada do Usuário ---
    input  [7:0] DataIn,       // Entrada de dados 8-bit
    input  Enter_btn,      // Botão "Enter" (pré-debounce)
    input  [2:0] OpSelect,     // Seletor de Operação (0=Soma, 1=Sub, ... 7=Div)
    input  [1:0] BaseSelect,   // Seletor de Base (00=Oct, 01=Hex, 10=Dec)
    input  [1:0] DisplaySelect, // Seletor de Display (00=Res_Low, 01=Res_High, 10=Resto, 11=T0)
    
    // --- Portas de Saída ---
    output Div0_flag,      // Flag de Divisão por Zero
    output [2:0] SegA,         // Segmento A (3 displays, ativo baixo)
    output [2:0] SegB,         // Segmento B (3 displays, ativo baixo)
    output [2:0] SegC,         // Segmento C (3 displays, ativo baixo)
    output [2:0] SegD,         // Segmento D (3 displays, ativo baixo)
    output [2:0] SegE,         // Segmento E (3 displays, ativo baixo)
    output [2:0] SegF,         // Segmento F (3 displays, ativo baixo)
    output [2:0] SegG          // Segmento G (3 displays, ativo baixo)
);

    // ===================================================================
    // == FIOS INTERNOS (DATAPATH E CONTROLE)
    // ===================================================================

    // --- Sinais de Controle ---
    wire        Enter_pulse;  // Pulso único do botão "Enter"
    wire [1:0]  Estado;       // 00=A, 01=B, 10=Op, 11=Disp
    wire        estA, estB, estOp; // Sinais de estado decodificados
    wire        LoadA, LoadB, LoadOp; // Sinais de Carga RPN
    wire        LoadT0_Op, LoadT1_Op, LoadT2_Op; // Sinais de Op (1=Manter, 0=Carregar)
    wire [7:0]  Op_Enable;    // Saída do decodificador 3-para-8
    wire        Mult_Start;   // Sinal de Start para o Multiplicador
    
    // --- Barramento da Pilha RPN ---
    wire [7:0]  T0, T1, T2;   // Saídas dos registradores da pilha
    wire [7:0]  MuxT0_in, MuxT1_in; // Entradas para os MUXes de controle
    wire [7:0]  D_in_T0, D_in_T1, D_in_T2; // Entradas para os FFs
    wire [7:0]  OperandoA;
    wire [7:0]  OperandoB;
    
    // --- Barramento da ULA (Resultados) ---
    wire [7:0]  res_Soma, res_Sub, res_Or, res_And, res_Xor, res_Not;
    wire [15:0] res_Mult;
    wire [7:0]  res_Div, res_Resto;
    // NÃO há 'wire Div0' - a saída do Divisor é conectada diretamente a Div0_flag
    
    wire [7:0]  res_ALU_8bit; // Saída do MUX de 8 bits da ULA
    wire [15:0] res_Final;    // Saída do MUX de 16 bits (Resultado final)

    // --- Barramento do Display ---
    wire [7:0]  Display_In;   // Dado de 8 bits a ser exibido
    wire [2:0]  OctHex_A, OctHex_B, OctHex_C, OctHex_D, OctHex_E, OctHex_F, OctHex_G;
    wire [3:0]  BCD_H, BCD_T, BCD_O;
    wire [2:0]  Dec_A, Dec_B, Dec_C, Dec_D, Dec_E, Dec_F, Dec_G;
    wire        BaseSel_Dec;
    wire [2:0]  SegA_pre, SegB_pre, SegC_pre, SegD_pre, SegE_pre, SegF_pre, SegG_pre; // (Ativo Alto)

    // ===================================================================
    // == 1. LÓGICA DE CONTROLE E ESTADO (RPN)
    // ===================================================================

    // Debouncer do botão Enter (black box)
    Debounce U_Debounce (
        .clk(Clk), 
        .btn_raw(Enter_btn), 
        .btn_pulse(Enter_pulse)
    );

    // Contador de Estado (avança com o pulso do Enter) (black box)
    Contador U_Cont (
        .S(Estado), 
        .btn(Enter_pulse), // Clock é o pulso do botão
        .reset(Rst)
    );

    // Decodificador de Estado (Estrutural)
    wire nS0, nS1;
    not(nS0, Estado[0]);
    not(nS1, Estado[1]);
    and(estA, nS1, nS0); // Estado 00 (A)
    and(estB, nS1, Estado[0]); // Estado 01 (B)
    and(estOp, nS0, Estado[1]); // Estado 10 (Op)
    
    // Sinais de Carga da Pilha RPN
    and(LoadA, estA, Enter_pulse); // Carrega em A
    and(LoadB, estB, Enter_pulse); // Carrega em B
    and(LoadOp, estOp, 1'b1);      // Carrega no estado Op (não precisa de Enter)
    
    // Sinais de Op (1=Manter, 0=Carregar) para os MUXes de Controle
    wire LoadT0, LoadT1, LoadT2;
    or(LoadT0, LoadA, LoadB, LoadOp); // T0 é carregado em A, B, e Op
    or(LoadT1, LoadB, LoadOp);      // T1 é carregado em B e Op
    or(LoadT2, LoadOp, 1'b0);      // T2 é carregado em Op
    
    not(LoadT0_Op, LoadT0); // Inverte, pois Op=1 é Manter
    not(LoadT1_Op, LoadT1);
    not(LoadT2_Op, LoadT2);

    // ===================================================================
    // == 2. PILHA RPN (DATAPATH) - ARQUITETURA ATUALIZADA
    // ===================================================================

    // MUX para entrada do Registrador T0
    // Se (LoadOp=1) T0 <= res_ALU_8bit, Senão T0 <= DataIn
    MUX_8bit_2para1 MUX_T0_Data_In (
        .Y(MuxT0_in), 
        .A(DataIn), 
        .B(res_ALU_8bit), 
        .S(LoadOp)
    );
    
    // MUX para entrada do Registrador T1
    // Se (LoadOp=1) T1 <= T2, Senão T1 <= T0
    MUX_8bit_2para1 MUX_T1_Data_In (
        .Y(MuxT1_in), 
        .A(T0), 
        .B(T2), 
        .S(LoadOp)
    );

    // --- Instâncias de MUX de Controle (Seu módulo) ---
    ControleReg8Bits MUX_Reg_T0 (
        .S(D_in_T0),     // Saída do MUX -> Entrada dos FFs
        .A(MuxT0_in),    // Dado novo
        .SFF(T0),        // Dado antigo (realimentação da saida do FF)
        .Op(LoadT0_Op)   // Seletor (1=manter, 0=carregar)
    );
    
    ControleReg8Bits MUX_Reg_T1 (
        .S(D_in_T1), 
        .A(MuxT1_in), 
        .SFF(T1), 
        .Op(LoadT1_Op)
    );

    ControleReg8Bits MUX_Reg_T2 (
        .S(D_in_T2), 
        .A(T1),          // T2 sempre recebe T1 (quando LoadOp=1)
        .SFF(T2), 
        .Op(LoadT2_Op)
    );

    // --- Instâncias de Registradores (Seu módulo black box) ---
    Registrador8Bits Reg_T0 (
        .saida(T0),      // Saída dos FFs
        .clock(Clk), 
        .reset(Rst), 
        .entrada(D_in_T0) // Entrada dos FFs (vem do MUX de controle)
    );
    
    Registrador8Bits Reg_T1 (
        .saida(T1), 
        .clock(Clk), 
        .reset(Rst), 
        .entrada(D_in_T1)
    );
    
    Registrador8Bits Reg_T2 (
        .saida(T2), 
        .clock(Clk), 
        .reset(Rst), 
        .entrada(D_in_T2)
    );
    

    // ===================================================================
    // == 3. UNIDADE LÓGICA E ARITMÉTICA (ULA)
    // ===================================================================


    
    // Conecta T0 a OperandoA (Buffer Lógico: A = T0)
    and(OperandoA[0], T0[0], T0[0]); // A forma estrutural de fazer A=T0
    and(OperandoA[1], T0[1], T0[1]);
    and(OperandoA[2], T0[2], T0[2]);
    and(OperandoA[3], T0[3], T0[3]);
    and(OperandoA[4], T0[4], T0[4]);
    and(OperandoA[5], T0[5], T0[5]);
    and(OperandoA[6], T0[6], T0[6]);
    and(OperandoA[7], T0[7], T0[7]);
    
    // Conecta T1 a OperandoB (Buffer Lógico: B = T1)
    and(OperandoB[0], T1[0], T1[0]);
    and(OperandoB[1], T1[1], T1[1]);
    and(OperandoB[2], T1[2], T1[2]);
    and(OperandoB[3], T1[3], T1[3]);
    and(OperandoB[4], T1[4], T1[4]);
    and(OperandoB[5], T1[5], T1[5]);
    and(OperandoB[6], T1[6], T1[6]);
    and(OperandoB[7], T1[7], T1[7]);

    // Instancia todas as 8 unidades funcionais (black boxes)
    // Op 0: Soma
    SomComp8bits U_SOMA (
        .S(res_Soma), .Cout(), .A(OperandoA), .B(OperandoB), .Cin(1'b0)
    );
    // Op 1: Subtração
    SubComp8bits U_SUB (
        .S(res_Sub), .Bout(), .A(OperandoA), .B(OperandoB), .Bin(1'b0)
    );
    // Op 2: And
    And8Bits U_AND (
        .S(res_And), .A(OperandoA), .B(OperandoB)
    );
    // Op 3: Or
    Or8Bits U_OR (
        .S(res_Or), .A(OperandoA), .B(OperandoB)
    );
    // Op 4: Xor
    Xor8Bits U_XOR (
        .S(res_Xor), .A(OperandoA), .B(OperandoB)
    );
    // Op 5: Not
    Not8Bits U_NOT (
        .S(res_Not), .A(OperandoA)
    );
    
    // Decodifica o OpSelect para o Start do Multiplicador
    Decoder_3para8 U_OpDec (
        .Y(Op_Enable), .S(OpSelect)
    );
    // Start do Multiplicador é ativado no estado de Operação E OpSelect=6
    and(Mult_Start, estOp, Op_Enable[6]); 
    
    // Op 6: Multiplicação
    Multiplicador U_MULT (
        .S(res_Mult), .A(OperandoA), .B(OperandoB), 
        .Clk(Clk), .Start(Mult_Start), .Rst(Rst)
    );
    // Op 7: Divisão
    Divisor U_DIV (
        .S(res_Div), .Resto(res_Resto), 
        .Div0(Div0_flag), // CORREÇÃO: Conecta Div0 diretamente à saída
        .A(OperandoA), .B(OperandoB)
    );

    // ===================================================================
    // == 4. BARRAMENTO DE RESULTADO (MUXes)
    // ===================================================================

    // MUX da ULA de 8 bits (para realimentar a pilha RPN)
    MUX_8bit_8para1 U_ALU_MUX (
        .Y(res_ALU_8bit), .S(OpSelect),
        .I0(res_Soma),
        .I1(res_Sub),
        .I2(res_And),
        .I3(res_Or),
        .I4(res_Xor),
        .I5(res_Not),
        .I6(res_Mult[7:0]), // Byte baixo da multiplicação
        .I7(res_Div)        // Quociente da divisão
    );

    // MUX do Resultado Final (para o Display)
    // CORREÇÃO: Removidos os 'assign' (wire w_res... = ...)
    // A concatenação é feita diretamente na porta.
    MUX_16bit_8para1 U_Final_Mux (
        .Y(res_Final), .S(OpSelect),
        .I0({8'b0, res_Soma}),
        .I1({8'b0, res_Sub}),
        .I2({8'b0, res_And}),
        .I3({8'b0, res_Or}),
        .I4({8'b0, res_Xor}),
        .I5({8'b0, res_Not}),
        .I6(res_Mult),
        .I7({res_Resto, res_Div})
    );

    // ===================================================================
    // == 5. SUBSISTEMA DE DISPLAY
    // ===================================================================

    // MUX de seleção de visualização (O que mostrar)
    // 00=Resultado Low, 01=Resultado High, 10=Resto, 11=T0
    MUX_8bit_4para1 U_Disp_Mux (
        .Y(Display_In), 
        .I0(res_Final[7:0]),  // Byte Baixo
        .I1(res_Final[15:8]), // Byte Alto
        .I2(res_Resto),       // Resto (útil p/ Div)
        .I3(T0),              // Valor em T0 (para debug)
        .S(DisplaySelect)
    );

    // Lógica de seleção de Base
    // BaseSelect: 00=Oct, 01=Hex, 10=Dec
    and(BaseSel_Dec, BaseSelect[1], 1'b1); // Seletor para Decimal

    // Conversor Octal/Hex (módulo do usuário)
    mux_octal_hex U_OctHex (
        .BIN(Display_In), 
        .sel(BaseSelect[0]), 
        .A(OctHex_A), .B(OctHex_B), .C(OctHex_C), .D(OctHex_D),
        .E(OctHex_E), .F(OctHex_F), .G(OctHex_G)
    );
    
    // Conversor Decimal (DoubleDabble)
    DoubleDabble U_Dab (
        .BIN(Display_In), 
        .H(BCD_H), .T(BCD_T), .O(BCD_O)
    );
    
    // Converte os 3 dígitos BCD para 7 segmentos
    BCD_to_7Seg U_Dec_H (
        .A(Dec_A[2]), .B(Dec_B[2]), .C(Dec_C[2]), .D(Dec_D[2]), 
        .E(Dec_E[2]), .F(Dec_F[2]), .G(Dec_G[2]), .BCD(BCD_H)
    );
    BCD_to_7Seg U_Dec_T (
        .A(Dec_A[1]), .B(Dec_B[1]), .C(Dec_C[1]), .D(Dec_D[1]), 
        .E(Dec_E[1]), .F(Dec_F[1]), .G(Dec_G[1]), .BCD(BCD_T)
    );
    BCD_to_7Seg U_Dec_O (
        .A(Dec_A[0]), .B(Dec_B[0]), .C(Dec_C[0]), .D(Dec_D[0]), 
        .E(Dec_E[0]), .F(Dec_F[0]), .G(Dec_G[0]), .BCD(BCD_O)
    );

    // MUX Final: Seleciona entre (Oct/Hex) ou (Dec)
    MUX_3bit_2para1 MUX_SegA ( .Y(SegA_pre), .A(OctHex_A), .B(Dec_A), .S(BaseSel_Dec) );
    MUX_3bit_2para1 MUX_SegB ( .Y(SegB_pre), .A(OctHex_B), .B(Dec_B), .S(BaseSel_Dec) );
    MUX_3bit_2para1 MUX_SegC ( .Y(SegC_pre), .A(OctHex_C), .B(Dec_C), .S(BaseSel_Dec) );
    MUX_3bit_2para1 MUX_SegD ( .Y(SegD_pre), .A(OctHex_D), .B(Dec_D), .S(BaseSel_Dec) );
    MUX_3bit_2para1 MUX_SegE ( .Y(SegE_pre), .A(OctHex_E), .B(Dec_E), .S(BaseSel_Dec) );
    MUX_3bit_2para1 MUX_SegF ( .Y(SegF_pre), .A(OctHex_F), .B(Dec_F), .S(BaseSel_Dec) );
    MUX_3bit_2para1 MUX_SegG ( .Y(SegG_pre), .A(OctHex_G), .B(Dec_G), .S(BaseSel_Dec) );

    // ===================================================================
    // == 6. SAÍDAS (INVERSORES ATIVO-BAIXO)
    // ===================================================================
    
    // Inverte os 21 sinais de segmento para Ativo Baixo
    not(SegA[0], SegA_pre[0]); not(SegA[1], SegA_pre[1]); not(SegA[2], SegA_pre[2]);
    not(SegB[0], SegB_pre[0]); not(SegB[1], SegB_pre[1]); not(SegB[2], SegB_pre[2]);
    not(SegC[0], SegC_pre[0]); not(SegC[1], SegC_pre[1]); not(SegC[2], SegC_pre[2]);
    not(SegD[0], SegD_pre[0]); not(SegD[1], SegD_pre[1]); not(SegD[2], SegD_pre[2]);
    not(SegE[0], SegE_pre[0]); not(SegE[1], SegE_pre[1]); not(SegE[2], SegE_pre[2]);
    not(SegF[0], SegF_pre[0]); not(SegF[1], SegF_pre[1]); not(SegF[2], SegF_pre[2]);
    not(SegG[0], SegG_pre[0]); not(SegG[1], SegG_pre[1]); not(SegG[2], SegG_pre[2]);

endmodule