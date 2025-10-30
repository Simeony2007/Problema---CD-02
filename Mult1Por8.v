module Mult1Por8(S, A, B);
	input A;
	input [7:0] B;
	output [7:0] S;
	
	and And0(S[0], B[0], A);
	and And1(S[1], B[1], A);
	and And2(S[2], B[2], A);
	and And3(S[3], B[3], A);
	and And4(S[4], B[4], A);
	and And5(S[5], B[5], A);
	and And6(S[6], B[6], A);
	and And7(S[7], B[7], A);

endmodule