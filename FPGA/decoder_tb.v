// Define 1 ns as the delay time unit and 100 ps of precision in the waveform
`timescale 1 ns / 100 ps
module decoder_tb;
	////// Module Instantiation //////
	// inputs to the module (reg)
	reg [4:0] select;
	// outputs of the module (wire)
	wire [31:0] register;
	// Instantiate the module to test
	decoder decode(.register(register), .select(select));
	////// Input Initialization //////
	// Initialize the inputs and specify the runtime
	initial begin
		// Initialize the inputs to 0
		select = 5'b0;
		// Set a time delay, in nanoseconds
		#3200;
		// Ends the testbench
		$finish;
	end
	////// Input Manipulation //////
	// Toggle input select[0] every 10 nanoseconds
	always
		#100 select[0] = ~select[0];
	// Toggle input select[1] every 20 nanoseconds
	always
		#200 select[1] = ~select[1];
	// Toggle input select[2] every 40 nanoseconds
	always
		#400 select[2] = ~select[2];
	// Toggle input select[3] every 80 nanoseconds
	always
		#800 select[3] = ~select[3];
	// Toggle input select[4] every 160 nanoseconds
	always
		#1600 select[4] = ~select[4];
	// Print the inputs and outputs whenever inputs change
	////// Output Results //////
	always @(select[0], select[1], select[2], select[3], select[4]) begin
		// Small Delay so outputs can stabilize
		#1;
		$display("select[0]:%b, select[1]:%b, select[2]:%b, select[3]:%b, select[4]:%b => register: %b \n", select[0], select[1], select[2], select[3], select[4], register);
	end

	// Define output waveform properties
	initial begin
		// Output file name
		$dumpfile("decoder_tb.vcd");
		// Module to capture and what level, 0 means all wires
		$dumpvars(0, decoder_tb);
	end
endmodule