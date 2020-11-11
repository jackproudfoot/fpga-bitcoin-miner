module bitwiseXNOR(out, X, Y);
	input [31:0] X, Y;
	output [31:0]out;

	xnor a(out[0], X[0], Y[0]);
	xnor b(out[1], X[1], Y[1]);
	xnor c(out[2], X[2], Y[2]);
	xnor d(out[3], X[3], Y[3]);
	xnor e(out[4], X[4], Y[4]);
	xnor f(out[5], X[5], Y[5]);
	xnor g(out[6], X[6], Y[6]);
	xnor h(out[7], X[7], Y[7]);
	xnor i(out[8], X[8], Y[8]);
	xnor j(out[9], X[9], Y[9]);
	xnor k(out[10], X[10], Y[10]);
	xnor l(out[11], X[11], Y[11]);
	xnor m(out[12], X[12], Y[12]);
	xnor n(out[13], X[13], Y[13]);
	xnor o(out[14], X[14], Y[14]);
	xnor p(out[15], X[15], Y[15]);
	xnor q(out[16], X[16], Y[16]);
	xnor r(out[17], X[17], Y[17]);
	xnor s(out[18], X[18], Y[18]);
	xnor t(out[19], X[19], Y[19]);
	xnor u(out[20], X[20], Y[20]);
	xnor v(out[21], X[21], Y[21]);
	xnor w(out[22], X[22], Y[22]);
	xnor x(out[23], X[23], Y[23]);
	xnor y(out[24], X[24], Y[24]);
	xnor z(out[25], X[25], Y[25]);
	xnor aa(out[26], X[26], Y[26]);
	xnor bb(out[27], X[27], Y[27]);
	xnor cc(out[28], X[28], Y[28]);
	xnor dd(out[29], X[29], Y[29]);
	xnor ee(out[30], X[30], Y[30]);
	xnor ff(out[31], X[31], Y[31]);

endmodule