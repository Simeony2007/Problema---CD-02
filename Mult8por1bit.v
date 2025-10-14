module Mult8por1bit(S, A, B);
	input [7:0]A;
	input B;
	output [7:0]S;
	
	and and0(S[0], A[0], B); 
	and and1(S[1], A[1], B); 
	and and2(S[2], A[2], B); 
	and and3(S[3], A[3], B); 
	and and4(S[4], A[4], B); 
	and and5(S[5], A[5], B); 
	and and6(S[6], A[6], B); 
	and and7(S[7], A[7], B); 

endmodule