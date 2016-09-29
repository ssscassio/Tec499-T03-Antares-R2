module loopBackTopLevel(
    input UART_Rx,
    output UART_Tx,
    input clock_50MHz
  );

  wire [7:0] RxD_data;
  wire dataReady;

  receiver REC(
      .clk(clock_50MHz),
      .RxD(UART_Rx),

      .RxD_data_ready(dataReady),
      .RxD_data(RxD_data)
  );

  wire TxD_busy;

  transmitter transmissor(
      .clk(clock_50MHz),
      .TxD_start(dataReady),
      .TxD_Data(RxD_data),

      .TxD(UART_Tx),
      .TxD_busy(TxD_busy)
  );

endmodule
