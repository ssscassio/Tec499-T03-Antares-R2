
`ifndef _id_ex
`define _id_ex
module id_ex(
      input clock, reset,
      input [1:0] WB,
      input [2:0] M,
      input [3:0] EX,
      input [4:0] rs,rt,rd,
      input [31:0] cpPlus4, data1, data2, immediate,
      output reg [1:0] WBregister,
      output reg [2:0] Mregister,
      output reg [3:0] EXregister,
      output reg [4:0] rsRegister, rtRegister, rdRegister,
      output reg [31:0] cpPlus4Register, data1Register, data2Register,immediateRegister
);

      always@(posedge clock) begin
        if(reset) begin
          WBregister = 0;
          Mregister = 0;
          EXregister = 0;
          rsRegister = 0;
          rtRegister = 0;
          rdRegister = 0;
          cpPlus4Register = 0;
          data1Register = 0;
          data2Register = 0;
          immediateRegister = 0;
        end
        else begin
          WBregister <= WB;
          Mregister <= M;
          EXregister <= EX;
          rsRegister <= rs;
          rtRegister <= rt;
          rdRegister <= rd;
          cpPlus4Register <= cpPlus4;
          data1Register <= data1;
          data2Register <= data2;
          immediateRegister <= immediate;
        end
      end
endmodule

`endif
