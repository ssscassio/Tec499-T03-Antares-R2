
`ifndef _mem_wb
`define _mem_wb

module mem_wb(
      input clock, reset,
      input memToReg, regWrite,
      input [4:0] rd,
      input [31:0] memOut,ALUOut,
      output reg memToRegRegister, regWriteRegister,
      output reg [31:0] memOutRegister,ALUOutRegister,
      output reg [4:0] rdRegister
);

     always@(posedge clock) begin
      if(reset) begin
        memToRegRegister = 0;
        regWriteRegister = 0;
        memOutRegister = 0;
        ALUOutRegister = 0;
        rdRegister = 0;
      end
      else begin
        memToRegRegister <= memToReg;
        regWriteRegister <= regWrite;
        memOutRegister <= memOut;
        ALUOutRegister <= ALUOut;
        rdRegister <= rd;
      end
     end

endmodule
`endif
