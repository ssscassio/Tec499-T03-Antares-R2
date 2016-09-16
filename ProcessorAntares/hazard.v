//-----------------------------------------------------------------------------
// Universidade Estadual de Feira de Santana
// TEC499 - MI - Sistemas Digitais
// Antares-R2 2016.1
//
// Module: hazard.v
// Desc: Solve bubble problems in pipeline datapath
// Inputs:
//  clk: System clock.
// 	rsId:
//  rtId:
//  rsEX:
//  rtEx:
//  memReadRegister:
//  mRegister:
// Outputs:
// 	stallID:
//  stallIF:
//  flushEX:
// ifIdWrite:
//-----------------------------------------------------------------------------

module hazard(  //stallID,stallIF,rsID,rtID,rsEX,rtEX,flushEX,memReadEx,clk,hazMuxCont,mRegister
  input [4:0] rsID,rtID,rtEX,rsEX,
  input clk, mRegister, memReadEx,
  output stallID,stallIF,flushEX,ifIdWrite
  );

  always @ (rsID,rtID,rsEX,memReadEx) begin
    if(memReadEx & ((rtEx == rsID)|(rtEx == rtID))
        stallIF = 0;
        ifIdWrite = 0;
    end
    else begin
      stallIF = 1;
      ifIdWrite = 1;
    end
endmodule
