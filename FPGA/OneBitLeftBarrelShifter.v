module OneBitLeftBarrelShifter(inL1, outL1);
	input [31:0] inL1;
	output [31:0] outL1;

	assign outL1[0] = 0;
	assign outL1[1] = inL1[0];
	assign outL1[2] = inL1[1];
	assign outL1[3] = inL1[2];
	assign outL1[4] = inL1[3];
	assign outL1[5] = inL1[4];
	assign outL1[6] = inL1[5];
	assign outL1[7] = inL1[6];
	assign outL1[8] = inL1[7];
	assign outL1[9] = inL1[8];
	assign outL1[10] = inL1[9];
	assign outL1[11] = inL1[10];
	assign outL1[12] = inL1[11];
	assign outL1[13] = inL1[12];
	assign outL1[14] = inL1[13];
	assign outL1[15] = inL1[14];
	assign outL1[16] = inL1[15];
	assign outL1[17] = inL1[16];
	assign outL1[18] = inL1[17];
	assign outL1[19] = inL1[18];
	assign outL1[20] = inL1[19];
	assign outL1[21] = inL1[20];
	assign outL1[22] = inL1[21];
	assign outL1[23] = inL1[22];
	assign outL1[24] = inL1[23];
	assign outL1[25] = inL1[24];
	assign outL1[26] = inL1[25];
	assign outL1[27] = inL1[26];
	assign outL1[28] = inL1[27];
	assign outL1[29] = inL1[28];
	assign outL1[30] = inL1[29];
	assign outL1[31] = inL1[30];
		
endmodule