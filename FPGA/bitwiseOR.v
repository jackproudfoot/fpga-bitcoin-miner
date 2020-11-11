module bitwiseOR(outR, XR, YR);
	input [31:0] XR, YR;
	output [31:0] outR;

	or a(outR[0], XR[0], YR[0]);
	or b(outR[1], XR[1], YR[1]);
	or c(outR[2], XR[2], YR[2]);
	or d(outR[3], XR[3], YR[3]);
	or e(outR[4], XR[4], YR[4]);
	or f(outR[5], XR[5], YR[5]);
	or g(outR[6], XR[6], YR[6]);
	or h(outR[7], XR[7], YR[7]);
	or i(outR[8], XR[8], YR[8]);
	or j(outR[9], XR[9], YR[9]);
	or k(outR[10], XR[10], YR[10]);
	or l(outR[11], XR[11], YR[11]);
	or m(outR[12], XR[12], YR[12]);
	or n(outR[13], XR[13], YR[13]);
	or o(outR[14], XR[14], YR[14]);
	or p(outR[15], XR[15], YR[15]);
	or q(outR[16], XR[16], YR[16]);
	or r(outR[17], XR[17], YR[17]);
	or s(outR[18], XR[18], YR[18]);
	or t(outR[19], XR[19], YR[19]);
	or u(outR[20], XR[20], YR[20]);
	or v(outR[21], XR[21], YR[21]);
	or w(outR[22], XR[22], YR[22]);
	or x(outR[23], XR[23], YR[23]);
	or y(outR[24], XR[24], YR[24]);
	or z(outR[25], XR[25], YR[25]);
	or aa(outR[26], XR[26], YR[26]);
	or bb(outR[27], XR[27], YR[27]);
	or cc(outR[28], XR[28], YR[28]);
	or dd(outR[29], XR[29], YR[29]);
	or ee(outR[30], XR[30], YR[30]);
	or ff(outR[31], XR[31], YR[31]);
	
endmodule