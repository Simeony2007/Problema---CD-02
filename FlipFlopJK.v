module FlipFlopJK (
    input clk,       // Clock 
    input rst_n,     // Reset
    input j,         // J 
    input k,         // K 
    output reg q,    // Q 
    output q_bar     // Q Invertido
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin // Reset assíncrono
            q <= 1'b0;
        end else begin
            case ({j, k})
                2'b00: q <= q;     // Mantém
                2'b01: q <= 1'b0;  // Reseta
                2'b10: q <= 1'b1;  // Coloca valor 1
                2'b11: q <= ~q;    // Inverte
            endcase
        end
    end

    // Saída de Q invertida
    assign q_bar = ~q;

endmodule