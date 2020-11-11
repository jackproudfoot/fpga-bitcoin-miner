module OneBitRightBarrelShifter(inR1, outR1);
	input [31:0] inR1;
	output [31:0] outR1;

	assign outR1[31] = inR1[31];
	assign outR1[30] = inR1[31];
	assign outR1[29] = inR1[30];
	assign outR1[28] = inR1[29];
	assign outR1[27] = inR1[28];
	assign outR1[26] = inR1[27];
	assign outR1[25] = inR1[26];
	assign outR1[24] = inR1[25];
	assign outR1[23] = inR1[24];
	assign outR1[22] = inR1[23];
	assign outR1[21] = inR1[22];
	assign outR1[20] = inR1[21];
	assign outR1[19] = inR1[20];
	assign outR1[18] = inR1[19];
	assign outR1[17] = inR1[18];
	assign outR1[16] = inR1[17];
	assign outR1[15] = inR1[16];
	assign outR1[14] = inR1[15];
	assign outR1[13] = inR1[14];
	assign outR1[12] = inR1[13];
	assign outR1[11] = inR1[12];
	assign outR1[10] = inR1[11];
	assign outR1[9] = inR1[10];
	assign outR1[8] = inR1[9];
	assign outR1[7] = inR1[8];
	assign outR1[6] = inR1[7];
	assign outR1[5] = inR1[6];
	assign outR1[4] = inR1[5];
	assign outR1[3] = inR1[4];
	assign outR1[2] = inR1[3];
	assign outR1[1] = inR1[2];
	assign outR1[0] = inR1[1];
		
endmodule