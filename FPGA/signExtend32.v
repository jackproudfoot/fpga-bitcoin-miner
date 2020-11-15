module signExtend32(extended, inToExtend);
	input [16:0] inToExtend;
	output [31:0] extended;

	assign extended[16:0] = inToExtend;
	assign extended[17] = inToExtend[16];
	assign extended[18] = inToExtend[16];
	assign extended[19] = inToExtend[16];
	assign extended[20] = inToExtend[16];
	assign extended[21] = inToExtend[16];
	assign extended[22] = inToExtend[16];
	assign extended[23] = inToExtend[16];
	assign extended[24] = inToExtend[16];
	assign extended[25] = inToExtend[16];
	assign extended[26] = inToExtend[16];
	assign extended[27] = inToExtend[16];
	assign extended[28] = inToExtend[16];
	assign extended[29] = inToExtend[16];
	assign extended[30] = inToExtend[16];
	assign extended[31] = inToExtend[16];

endmodule