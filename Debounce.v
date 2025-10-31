module Debounce(
    input clk,
    input btn_raw,
    output btn_pulse
);
    // sincronização do botão
    wire sync0, sync1;
    FlipFlopD ff_sync0(.clk(clk), .a(btn_raw), .s(sync0));
    FlipFlopD ff_sync1(.clk(clk), .a(sync0), .s(sync1));

    // detector de borda
    wire prev;
    FlipFlopD ff_prev(.clk(clk), .a(sync1), .s(prev));

    wire edge_sig;
    xor(edge_sig, sync1, prev);       // borda 0->1 ou 1->0
    wire rising_edge;
    and(rising_edge, edge_sig, sync1); // apenas 0->1

    // latch do pulso único
    wire pulse_ff;
    wire pulse_reset;
    FlipFlopD ff_pulse(.clk(clk), .a(rising_edge), .s(pulse_ff));
    not u_reset(pulse_reset, sync1);   // reseta quando botão liberado
    and(btn_pulse, pulse_ff, sync1);   // pulso de 1 ciclo
endmodule