module bitwiseAND(outAND, Xand, Yand);
	input [31:0] Xand, Yand;
	output [31:0] outAND;

	and a(outAND[0], Xand[0], Yand[0]);
	and b(outAND[1], Xand[1], Yand[1]);
	and c(outAND[2], Xand[2], Yand[2]);
	and d(outAND[3], Xand[3], Yand[3]);
	and e(outAND[4], Xand[4], Yand[4]);
	and f(outAND[5], Xand[5], Yand[5]);
	and g(outAND[6], Xand[6], Yand[6]);
	and h(outAND[7], Xand[7], Yand[7]);
	and i(outAND[8], Xand[8], Yand[8]);
	and j(outAND[9], Xand[9], Yand[9]);
	and k(outAND[10], Xand[10], Yand[10]);
	and l(outAND[11], Xand[11], Yand[11]);
	and m(outAND[12], Xand[12], Yand[12]);
	and n(outAND[13], Xand[13], Yand[13]);
	and o(outAND[14], Xand[14], Yand[14]);
	and p(outAND[15], Xand[15], Yand[15]);
	and q(outAND[16], Xand[16], Yand[16]);
	and r(outAND[17], Xand[17], Yand[17]);
	and s(outAND[18], Xand[18], Yand[18]);
	and t(outAND[19], Xand[19], Yand[19]);
	and u(outAND[20], Xand[20], Yand[20]);
	and v(outAND[21], Xand[21], Yand[21]);
	and w(outAND[22], Xand[22], Yand[22]);
	and x(outAND[23], Xand[23], Yand[23]);
	and y(outAND[24], Xand[24], Yand[24]);
	and z(outAND[25], Xand[25], Yand[25]);
	and aa(outAND[26], Xand[26], Yand[26]);
	and bb(outAND[27], Xand[27], Yand[27]);
	and cc(outAND[28], Xand[28], Yand[28]);
	and dd(outAND[29], Xand[29], Yand[29]);
	and ee(outAND[30], Xand[30], Yand[30]);
	and ff(outAND[31], Xand[31], Yand[31]);
	
endmodule