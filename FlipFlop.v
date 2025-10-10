module FlipFlop(
    input wire clock,
	 input wire copie,
    input wire entrada,
    output reg saida
);

    always @(posedge clock) begin
        if (copie) begin
	         saida <= entrada;
        end
    end

endmodule