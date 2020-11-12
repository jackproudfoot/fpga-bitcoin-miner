`timescale 1 ns / 100 ps
module seven_segment_tb();
    reg clock = 0;
	
    reg [31:0] data = 32'h12344567;

    seven_segment display(data, clock);

	// Give inputs and runtime
	initial begin
        #100000000 

		// End testbench
		$finish;
	end

	// Input Manipulation
	always
		#5 clock = ~clock;  //100 Mhz clock

	initial begin
		// Output filename
		$dumpfile("seven_segment.vcd");
		// Module to capture and what level, 0 -> all wires
		$dumpvars(0, seven_segment_tb);
	end
endmodule