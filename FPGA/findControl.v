module findControl(ctrl, multi, clockCon, reset);
	input [31:0] multi;
	input clockCon, reset;

	output [2:0] ctrl;

	wire [31:0] w1, shiftToReg, Q, preCon, temp;

	mux_2 firstMux(w1, reset, multi, Q);

	SRA_2_32B shift(shiftToReg, w1);

	reg32 regControl(Q, shiftToReg, clockCon, 1'b1, 1'b0);

	mux_2 finalMux(preCon, reset, multi, Q);

	assign ctrl = preCon[2:0];

endmodule