module receiver (input clk, RxD,
    output data_ready, output [7:0] data);


reg [1:0] RxD_sync = 2'b11;

wire baudTick;
baud_generator BaudTick(.clk(clk),.enable(1'b1),.tick(baudTick));

always @(posedge clk) if(baudTick) RxD_sync <= {RxD_sync[0], RxD};

reg [1:0] RxD_cnt;
reg RxD_bit;

always @(posedge clk)
if(baudTick)
begin
  if(RxD_sync[1] && RxD_cnt!=2'b11) RxD_cnt <= RxD_cnt + 1;
  else
  if(~RxD_sync[1] && RxD_cnt!=2'b00) RxD_cnt <= RxD_cnt - 1;

  if(RxD_cnt==2'b00) RxD_bit <= 0;
  else
  if(RxD_cnt==2'b11) RxD_bit <= 1;
end

reg [3:0] state;

always @(posedge clk)
if(baudTick)
case(state)
  4'b0000: if(~RxD_bit) state <= 4'b1000; // start bit found?
  4'b1000: if(next_bit) state <= 4'b1001; // bit 0
  4'b1001: if(next_bit) state <= 4'b1010; // bit 1
  4'b1010: if(next_bit) state <= 4'b1011; // bit 2
  4'b1011: if(next_bit) state <= 4'b1100; // bit 3
  4'b1100: if(next_bit) state <= 4'b1101; // bit 4
  4'b1101: if(next_bit) state <= 4'b1110; // bit 5
  4'b1110: if(next_bit) state <= 4'b1111; // bit 6
  4'b1111: if(next_bit) state <= 4'b0001; // bit 7
  4'b0001: if(next_bit) state <= 4'b0000; // stop bit
  default: state <= 4'b0000;
endcase

reg [2:0] bit_spacing;

always @(posedge clk)
if(state==0)
  bit_spacing <= 0;
else
if(baudTick)
  bit_spacing <= bit_spacing + 1;

wire next_bit = (bit_spacing==7);

reg [7:0] RxD_data;
always @(posedge clk) if(baudTick && next_bit && state[3]) RxD_data <= {RxD_bit, RxD_data[7:1]};

endmodule
