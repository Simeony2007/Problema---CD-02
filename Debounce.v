module Debounce(S, Btn, Clk, rst);
	input Btn, Clk, rst;
	output S;
	wire T0, T1, T2, T3, T4;

	// A saída do pulso do botão em 1(nivel logico alto)
	
	FlipFlopD FF0(
	.s(T2), 
	.a(Btn), 
	.clk(Clk), 
	.reset(rst));

	FlipFlopD FF1(
	.s(T3), 
	.a(T2), 
	.clk(Clk), 
	.reset(rst));
	
	FlipFlopD FF2(
	.s(T4), 
	.a(T3), 
	.clk(Clk), 
	.reset(rst));

	
	FlipFlopD ValorAntigo(
	.s(T0), 
	.a(T4), 
	.clk(Clk), 
	.reset(rst));
	
	and and0(S, T0, T1);
	not not0(T1, T4);

endmodule