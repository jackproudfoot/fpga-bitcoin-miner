`timescale 1 ns / 100 ps
module uart_tb();
	reg clock = 1;
	
    reg reset, rxd;
    wire txd;

    wire datasent, transmit;

	// Module to test
	uart_echo uart(clock, reset, txd, rxd, datasent, transmit);

	// Give inputs and runtime
	initial begin
        reset <= 1'b1;
		// time delay (ns)
		#40
        reset <= 1'b0;

        #10000000

		// End testbench
		$finish;
	end

	// Input Manipulation
	// Toggle clock every 4 ns
	always
		#5 clock = ~clock;

	initial begin
		// Output filename
		$dumpfile("uart_tb.vcd");
		// Module to capture and what level, 0 -> all wires
		$dumpvars(0, uart_tb);
	end
endmodule