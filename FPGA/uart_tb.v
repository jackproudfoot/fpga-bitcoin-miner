`timescale 1 ns / 100 ps
module uart_tb();
	reg clock = 1;
	reg [3:0] display_toggle =3'b0;
	
    reg reset, rxd;
    wire txd;

	wire [7:0] ca, an;

	reg [31:0] nonce = 32'h12345678;

	// Module to test
	uart_wrapper test_wrapper(clock, reset, rxd, txd, ca, an, display_toggle);

	// Give inputs and runtime
	initial begin
		
		#10000

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