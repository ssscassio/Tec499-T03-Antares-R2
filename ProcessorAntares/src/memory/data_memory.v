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
      input clk, memWrite, memRead2,
      input [31:0] address, address2,
      output reg [31:0] readData, readData2,
      input [31:0] writeData
);

      wire clk4;

      PLL4 pll(
        .inclk0(clk),
        .c0(clk4));

      reg [15:0] addr1, addr2;
      reg [7:0] wr2;
      wire [7:0] out1, out2;
      reg memWrite2;

      memory_ram Memory(
          .clock(clk4),

          .address_a(addr1),
			 .wren_a(1'b0),
          .data_a(8'b0),
          .q_a(out1),

          .address_b(addr2),
          .wren_b(memWrite2),
          .data_b(wr2),
          .q_b(out2)
        );

      reg[1:0] state1 = 2'b00;
    	reg[1:0] state2 = 2'b00;

      reg [1:0] nextstate1, nextstate2;

      always @ ( posedge clk4 ) begin
        state1 <= nextstate1;
        state2 <= nextstate2;
      end

      always @ ( * ) begin
        case(state1)
          2'b00: begin
            addr1 = address[15:0];
            readData[7:0] = out1;
            nextstate1 = 2'b01;
          end
          2'b01: begin
            addr1 = address[15:0] + 2'b01;
            readData[31:24] = out1;
            nextstate1 = 2'b10;
          end
          2'b10: begin
            addr1 = address[15:0] + 2'b10;
            readData[23:16] = out1;
            nextstate1 = 2'b11;
          end
          2'b11: begin
            addr1 = address[15:0] + 2'b11;
            readData[15:8] = out1;
            nextstate1 = 2'b00;
          end
        endcase
      end

      always @ ( * ) begin
        case(state2)
          2'b00: begin
            addr2 = address2[15:0];
            if(memRead2) begin
              readData2[7:0] = out2;
            end
            wr2 = writeData[31:24];
            nextstate2 = 2'b01;
          end
          2'b01: begin
            addr2 = address2[15:0] + 2'b01;
            if(memRead2) begin
              readData2[31:24] = out2;
            end
            wr2 = writeData[23:16];
            nextstate2 = 2'b10;
          end
          2'b10: begin
            addr2 = address2[15:0] + 2'b10;
            if(memRead2) begin
              readData2[23:16] = out2;
            end
            wr2 = writeData[15:8];
            nextstate2 = 2'b11;
          end
          2'b11: begin
            addr2 = address[15:0] + 2'b11;
            if(memRead2) begin
              readData2[15:8] = out2;
            end
            wr2 = writeData[7:0];
            nextstate2 = 2'b00;
          end
        endcase
      end
endmodule
`endif
