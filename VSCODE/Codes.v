module Registrador8Bits(saida, clock, reset, entrada);
    output [7:0] saida;  
    input clock, reset;  
    input [7:0] entrada; 

    // Bit 0
    FlipFlopD ff0 (
        .a(entrada[0]),
        .s(saida[0]),
        .clk(clock),
        .reset(reset)
    );
     
    // Bit 1
    FlipFlopD ff1 ( 
        .a(entrada[1]),
        .s(saida[1]),
        .clk(clock),
        .reset(reset)
    );

    // Bit 2
    FlipFlopD ff2 ( 
        .a(entrada[2]),
        .s(saida[2]),
        .clk(clock),
        .reset(reset)
    );

    // Bit 3
    FlipFlopD ff3 ( 
        .a(entrada[3]),
        .s(saida[3]),
        .clk(clock),
        .reset(reset)
    );

    // Bit 4
    FlipFlopD ff4 ( 
        .a(entrada[4]),
        .s(saida[4]),
        .clk(clock),
        .reset(reset)
    );

    // Bit 5
    FlipFlopD ff5 ( 
        .a(entrada[5]),
        .s(saida[5]),
        .clk(clock),
        .reset(reset)
    );

    // Bit 6
    FlipFlopD ff6 ( 
        .a(entrada[6]),
        .s(saida[6]),
        .clk(clock),
        .reset(reset)
    );

    // Bit 7
    FlipFlopD ff7 ( 
        .a(entrada[7]),
        .s(saida[7]),
        .clk(clock),
        .reset(reset)
    );
     
endmodule