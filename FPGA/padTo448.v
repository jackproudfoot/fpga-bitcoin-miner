module padTo448(paddedOutput, inputValue);
	input [88:0] inputValue;
	output [447:0] paddedOutput;

	assign paddedOutput[88:0] = inputValue[88:0];
	assign paddedOutput[447:89] = 360'b0;

endmodule