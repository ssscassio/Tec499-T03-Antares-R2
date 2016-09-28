`ifndef _baud_generator
`define _baud_generator

module baud_generator(
    input clk,
    output tick
);
    parameter clkFrequency = 50000000; // 50MHz / 115200 =  434,027
    parameter baud = 115200;            // 2^16 / 151 =  434.013
    parameter baudGeneratorAccWidth = 16;
    parameter baudGeneratorInc = (baud<<baudGeneratorAccWidth)/clkFrequency; // Deve ser igual a 151

    reg [baudGeneratorAccWidth:0] baudGeneratorAcc;

    always @(posedge clk) begin
      baudGeneratorAcc <= baudGeneratorAcc[baudGeneratorAccWidth-1:0] + baudGeneratorInc;
    end

    wire tick = baudGeneratorAcc[baudGeneratorAccWidth];

endmodule

`endif
