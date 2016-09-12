//-----------------------------------------------------------------------------
// Universidade Estadual de Feira de Santana
// TEC499 - MI - Sistemas Digitais
// Antares-R2 2016.1
//
// Module: mux_2_5.v
// Desc: Multiplex 2 signals of 5 bits into 1 signal of 5 bits
// Inputs:
// 	A: First 5 bits value beign multiplex (Selector = High)
//  B: Second 5 bits value beign multiplex (Selector = Low)
//  sel: Selector key
// Outputs:
// 	out: The Binary input selected
//-----------------------------------------------------------------------------

`ifndef _mux_2_5
`define _mux_2_5

module mux_2_5(
      input [4:0] A, B,
      input Sel,
      output [4:0] out
    );

    assign out = (Sel)? A : B;
endmodule

`endif
