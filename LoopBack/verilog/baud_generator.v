`ifndef _baud_generator
`define _baud_generator

module baud_generator(
    input clk, enable,
    output tick
);
    parameter clkFrequency = 50000000;
    parameter baud = 9600;
    parameter baudGeneratorAccWidth = 16;
    parameter baudGeneratorInc = (baud<<baudGeneratorAccWidth)/clkFrequency; // Deve ser igual a 151

    reg [baudGeneratorAccWidth:0] baudGeneratorAcc;

    always @(posedge clk) begin
      if(enable)
        baudGeneratorAcc <= baudGeneratorAcc[baudGeneratorAccWidth-1:0] + baudGeneratorInc;
    end

    reg tick = baudGeneratorAcc[baudGeneratorAccWidth];

endmodule

`endif
