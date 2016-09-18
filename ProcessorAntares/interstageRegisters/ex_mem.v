`ifndef _ex_mem
`define _ex_mem

module ex_mem(
      input clock, reset,
      input memWrite, memRead,
      input memToReg, regWrite,
      input [4:0] rd,
      input [31:0] ALUout,writeDataIn,
      output reg memWriteRegister,memReadRegister,
      output reg memToRegRegister, regWriteRegister,
      output reg [31:0] ALURegister,writeDataOut,
      output reg [4:0] rdRegister
);

    always@(posedge clock) begin
      if(reset) begin
        memToRegRegister = 0;
        regWriteRegister = 0;
        memReadRegister=0;
        memWriteRegister=0;
        ALURegister=0;
        writeDataOut=0;
        rdRegister=0;
      end
      else begin
        memToRegRegister <= memToReg;
        regWriteRegister <= regWrite;
        memReadRegister <= memRead;
        memWriteRegister <= memWrite;
        ALURegister <= ALUout;
        rdRegister <= rd;
        writeDataOut <= writeDataIn;
      end
    end

endmodule

`endif
