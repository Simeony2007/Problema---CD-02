module Registrador8Bits(saida, clock, copie, entrada);
	input clock, copie;
	input [8:0]entrada;
	output [8:0]saida;
	
	FlipFlop f0(clock, copie, entrada[0], saida[0]);
	FlipFlop f1(clock, copie, entrada[1], saida[1]);
	FlipFlop f2(clock, copie, entrada[2], saida[2]);
	FlipFlop f3(clock, copie, entrada[3], saida[3]);
	FlipFlop f4(clock, copie, entrada[4], saida[4]);
	FlipFlop f5(clock, copie, entrada[5], saida[5]);
	FlipFlop f6(clock, copie, entrada[6], saida[6]);
	FlipFlop f7(clock, copie, entrada[7], saida[7]);
	FlipFlop f8(clock, copie, entrada[8], saida[8]);


endmodule