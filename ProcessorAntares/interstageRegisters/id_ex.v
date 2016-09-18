
`ifndef _id_ex
`define _id_ex
module id_ex(
      input clock, reset,
      input [3:0] aluOp,
      input regDst, aluSrc
      input [1:0] WB,
      input [2:0] M,
      input [4:0] rs,rt,rd,
      input [31:0] pcPlus4, data1, data2, immediate,
      output reg[3:0] aluOpRegister,
      output reg regDstRegister, aluSrcRegister,
      output reg [1:0] WBregister,
      output reg [2:0] Mregister,
      output reg [4:0] rsRegister, rtRegister, rdRegister,
      output reg [31:0] pcPlus4Register, data1Register, data2Register,immediateRegister
);

      always@(posedge clock) begin
        if(reset) begin
          WBregister = 0;
          Mregister = 0;
          rsRegister = 0;
          rtRegister = 0;
          rdRegister = 0;
          cpPlus4Register = 0;
          data1Register = 0;
          data2Register = 0;
          immediateRegister = 0;
          aluOpRegister = 0;
          regDstRegister = 0;
          aluSrcRegister = 0;
        end
        else begin
          WBregister <= WB;
          Mregister <= M;
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
