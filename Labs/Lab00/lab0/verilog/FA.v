//-----------------------------------------------------------------------------
// UEFS TEC 499
// Lab 0, 2016.1
// Module: FA.v
// Desc: 1-bit Full Adder
//       You may only use structural verilog in this module.
//-----------------------------------------------------------------------------
module FA(
    input A, B, Cin,
    output Sum, Cout
);
   // Structural verilog only!
   /********YOUR CODE HERE********/
    // Desc: Sum = (A xor B) xor Cin
    //       Cout = [(A xor B) and Cin] or (A and B)

    wire AxorB, AandB, AxorBandCin;

    //Share Wire
    xor (AxorB, A, B);
    //Sum struct
    xor (Sum, AxorB, Cin)
    //Cout struct
    and (AandB, A, B);
    and (AxorBandCin, AxorB, Cin);
    or (Cout, AxorBandCin, AandB);

   /********END CODE********/
endmodule
