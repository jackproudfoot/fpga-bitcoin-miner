module SRA_2(shiftA, A);
	input [64:0] A;
	output [64:0] shiftA;

	assign shiftA[62:0] = A[64:2];
	assign shiftA[63] = A[64];
	assign shiftA[64] = A[64];
	

endmodule