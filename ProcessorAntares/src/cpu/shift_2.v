//-----------------------------------------------------------------------------
// Universidade Estadual de Feira de Santana
// TEC499 - MI - Sistemas Digitais
// Antares-R2 2016.1
//
// Module: shift_2.v
// Desc: Structure to Shift 2 a Binary(Multiply by 4) used on Jump or Branch Instructions
// Inputs:
// 	in: 32 bits Word sign extended of offset Value of the instruction
//  Outputs:
// 	out: The 32 bits Shift left by 2
//-----------------------------------------------------------------------------

`ifndef _shift_2
`define _shift_2

module shift_2(
      input [31:0] in,
      output [31:0] out
    );

    assign out = {in[29:0], 2'b0};
endmodule

`endif
