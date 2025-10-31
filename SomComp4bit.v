module SomComp4bit(S, Cout, A, B, Cin);
	input [3:0]A; 
	input [3:0]B;
	input Cin;
	output Cout;
	output [3:0]S;
	wire T0;
	
	SomComp2Bits b0(.S(S[1:0]), .Cout(T0), .A(A[1:0]), .B(B[1:0]), .Cin(Cin));
	SomComp2Bits b1(.S(S[3:2]), .Cout(Cout), .A(A[3:2]), .B(B[3:2]), .Cin(T0));
endmodule