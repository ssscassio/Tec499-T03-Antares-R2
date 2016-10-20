module topModuleDevice(
	input clock_50MHz,
	output UART_Tx
);

	wire [31:0] monitorOut;
	wire memRead2_test, memWrite_test,memRead2_test2, memWrite_test2;
 	wire [32:0] readData_test, readData2_test, address_test, address2_test, writeData_test;

	cpu cpu( .clock(clock_50MHz), .reset(Reset),
        .readData(readData_test), .readData2(readData2_test),

        .memWrite(memWrite_test), .memRead2(memRead2_test), .writeData(writeData_test),
        .address(address_test), .address2(address2_test)
	 );

	device_manager monitor(
		.writeIn(memWrite_test),.writeOut(memWrite_test2),.readIn(memRead2_test),.readOut(memRead2_test2),

		.dataDeviceOut(monitorOut));

	full_transmitter Transmitter(.data(monitorOut));

	data_memory mem(.clk(clock_50MHz), .memWrite(memWrite_test2), .memRead2(memRead2_test2),
    .address(address_test), .address2(address2_test), .writeData(writeData_test),


    .readData(readData_test), .readData2(readData2_test));
endmodule