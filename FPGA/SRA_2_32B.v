module SRA_2_32B(shiftA, A);
	input [31:0] A;
	output [31:0] shiftA;

	assign shiftA[29:0] = A[31:2];
	assign shiftA[30] = A[31];
	assign shiftA[31] = A[31];
	

endmodule