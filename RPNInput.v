module RPNInput(Contador, T0, T1, T2, A, Clk, Rst);
	input Rst, Clk;
	input [7:0]A;
	output [1:0]Contador;
	output [7:0]T0;
	output [7:0]T1;
	output [7:0]T2;
	
	// Guarda A B Op e a base de exibição é decidida na hora
	Registrador8Bits RegA(.saida(T0), .clock(Clk), .reset(Rst), .entrada(A));
	Registrador8Bits RegB(.saida(T1), .clock(Clk), .reset(Rst), .entrada(T0));
	Registrador8Bits RegOP(.saida(T2), .clock(Clk), .reset(Rst), .entrada(T1)); 
	
	Contador cont(
	.S(Contador), 
	.btn(Clk), 
	.reset(Rst));
	
endmodule