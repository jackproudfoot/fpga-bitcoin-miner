module SixteenBitLeftBarrelShifter(inL16, outL16);
	input [31:0] inL16;
	output [31:0] outL16;

	assign outL16[0] = 0;
	assign outL16[1] = 0;
	assign outL16[2] = 0;
	assign outL16[3] = 0;
	assign outL16[4] = 0;
	assign outL16[5] = 0;
	assign outL16[6] = 0;
	assign outL16[7] = 0;
	assign outL16[8] = 0;
	assign outL16[9] = 0;
	assign outL16[10] = 0;
	assign outL16[11] = 0;
	assign outL16[12] = 0;
	assign outL16[13] = 0;
	assign outL16[14] = 0;
	assign outL16[15] = 0;
	assign outL16[16] = inL16[0];
	assign outL16[17] = inL16[1];
	assign outL16[18] = inL16[2];
	assign outL16[19] = inL16[3];
	assign outL16[20] = inL16[4];
	assign outL16[21] = inL16[5];
	assign outL16[22] = inL16[6];
	assign outL16[23] = inL16[7];
	assign outL16[24] = inL16[8];
	assign outL16[25] = inL16[9];
	assign outL16[26] = inL16[10];
	assign outL16[27] = inL16[11];
	assign outL16[28] = inL16[12];
	assign outL16[29] = inL16[13];
	assign outL16[30] = inL16[14];
	assign outL16[31] = inL16[15];
		
endmodule