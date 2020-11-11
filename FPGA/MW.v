module MW(instrIn, ALUin, memIn, instrOut, ALUout, memOut, clock, enable, clear);
	input clock, enable, clear;
	input [31:0] instrIn, ALUin, memIn;

	output [31:0] instrOut, ALUout, memOut;
	
	reg32 aluReg(ALUout, ALUin, clock, enable, clear);
	reg32 memReg(memOut, memIn, clock, enable, clear);
	reg32 instrReg(instrOut, instrIn, clock, enable, clear);
endmodule