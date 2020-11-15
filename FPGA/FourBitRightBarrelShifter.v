module FourBitRightBarrelShifter(inR4, outR4);
	input [31:0] inR4;
	output [31:0] outR4;

	assign outR4[31] = inR4[31];
	assign outR4[30] = inR4[31];
	assign outR4[29] = inR4[31];
	assign outR4[28] = inR4[31];
	assign outR4[27] = inR4[31];
	assign outR4[26] = inR4[30];
	assign outR4[25] = inR4[29];
	assign outR4[24] = inR4[28];
	assign outR4[23] = inR4[27];
	assign outR4[22] = inR4[26];
	assign outR4[21] = inR4[25];
	assign outR4[20] = inR4[24];
	assign outR4[19] = inR4[23];
	assign outR4[18] = inR4[22];
	assign outR4[17] = inR4[21];
	assign outR4[16] = inR4[20];
	assign outR4[15] = inR4[19];
	assign outR4[14] = inR4[18];
	assign outR4[13] = inR4[17];
	assign outR4[12] = inR4[16];
	assign outR4[11] = inR4[15];
	assign outR4[10] = inR4[14];
	assign outR4[9] = inR4[13];
	assign outR4[8] = inR4[12];
	assign outR4[7] = inR4[11];
	assign outR4[6] = inR4[10];
	assign outR4[5] = inR4[9];
	assign outR4[4] = inR4[8];
	assign outR4[3] = inR4[7];
	assign outR4[2] = inR4[6];
	assign outR4[1] = inR4[5];
	assign outR4[0] = inR4[4];
		
endmodule