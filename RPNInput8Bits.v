module RPNInput8Bits(S, A, REG0, REG1, REG2, REG3, Contador, Clk, reset);
	
	// FINALIZAR
	
	Registrador8Bits Reg0(
	.saida(), 
	.clock(), 
	.reset(), 
	.entrada());
	
	RPNInput bit0(
	.S(), 
	.A(), 
	.FF0(), 
	.FF1(), 
	.FF2(), 
	.FF3(), 
	.Contador());

endmodule