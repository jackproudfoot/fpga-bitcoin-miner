module LeftBarrelShifter(shamtL, inL, outL);
	input [31:0] inL;
	input [4:0] shamtL;
	output [31:0] outL;
	wire [31:0] w1L, w2L, w3L, w4L, shiftOneL, shiftTwoL, shiftFourL, shiftEightL, shiftSixteenL;

	SixteenBitLeftBarrelShifter s16(inL, shiftSixteenL);
	mux_2 sixteen(w1L, shamtL[4], inL, shiftSixteenL);

	EightBitLeftBarrelShifter s8(w1L, shiftEightL);
	mux_2 eight(w2L, shamtL[3], w1L, shiftEightL);

	FourBitLeftBarrelShifter s4(w2L, shiftFourL);
	mux_2 four(w3L, shamtL[2], w2L, shiftFourL);

	TwoBitLeftBarrelShifter s2(w3L, shiftTwoL);
	mux_2 two(w4L, shamtL[1], w3L, shiftTwoL);

	OneBitLeftBarrelShifter s1(w4L, shiftOneL);
	mux_2 one(outL, shamtL[0], w4L, shiftOneL);

endmodule