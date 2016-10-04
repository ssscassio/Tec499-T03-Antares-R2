module loopBackTopLevel(
    input UART_Rx,
    output UART_Tx,
    input clock_50MHz
  );

  wire clock;

  PLL pll(
    .inclk0(clock_50MHz),
    .c0(clock));

  reg dataReady;
  wire [7:0] RxD_data;


  receiver REC(
      .clk(clock),
      .RxD(UART_Rx),

      .data(RxD_data)
  );

  
  transmitter transmissor(
      .clk(clock),
      .start(dataReady),
      .data(RxD_data),

      .TxD(UART_Tx),
  );

  
  reg [3:0] read = 0;
  
  always@(posedge clock) begin
	if(read==0 && UART_Rx == 0) begin
		dataReady <= 1'b0;
		read = 4'b1;
	end
	else if(read <= 4'd10 && read !=0) begin
		read= read + 1'b1;
		dataReady <= 1'b0;
		if(read > 4'd8) begin
			dataReady<= 1'b1;
			read <= 0;
		end
	end 
	else
		dataReady <= 0;
  end
  
endmodule
