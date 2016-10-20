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
      input clock, regWrite, reset,
      input [31:0] writeData,
      input [4:0] readRegister1, readRegister2, writeRegister,
      output [31:0] readData1, readData2
);

      reg [31:0] memory [0:31];  // 32-bit memory with 32 entries

      reg [31:0] _data1, _data2;

      always @(*) begin
      		if (readRegister1 == 5'd0)
      			_data1 = 32'd0;//Always read 0 from $zero register
          else if ((readRegister1 == writeRegister) && regWrite)
          			_data1 = writeData;//Caso a leitura seja no registrador que esta escreendo no momento
      		else
      			_data1 = memory[readRegister1][31:0];
    	end

      always @(*) begin
          if (readRegister2 == 5'd0)
            _data2 = 32'd0;//Always read 0 from $zero register
          else if ((readRegister2 == writeRegister) && regWrite)
              _data2 = writeData;
          else
            _data2 = memory[readRegister2][31:0];
      end

      assign readData1 = _data1;
      assign readData2 = _data2;

      always @(posedge clock) begin //Write Data on Falling edge
      		if (regWrite && writeRegister != 5'd0) begin //Check if write sinal is on
      			memory[writeRegister] <= writeData;
      		end
          if(reset) begin
          		memory[0] <= 32'd0;
          		memory[1] <= 32'd0;
          		memory[2] <= 32'd0;
          		memory[3] <= 32'd0;
          		memory[4] <= 32'd0;
          		memory[5] <= 32'd0;
          		memory[6] <= 32'd0;
          		memory[7] <= 32'd0;
          		memory[8] <= 32'd0;
          		memory[9] <= 32'd0;
          		memory[10] <= 32'd0;
          		memory[11] <= 32'd0;
          		memory[12] <= 32'd0;
          		memory[13] <= 32'd0;
          		memory[14] <= 32'd0;
          		memory[15] <= 32'd0;
          		memory[16] <= 32'd0;
          		memory[17] <= 32'd0;
          		memory[18] <= 32'd0;
          		memory[19] <= 32'd0;
          		memory[20] <= 32'd0;
          		memory[21] <= 32'd0;
          		memory[22] <= 32'd0;
          		memory[23] <= 32'd0;
          		memory[24] <= 32'd0;
          		memory[25] <= 32'd0;
          		memory[26] <= 32'd0;
          		memory[27] <= 32'd0;
          		memory[28] <= 32'd0;
          		memory[29] <= 32'd0;
          		memory[30] <= 32'd0;
          		memory[31] <= 32'd0;
         end
      end

endmodule
`endif
