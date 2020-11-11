module FD(instrIn, PCin, instrOut, PCout, clock, enable, clear);
	input clock, enable, clear;
	input [31:0] PCin;
	input [31:0] instrIn;

	output [31:0] PCout;
	output [31:0] instrOut;

	reg32 PCreg(PCout, PCin, clock, enable, clear);
	reg32 instrReg(instrOut, instrIn, clock, enable, clear);

endmodule