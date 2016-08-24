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

endmodule
