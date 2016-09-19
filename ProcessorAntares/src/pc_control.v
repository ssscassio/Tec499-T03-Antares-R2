`ifndef _pc_control
`define _pc_control

module pc_control(
  input branch,
  input jumpReg, clk, stall,
  input [31:0] jumpAddress,branchAddress, PC,
  output reg [31:0] nextPC
);

    initial begin
      nextPC <= 32'd0;
    end

    always @(posedge clk) begin
      if (stall)
        nextPC <= PC;
      else if (branch == 2'b10 || branch == 2'b01)
        nextPC <= branchAddress;
      else if (jumpReg == 1'b1)
        nextPC <= jumpAddress;
      else
        nextPC <= PC + 32'h00000004;
    end

endmodule
`endif
