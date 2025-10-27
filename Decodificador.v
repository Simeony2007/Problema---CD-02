module Decodificador(S, A);
	input [1:0]A;
	output [3:0]S;
	wire T0, T1;

	not(T0, A[0]);
	not(T1, A[1]);

	or(S[0], A[1], A[0]);
	or(S[1], A[1], T0);
	or(S[2], T1, A[0]);
	or(S[3], T1, T0);
	
endmodule