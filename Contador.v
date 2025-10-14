module Contador(S, A, B);
	// ENTRADAS, SAIDAS E FIOS:
	input [2:0]A;
	input [2:0]B;
	output [2:0]S;
	wire [2:0]T;
	
	// INSTANCIAÇÃO DO SUBTRATOR COMPLETO DE 1 BIT:
	SubComp1bit U0(S[0], T[1], A[0], B[0], 0);
	SubComp1bit U1(S[1], T[2], A[1], B[1], T[1]);
	SubComp1bit U2(S[2], 0, A[2], B[2], T[2]);

	
endmodule