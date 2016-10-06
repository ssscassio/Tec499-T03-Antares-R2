//-----------------------------------------------------------------------------
// Universidade Estadual de Feira de Santana
// TEC499 - MI - Sistemas Digitais
// Antares-R2 2016.1
//
// Module: convert32to8.v
// Desc:
// Inputs:
// clk:
// in:
// reset:
// Outputs:
// state:
// out:
//
// Credits: https://www.altera.com/support/support-resources/design-examples/design-software/verilog/ver_statem.html
//-----------------------------------------------------------------------------

module convert32to8(
  input clk, reset,
  input [31:0] data,
  output reg [7:0] out
  );
reg [1:0] state;

parameter zero=0, one=1, two=2, three=3;

always @(state)
     begin
          case (state)
              zero:
                   assign out = data[7:0];
              one:
                   assign out = data[15:8];
              two:
                   assign out = data[23:16];
              three:
                   assign out = data[31:24];
              default:
                   assign out = 8'b0;
          endcase
     end

always @(posedge clk or posedge reset)
     begin
          if (reset)
               state = zero;
          else
               case (state)
                    zero:
                         state = one;
                    one:
                         state = two;
                    two:
                         state = three;
                    three:
                         state = zero;
               endcase
     end

endmodule
