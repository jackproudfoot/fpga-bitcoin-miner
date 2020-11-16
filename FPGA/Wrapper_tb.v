`timescale 1 ns / 100 ps
module Wrapper_tb();
	reg clk, reset, rxd, switch1, switch2, switch3, switch4, switch5, switch6, switch7, switch8, switch9, switch10, switch11, switch12, switch13, switch14, switch15, switch16;
	wire led, txd;
	wire [7:0] ca, an;

	// Module to test
	Wrapper processor(clk, reset, led, ca, an, rxd, txd, switch1, switch2, switch3, switch4, switch5, switch6,
                      switch7, switch8, switch9, switch10, switch11, switch12, switch13, switch14, switch15, switch16);

	// Give inputs and runtime
	initial begin
		// Initialize inputs to 0
		clk = 1;
		reset = 0;
		rxd = 0;
		switch1 = 0;
		switch2 = 0;
		switch3 = 0;
		switch4 = 0;
		switch5 = 0;
		switch6 = 0;
		switch7 = 0;
		switch8 = 0;
		switch9 = 0;
		switch10 = 0;
		switch11 = 0;
		switch12 = 0;
		switch13 = 0;
		switch14 = 0;
		switch15 = 0;
		switch16 = 0;


		// time delay (ns)
		#70000

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