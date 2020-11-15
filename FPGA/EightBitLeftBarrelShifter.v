module EightBitLeftBarrelShifter(inL8, outL8);
	input [31:0] inL8;
	output [31:0] outL8;

	assign outL8[0] = 0;
	assign outL8[1] = 0;
	assign outL8[2] = 0;
	assign outL8[3] = 0;
	assign outL8[4] = 0;
	assign outL8[5] = 0;
	assign outL8[6] = 0;
	assign outL8[7] = 0;
	assign outL8[8] = inL8[0];
	assign outL8[9] = inL8[1];
	assign outL8[10] = inL8[2];
	assign outL8[11] = inL8[3];
	assign outL8[12] = inL8[4];
	assign outL8[13] = inL8[5];
	assign outL8[14] = inL8[6];
	assign outL8[15] = inL8[7];
	assign outL8[16] = inL8[8];
	assign outL8[17] = inL8[9];
	assign outL8[18] = inL8[10];
	assign outL8[19] = inL8[11];
	assign outL8[20] = inL8[12];
	assign outL8[21] = inL8[13];
	assign outL8[22] = inL8[14];
	assign outL8[23] = inL8[15];
	assign outL8[24] = inL8[16];
	assign outL8[25] = inL8[17];
	assign outL8[26] = inL8[18];
	assign outL8[27] = inL8[19];
	assign outL8[28] = inL8[20];
	assign outL8[29] = inL8[21];
	assign outL8[30] = inL8[22];
	assign outL8[31] = inL8[23];
	
endmodule