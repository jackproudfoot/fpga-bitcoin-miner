module SixteenBitRightBarrelShifter(inR16, outR16);
	input [31:0] inR16;
	output [31:0] outR16;

	assign outR16[31] = inR16[31];
	assign outR16[30] = inR16[31];
	assign outR16[29] = inR16[31];
	assign outR16[28] = inR16[31];
	assign outR16[27] = inR16[31];
	assign outR16[26] = inR16[31];
	assign outR16[25] = inR16[31];
	assign outR16[24] = inR16[31];
	assign outR16[23] = inR16[31];
	assign outR16[22] = inR16[31];
	assign outR16[21] = inR16[31];
	assign outR16[20] = inR16[31];
	assign outR16[19] = inR16[31];
	assign outR16[18] = inR16[31];
	assign outR16[17] = inR16[31];
	assign outR16[16] = inR16[31];
	assign outR16[15] = inR16[31];
	assign outR16[14] = inR16[30];
	assign outR16[13] = inR16[29];
	assign outR16[12] = inR16[28];
	assign outR16[11] = inR16[27];
	assign outR16[10] = inR16[26];
	assign outR16[9] = inR16[25];
	assign outR16[8] = inR16[24];
	assign outR16[7] = inR16[23];
	assign outR16[6] = inR16[22];
	assign outR16[5] = inR16[21];
	assign outR16[4] = inR16[20];
	assign outR16[3] = inR16[19];
	assign outR16[2] = inR16[18];
	assign outR16[1] = inR16[17];
	assign outR16[0] = inR16[16];
		
endmodule