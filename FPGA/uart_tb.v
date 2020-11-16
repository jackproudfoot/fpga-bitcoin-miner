`timescale 1 ns / 100 ps
module uart_tb();
	reg clock = 0;
	reg [3:0] display_toggle =3'b0;
	
    reg reset = 0, rxd = 0;
    wire txd;

	wire [7:0] ca, an;

	wire hashLed;

	// Module to test
	uart_wrapper test_wrapper(clock, reset, rxd, txd, ca, an, display_toggle, hashLed);

	// Give inputs and runtime
	initial begin
		
		#10
		reset <= 1'b1;
		#10
		reset <= 1'b0;

		#100000

		// End testbench
		$finish;
	end

	// Input Manipulation
	always
		#1 clock = ~clock;

	initial begin
		// Output filename
		$dumpfile("uart_tb.vcd");
		// Module to capture and what level, 0 -> all wires
		$dumpvars(0, uart_tb);
	end
endmodule