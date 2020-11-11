`timescale 1 ns / 100 ps
module minerControl_tb();
	//NOT DONE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	reg clock = 1;
	reg [639:0] blockHeader;
	wire [255:0] satisfactoryHash;
	wire ledControl;

	// Module to test
	minerControl mine(blockHeader, satisfactoryHash, clock, ledControl);

	// Give inputs and runtime
	initial begin

		blockHeader = 640'h0100000081cd02ab7e569e8bcd9317e2fe99f2de44d49ab2b8851ba4a308000000000000e320b6c2fffc8d750423db8b1eb942ae710e951ed797f7affc8892b0f1fc122bc7f5d74df2b9441a42a14695;
		
		// // time delay (ns)
		#150

		// End testbench
		$finish;
	end

	// Input Manipulation
	// Toggle clock every 20 ns
	always
		#20 clock = ~clock;

	initial begin
		// Output filename
		$dumpfile("minerControl.vcd");
		// Module to capture and what level, 0 -> all wires
		$dumpvars(0, minerControl_tb);
	end
endmodule