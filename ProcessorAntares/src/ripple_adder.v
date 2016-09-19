//-----------------------------------------------------------------------------
// Universidade Estadual de Feira de Santana
// TEC499 - MI - Sistemas Digitais
// Antares-R2 2016.1
//
// Module: ripple_adder.v
// Desc: Parametrized structural ripple-carry adder
// Inputs:
// 	A: First binary value to Adder
//  B: Second binary value to Adder
// Outputs:
// 	Result: The result of the sum of A with B
//  Cout: Carry value result
//-----------------------------------------------------------------------------
`include "full_adder.v"

`ifndef _ripple_adder
`define _ripple_adder

module ripple_adder #(
      parameter Width = 32
    )
    ( input   [Width-1:0] A,
      input   [Width-1:0] B,
      output  [Width-1:0] Result,
      output              Cout);

      wire    [Width:0] Carry;

      assign  Carry[0] = 1'b0;

      assign  Cout = Carry[Width];

      genvar 	      i;
      generate
        for (i = 0 ; i < Width; i = i + 1)
          begin: gen_adder
            full_adder addN (
              .A(A[i]), .B(B[i]), .Cin(Carry[i]),//Inputs
              .Sum(Result[i]), .Cout(Carry[i+1])//Outputs
              );
          end
      endgenerate

endmodule

`endif
