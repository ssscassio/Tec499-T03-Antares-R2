//-----------------------------------------------------------------------------
// Universidade Estadual de Feira de Santana
// TEC499 - MI - Sistemas Digitais
// Antares-R2 2016.1
//
// Module: datamemory.v
// Desc:   Write or Read data from Memory
// Inputs:
//  clock: The clock Signal of the system
//  address: Address to write data on mmemory or read from
//  mem_write: Signal to write(high) or read(low) on Memory
//  writeData: Data that will be written
//  mem_read: Control signal (not used but present in datapath mips)
// Outputs:
// 	read_data: Data values on memory being read
//-----------------------------------------------------------------------------
 
module DataMemory(
  clk,
  address,
  read_data,
  write_data,
  mem_read, //Not used
  mem_write
  )

// Input Declarations
//----------------------
input [3:0] mem_write;
input [31:0] write_data;
input [31:0] address;
//----------------------
// Output Declarations
//----------------------
output [31:0] read_data;
//----------------------
// Reg Declarations
//----------------------
reg [31:0] memory[65535:0];
//----------------------
always @ ( posedge clk ) begin
  if(mem_write)
    memory[address] = writedata;
  end
end

assign read_data = mem_write ? write_data : memory[address][31:0];

endmodule
