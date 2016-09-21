module controlUnitTestBench();


   reg [5:0] opCode;
   reg reset;
   wire [1:0] branch;
   wire jump, regDst, memRead, memToReg, memWrite, aluSrc, regWrite;
   reg [1:0] REFbranch;
   reg REFjump, REFregDst, REFmemRead, REFmemToReg, REFmemWrite, REFaluSrc, REFregWrite;


  task checkOutput;
      if ( branch != REFbranch || jump !=REFjump || REFregDst != regDst || REFmemRead != memRead || REFmemToReg != memToReg ||
           REFmemWrite != memWrite || REFaluSrc != aluSrc || REFregWrite != regWrite ) begin
          $display("**************FAIL***************");
          $display("***********OPCODE:%6b************", opCode);
          $display("Branch: Esperado: %2b, Encontrado: %2b", REFbranch, branch);
          $display("Jump: Esperado: %1b, Encontrado: %1b", REFjump, jump);
          $display("regDst: Esperado: %1b, Encontrado: %1b", REFregDst, regDst);
          $display("memRead: Esperado: %1b, Encontrado: %1b", REFmemRead, memRead);
          $display("memToReg: Esperado: %1b, Encontrado: %1b", REFmemToReg, memToReg);
          $display("memWrite: Esperado: %1b, Encontrado: %1b", REFmemWrite, memWrite);
          $display("aluSrc: Esperado: %1b, Encontrado: %1b", REFaluSrc, aluSrc);
          $display("regWrite: Esperado: %1b, Encontrado: %1b", REFregWrite, regWrite);
      end
      else begin
        $display("**************PASS***************");
		    $display("***********OPCODE:%6b************", opCode);
          $display("Branch: Esperado: %2b, Encontrado: %2b", REFbranch, branch);
          $display("Jump: Esperado: %1b, Encontrado: %1b", REFjump, jump);
          $display("regDst: Esperado: %1b, Encontrado: %1b", REFregDst, regDst);
          $display("memRead: Esperado: %1b, Encontrado: %1b", REFmemRead, memRead);
          $display("memToReg: Esperado: %1b, Encontrado: %1b", REFmemToReg, memToReg);
          $display("memWrite: Esperado: %1b, Encontrado: %1b", REFmemWrite, memWrite);
          $display("aluSrc: Esperado: %1b, Encontrado: %1b", REFaluSrc, aluSrc);
          $display("regWrite: Esperado: %1b, Encontrado: %1b", REFregWrite, regWrite);
      end
  endtask

control_unit controlUnit(.opCode(opCode), .reset(reset),
                    .branch(branch),.jump(jump),
                    .regDst(regDst), .memRead(memRead),
                    .memToReg(memToReg),.memWrite(memWrite),
                    .aluSrc(aluSrc),.regWrite(regWrite));

	initial begin

        //Rtype
        REFbranch = 2'b00;
        REFjump = 1'b0;
        REFregDst = 1'b1;
        REFaluSrc = 1'b0;
        REFmemRead = 1'b0;
        REFmemWrite = 1'b0;
        REFmemToReg = 1'b0;
        REFregWrite = 1'b1;
        opCode = 6'b000000;
			#1;
			checkOutput();
    
        REFbranch = 2'b00;
        REFjump = 1'b0;
        REFregDst = 1'b0;
        REFaluSrc = 1'b1;
        REFmemRead = 1'b0;
        REFmemWrite = 1'b0;
        REFmemToReg = 1'b0;
        REFregWrite = 1'b1;

        opCode = 6'b001001;
        #1;
		  checkOutput();

        opCode = 6'b001000;
		  #1;
        checkOutput();
    
        opCode = 6'b001010;
		  #1;
        checkOutput();
    

        opCode = 6'b001011;
		  #1;
        checkOutput();
    

        opCode = 6'b001101;
		  #1;
        checkOutput();
   

        opCode = 6'b001110;
		  #1;
        checkOutput();

        opCode = 6'b001111;
		  #1;
        checkOutput();

        opCode = 6'b000100;
        REFbranch = 2'b01;
        REFjump = 1'b0;
        REFregDst = 1'b0;
        REFaluSrc = 1'b1;
        REFmemRead = 1'b0;
        REFmemWrite = 1'b0;
        REFmemToReg = 1'b0;
        REFregWrite = 1'b0;
		  #1;
        checkOutput();

        opCode = 6'b000101;
        REFbranch = 2'b10;
        REFjump = 1'b0;
        REFregDst = 1'b0;
        REFaluSrc = 1'b1;
        REFmemRead = 1'b0;
        REFmemWrite = 1'b0;
        REFmemToReg = 1'b0;
        REFregWrite = 1'b0;
		  #1;
        checkOutput();


        opCode = 6'b100000;
        REFregDst = 0;
        REFjump = 1'b0;
        REFaluSrc = 1;
        REFmemWrite = 0;
        REFmemRead =1;
        REFmemToReg = 1;
        REFregWrite  = 1;
        REFbranch = 0;
		  #1;
        checkOutput();


		  opCode = 6'b101011;
        REFregDst =  0;
        REFjump = 0;
        REFaluSrc = 1;
        REFmemWrite = 1;
        REFmemRead = 0;
        REFmemToReg = 0;
        REFregWrite = 0;
        REFbranch = 0;
		  #1;
        checkOutput();


		  
        opCode = 6'b000010;//Jump
        REFjump =1;
        REFbranch = 2'b00;
        REFjump = 0;
        REFregDst = 1'b0;
        REFaluSrc = 1'b0;
        REFmemRead = 0;
        REFmemWrite = 0;
        REFmemToReg = 0;
        REFregWrite = 0;
		  #1;
        checkOutput();


    end


endmodule
