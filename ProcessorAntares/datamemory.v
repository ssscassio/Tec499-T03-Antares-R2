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
// Reg Declarations
//----------------------
reg [31:0] read_data;
reg [31:0] memory[65535:0];
//----------------------
always @ ( posedge clk ) begin
  if(mem_write)
    memory[address] = writedata;
  end

assign read_data = mem_write ? write_data : memory[address][31:0];

endmodule
