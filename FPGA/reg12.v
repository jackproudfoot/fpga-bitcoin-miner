module reg12(q, d, clk, en, clr);
	input [31:0] d; 
	input clk, en, clr;
	output [31:0] q;

	dffe_ref flipFlop0(q[0], d[0], clk, en, clr);
	dffe_ref flipFlop1(q[1], d[1], clk, en, clr);
	dffe_ref flipFlop2(q[2], d[2], clk, en, clr);
	dffe_ref flipFlop3(q[3], d[3], clk, en, clr);
	dffe_ref flipFlop4(q[4], d[4], clk, en, clr);
	dffe_ref flipFlop5(q[5], d[5], clk, en, clr);
	dffe_ref flipFlop6(q[6], d[6], clk, en, clr);
	dffe_ref flipFlop7(q[7], d[7], clk, en, clr);
	dffe_ref flipFlop8(q[8], d[8], clk, en, clr);
	dffe_ref flipFlop9(q[9], d[9], clk, en, clr);
	dffe_ref flipFlop10(q[10], d[10], clk, en, clr);
	dffe_ref flipFlop11(q[11], d[11], clk, en, clr);
endmodule