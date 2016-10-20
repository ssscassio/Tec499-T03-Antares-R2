module full_transmitter(
    input [31:0] data,
    input clk,  start,
    output reg TxD,
    output reg finish
);

reg [39:0]buffer;

always @( * )begin
	if(buffer == 0) begin
		TxD = 1'b1;
		finish = 1'b1;
 	end else begin
		TxD = buffer[39];
		finish = 1'b0;
	end
end


always @(posedge clk) begin
	if(start)
		buffer <= {1'b0, data[31:24], 1'b1,1'b0, data[23:16], 1'b1,1'b0, data[15:8], 1'b1,1'b0, data[7:0], 1'b1};
	else
		buffer <= buffer << 1;
end

endmodule
