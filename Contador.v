module Contador(S, btn, reset);
	input btn, reset; // VERIFICAR WAVEFORM SEM O CLOCK, USANDO O BTN NO LUGAR!!!
	output [1:0]S;
	
	wire [1:0]valorFF;
	wire [1:0]soma;
	
	wire GND;
	
	// FAZER O SISTEMA DE BOUNCE DO BOTÃO
		
	FlipFlopD ff0(
		.a(valorFF[0]),
      .s(S[0]),
      .clk(btn),
      .reset(reset));
		
	FlipFlopD ff1(
		.a(valorFF[1]),
      .s(S[1]),
      .clk(btn),
      .reset(reset));
		
	ControleFFD Controle0(
		.S(valorFF[0]), 
		.A(soma[0]), 
		.SFF(S[0]), 
		.Op(btn));
		
	ControleFFD Controle1(
		.S(valorFF[1]), 
		.A(soma[1]), 
		.SFF(S[1]), 
		.Op(btn));	
		
	SomComp2Bits somador(.S(soma), .Cout(GND), .A(S), .B(2'b01), .Cin(0));
	
		
endmodule