module Divisor(S, Resto, Div0, A, B);
    input  [7:0] A;
    input  [7:0] B;
    output [7:0] S;
    output [7:0] Resto;
    output Div0;
	 
	 wire B0, B1, B2, B3, B4, B5, B6, B7;
	 wire [7:0]Sub0;
	 wire [7:0]Sub1;
	 wire [7:0]Sub2;
	 wire [7:0]Sub3;
	 wire [7:0]Sub4;
	 wire [7:0]Sub5;
	 wire [7:0]Sub6;
	 wire [7:0]Sub7;
	 wire [7:0]R0;
	 wire [7:0]R1;
	 wire [7:0]R2;
	 wire [7:0]R3;
	 wire [7:0]R4;
	 wire [7:0]R5;
	 wire [7:0]R6;
	 wire [7:0]T;

	 // Bit 0
    SubComp8bits sub0(
	 .S(Sub0),
	 .Bout(B0),
	 .A({6'b0, A[7]}),
	 .B(B),
	 .Bin(1'b0));
	 
	 MUX8para8 Decisao0(
	 .S(R0),
	 .A(Sub0),
	 .B({6'b0, A[7]}),
	 .SLCT(B0)); // 0 = A, 1 = B
    
	 not Saida0(S[7], B0);
	 
	 // Bit 1
	 SubComp8bits sub1(
	 .S(Sub1),
	 .Bout(B1),
	 .A({R0[6:0], A[6]}),
	 .B(B),
	 .Bin(1'b0));
	 
	 MUX8para8 Decisao1(
	 .S(R1),
	 .A(Sub1),
	 .B({R0[6:0], A[6]}),
	 .SLCT(B1)); 
    
	 not Saida1(S[6], B1);
	 
	 // Bit 2
	 SubComp8bits sub2(
	 .S(Sub2),
	 .Bout(B2),
	 .A({R1[6:0], A[5]}),
	 .B(B),
	 .Bin(1'b0));
	 
	 MUX8para8 Decisao2(
	 .S(R2),
	 .A(Sub2),
	 .B({R1[6:0], A[5]}),
	 .SLCT(B2)); 
    
	 not Saida2(S[5], B2);
	 
	 // Bit 3
	 SubComp8bits sub3(
	 .S(Sub3),
	 .Bout(B3),
	 .A({R2[6:0], A[4]}),
	 .B(B),
	 .Bin(1'b0));
	 
	 MUX8para8 Decisao3(
	 .S(R3),
	 .A(Sub3),
	 .B({R2[6:0], A[4]}),
	 .SLCT(B3)); 
    
	 not Saida3(S[4], B3);
	 
	 // Bit 4
	 SubComp8bits sub4(
	 .S(Sub4),
	 .Bout(B4),
	 .A({R3[6:0], A[3]}),
	 .B(B),
	 .Bin(1'b0));
	 
	 MUX8para8 Decisao4(
	 .S(R4),
	 .A(Sub4),
	 .B({R3[6:0], A[3]}),
	 .SLCT(B4)); 
    
	 not Saida4(S[3], B4);
	 
	 // Bit 5
	 SubComp8bits sub5(
	 .S(Sub5),
	 .Bout(B5),
	 .A({R4[6:0], A[2]}),
	 .B(B),
	 .Bin(1'b0));
	 
	 MUX8para8 Decisao5(
	 .S(R5),
	 .A(Sub5),
	 .B({R4[6:0], A[2]}),
	 .SLCT(B5)); 
    
	 not Saida5(S[2], B5);
	 
	 // Bit 6
	 SubComp8bits sub6(
	 .S(Sub6),
	 .Bout(B6),
	 .A({R5[6:0], A[1]}),
	 .B(B),
	 .Bin(1'b0));
	 
	 MUX8para8 Decisao6(
	 .S(R6),
	 .A(Sub6),
	 .B({R5[6:0], A[1]}),
	 .SLCT(B6)); 
    
	 not Saida6(S[1], B6);
	 
	 // Bit 6
	 SubComp8bits sub7(
	 .S(Sub7),
	 .Bout(B7),
	 .A({R6[6:0], A[0]}),
	 .B(B),
	 .Bin(1'b0));
	 
	 MUX8para8 Decisao7(
	 .S(Resto),
	 .A(Sub7),
	 .B({R6[6:0], A[0]}),
	 .SLCT(B7)); 
    
	 not Saida7(S[0], B7);
	 
	 not(T[0], B[0]);
	 not(T[1], B[1]);
	 not(T[2], B[2]);
	 not(T[3], B[3]);
	 not(T[4], B[4]);
	 not(T[5], B[5]);
	 not(T[6], B[6]);
	 not(T[7], B[7]);
	 
	 and(Div0, T[7:0]);
	 
	 
endmodule