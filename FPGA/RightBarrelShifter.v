module RightBarrelShifter(shamtR, inR, outRR);
	input [31:0] inR;
	input [4:0] shamtR;
	output [31:0] outRR;
	wire [31:0] w1, w2, w3, w4, shiftOne, shiftTwo, shiftFour, shiftEight, shiftSixteen;

	SixteenBitRightBarrelShifter s16(inR, shiftSixteen);
	mux_2 sixteen(w1, shamtR[4], inR, shiftSixteen);

	EightBitRightBarrelShifter s8(w1, shiftEight);
	mux_2 eight(w2, shamtR[3], w1, shiftEight);

	FourBitRightBarrelShifter s4(w2, shiftFour);
	mux_2 four(w3, shamtR[2], w2, shiftFour);

	TwoBitRightBarrelShifter s2(w3, shiftTwo);
	mux_2 two(w4, shamtR[1], w3, shiftTwo);

	OneBitRightBarrelShifter s1(w4, shiftOne);
	mux_2 one(outRR, shamtR[0], w4, shiftOne);

endmodule