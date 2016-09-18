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
  output reg [1:0] aluOp, //Alu Control:  00:lw,sw   01:beq    10:arithmetic
  output reg regDst,memRead,memToReg,memWrite,aluSrc,regWrite,
  output reg beq,bne,
  output reg jump
  );

  always @ ( * ) begin
    case (opCode)
    //R-TYPE
    	`RTYPE: begin
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
    	end

    //LI  (addiu $4, $zero, C)
    	`LI: begin

    	end

    //J
    	`J: begin
        jump <= 1'b1;
    	end
    //JAL
    	`JAL: begin

    	end

    //SW
    	`SW: begin
        aluOp[1:0] <= 2'b00;
        memWrite <= 1'b1;
        aluOp[1] <= 1'b0;
        aluSrc   <= 1'b1;
        regWrite <= 1'b0;
    	end

    //LW
    	`LW: begin
      memRead  <= 1'b1;
      regDst   <= 1'b0;
      memToReg <= 1'b1;
      aluOp[1] <= 1'b0;
      aluSrc   <= 1'b1;
    	end

    //SLTI
    	`SLTI: begin

    	end

    //BEQ
    	´BEQ: begin
        aluOp[0]  <= 1'b1;
        aluOp[1]  <= 1'b0;
        beq <= 1'b1;
        regWrite  <= 1'b0;
    	end

    //BNE
    	´BNE: begin
        aluOp[0]  <= 1'b1;
        aluOp[1]  <= 1'b0;
        bne <= 1'b1;
        regWrite  <= 1'b0;
    	end

    //ADDI
    	`ADDI: begin
        regDst   <= 1'b0;
        aluOp[1] <= 1'b0;
        aluSrc   <= 1'b1;
    	end

    //SUBI
      `SUBI: begin

      end

    //JR    (Tipo R)
    	`JR: begin

    	end

    //MFHI
    	`MFHI: begin

    	end

    //MOVE  (add $1, $2, $zero)
    	`MOVE: begin

    	end
   endcase
 end
endmodule

`endif
