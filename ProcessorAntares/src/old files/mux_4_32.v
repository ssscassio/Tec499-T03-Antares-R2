//-----------------------------------------------------------------------------
// Universidade Estadual de Feira de Santana
// TEC499 - MI - Sistemas Digitais
// Antares-R2 2016.1
//
// Module: mux_4_32.v
// Desc: Multiplex 4 signals of 32 bits into 1 signal of 32 bits
// Inputs:
// 	A: First 32 bits value beign multiplex (Selector = High)
//  B: Second 32 bits value beign multiplex (Selector = Low)
//  sel: Selector key
// Outputs:
// 	out: The Binary input selected
//-----------------------------------------------------------------------------

`ifndef _mux_4_32
`define _mux_4_32

module mux_4_32(
      input [31:0] A, B, C, D,
      input [1:0] Sel,
      output reg [31:0] out
    );

    always @ ( * ) begin
  		case (Sel)
  			0:
    		  out <= A;
  			1:
    			out <= B;
  			2:
  			  out <= C;
  			3:
  			  out <= D;
  		endcase
    end
endmodule

`endif
