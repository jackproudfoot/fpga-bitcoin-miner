module FourBitLeftBarrelShifter(inL4, outL4);
	input [31:0] inL4;
	output [31:0] outL4;

	assign outL4[0] = 0;
	assign outL4[1] = 0;
	assign outL4[2] = 0;
	assign outL4[3] = 0;
	assign outL4[4] = inL4[0];
	assign outL4[5] = inL4[1];
	assign outL4[6] = inL4[2];
	assign outL4[7] = inL4[3];
	assign outL4[8] = inL4[4];
	assign outL4[9] = inL4[5];
	assign outL4[10] = inL4[6];
	assign outL4[11] = inL4[7];
	assign outL4[12] = inL4[8];
	assign outL4[13] = inL4[9];
	assign outL4[14] = inL4[10];
	assign outL4[15] = inL4[11];
	assign outL4[16] = inL4[12];
	assign outL4[17] = inL4[13];
	assign outL4[18] = inL4[14];
	assign outL4[19] = inL4[15];
	assign outL4[20] = inL4[16];
	assign outL4[21] = inL4[17];
	assign outL4[22] = inL4[18];
	assign outL4[23] = inL4[19];
	assign outL4[24] = inL4[20];
	assign outL4[25] = inL4[21];
	assign outL4[26] = inL4[22];
	assign outL4[27] = inL4[23];
	assign outL4[28] = inL4[24];
	assign outL4[29] = inL4[25];
	assign outL4[30] = inL4[26];
	assign outL4[31] = inL4[27];
		
endmodule