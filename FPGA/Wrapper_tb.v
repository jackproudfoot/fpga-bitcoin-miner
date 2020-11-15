`timescale 1 ns / 100 ps
module Wrapper_tb();
	reg clk, reset;
	wire [7:0] ca, an;

	wire txd;
	reg rxd = 0;

	reg display_toggle = 1'b0;

	// Module to test
	Wrapper processor(clk, reset, ca, an, txd, rxd, display_toggle);

	// Give inputs and runtime
	initial begin
		// Initialize inputs to 0
		clk = 1;
		reset = 0;

		// time delay (ns)
		#100000

		// End testbench
		$finish;
	end

	// Input Manipulation
	// Toggle clock every 5 ns
	always
		#5 clk = ~clk;
	
	initial begin
	// Output filename
	$dumpfile("wrapper.vcd");
	// Module to capture and what level, 0 -> all wires
	$dumpvars(0, Wrapper_tb);
	end
endmodule