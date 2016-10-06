//-----------------------------------------------------------------------------
// Universidade Estadual de Feira de Santana
// TEC499 - MI - Sistemas Digitais
// Antares-R2 2016.1
//
// Module: memory_monitor.v
// Desc:
// Inputs:
// clk: Clock
// address:
//
// Outputs:
// status:
//-----------------------------------------------------------------------------

`ifndef _mux_2_32
`define _mux_2_32

module memory_monitor(
  input clk,
  output reg status,
  output reg [31:0] statusAddress,
  input [31:0] address
  );

  reg deviceDataAddress = 32'11111111111111111000000000000100;

  initial begin
    statusAddress <= 32'b11111111111111111000000000000000;
  end

  always @ ( posedge clk) begin
      if(address == deviceDataAddress) //32 bits after status address
        assign status = 1;
      else
        assign status = 0;
  end

endmodule

`endif
