//-----------------------------------------------------------------------------
// Universidade Estadual de Feira de Santana
// TEC499 - MI - Sistemas Digitais
// Antares-R2 2016.1
//
// Module: memory_monitor.v
// Desc:
// Inputs:
// clk: Clock
// address:
//
// Outputs:
// status:
//-----------------------------------------------------------------------------

`ifndef _memory_monitor
`define _memory_monitor

module memory_monitor(
  input clk, reset,
  output reg status,
  output reg [31:0] outAddress,
  input [31:0] inAddress
  );

  reg [31:0] deviceDataAddress = 32'11111111111111111000000000000100;
  reg [31:0] statusAddress = 32'b11111111111111111000000000000000;
  reg state;

  parameter zero=0, one=1;

  always @ ( state ) begin
    case (state)
      zero:
        assign outAddress = inAddress;
      one: begin
        assign outAddress = statusAddress;
        assign status = 1;
      end
    default:
        assign outAddress = inAddress;
    endcase
  end

  always @ ( posedge clk or posedge reset) begin
        if (reset)
          state = zero;
        else begin
          case (state)
              zero: begin
                if(inAddress == deviceDataAddress)
                   state = one;
              end
              one:
                state = zero;
          endcase
  end

endmodule

`endif
