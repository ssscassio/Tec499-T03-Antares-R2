//-----------------------------------------------------------------------------
// Universidade Estadual de Feira de Santana
// TEC499 - MI - Sistemas Digitais
// Antares-R2 2016.1
//
// Module: mux_2_32.v
// Desc: Multiplex 2 signals of 32 bits into 1 signal of 32 bits
// Inputs:
// 	A: First 32 bits value beign multiplex (Selector = High)
//  B: Second 32 bits value beign multiplex (Selector = Low)
//  sel: Selector key
// Outputs:
// 	out: The Binary input selected
//-----------------------------------------------------------------------------

`ifndef _mux_2_32
`define _mux_2_32

module _mux_2_32(
      input [32:0] A, B,
      input Sel,
      output out
    );

    assign out = (Sel)? A : B;
endmodule

`endif
