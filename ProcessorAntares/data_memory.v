//-----------------------------------------------------------------------------
// Universidade Estadual de Feira de Santana
// TEC499 - MI - Sistemas Digitais
// Antares-R2 2016.1
//
// Module: data_memory.v
// Desc:   Write or Read data from Memory
// Inputs:
//  clock: The clock Signal of the system
//  address: Address to write data on mmemory or read from
//  memWrite: Signal to write(high) or read(low) on Memory
//  writeData: Data that will be written
// Outputs:
// 	readData: Data values on memory being read
//-----------------------------------------------------------------------------

`ifndef _data_memory
`define _data_memory

module data_memory(
      input clk, memWrite,
      input [31:0] address,
      input [31:0] address2,
      output [31:0] readData,
      output [31:0] readData2,
      input [31:0] writeData
);
      //----------------------
      // Reg Declarations
      //----------------------
      reg [7:0] memory[0:65535];
      //----------------------
      always @ ( posedge clk ) begin
        if(memWrite)
        begin
          memory[address] = writeData[7:0];
          memory[address+1] = writeData[15:8];
          memory[address+2] = writeData[23:16];
          memory[address+3] = writeData[31:24];
        end
      end

      assign readData = memWrite ? writeData : {memory[address+3][7:0],memory[address+2][7:0],memory[address+1][7:0],memory[address][7:0]};

endmodule
`endif
