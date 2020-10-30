module rightrotate11(rotatedValue, inputValue);
	input [31:0] inputValue;
	output [31:0] rotatedValue;

	assign rotatedValue[0] = inputValue[11];
	assign rotatedValue[1] = inputValue[12];
	assign rotatedValue[2] = inputValue[13];
	assign rotatedValue[3] = inputValue[14];
	assign rotatedValue[4] = inputValue[15];
	assign rotatedValue[5] = inputValue[16];
	assign rotatedValue[6] = inputValue[17];
	assign rotatedValue[7] = inputValue[18];
	assign rotatedValue[8] = inputValue[19];
	assign rotatedValue[9] = inputValue[20];
	assign rotatedValue[10] = inputValue[21];
	assign rotatedValue[11] = inputValue[22];
	assign rotatedValue[12] = inputValue[23];
	assign rotatedValue[13] = inputValue[24];
	assign rotatedValue[14] = inputValue[25];
	assign rotatedValue[15] = inputValue[26];
	assign rotatedValue[16] = inputValue[27];
	assign rotatedValue[17] = inputValue[27];
	assign rotatedValue[18] = inputValue[28];
	assign rotatedValue[19] = inputValue[30];
	assign rotatedValue[20] = inputValue[31];
	assign rotatedValue[21] = inputValue[0];
	assign rotatedValue[22] = inputValue[1];
	assign rotatedValue[23] = inputValue[2];
	assign rotatedValue[24] = inputValue[3];
	assign rotatedValue[25] = inputValue[4];
	assign rotatedValue[26] = inputValue[5];
	assign rotatedValue[27] = inputValue[6];
	assign rotatedValue[28] = inputValue[7];
	assign rotatedValue[29] = inputValue[8];
	assign rotatedValue[30] = inputValue[9];
	assign rotatedValue[31] = inputValue[10];

endmodule