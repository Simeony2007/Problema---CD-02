module Multiplicador(S, A, B, Clk, Start, Rst);
	input [7:0] A;
	input [7:0] B;
	input Clk;
	input Start;
	input Rst;
	output [15:0] S;
	
	wire [7:0] M0;
	wire [7:0] M1;
	wire [7:0] M2;
	wire [7:0] M3;
	wire [7:0] M4;
	wire [7:0] M5;
	wire [7:0] M6;
	wire [7:0] M7;
	wire [2:0] Contador;
	wire [15:0]Shift;
	wire [15:0]Soma;
	wire T0, T1, T2, T3;
	wire GND;
	
	// MULTIPLICAÇÕES
	Mult1Por8 mult0(
	.S(M0), 
	.A(B[0]), 
	.B(A));
	
	Mult1Por8 mult1(
	.S(M1), 
	.A(B[1]), 
	.B(A));
	
	Mult1Por8 mult2(
	.S(M2), 
	.A(B[2]), 
	.B(A));
	
	Mult1Por8 mult3(
	.S(M3), 
	.A(B[3]), 
	.B(A));
	
	Mult1Por8 mult4(
	.S(M4), 
	.A(B[4]), 
	.B(A));
	
	Mult1Por8 mult5(
	.S(M5), 
	.A(B[5]), 
	.B(A));
	
	Mult1Por8 mult6(
	.S(M6), 
	.A(B[6]), 
	.B(A));
	
	Mult1Por8 mult7(
	.S(M7), 
	.A(B[7]), 
	.B(A));
	
	// Contador
	Contador8Bits cont(
	.S(Contador), 
	.clk(Clk), 
	.reset(T1),
	.toggle(T2));
	
	// Shifter
	Shifter sift(
	.S(Shift), 
	.Contador(Contador), 
	.P1({8'b0, M0}), // M0 << 0
	.P2({7'b0, M1, 1'b0}), // M1 << 1
	.P3({6'b0, M2, 2'b0}), // M2 << 2
	.P4({5'b0, M3, 3'b0}), // M3 << 3
	.P5({4'b0, M4, 4'b0}), // M4 << 4
	.P6({3'b0, M5, 5'b0}), // M5 << 5
	.P7({2'b0, M6, 6'b0}), // M6 << 6
	.P8({1'b0, M7, 7'b0}));  // M7 << 7
	
	ControleMultiplicacao control(
	.Finalizado(T3),
   .ativCont(T2),
   .limpaCont(T1),
   .acumula(T0),
   .Clk(Clk),
   .Rst(Rst),
   .Start(Start),
   .contador(Contador));
	
	
	SomComp16Bits soma(
	.S(Soma), 
	.Cout(GND), 
	.A(S), 
	.B(Shift), 
	.Cin(1'b0));
	
	Registrador8Bits Reg0(
	.saida(S[7:0]), 
	.clock(Clk), 
	.reset(Rst), 
	.entrada(InpReg0));
	
	Registrador8Bits Reg1(
	.saida(S[15:8]), 
	.clock(Clk), 
	.reset(Rst), 
	.entrada(InpReg1));
	
	ControleReg8Bits controle0(
	.S(InpReg0), 
	.A(Soma[7:0]), 
	.SFF(S[7:0]), 
	.Op(T0));
	
	ControleReg8Bits controle1(
	.S(InpReg1), 
	.A(Soma[15:8]), 
	.SFF(S[15:8]), 
	.Op(T0));
	

endmodule