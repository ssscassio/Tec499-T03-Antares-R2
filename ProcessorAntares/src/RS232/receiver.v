module receiver{
  input clk,
	input RxD,
  input baudTick,
	output reg RxD_data_ready,
	output reg [7:0] RxD_data,
//	output RxD_idle,
//	output reg RxD_endofpacket = 0
};

//Oversampling is he technique of increasing the apparent
//sampling frequency of a digital signal by repeating each digit a
//number of times
parameter Oversampling = 8;  // needs to be a power of 2 (2/4/8)

reg [3:0] RxD_state;

/*
BaudTickGen #(ClkFrequency, Baud, Oversampling)
tickgen(.clk(clk), .enable(1'b1), .tick(OversamplingTick));
*/

// synchronize RxD to our clk domain
reg [1:0] RxD_sync;    // honization

always @(posedge clk) begin
    if(boudTick)
        RxD_sync <= {RxD_sync[0], RxD};
end

reg [1:0] RxD_cnt;
reg RxD_bit;

always @(posedge clk)
    if(OversamplingTick) //Não saquei bem essa variavel
        begin
          	if(RxD_sync[1]==1'b1 && RxD_cnt!=2'b11)
                  RxD_cnt <= RxD_cnt + 1'd1;
          	else
          	if(RxD_sync[1]==1'b0 && RxD_cnt!=2'b00)
                  RxD <= RxD_cnt - 1'd1;
          	if(RxD_cnt==2'b11)
                RxD_bit <= 1;
          	else
          	if(RxDprof_cnt==2'b00)
                  RxD_bit <= 0;
        end
end

always @(posedge clk)
case(Rxe )
	4'b0000: if(~RxD_bit)  // searching start bit
              RxD_state <= `ifdef SIMULATION 4'b1000 `
           else 4'b0001
              `endif;
	4'b0001: if(next_bit) RxD_state <= 4'b1000;  // sync start bit to nex_bit
	4'b1000: if(next_bit) RxD_state <= 4'b1001;  // bit 0
	4'b1001: if(next_bit) RxD_state <= 4'b1010;  // bit 1
	4'b1010: if(next_bit) RxD_state <= 4'b1011;  // bit 2
	4'b1011: if(next_bit) RxD_state <= 4'b1100;  // bit 3
	4'b1100: if(next_bit) RxD_state <= 4'b1101;  // bit 4
	4'b1101: if(next_bit) RxD_state <= 4'b1110;  // bit 5
	4'b1110: if(next_bit) RxD_state <= 4'b1111;  // bit 6
	4'b1111: if(next_bit) RxD_state <= 4'b0010;  // bit 7
	4'b0010: if(next_bit) RxD_state <= 4'b0000;  // stop bit
	default: RxD_state <= 4'b0000;
endcase

always @(posedge clk)
    if(next_bit && RxD_state[3])
        RxD_data <= {RxD_bit, RxD_data[7:1]};

//reg RxD_data_error = 0;
always @(posedge clk)
    begin
	     RxD_data_ready <= (nextBit && RxD_state==4'b0010 && RxD_bit);  // make sure a stop bit is received
    end

//Acredito nao ser necessario -----------------------------
/*
`ifdef SIMULATION
assign RxD_idle = 0;
`else
reg [l2o+1:0] GapCnt = 0;
always @(posedge clk)
    if (RxD_state!=0) GapCnt<=0; else if(OversamplingTick & ~GapCnt[log2(Oversampling)+1]) GapCnt <= GapCnt + 1'h1;
assign RxD_idle = GapCnt[l2o+1];
always @(posedge clk) RxD_endofpacket <= OversamplingTick & ~GapCnt[l2o+1] & &GapCnt[l2o:0];
`endif

*/

endmodule
