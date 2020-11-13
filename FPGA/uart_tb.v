`timescale 1 ns / 100 ps
module uart_tb();
	reg clock = 1, display_toggle = 0;
	
    reg reset, rxd;
    wire txd;

	wire [7:0] ca, an;

	reg [31:0] nonce = 32'h12345678;
	reg nonce_we, transmit_data = 0;

	// Module to test
	uart_core uart(clock, reset, txd, rxd, ca, an, nonce_we, transmit_data, display_toggle);

	// Give inputs and runtime
	initial begin
        #10
		nonce_we <= 1'b1;
		#10
		nonce_we <= 1'b0;

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