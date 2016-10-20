//-----------------------------------------------------------------------------
// Universidade Estadual de Feira de Santana
// TEC499 - MI - Sistemas Digitais
// Antares-R2 2016.1
//
// Module: if_id.v
// Desc:   Structure to keep all interstage Registers between Instruction Fetch
//         and Instruction Decode steps
// Inputs:
// 	flush: Signal to reset the output registers when it is on High
//  clock: The clock signal to change the value of output registers or reset it
//  IFIDWrite: Signal that say if the registers will be write or not
//  pcPlus4: the Value of Pc+4 that must be save on register
//  instruction: the 32 bits of the instruction that must be save on register
// Outputs:
//  instructionRegister: the value of the instruction on a previous clock pulse
//  pcPlus4Register: the PC plus 4 value on a previous clock pulse
//-----------------------------------------------------------------------------

`ifndef _if_id
`define _if_id

module if_id(
      input flush, clock,IFIDWrite, reset,
      input [31:0] pcPlus4, instruction,
      output reg [31:0] instructionRegister,pcPlus4Register
);


      always@(posedge clock) begin
          if (flush || reset) begin
            instructionRegister <= 0;
            pcPlus4Register <=0;
          end
          else if(IFIDWrite) begin
            instructionRegister <= instruction;
            pcPlus4Register <= pcPlus4;
          end
        end

endmodule
`endif
