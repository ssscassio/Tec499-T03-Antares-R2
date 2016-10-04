module transmitter(
    input [7:0] data,
    input clk,  start,
    output  reg TxD
);


reg [9:0]buffer;

always @( * )begin
	if(buffer == 0)
		TxD = 1'b1;	
	else
		TxD = buffer[9];
end


always @(posedge clk) begin
	if(start)
		buffer <= {1'b0, data, 1'b1};
	else
		buffer <= buffer << 1;
end

endmodule
