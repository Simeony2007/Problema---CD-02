module Contador8Bits(S, clk, reset, toggle);
	input clk, reset; 
	input toggle;
	output [2:0]S;
	
	wire [2:0]valorFF;
	wire [2:0]soma;
	
	wire GND;

	FlipFlopD ff0(
		.a(valorFF[0]),
      .s(S[0]),
      .clk(clk),
      .reset(reset));
		
	FlipFlopD ff1(
		.a(valorFF[1]),
      .s(S[1]),
      .clk(clk),
      .reset(reset));
		
	FlipFlopD ff2(
		.a(valorFF[2]),
      .s(S[2]),
      .clk(clk),
      .reset(reset));
		
	ControleFFD Controle0(
		.S(valorFF[0]), 
		.A(soma[0]), 
		.SFF(S[0]), 
		.Op(toggle));
		
	ControleFFD Controle1(
		.S(valorFF[1]), 
		.A(soma[1]), 
		.SFF(S[1]), 
		.Op(toggle));	
		
	ControleFFD Controle2(
		.S(valorFF[2]), 
		.A(soma[2]), 
		.SFF(S[2]), 
		.Op(toggle));	
		
	SomComp3Bits somador(.S(soma), .Cout(GND), .A(S), .B(3'b001), .Cin(0));

endmodule