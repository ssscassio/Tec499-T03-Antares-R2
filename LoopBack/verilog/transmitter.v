module transmitter(
    input [7:0] data,
    input clk,  start,
    output busy, TxD
);


wire baudTick;
baud_generator BaudTick(.clk(clk),.enable(busy),.tick(baudTick));

reg [3:0] state;

assign busy = ~(state == 0);


always @(posedge baudTick)
case(state)
  4'b0000: if(start) state <= 4'b0100;
  4'b0100: if(baudTick) state <= 4'b1000; // start
  4'b1000: if(baudTick) state <= 4'b1001; // bit 0
  4'b1001: if(baudTick) state <= 4'b1010; // bit 1
  4'b1010: if(baudTick) state <= 4'b1011; // bit 2
  4'b1011: if(baudTick) state <= 4'b1100; // bit 3
  4'b1100: if(baudTick) state <= 4'b1101; // bit 4
  4'b1101: if(baudTick) state <= 4'b1110; // bit 5
  4'b1110: if(baudTick) state <= 4'b1111; // bit 6
  4'b1111: if(baudTick) state <= 4'b0001; // bit 7
  4'b0001: if(baudTick) state <= 4'b0010; // stop1
  4'b0010: if(baudTick) state <= 4'b0000; // stop2
  default: state <= 4'b0000;
endcase


reg muxbit;

always @(state[2:0])
case(state[2:0])
  0: muxbit <=  data[0];
  1: muxbit <=  data[1];
  2: muxbit <=  data[2];
  3: muxbit <=  data[3];
  4: muxbit <=  data[4];
  5: muxbit <=  data[5];
  6: muxbit <=  data[6];
  7: muxbit <=  data[7];
endcase

// combine start, data, and stop bits together
assign TxD = (state<4) | (state[3] & muxbit);

endmodule
