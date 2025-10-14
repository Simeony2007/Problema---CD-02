module SubComp8bits(S, Bout, A, B, Bin);
	// ENTRADAS, SAIDAS E FIOS:
	input [7:0]A;
	input [7:0]B;
	input Bin;
	output [7:0]S;
	output Bout;
	wire [7:0]T;
	
	// INSTANCIAÇÃO DO SUBTRATOR COMPLETO DE 1 BIT:
	SubComp1bit U0(S[0], T[1], A[0], B[0], Bin);
	SubComp1bit U1(S[1], T[2], A[1], B[1], T[1]);
	SubComp1bit U2(S[2], T[3], A[2], B[2], T[2]);
	SubComp1bit U3(S[3], T[4], A[3], B[3], T[3]);
	SubComp1bit U4(S[4], T[5], A[4], B[4], T[4]);
	SubComp1bit U5(S[5], T[6], A[5], B[5], T[5]);
	SubComp1bit U6(S[6], T[7], A[6], B[6], T[6]);
	SubComp1bit U7(S[7], Bout, A[7], B[7], T[7]);
	
endmodule