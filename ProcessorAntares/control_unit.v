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
include "Opcode.vh"
`ifndef _control_unit
`define _control_unit

module control_unit(
  input [5:0] opCode,
  output [1:0] reg branch,
  output reg jump,
  output reg regDst,memRead,memToReg,memWrite,aluSrc,regWrite
  );

  always @ ( * ) begin
    case (opCode)
    	`RTYPE: begin
        branch <= 2'b00;
        jump <= 1'b0;
        regDst <= 1'b1;
        aluSrc <= 1'b0;
        memRead <= 1'b0;
        memWrite <= 1'b0;
        memToReg <= 1'b0;
        regWrite <= 1'b1;
    	end
      6'b001???: begin //Immediate Operations
        branch <= 2'b00;
        jump <= 0;
        regDst <= 1'b0;
        aluSrc <= 1'b1;
        memRead <= 0;
        memWrite <= 0;
        memToReg <= 0;
        regWrite <= 1;
      end
      `MUL: begin
        branch <= 2'b00;
        jump <= 1'b0;
        regDst <= 1'b1;
        aluSrc <= 1'b0;
        memRead <= 1'b0;
        memWrite <= 1'b0;
        memToReg <= 1'b0;
        regWrite <= 1'b1;
      end
      `BEQ: begin
        branch <= 2'b01;
        jump <= 0;
        regDst <= 1'b0;
        aluSrc <= 1'b1;
        memRead <= 0;
        memWrite <= 0;
        memToReg <= 0;
        regWrite <= 0;
      end
      `BNE: begin
        branch <= 2'b10;
        jump <= 0;
        regDst <= 1'b0;
        aluSrc <= 1'b1;
        memRead <= 0;
        memWrite <= 0;
        memToReg <= 0;
        regWrite <= 0;
      end
      `100???: begin //Load
        RegDst <= 0;
        aluSrc <= 1;
        memWrite <= 0;
        memRead <=1;
        memToReg <= 1;
        regWrite  <= 1;
        branch <= 0;
      end
      `101???: begin //Store
        co_RegDest = 0;
        co_ALUSource = 1;
        co_ALUControl = 0;
        co_MemWrite = 1;
        co_RegWSource = 0;
        co_RegWrite = 0;
        co_Branch = 0;
      `J: begin
        jump <=1'b1;
        branch <= 2'b00;
        jump <= 0;
        regDst <= 1'b0;
        aluSrc <= 1'b0;
        memRead <= 0;
        memWrite <= 0;
        memToReg <= 0;
        regWrite <= 0;
      end
      `JAL: begin

      end
      `DIV: begin

      end
      `MFHI: begin

      end

    endcase
  end

endmodule
`endif
