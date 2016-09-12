//-----------------------------------------------------------------------------
// Universidade Estadual de Feira de Santana
// TEC499 - MI - Sistemas Digitais
// Antares-R2 2016.1
//
// Module: branch_compare.v
// Desc:   Comparador para verificar o resultado de um branch ainda na etapa de
//         Instruction Decode
// Inputs:
// 	registerA: 32-bit value
// 	registerB: 32-bit value
//  branch: Signal to say that is a Beq(01) or Bne(11) Operation
//
// Outputs:
// 	SelPC : Selector to Multiplex of PC
//-----------------------------------------------------------------------------

`ifndef _branch_compare
`define _branch_compare

module branch_compare(
      input [31:0] A,B,
      input [1:0] branch,
      output reg selPC
);

      localparam EQ_BNE = 2'b11;
      localparam EQ_BEQ = 2'b01;

      always@ (*)
      begin
        case(branch)
          EQ_BNE: begin
            selPC = (A-B == 0)?1'b0:1'b1;
          end
          EQ_BEQ: begin
            selPC = (A-B == 0)?1'b1:1'b0;
          end
          default: begin
            selPC = 1'b0;
          end
        endcase
      end
endmodule

`endif
