module device_manager(
		input [31:0] memOutIn,
		input [31:0] addressIn, dataIn,
		input readIn, writeIn, finish,
		output reg readOut, writeOut,
		output reg start,
		output reg [31:0] data,
    output reg [31:0] memOutOut
	);

    reg statusReg;

	localparam deviceAddress = 32'b00000000000000001111111111111000;
  localparam statusAddress = 32'b00000000000000001111111111111100;

	always @ ( * ) begin

        if(finish == 1) begin
            statusReg =0;
        end
        if (addressIn == deviceAddress && statusReg == 0) begin
            data = dataIn;
            readOut = 0;
            writeOut = 0;
            start = 1;
            statusReg = 1;
        end
        else if(addressIn == statusAddress) begin
        	memOutOut = statusReg;
        	readOut = 0;
            writeOut = 0;
        	start = 0;
       	end else begin
			      memOutOut = memOutIn;
            readOut = readIn;
            writeOut = writeIn;
            start = 0;
        end

    end

endmodule
