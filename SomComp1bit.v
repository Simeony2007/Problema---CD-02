module SomComp1bit(S, Cout, A, B, Cin);
	// Declarações
	input A, B, Cin;
	output S, Cout;
	wire T0, T1, T2;
	
	// Calculo de soma / S = A xor B xor C
	xor Xor0(S, A, B, Cin);
	
	// Calculo do Cout / Cout = B(A + C) + AC
	or Or0(T0, A, Cin);
	and And0(T1, T0, B);
	and And1(T2, A, Cin);
	or Or1(Cout, T1, T2);
	
endmodule