`ifndef _behavioral_adder
`define _behavioral_adder

module behavioral_adder #(
  parameter Width = 32
)
(
  input   [Width-1:0] A,
  input   [Width-1:0] B,
  output  [Width-1:0] Result,
  output              Cout
);

  assign {Cout, Result} = A + B;

endmodule

`endif
