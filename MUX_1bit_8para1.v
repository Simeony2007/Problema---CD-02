module MUX_1bit_8para1(Y, I, S);
    output Y;
    input  [7:0] I;
    input  [2:0] S;
    wire   [7:0] Dec, w;
    
    Decoder_3para8 U_Dec(Dec, S);
    
    and(w[0], I[0], Dec[0]);
    and(w[1], I[1], Dec[1]);
    and(w[2], I[2], Dec[2]);
    and(w[3], I[3], Dec[3]);
    and(w[4], I[4], Dec[4]);
    and(w[5], I[5], Dec[5]);
    and(w[6], I[6], Dec[6]);
    and(w[7], I[7], Dec[7]);
    
    or(Y, w[0], w[1], w[2], w[3], w[4], w[5], w[6], w[7]);
endmodule