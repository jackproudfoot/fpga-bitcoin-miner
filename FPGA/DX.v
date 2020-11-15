module DX(instrIn, PCin, rsIn, rtIn, rtrdIn, rsOut, rtOut, rtrdOut, instrOut, PCout, clock, enable, clear);
	input clock, enable, clear;
	input [4:0] rtrdIn;
	input [31:0] PCin;
	input [31:0] instrIn, rsIn, rtIn;

	output [4:0] rtrdOut;
	output [31:0] PCout;
	output [31:0] instrOut, rsOut, rtOut;

	reg5 rdrdR(rtrdOut, rtrdIn, clock, enable, clear);
	reg32 PCreg(PCout, PCin, clock, enable, clear);
	reg32 rsReg(rsOut, rsIn, clock, enable, clear);
	reg32 rtORrdReg(rtOut, rtIn, clock, enable, clear);
	reg32 instrReg(instrOut, instrIn, clock, enable, clear);
endmodule