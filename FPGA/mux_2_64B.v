module mux_2_64B(out, select, in0, in1);
	input select;
	input [63:0] in0, in1;
	output [63:0] out;
	assign out = select ? in1 : in0;
endmodule