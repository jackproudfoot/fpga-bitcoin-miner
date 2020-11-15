`timescale 1 ns / 100 ps
module sevseg_tb();
    reg [31:0] data;
    reg clock;

    wire [7:0] ca, an;

	// Module to test
	seven_segment disp(ca, an, data, clock);

	// Give inputs and runtime
	initial begin
		// Initialize inputs to 0
		clk = 1;
		data = 32'h0;

		// time delay (ns)
		#5000

		// End testbench
		$finish;
	end

	// Input Manipulation
	// Toggle clock every 5 ns
	always begin
		#500 clk = ~clk;
		data <= data+1
	end

	initial begin
	// Output filename
	$dumpfile("sevseg.vcd");
	// Module to capture and what level, 0 -> all wires
	$dumpvars(0, sevseg_tb);
	end
endmodule