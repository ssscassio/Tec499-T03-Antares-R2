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
//
// Credits: 2014, Segiusz 'q3k' Bazanski <sergiusz@bazanski.pl>
//-----------------------------------------------------------------------------
`include "Opcode.vh"
`ifndef _control_unit
`define _control_unit

module control_unit(
  input [5:0] opCode,
  input reset,
  output reg [1:0] branch,
  output reg jump,
  output reg regDst,memRead,memToReg,memWrite,aluSrc,regWrite
  );

  always @ ( * ) begin
    if(reset) begin
      branch <= 2'b00;
      jump <= 1'b0;
      regDst <= 1'b0;
      aluSrc <= 1'b0;
      memRead <= 1'b0;
      memWrite <= 1'b0;
      memToReg <= 1'b0;
      regWrite <= 1'b0;
    end
    else begin
    casex (opCode)
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
      6'b100???: begin //Load
        regDst <= 0;
        jump <= 0;
        aluSrc <= 1;
        memWrite <= 0;
        memRead <=1;
        memToReg <= 1;
        regWrite  <= 1;
        branch <= 0;
      end
      6'b101???: begin //Store
        regDst <=  0;
        jump <= 0;
        aluSrc <= 1;
        memWrite <= 1;
        memRead <= 0;
        memToReg <= 0;
        regWrite <= 0;
        branch <= 0;
      end
      `J: begin
        jump <=1;
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
      default: begin

      end

    endcase
    end
  end

endmodule
`endif
