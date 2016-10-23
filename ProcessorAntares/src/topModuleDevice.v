module topModuleDevice(
	input clock_50MHz,
	output UART_Tx,
	input [11:0] KEY
	);

	wire [31:0] monitorOut;
	wire sendFinish,clock,sendStart;
	wire memRead2_test, memWrite_test,memRead2_test2, memWrite_test2;
 	wire [31:0] readData_test, readData2_test,readData3_test, address_test, address2_test, writeData_test;
 	wire readOut_test, writeOut_test;

	PLL pll(
    .inclk0(clock_50MHz),
    .c0(clock));

	cpu cpu( .clock(clock_50MHz), .reset(KEY[11]),
        .readData(readData_test), .readData2(readData3_test),

        .memWrite(memWrite_test), .memRead2(memRead2_test), .writeData(writeData_test),
        .address(address_test), .address2(address2_test)
	 );

	device_manager monitor(
		.writeIn(memWrite_test),.readIn(memRead2_test),
		.finish(sendFinish), .memOutIn (readData2_test),
		.addressIn(address2_test), .dataIn (writeData_test),

		.data(monitorOut),.writeOut(memWrite_test2),.readOut(memRead2_test2),.start(sendStart),
		.memOutOut(readData3_test),);


	full_transmitter Transmitter(.data(monitorOut), .clk(clock),.start(sendStart),

		.finish(sendFinish), .TxD(UART_Tx));

	data_memory mem(.clk(clock_50MHz), .memWrite(memWrite_test2), .memRead2(memRead2_test2),
    .address(address_test), .address2(address2_test), .writeData(writeData_test),


    .readData(readData_test), .readData2(readData2_test));

endmodule
