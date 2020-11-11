module controller(control, add, sub, add2M, sub2M, doNothing);
	input [2:0] control;
	output add, sub, add2M, sub2M, doNothing;

	wire [7:0] w;

	decoderMult dec(w, control);

	or addAND(add, w[1], w[2]);
	or subAND(sub, w[5], w[6]);
	or doNothingAND(doNothing, w[0], w[7]);
	assign add2M = w[3];
	assign sub2M = w[4];

endmodule