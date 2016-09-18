
`ifndef _id_ex
`define _id_ex
module id_ex(
      input clock, reset,
      input flush,
      input [4:0] aluOp, //EX
      input regDst, aluSrc, //EX
      input memRead, memWrite,//MEM
      input memToReg, regWrite, // WB
      input [4:0] rs,rt,rd,
      input [31:0] pcPlus4, data1, data2, immediate,
      output reg[4:0] aluOpRegister,
      output reg regDstRegister, aluSrcRegister,
      output reg memToRegRegister, regWriteRegister,
      output reg memWriteRegister, memReadRegister,
      output reg [4:0] rsRegister, rtRegister, rdRegister,
      output reg [31:0] pcPlus4Register, data1Register, data2Register,immediateRegister
);

      always@(posedge clock) begin
        if(reset || flush) begin
          memToRegRegister = 0;
          regWriteRegister = 0;
          memReadRegister = 0;
          memWriteRegister = 0;
          rsRegister = 0;
          rtRegister = 0;
          rdRegister = 0;
          pcPlus4Register = 0;
          data1Register = 0;
          data2Register = 0;
          immediateRegister = 0;
          aluOpRegister = 0;
          regDstRegister = 0;
          aluSrcRegister = 0;
        end
        else begin
          memToRegRegister <= memToReg; //WB
          regWriteRegister <= regWrite; //WB
          memReadRegister <= memRead; //MEM
          memWriteRegister <= memWrite; //MEM
          rsRegister <= rs; //Rs Register
          rtRegister <= rt; //Rt Register
          rdRegister <= rd; //Supose Rd Register
          pcPlus4Register <= pcPlus4; //PC instruction
          data1Register <= data1; //Data on Rs
          data2Register <= data2; //Data on Rt
          immediateRegister <= immediate; //Immmediate Value 32 bits
          aluOpRegister <= aluOp; //EX
          regDstRegister <= regDst; //EX
          aluSrcRegister <= aluSrc; //EX
        end
      end
endmodule

`endif
