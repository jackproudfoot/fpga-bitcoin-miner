module triStateBuffer(out, enable, in);
	input enable;
	input [31:0] in;
	output [31:0] out;
	assign out = enable ? in : 32'bz;
endmodule
