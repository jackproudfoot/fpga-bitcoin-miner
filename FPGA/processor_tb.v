`timescale 1ns/100ps
module processor_tb;

    // module inputs
    reg           clock = 0, ctrl_reset;

    // expected module outputs
    reg [31:0] exp_dataRegA, exp_dataRegB;

    // instantiate the regfile
    Wrapper tester (clock, ctrl_reset);

    integer cycles = 0;

	initial begin
        //Wait for mem files to be loaded
        #245
        ctrl_reset = 1;
        #5
        ctrl_reset = 0;

        // Output file name
        $dumpfile({"processor.vcd"});
        // Module to capture and what level, 0 means all wires
        $dumpvars(0, processor_tb);

        while (cycles < 1000) begin
            @(negedge clock);
			cycles = cycles + 1;
        end

        $finish;
	end



    always 
    	#20 clock = !clock;

endmodule