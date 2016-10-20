module cpu(input clock, reset, 
				output memWrite, memRead2,
				output [31:0] address, address2, writeData,
				input [31:0] readData, readData2
);

  //********************Instruction Fetch - Stage 1***************************//
  wire [31:0] pcPlus4, branchAddress, jump_address_2;
  wire jump_2, pcBranch, pcStop_1;
  pc_control pcControl( .branch(pcBranch), .jumpReg(jump_2),.clk(clock),.PC(pcPlus4),
                        .stall(pcStop_1), .reset(reset),
                        .jumpAddress(jump_address_2), .branchAddress(branchAddress),

                        .nextPC(pcPlus4));


  wire [31:0] instruction_1;
  wire [31:0] aluResult_4,writeData_4;
  wire memRead_4, memWrite_4;
  wire [31:0] outMemory_4;
  
  assign memWrite = memWrite_4;
  assign memRead2 = memRead_4;
  assign address = pcPlus4;
  assign address2 = aluResult_4;
  assign writeData = writeData_4;
  assign instruction_1 = readData;
  assign outMemory_4 =  readData2;
  

  wire [31:0] PCPlus4_2;
  wire ifIdFlush_1;
  wire ifIdWrite_1;
  wire[31:0] instruction_2;
  if_id IFID( .flush(ifIdFlush_1),.clock(clock),.IFIDWrite(ifIdWrite_1),.reset(reset),
              .pcPlus4(pcPlus4),.instruction(instruction_1),

              .instructionRegister(instruction_2), .pcPlus4Register(PCPlus4_2));
  //*****************End Instruction Fetch************************************//


  //***********************Instruction Decode - Stage 2***********************//
  wire[1:0] branch_2;
  wire regDst_2,aluSrc_2,memWrite_2,memRead_2,memToReg_2,regWrite_2;
  control_unit ControlUnit ( .opCode(instruction_2[31:26]),
                             .reset(reset),

                            .branch(branch_2),
                            .jump(jump_2),
                            .regDst(regDst_2), .aluSrc(aluSrc_2),
                            .memWrite(memWrite_2), .memRead(memRead_2),
                            .memToReg(memToReg_2), .regWrite(regWrite_2)
                           );

  wire [4:0] aluOp_2;
  alu_dec DecodeALU (.opcode(instruction_2[31:26]),.funct(instruction_2[5:0]),.ALUop(aluOp_2));


  wire [4:0] rd_5;
  wire [31:0] rsData_2,rtData_2;
  wire [31:0] writeDataRegister_5;
  wire regWrite_5;
  register_memory Registers ( .clock(clock), .regWrite(regWrite_5), .reset(reset),
                            .writeData(writeDataRegister_5),
                            .readRegister1(instruction_2[25:21]),.readRegister2(instruction_2[20:16]),
                            .writeRegister(rd_5),

                            .readData1(rsData_2),.readData2(rtData_2));


  //Branch Compare
  branch_compare BranchCompare( .A(rsData_2), .B(rtData_2),
                                .branch(branch_2),

                                .selPC(pcBranch));

  //Branch Address Calculate
  wire [31:0] immediate_extended;
  sign_extend ImmediateExtend(.immediate(instruction_2[16:0]),.out(immediate_extended));

  wire [31:0] immediate_shift2;
  shift_2 BranchShift2 (.in(immediate_extended),.out(immediate_shift2));

  behavioral_adder #(.Width(32)) BranchPlusPC(.A(PCPlus4_2), .B(immediate_shift2),
                                              .Result(branchAddress));
  //End Branch Calculate

  //Jump Address Calculate
  assign jump_address_2 ={PCPlus4_2[31:28],instruction_2[25:0],2'b00};
  //End Jump Address Calculate


  //End Destine register Selection

  wire [4:0] aluOp_3;
  wire [31:0] rsData_3, rtData_3, immediate_3, PCPlus4_3;
  wire [4:0] rs_3, rt_3, rd_3;
  wire idExFlush_2;
  wire regDst_3, aluSrc_3,memWrite_3,memRead_3,memToReg_3,regWrite_3;
  id_ex IDEX( .clock(clock),.reset(reset), .flush(idExFlush_2),
              .data1(rsData_2),.data2(rtData_2), .immediate(immediate_extended),
              .aluOp(aluOp_2), .regDst(regDst_2), .aluSrc(aluSrc_2),//EX
              .memWrite(memWrite_2), .memRead(memRead_2),//MEM
              .memToReg(memToReg_2), .regWrite(regWrite_2), //WB
              .pcPlus4(PCPlus4_2), .rs(instruction_2[25:21]), .rt(instruction_2[20:16]), .rd(instruction_2[15:11]),

              .data1Register(rsData_3),.data2Register(rtData_3),.immediateRegister(immediate_3),
              .aluOpRegister(aluOp_3), .regDstRegister(regDst_3),.aluSrcRegister(aluSrc_3),
              .memWriteRegister(memWrite_3),.memReadRegister(memRead_3),
              .memToRegRegister(memToReg_3), .regWriteRegister(regWrite_3),
              .pcPlus4Register(PCPlus4_3),.rsRegister(rs_3), .rtRegister(rt_3), .rdRegister(rd_3));

  //*******************End of Instruction Decode******************************//

  //************************Execute - Stage 3*********************************//

  //Hazard Unit

  hazard HazardUnit(.reset(reset), .clock(clock),
                    .opcode(instruction_2[31:26]), .branchResult(pcBranch),
                    .memReadEx(memRead_2),
                    .rtEx(rt_3), .rsId(instruction_2[25:21]), .rtId(instruction_2[20:16]),

                    .pcStop(pcStop_1), .idExFlush(idExFlush_2), .ifIdFlush(ifIdFlush_1), .ifIdWrite(ifIdWrite_1));


  //Destine register Selection
  wire [4:0] realrd;
  mux_2_5 MuxDestineRegister(.A(rd_3),.B(rt_3),.Sel(regDst_3),
                              .out(realrd));
  //Forwarding Unit
  wire [1:0] muxSel1, muxSel2;
  wire [31:0] aluInA_3,aluInB_3,B_3;
  wire [4:0] rd_4;
  wire regWrite_4;
  forwarding_unit FowardingUnit(  .rsEX(rs_3), .rtEX(rt_3), .rdMEM(rd_4), .rdWB(rd_5),
                                  .regWriteMEM(regWrite_4), .regWriteWB(regWrite_5),

                                  .dataSelectorEX1(muxSel1), .dataSelectorEX2(muxSel2));


  mux_4_32 MultiplexReadDataOutRS(.A(rsData_3),.B(aluResult_4),.C(writeDataRegister_5), .Sel(muxSel1),

                                .out(aluInA_3));

  mux_4_32 MultiplexReadDataOutRT(.A(rtData_3),.B(aluResult_4),.C(writeDataRegister_5), .Sel(muxSel2),

                                .out(B_3));

  //Selection Fowarding result or Immediate Value
  mux_2_32 MultiplexImmediateRS(.A(immediate_3), .B(B_3),.Sel(aluSrc_3),

                                .out(aluInB_3));

  wire [31:0] aluResult;
  alu ALU(.A(aluInA_3), .B(aluInB_3), .ALUop(aluOp_3),
          .Out(aluResult));

  wire memToReg_4;
  ex_mem EXMEN (.clock(clock), .reset(reset),
                .ALUout(aluResult), .writeDataIn(B_3), .rd(realrd),
                .memRead(memRead_3), .memWrite(memWrite_3), //MEM
                .memToReg(memToReg_3), .regWrite(regWrite_3), //WB

                .ALURegister(aluResult_4),.writeDataOut(writeData_4), .rdRegister(rd_4),
                .memReadRegister(memRead_4), .memWriteRegister(memWrite_4),
                .memToRegRegister(memToReg_4), .regWriteRegister(regWrite_4)
      );


  //*****************************End of Execute*******************************//

  //*****************************Memory Access - Stage 4**********************//

  /*
    Como nosso processador se trada de um processador com uma unica memória
    compartilhada tanto para instruções quanto para dados, este estágio
    apenas conecta as saidas dos registradores interestagios com as estruturas
    já declaradas previamente.

    aluResult_4 -> Address2(Memory)
    aluResult_4 -> B(MultiplexReadDataOutRS)
    aluResult_4 -> B(MultiplexReadDataOutRT)
    writeData_4 -> writeData(Memory)
    memRead_4   -> memRead2(Memory)
    memWrite_4  -> memWrite(Memory)
    rd_4 -> rdMEM (ForwardingUnit)
  */

  wire memToReg_5;
  wire [31:0] outMemory_5, aluResult_5;
  mem_wb MEMWB (  .clock(clock), .reset(reset),
                  .rd(rd_4),.memOut(outMemory_4),.ALUOut(aluResult_4),
                  .memToReg(memToReg_4), .regWrite(regWrite_4), //WB

                  .rdRegister(rd_5),.memOutRegister(outMemory_5),.ALUOutRegister(aluResult_5),
                  .memToRegRegister(memToReg_5), .regWriteRegister(regWrite_5));

  //*************************End of Memory Access*****************************//

  //***************************** Write Back - Stage 5 ***********************//

  mux_2_32 RegisterMemoryDataInMux (.A(outMemory_5),.B(aluResult_5),.Sel(memToReg_5),.out(writeDataRegister_5));


endmodule
