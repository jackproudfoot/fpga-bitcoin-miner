`timescale 1 ns / 100 ps
module SHA256_tb();
	reg clock;
	reg [87:0] originalValue;
	reg [255:0] hashValReg;
	wire [255:0] hashedValue;

	// Module to test
	SHA256 algor(originalValue, hashedValue, clock);

	// Give inputs and runtime
	initial begin
		// Initialize inputs to 0
		clock = 0;
		originalValue = 88'b0110100001100101011011000110110001101111001000000111011101101111011100100110110001100100;

		// // time delay (ns)
		#50

		// End testbench
		$finish;
	end

	// Input Manipulation
	// Toggle clock every 2s0 ns
	always begin
		#40 clock = ~clock;
		hashValReg <= hashedValue;
		$display("hash: %h", algor.hashedValue);
	end
	
	initial begin
	// Output filename
	$dumpfile("SHA256.vcd");
	// Module to capture and what level, 0 -> all wires
	$dumpvars(0, SHA256_tb);
	end
endmodule