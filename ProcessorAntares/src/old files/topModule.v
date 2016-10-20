module topModule(input clock, output saida);


  wire clk4;

  wire memRead2_test, memWrite_test;
  wire [32:0] readData_test, readData2_test, address_test, address2_test, writeData_test;


  data_memory mem(.clk(clk4), .memWrite(memWrite_test), .memRead2(memRead2_test),
    .address(address_test), .address2(address2_test), .writeData(writeData_test),


    .readData(readData_test), .readData2(readData2_test));


	 
  cpu cpu( .clock(clock), .reset(Reset),
        .readData(readData_test), .readData2(readData2_test),

        .memWrite(memWrite_test), .memRead2(memRead2_test), .writeData(writeData_test),
        .address(address_test), .address2(address2_test)
  );

endmodule
