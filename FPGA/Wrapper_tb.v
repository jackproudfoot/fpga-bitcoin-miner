`timescale 1 ns / 100 ps
module Wrapper_tb();
	reg clk, reset;
	wire led;

	// Module to test
	Wrapper processor(clk, reset, led);

	// Give inputs and runtime
	initial begin
		// Initialize inputs to 0
		clk = 0;
		reset = 0;

		// time delay (ns)
		#160

		// End testbench
		$finish;
	end

	// Input Manipulation
	// Toggle clock every 2s0 ns
	always
		#20 clk = ~clk;
	
	initial begin
	// Output filename
	$dumpfile("wrapper.vcd");
	// Module to capture and what level, 0 -> all wires
	$dumpvars(0, Wrapper_tb);
	end
endmodule