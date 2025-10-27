module SomComp16Bits(S, Cout, A, B, Cin);
	input [15:0]A;
	input [15:0]B;
	input Cin;
	output [15:0]S;
	output Cout;
	wire T;
	
	SomComp8bits parte1(
	.S(S[7:0]), 
	.Cout(T), 
	.A(A[7:0]), 
	.B(B[7:0]), 
	.Cin(Cin));
	
	SomComp8bits parte2(
	.S(S[15:8]), 
	.Cout(Cout), 
	.A(A[15:8]), 
	.B(B[15:8]), 
	.Cin(T));
	
endmodule