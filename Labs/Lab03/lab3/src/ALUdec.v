// Universidade Estadual de Feira de Santana
// TEC499 - MI - Sistemas Digitais
// Lab 3, 2016.1
//
// Module: ALUdecoder
// Desc:   Sets the ALU operation
// Inputs:
// 	opcode: the top 6 bits of the instruction
//    funct: the funct, in the case of r-type instructions
// Outputs:
// 	ALUop: Selects the ALU's operation

`include "Opcode.vh"
`include "ALUop.vh"

module ALUdec(
  input [5:0] funct, opcode,
  output reg [3:0] ALUop
);

    // Implement your ALU decoder here, then delete this comment
always @ (*)
begin
  case(opcode)
    `RTYPE:
      case(funct)
      `SLL: ALUop <= `ALU_SLL;
      `SRL: ALUop <= `ALU_SRL;
      `SRA: ALUop <= `ALU_SRA;
      `SLLV: ALUop <= `ALU_XXX;
      `SRLV: ALUop <= `ALU_XXX;
      `SRAV: ALUop <= `ALU_XXX;
      `ADDU: ALUop <= `ALU_ADDU;
      `SUBU: ALUop <= `ALU_SUBU;
      `AND: ALUop <= `ALU_AND;
      `OR: ALUop <= `ALU_OR;
      `XOR: ALUop <= `ALU_XOR;
      `NOR: ALUop <= `ALU_NOR;
      `SLT: ALUop <= `ALU_SLT;
      `SLTU: ALUop <= `ALU_SLTU;
      endcase
    // Load/store
    `LB: ALUop <= `ALU_XXX;
    `LB: ALUop <= `ALU_XXX;
    `LH: ALUop <= `ALU_XXX;
    `LW: ALUop <= `ALU_XXX;
    `LBU: ALUop <= `ALU_XXX;
    `LHU: ALUop <= `ALU_XXX;
    `SB: ALUop <= `ALU_XXX;
    `SH: ALUop <= `ALU_XXX;
    `SW: ALUop <= `ALU_XXX;
    // I-type
    `ADDIU: ALUop <= `ALU_XXX;
    `SLTI: ALUop <= `ALU_XXX;
    `SLTIU: ALUop <= `ALU_XXX;
    `ANDI: ALUop <= `ALU_XXX;
    `ORI: ALUop <= `ALU_XXX;
    `XORI: ALUop <= `ALU_XXX;
    `LUI: ALUop <= `ALU_LUI;
  endcase
end
endmodule
