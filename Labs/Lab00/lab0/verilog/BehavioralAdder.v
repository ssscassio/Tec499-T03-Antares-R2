
module BehavioralAdder #(
  parameter Width = 16
)
(
  input   [Width-1:0] A,
  input   [Width-1:0] B,
  output  [Width-1:0] Result,
  output              Cout
);

  assign {Cout, Result} = A + B;

endmodule
