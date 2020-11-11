module SLL_1(shiftA, A);
	input [31:0] A;
	output [31:0] shiftA;

	assign shiftA[0] = 1'b0;
	assign shiftA[31:1] = A[30:0];
	
	

endmodule