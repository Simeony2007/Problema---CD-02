module SubComp1bit(S, Bout, A, B, Bin);
	// ENTRADAS, SAIDAS E FIOS:
	input A, B, Bin;
	output S, Bout;
	
	wire F1, F2, F3, F4;
	
	// A mesma lógica da soma, o que muda é o Bout:
	xor Xor0(S, A, B, Bin);
	
	not NotA(F1, A);
	
	or Or0(F2, F1, Bin);
	and And0(F3, F2, B);
	and And1(F4, F1, Bin);
	or Or1(Bout, F3, F4);
	
endmodule