module receiver (
    input clk, RxD,
    output reg [7:0] data
);

always @(posedge clk) begin
		data <= {data[6:0],RxD};
end

endmodule
