//-----------------------------------------------------------------------------
// Universidade Estadual de Feira de Santana
// TEC499 - MI - Sistemas Digitais
// Antares-R2 2016.1
//
// Module: full_adder.v
// Desc: 1-bit Full Adder
// Inputs:
// 	A: First bit to sum
//  B: Second bit to sum
// Outputs:
// 	Sum: The result of the sum of A with B
//  Cout: Carry value result
//-----------------------------------------------------------------------------
`ifndef _full_adder
`define _full_adder

module full_adder(
      input A, B, Cin,
      output Sum, Cout);

      // Desc: Sum = (A xor B) xor Cin
      //       Cout = [(A xor B) and Cin] or (A and B)
      assign Sum = (A ^ B) ^ Cin;
      assign Cout = (Cin & (A ^ B)) | (A & B);

endmodule

`endif
