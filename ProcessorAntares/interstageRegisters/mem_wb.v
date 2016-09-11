
`ifndef _mem_wb
`define _mem_wb

module mem_wb(
      input clock, reset,
      input [1:0] WB,
      input [4:0] rd,
      input [31:0] memOut,ALUOut,
      output reg [1:0] WBRegister,
      output reg [31:0] memRegister,ALURegister,
      output reg [4:0] rdRegister
);

     always@(posedge clock) begin
      if(reset) begin
        WBRegister = 0;
        memRegister = 0;
        ALURegister = 0;
        rdRegister = 0;
      end
      else begin
        WBRegister <= WB;
        memRegister <= memOut;
        ALURegister <= ALUOut;
        rdRegister <= rd;
      end
     end

endmodule
`endif
