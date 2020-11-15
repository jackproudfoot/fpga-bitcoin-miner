module TwoBitLeftBarrelShifter(inL2, outL2);
	input [31:0] inL2;
	output [31:0] outL2;

	assign outL2[0] = 0;
	assign outL2[1] = 0;
	assign outL2[2] = inL2[0];
	assign outL2[3] = inL2[1];
	assign outL2[4] = inL2[2];
	assign outL2[5] = inL2[3];
	assign outL2[6] = inL2[4];
	assign outL2[7] = inL2[5];
	assign outL2[8] = inL2[6];
	assign outL2[9] = inL2[7];
	assign outL2[10] = inL2[8];
	assign outL2[11] = inL2[9];
	assign outL2[12] = inL2[10];
	assign outL2[13] = inL2[11];
	assign outL2[14] = inL2[12];
	assign outL2[15] = inL2[13];
	assign outL2[16] = inL2[14];
	assign outL2[17] = inL2[15];
	assign outL2[18] = inL2[16];
	assign outL2[19] = inL2[17];
	assign outL2[20] = inL2[18];
	assign outL2[21] = inL2[19];
	assign outL2[22] = inL2[20];
	assign outL2[23] = inL2[21];
	assign outL2[24] = inL2[22];
	assign outL2[25] = inL2[23];
	assign outL2[26] = inL2[24];
	assign outL2[27] = inL2[25];
	assign outL2[28] = inL2[26];
	assign outL2[29] = inL2[27];
	assign outL2[30] = inL2[28];
	assign outL2[31] = inL2[29];
		
endmodule