module FlipFlopD(s, a, clk, reset);
    output reg s;   // Saída
    input  wire a;   // Entrada
    input  wire clk; // Clock
    input  wire reset; // Reset

    always @(posedge clk or posedge reset) begin
        
        // Reset assíncrono
        if (reset) begin
            s <= 1'b0;
        end
        else begin
            s <= a;
        end
    end

endmodule