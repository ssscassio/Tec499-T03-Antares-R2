
module pc_control(
  input [1:0] branch, //10 e 01 toma desvio
  input jumpReg, clk, stall,
  input [31:0] jumpAdress,branchAdress, PC,
  output reg [31:0] nextPC
);

    initial begin
      nextPC <= 32'd0;
    end

    always @(posedge clk) begin
      if (stall)
        nextPC <= PC;
      else if (branch == 2'b10 || branch == 2'b01)
        nextPC <= branchAdress;
      else if (jumpReg == 1'b1)
        nextPC <= jumpAdress;
      else
        nextPC <= PC + 32'h00000004;
    end

endmodule
