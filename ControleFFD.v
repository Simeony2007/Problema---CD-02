module ControleFFD(S, A, SFF, Op);

	input A, SFF, Op;
	output S;
	
	wire nOp;
	wire T0;

	not OpInv(nOp, Op);
	
	and and0(T0, A, nOp);
	and and1(T1, SFF, Op);
	
	or or0(S, T0, T1);

endmodule