`timescale 1 ns / 100 ps
module SHA256_tb();
	reg clock;
	reg [31:0] hash0In, hash1In, hash2In, hash3In, hash4In, hash5In, hash6In, hash7In;
	wire [31:0] hash0Out, hash1Out, hash2Out, hash3Out, hash4Out, hash5Out, hash6Out, hash7Out;
	wire [63:0] length;
	reg [447:0] originalValue;
	reg [255:0] hashValReg;
	wire [255:0] hashedValue;

	// Module to test
	SHA256 algor(originalValue, length, hashedValue, clock,
				 hash0In, hash1In, hash2In, hash3In, hash4In, hash5In, hash6In, hash7In, 
			     hash0Out, hash1Out, hash2Out, hash3Out, hash4Out, hash5Out, hash6Out, hash7Out);

	wire [87:0] data;
	assign data [87:0] = 88'b0110100001100101011011000110110001101111001000000111011101101111011100100110110001100100;

	assign length = {56'b0, 8'b01011000};

	// Give inputs and runtime
	initial begin
		// Initialize inputs to 0
		clock = 0;

		originalValue = {data, 1'b1, 359'b0};
		hash0In = 32'b01101010000010011110011001100111;
		hash1In = 32'b10111011011001111010111010000101;
		hash2In = 32'b00111100011011101111001101110010;
		hash3In = 32'b10100101010011111111010100111010;
		hash4In = 32'b01010001000011100101001001111111;
		hash5In = 32'b10011011000001010110100010001100;
		hash6In = 32'b00011111100000111101100110101011;
		hash7In = 32'b01011011111000001100110100011001;

		// // time delay (ns)
		#1000

		// End testbench
		$finish;
	end

	// Input Manipulation
	// Toggle clock every 2s0 ns
	always begin
		#20 clock = ~clock;
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