module cpu();

  reg clock;


  //********************Instruction Fetch - Stage 1***************************//
  wire [31:0] pcPlus4, branchAddress, jump_address_2;
  wire jump_2, pcBranch;
  pc_control pcControl( .branch(pcBranch), .jumpReg(jump_2),.clk(clock),.PC(pcPlus4),
                        .jumpAddress(jump_address_2), .branchAddress(branchAddress),

                        .nextPC(pcPlus4));


  wire [31:0] instruction_1;
  wire [32:0] aluResult_4,writeData_4;
  data_memory Memory(.clk(clock), .memWrite(), .address(pcPlus4),
 .address2(aluResult_4), .writeData(writeData_4),.readData(instruction_1),.readData2());

  wire [31:0] PCPlus4_2;
  if_id IFID( .flush(),.clock(clock),.IFIDWrite(),.reset(),
              .pcPlus4(pcPlus4),.instruction(instruction_1),

              .instructionRegister(), .pcPlus4Register(PCPlus4_2));
  //*****************End Instruction Fetch************************************//


  //***********************Instruction Decode - Stage 2***********************//
  wire[31:0] instruction_2;
  wire[1:0] branch_2;
  wire regDst_2,aluSrc_2;
  control_unit ControlUnit ( .opCode(instruction_2[31:26]),
                            //Esperar Khaick consertar o control_unit para colocar os sinais
                            .branch(branch_2),
                            .jump(jump_2),
                            .regDst(regDst_2),
                            .aluSrc(aluSrc_2)
                           );

  wire [3:0] aluOp_2;
  alu_dec DecodeALU (.opcode(instruction_2[31:26]),.funct(instruction_2[5:0]),.ALUop(aluOp_2));


  wire [4:0] rd_5;
  wire [31:0] rsData_2,rtData_2;
  register_memory Registers ( .clock(clock), .regWrite(),
                            .writeData(),
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
                                              .Result(branchAddress),.Cout());
  //End Branch Calculate

  //Jump Address Calculate
  assign jump_address_2 ={PCPlus4_2[31:28],instruction_2[25:0],2'b00};
  //End Jump Address Calculate


  //End Destine register Selection

  wire [3:0] aluOp_3;
  wire [31:0] rsData_3, rtData_3, immediate_3, PCPlus4_3;
  wire [4:0] rs_3, rt_3, rd_3;
  wire regDst_3, aluSrc_3;
  id_ex IDEX( .data1(rsData_2),.data2(rtData_2), .immediate(immediate_extended),
              .aluOp(aluOp_2), .regDst(regDst_2), .aluSrc(aluSrc_2),
              .pcPlus4(PCPlus4_2), .rs(instruction_2[25:21]), .rt(instruction_2[20:16]), .rd(instruction[15:11]),

              .data1Register(rsData_3),.data2Register(rtData_3),.immediateregister(immediate_3),
              .aluOpRegister(aluOp_3), .regDstRegister(regDst_3),.aluSrcRegister(aluSrc_3),
              .pcPlus4register(PCPlus4_3),.rsRegister(rs_3), .rtRegister(rt_3), .rdRegister(rd_3));

  //*******************End of Instruction Decode******************************//

  //************************Execute - Stage 3*********************************//

  //Destine register Selection
  wire [4:0] realrd;
  mux_2_5 MuxDestineRegister(.A(rd_3),.B(rt_3),.Sel(regDst_3),
                              .out(realrd));
  //Forwarding Unit
  wire [1:0] muxSel1, muxSel2;
  wire [31:0] aluInA_3,aluInB_3,B_3;
  wire [4:0] rd_4;
  forwarding_unit FowardingData(  .rsEx(rs_3), .rtEx(rt_3), .rdMEM(rd_4), .rdWB(),
                                  .regWriteMEM(), .regWriteWB(),
                                  .dataSelectorEx1(muxSel1), .dataSelectorEx2(muxSel2));


  mux_4_32 MultiplexReadDataOutRS(.A(rsData_3),.B(),.C(),.D(), .Sel(muxSel1),

                                .out(aluInA_3));

  mux_4_32 MultiplexReadDataOutRT(.A(rtData_3),.B(),.C(),.D(), .Sel(muxSel2),

                                .out(B_3));

  //Selection Fowarding result or Immediate Value
  mux_2_32 MultiplexImmediateRS(.A(immediate_3), .B(B_3),.Sel(aluSrc_3),

                                .out(aluInB_3));

  wire [32:0] aluResult;
  alu ALU(.A(aluInA_3), .B(aluInB_3), .ALUop(aluOp_3),
          .Out(aluResult),.Zero());


  ex_mem EXMEN (.clock(clock), .reset(reset),
                .ALUout(aluResult), .writeDataIn(B_3), .rd(realrd),

                .ALURegister(aluResult_4),.writeDataOut(writeData_4), .rdRegister(rd_4)
      );


  //*****************************End of Execute******************************//





  wire [31:0] writeDataRegister;
  wire [4:0] writeBackRegister;
  mux_2_32 RegisterMemoryDataInMux (.A(ALUOut_5),.B(MEMOut_5),.Sel(WB[0]),.out(writeDataRegister));




  wire [31:0] ALUOutEXMEN;
  wire [31:0] writeDataOut;

  wire [2:0] M;
  wire [31:0] readDataMem;


  wire [31:0] memRegister;
  wire [31:0] ALURegisterEXMEN;




  wire [2:0] WB;

  mem_wb MEMWB (.rdRegister(writeBackRegister),.WB(WB),.memOut(readDataMem), .ALUOut(aluResult),
          .ALURegister(ALURegister),.memRegister(memRegister));


endmodule
