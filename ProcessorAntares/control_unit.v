//-----------------------------------------------------------------------------
// Universidade Estadual de Feira de Santana
// TEC499 - MI - Sistemas Digitais
// Antares-R2 2016.1
//
// Module: control_unit.v
// Desc: Receive an instruction opcode and distributes microcommands
// Inputs:
// 	opCode: Instruction OpCode
// Outputs:
// 	out: A microprogram to command datapath's structures
//-----------------------------------------------------------------------------
`ifndef _control_unit
`define _control_unit

module control_unit(
  input [5:0] opCode;
  output reg [1:0] aluOp,
  output reg regDst,memRead,memToReg,memWrite,aluSrc,regWrite,
  output reg beq,bne,
  output reg jump
  );

  always @ ( * ) begin
  //Default settings
    regDst <= 1'b1;
    beq <= 1'b0;
    bne <= 1'b0;
    memRead <= 1'b0;
    memToReg <= 1'b0;
    aluOp[1:0] <= 2'b10;
    memWrite <= 1'b0;
    aluSrc <= 1'b0;
    regWrite <= 1'b1;
    jump <= 1'b0;

    case (opCode)
    //JUMP
      6'b000010: begin
        jump <= 1'b1;
      end
    //ADDI
      6'b001000: begin
        regDst   <= 1'b0;
        aluOp[1] <= 1'b0;
        aluSrc   <= 1'b1;
      end
    //BEQ
      6'b000100: begin
        aluOp[0]  <= 1'b1;
        aluOp[1]  <= 1'b0;
        beq <= 1'b1;
        regWrite  <= 1'b0;
      end
    //BNE
      6'b000101: begin
        aluOp[0]  <= 1'b1;
        aluOp[1]  <= 1'b0;
        bne <= 1'b1;
        regWrite  <= 1'b0;
      end
    //LW
      6'b100011: begin
        memRead  <= 1'b1;
        regDst   <= 1'b0;
        memToReg <= 1'b1;
        aluOp[1] <= 1'b0;
        aluSrc   <= 1'b1;
      end
    //SW
      6'b101011: begin
        memwrite <= 1'b1;
        aluOp[1] <= 1'b0;
        aluSrc   <= 1'b1;
        regWrite <= 1'b0;
      end
    end
endmodule

`endif
