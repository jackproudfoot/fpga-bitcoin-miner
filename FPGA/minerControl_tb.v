`timescale 1 ns / 100 ps
module minerControl_tb();
	//NOT DONE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	reg clock = 1;
	reg [639:0] blockHeader;
	reg [31:0] nonce;
	wire [255:0] satisfactoryHash;
	wire ledControl;
	wire hashSuccess;

	// Module to test
	minerControl mine(blockHeader, satisfactoryHash, clock, ledControl, nonce, hashSuccess);

	// Give inputs and runtime
	initial begin
		nonce = 32'h42a14695;
		blockHeader = 640'h0100000081cd02ab7e569e8bcd9317e2fe99f2de44d49ab2b8851ba4a308000000000000e320b6c2fffc8d750423db8b1eb942ae710e951ed797f7affc8892b0f1fc122bc7f5d74df2b9441a42a14695;
		
		// // time delay (ns)
		#160

		// End testbench
		$finish;
	end

	// Input Manipulation
	// Toggle clock every 20 ns
	always 
		#20 clock = ~clock;
		// $display("shaReturn: %h\n", mine.shaReturn);
		// $display("difficulty: %b", mine.difficulty);
		// $display("difficulty: %d\n", mine.difficulty);
		// $display("hashToCheck: %b", mine.hashToCheck);
		// $display("hashToCheck: %d\n", mine.hashToCheck);
		// $display("\n");
		// $display("\n");
	

	initial begin
		// Output filename
		$dumpfile("minerControl.vcd");
		// Module to capture and what level, 0 -> all wires
		$dumpvars(0, minerControl_tb);
	end
endmodule