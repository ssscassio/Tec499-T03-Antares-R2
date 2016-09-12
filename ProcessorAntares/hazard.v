// module HazardUnit(IDRegRs,IDRegRt,EXRegRt,EXMemRead,stallIF,IFIDWrite,HazMuxCon);
//  input [4:0] IDRegRs,IDRegRt,EXRegRt;
//  input EXMemRead;
//  output stallIF, IFIDWrite, HazMuxCon;
//
//  reg PCWrite, IFIDWrite, HazMuxCon;
//
//  always@(IDRegRs,IDRegRt,EXRegRt,EXMemRead)
//     if(EXMemRead&((EXRegRt == IDRegRs)|(EXRegRt == IDRegRt)))
//       begin//stall
//       stallIF = 0;
//       IFIDWrite = 0;
//       HazMuxCon = 1;
//       end
//     else
//       begin//no stall
//       stallIF = 1;
//       IFIDWrite = 1;
//       HazMuxCon = 1;
//     end
// endmodule

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
    if(memReadEx $ ((rtEx == rsID)|(rtEx == rtID)) begin
        stallIF = ifIdWrite = 0;
    end
    else begin
      stallIF = ifIdWrite;
    end
endmodule
