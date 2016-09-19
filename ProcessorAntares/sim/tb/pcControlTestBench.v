module pcControlTestBench();

	reg clock, reset, stall, branch, jumpReg;
	reg	[31:0] 	branchAddress, jumpAddress, PC;
	wire[31:0] 	nextPC;
  reg [31:0]  REFout;

  task checkOutput;
      if ( REFout !== nextPC ) begin
          $display("FAIL: Saida esperada %8d, Saida encontrada %8d", REFout, nextPC);
          $finish();
      end
      else begin
          $display("PASS");
      end
  endtask

  pc_control pc(.clk(clock), .stall(stall), .branch(branch), .jumpReg(jumpReg),
                .jumpAddress(jumpAddress), .branchAddress(branchAddress), .PC(PC),
                .nextPC(nextPC));

	initial begin
		clock = 0;
		$display("Teste do PC");

    stall = 0;
    jumpReg = 0;
    branch = 0;
		PC = 32'b0;
    branchAddress = 32'd20;
    jumpAddress = 32'd40;

    //Primeiro teste PC+4
    #1;
		clock = 1;
		#1
    REFout = PC+ 32'd4;
    PC = PC +32'd4;
		checkOutput();

    //Segundo teste PC Stall
		clock = 0;
    stall =1;
		#1;
		clock = 1;
		#1
    checkOutput();


    //Terceiro Teste Branch
		clock = 0;
    stall = 0;
    REFout = branchAddress;
    branch = 1;
		#1;
		clock = 1;
		#1
    checkOutput();

    //Quart Teste Jump
		clock = 0;
    REFout = jumpAddress;
    branch = 0;
    jumpReg = 1;
		#1;
		clock = 1;
		#1
    checkOutput();

	end
endmodule
