module XM(instrIn, ALUin, rdIn, instrOut, ALUout, rdOut, clock, enable, clear);
	input clock, enable, clear;
	input [31:0] instrIn, ALUin, rdIn;

	output [31:0] instrOut, ALUout, rdOut;
	
	reg32 aluReg(ALUout, ALUin, clock, enable, clear);
	reg32 rdReg(rdOut, rdIn, clock, enable, clear);
	reg32 instrReg(instrOut, instrIn, clock, enable, clear);
endmodule