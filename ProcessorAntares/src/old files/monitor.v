`ifndef _monitor
`define _monitor

module monitor(
  input memWriteIn, readDataIn, dataDeviceFinish,
  input [31:0] dataIn,
  input [31:0] addressIn,
  output reg [31:0] dataOut,
  output reg [31:0] addressOut, dataDeviceOut,
  output reg memWriteOut, readDataOut
);


    localparam deviceAddress = 32'b1;
    localparam statusAddress = 32'b00000000000000001111111111111100;

    always @ ( * ) begin

        if (addressIn == deviceAddress) begin
            memWriteOut <= 0;
            dataDeviceOut <= dataIn;
            addressOut <= statusAddress;
            dataOut <= 32'b1;
            readDataOut <= 0;
        end
        else begin
            addressOut <= addressIn;
            dataOut <= dataIn;
            memWriteOut <= memWriteIn;
            readDataOut <= readDataIn;
        end
    end

    always @(dataDeviceFinish) begin
        if(dataDeviceFinish) begin
            dataOut <= 32'b0;
            memWriteOut <= 1;
            addressOut <= statusAddress;
        end
    end

endmodule
`endif
