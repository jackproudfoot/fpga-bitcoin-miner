module signExtendTarget(extended, inToExtend);
	input [26:0] inToExtend;
	output [31:0] extended;

	assign extended[26:0] = inToExtend;
	assign extended[27] = 1'b0;
	assign extended[28] = 1'b0;
	assign extended[29] = 1'b0;
	assign extended[30] = 1'b0;
	assign extended[31] = 1'b0;

endmodule