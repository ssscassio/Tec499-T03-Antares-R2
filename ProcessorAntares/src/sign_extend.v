//-----------------------------------------------------------------------------
// Universidade Estadual de Feira de Santana
// TEC499 - MI - Sistemas Digitais
// Antares-R2 2016.1
//
// Module: sign_extend.v
// Desc: Structure to Signal extend a 16 bits value to 32 bits
// Inputs:
// 	Immediate: The Imediate that will be signal extend
// Outputs:
// 	Out: The Imediate with signal extended
//-----------------------------------------------------------------------------

`ifndef _sign_extend
`define _sign_extend

module sign_extend(
      input  [15:0] immediate,
      output [31:0] out);

      assign out = $signed(immediate);

endmodule

`endif
