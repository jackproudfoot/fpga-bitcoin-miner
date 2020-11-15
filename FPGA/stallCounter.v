module stallCounter(clock, reset, restart, outCount);
	input clock, reset, restart;
	output reg [0:6] outCount = 356;

	always @(posedge clock or posedge reset) begin
		if (reset) begin 
			outCount <= 35;
		end
		else if (restart) begin 
			outCount <= 0;
		end
		else begin
			if (outCount < 35) begin
				outCount <= outCount + 1;
			end
		end
	end

endmodule