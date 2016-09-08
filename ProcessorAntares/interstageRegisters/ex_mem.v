`ifndef _ex_mem
`define _ex_mem

module ex_mem(
      input clock,
      input [1:0] WB,
      input [2:0] M,
      input [4:0] rd,
      input [31:0] ALUout,writeDataIn,
      output reg [1:0] WBRegister,
      output reg [2:0] MRegister,
      output reg [31:0] ALURegister,writeDataOut,
      output reg [4:0] rdRegister
);

    initial begin
      WBRegister=0;
      MRegister=0;
      ALURegister=0;
      writeDataOut=0;
      rdRegister=0;
    end


    always@(posedge clock) begin
      WBRegister <= WB;
      MRegister <= M;
      ALURegister <= ALUout;
      rdRegister <= rd;
      writeDataOut <= writeDataIn;
    end
endmodule

`endif
