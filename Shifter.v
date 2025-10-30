module Shifter(S, Contador, P1, P2, P3, P4, P5, P6, P7, P8);
	input [2:0]Contador;
	input [15:0] P1;
	input [15:0] P2;
	input [15:0] P3;
	input [15:0] P4;
	input [15:0] P5;
	input [15:0] P6;
	input [15:0] P7;
	input [15:0] P8;
	output [15:0] S;
	
	wire [15:0]T0;
	wire [15:0]T1;
	wire [15:0]T2;
	wire [15:0]T3;
	wire [15:0]T4;
	wire [15:0]T5;
	wire [15:0]T6;
	wire [15:0]T7;
	
	wire N0, N1, N2;
	wire Slc0, Slc1, Slc2, Slc3, Slc4, Slc5, Slc6, Slc7;
	
	not(N0, Contador[0]);
	not(N1, Contador[1]);
	not(N2, Contador[2]);
	
	and And0(Slc0, N2, N1, N0);
	and And1(Slc1, N2, N1, Contador[0]);
	and And2(Slc2, N2, Contador[1], N0);
	and And3(Slc3, N2, Contador[1], Contador[0]);
	
	and And4(Slc4, Contador[2], N1, N0);
	and And5(Slc5, Contador[2], N1, Contador[0]);
	and And6(Slc6, Contador[2], Contador[1], N0);
	and And7(Slc7, Contador[2], Contador[1], Contador[0]);
	
	genvar i;
	generate
		for (i = 0; i < 16; i = i + 1) begin : loop
		
		wire F0, F1, F2, F3, F4, F5, F6, F7;
		
		and vlr0(F0, P1[i], Slc0);
		and vlr1(F1, P2[i], Slc1);
		and vlr2(F2, P3[i], Slc2);
		and vlr3(F3, P4[i], Slc3);
		and vlr4(F4, P5[i], Slc4);
		and vlr5(F5, P6[i], Slc5);
		and vlr6(F6, P7[i], Slc6);
		and vlr7(F7, P8[i], Slc7);
		
		or saida(S[i], F0, F1, F2, F3, F4, F5, F6, F7);
		
		end
	endgenerate

endmodule