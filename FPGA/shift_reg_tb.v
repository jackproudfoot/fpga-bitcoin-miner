`timescale 1 ns / 100 ps
module shift_reg_tb();
    reg clock = 0, 
        reset = 0, 
        shift = 0,
        en = 0;
	
    reg [7:0] d;
    wire [7:0] q;

    shift_reg register(q, d, clock, en, shift, reset);

	// Give inputs and runtime
	initial begin
        d <= 8'ha7;
        en <= 1'b1;
        #5
        d <= 8'h82;
        en <= 1'b0;
        #15
        en <= 1'b1;
        #5
        en <= 1'b0;

        #5000

		// End testbench
		$finish;
	end

	// Input Manipulation
	// Toggle clock every 4 ns
	always
		#5 clock = ~clock;

	initial begin
		// Output filename
		$dumpfile("shift_reg_tb.vcd");
		// Module to capture and what level, 0 -> all wires
		$dumpvars(0, shift_reg_tb);
	end
endmodule