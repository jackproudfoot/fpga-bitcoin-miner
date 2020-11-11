module reg5(q, d, clk, en, clr);
	input [4:0] d; 
	input clk, en, clr;
	output [4:0] q;

	dffe_ref flipFlop0(q[0], d[0], clk, en, clr);
	dffe_ref flipFlop1(q[1], d[1], clk, en, clr);
	dffe_ref flipFlop2(q[2], d[2], clk, en, clr);
	dffe_ref flipFlop3(q[3], d[3], clk, en, clr);
	dffe_ref flipFlop4(q[4], d[4], clk, en, clr);

endmodule