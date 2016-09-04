//-----------------------------------------------------------------------------
// Universidade Estadual de Feira de Santana
// TEC499 - MI - Sistemas Digitais
// Antares-R2 2016.1
//
// Module: register_memory.v
// Desc:   Write or Read from Registers on Memory
// Inputs:
//  clock: The clock Signal of the system
//  regWrite: Signal to write(high) or read(low) on Register Bank
//  writeData: Data that will be write on a Register
//  readRegister1,readRegister2: Specify which of registers will be read
// 	writeRegister:  Specify in which register the data specified on
//       writeData will be write
// Outputs:
// 	readData1,readData2: Data values on registers being read
//-----------------------------------------------------------------------------

`ifndef _register_memory
`define _register_memory

module register_memory(
      input clock, regWrite,
      input [31:0] writeData,
      input [4:0] readRegister1, readRegister2, writeRegister
      output [31:0] readData1, readData2
);

      reg [31:0] memory [0:31];  // 32-bit memory with 32 entries

      reg [31:0] _data1, _data2;

      always @(*) begin
      		if (readRegister1 == 5'd0)
      			_data1 = 32'd0;//Always read 0 from $zero register
      		else
      			_data1 = memory[readRegister1][31:0];
    	end

      always @(*) begin
          if (readRegister2 == 5'd0)
            _data2 = 32'd0;//Always read 0 from $zero register
          else
            _data2 = memory[readRegister2][31:0];
      end

      assign readData1 = _data1;
      assign readData2 = _data2;

      always @(posedge clock) begin //Write Data on Falling edge
      		if (regWrite && writeRegister != 5'd0) begin //Check if write sinal is on
      			memory[writeRegister] <= wrdata;
      		end
      end

endmodule
`endif
