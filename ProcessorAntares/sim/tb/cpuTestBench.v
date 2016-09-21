`timescale 1ns / 1ps

module cpuTestBench();

  reg Clock, Clock4 ,Reset;

  parameter Halfcycle = 40;
  parameter Halfcycle4 = Halfcycle/10;

  localparam  Cycle = 2*Halfcycle;
  localparam  Cycle4 = 2*Halfcycle4;

  initial Clock = 0;
  initial Clock4 = 0;

  always #(Halfcycle) Clock = ~Clock;
  always #(Halfcycle4) Clock4 = ~Clock4;
  wire [31:0] memOutputCPU;
  

  wire memRead2_test, memWrite_test;
  wire [31:0] readData_test, readData2_test, address_test, address2_test, writeData_test;
  
  
  data_memory mem(.clk(Clock), .memWrite(memWrite_test), .memRead2(memRead2_test),
		.address(address_test), .address2(address2_test), .writeData(writeData_test),
		
		
		.readData(readData_test), .readData2(readData2_test));
		
		
  cpu cpu( .clock(Clock), .reset(Reset),
			  .readData(readData_test), .readData2(readData2_test),
			  
			  .memWrite(memWrite_test), .memRead2(memRead2_test), .writeData(writeData_test),
			  .address(address_test), .address2(address2_test)
  );
 

 
  assign mem.clk4 = Clock4; //Conectando a fio interno da memória

  wire pc;

  assign PC = cpu.pcPlus4;

  localparam loops = 20; // number of instructions on test (inputLines/4)+Stalls
  integer i;
  
  initial begin

    $readmemb("pow.input", mem.Memory.ram);

    Reset = 1;
    #Cycle;
    Reset = 0;
    for(i = 0; i < loops; i = i + 1) begin
		
      $display("***********************INSTRUCTION FETCH************************");
      $display("Next PC: %b",cpu.pcPlus4);
      $display("Instruction Fetched: %b", cpu.instruction_1);
      $display("****************************************************************");

      $display("**********************INSTRUCTION DECODE************************");
      $display("Will flush?: %b", cpu.idExFlush_2);
      $display("RS Data: %b", cpu.rsData_2);
      $display("RT Data: %b", cpu.rtData_2);
      $display("Immediate: %b", cpu.immediate_extended);
      $display("Is Jump? %b",cpu.jump_2);
      $display("Jump Address: %b",cpu.jump_address_2);
      $display("Is Branch?(01-Beq,10-Bne,00-NoBranch) %b", cpu.branch_2);
      $display("Branch compare Result: %b", cpu.pcBranch);
      $display("Branch Address: %b",cpu.branchAddress);
      $display("aluOp(EX control): %b", cpu.aluOp_2);
      $display("regDst(EX control): %b", cpu.regDst_2);
      $display("aluSrc(EX control): %b", cpu.aluSrc_2);
      $display("memWrite(MEM control): %b", cpu.memWrite_2);
      $display("memRead(MEM control): %b", cpu.memRead_2);
      $display("memToReg(WB control): %b", cpu.memToReg_2);
      $display("regWrite(WB control): %b", cpu.regWrite_2);
      $display("PC of Instruction in this stage: %b", cpu.PCPlus4_2);
      $display("RS Register: %b", cpu.instruction_2[25:21]);
      $display("RT Register: %b", cpu.instruction_2[20:16]);
      $display("RD Register: %b", cpu.instruction_2[15:11]);
      $display("****************************************************************");

      $display("****************************EXECUTE*****************************");
      $display("ALU In A: %b", cpu.aluInA_3);
      $display("ALU In B: %b", cpu.aluInB_3);
      $display("ALU Operation: %b", cpu.aluOp_3);
      $display("Alu Result: %b", cpu.aluResult);
      $display("regDst: %b, RT(0): %b, RD(1): %b, Real RD: %b",cpu.regDst_3, cpu.rt_3, cpu.rd_3, cpu.realrd);
      $display("aluSrc: %b, B Data(0): %b, Immediate(1): %b, ALU In B: %b",cpu.aluSrc_3, cpu.B_3, cpu.immediate_3, cpu.aluInB_3);
      $display("memWrite(MEM control): %b", cpu.memWrite_3);
      $display("memRead(MEM control): %b", cpu.memRead_3);
      $display("memToReg(WB control): %b", cpu.memToReg_3);
      $display("regWrite(WB control): %b", cpu.regWrite_3);
      $display("****************************************************************");

      $display("**********************MEMEMORY ACCESS***************************");
      $display("Address to Write/Read: %b", cpu.aluResult_4);
      $display("Memomory Read?: %b", cpu.memRead_4);
      $display("Data Read: %b", cpu.outMemory_4);
      $display("Memomory Write?: %b", cpu.memWrite_4);
      $display("Data to Write: %b", cpu.writeData_4);
      $display("memToReg(WB control): %b", cpu.memToReg_4);
      $display("regWrite(WB control): %b", cpu.regWrite_4);
      $display("Alu Result: %b", cpu.aluResult_4);
      $display("****************************************************************");

      $display("************************WRITE BACK******************************");
      $display("Register Bank Write?: %b", cpu.regWrite_5);
      $display("Destine Register: %b", cpu.rd_5);
      $display("memToReg_5: %b, Alu Result(0): %b, Memomory Out(1): %b, Write Data: %b",cpu.memToReg_5, cpu.aluResult_5, cpu.outMemory_5, cpu.writeDataRegister_5);
      $display("****************************************************************");

      $display("================================================================");
      $display("=========================CLOCK  %d===============================",i);
      $display("================================================================");

      #Cycle;
    end

  end

endmodule
