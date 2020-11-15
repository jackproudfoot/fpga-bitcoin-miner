module EightBitRightBarrelShifter (inR8, outR8);
	input [31:0] inR8;
	output [31:0] outR8;

	assign outR8[31] = inR8[31];
	assign outR8[30] = inR8[31];
	assign outR8[29] = inR8[31];
	assign outR8[28] = inR8[31];
	assign outR8[27] = inR8[31];
	assign outR8[26] = inR8[31];
	assign outR8[25] = inR8[31];
	assign outR8[24] = inR8[31];
	assign outR8[23] = inR8[31];
	assign outR8[22] = inR8[30];
	assign outR8[21] = inR8[29];
	assign outR8[20] = inR8[28];
	assign outR8[19] = inR8[27];
	assign outR8[18] = inR8[26];
	assign outR8[17] = inR8[25];
	assign outR8[16] = inR8[24];
	assign outR8[15] = inR8[23];
	assign outR8[14] = inR8[22];
	assign outR8[13] = inR8[21];
	assign outR8[12] = inR8[20];
	assign outR8[11] = inR8[19];
	assign outR8[10] = inR8[18];
	assign outR8[9] = inR8[17];
	assign outR8[8] = inR8[16];
	assign outR8[7] = inR8[15];
	assign outR8[6] = inR8[14];
	assign outR8[5] = inR8[13];
	assign outR8[4] = inR8[12];
	assign outR8[3] = inR8[11];
	assign outR8[2] = inR8[10];
	assign outR8[1] = inR8[9];
	assign outR8[0] = inR8[8];
		
endmodule