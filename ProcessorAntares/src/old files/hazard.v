//-----------------------------------------------------------------------------
// UniversIdade Estadual de Feira de Santana
// TEC499 - MI - Sistemas Digitais
// Antares-R2 2016.1
//
// Module: hazard.v
// Desc: Solve bubble problems in pipeline datapath
// Inputs:
//  clk: System clock.
// 	rsId:
//  rtId:
//  rsEx:
//  rtEx:
//  memReadRegister:
//  mRegister:
// Outputs:
// 	stallId:
//  stallIF:
//  flushEx:
// ifIdWrite:
//-----------------------------------------------------------------------------
`include "Opcode.vh"

module hazard(
  input [5:0] opcode,
  input branchResult,
  input memReadEx,reset,clock,
  input [4:0] rtEx, rsId, rtId,
  output reg pcStop, idExFlush,ifIdFlush, ifIdWrite);

  always @ (rtEx, rsId, rtId,opcode, branchResult, memReadEx, reset) begin

    case(opcode)
      `BEQ:
      if(branchResult) begin
        ifIdFlush = 1;
        ifIdWrite =0;
      end
      `BNE:
      if(branchResult) begin
        ifIdFlush = 1;
        ifIdWrite = 0;
      end
      default: begin
        ifIdFlush = 0;
        ifIdWrite = 1;
      end

    endcase

    if(memReadEx && ((rsId == rtEx) || (rtId == rtEx))) begin
      pcStop = 1;
      idExFlush = 1;
      ifIdWrite = 0;
    end
    else begin
      pcStop = 0;
      idExFlush = 0;
      ifIdWrite = 1;
    end

  end
endmodule
