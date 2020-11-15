module CLA_32(S32, overflow32, X32, Y32, Cin32);
	input [31:0] X32, Y32;
	input Cin32;
	output [31:0] S32;
	output overflow32;
	wire [3:0] carry;
	wire w1C32, w2C32, w3C32;
	wire G0, P0, G1, P1, G2, P2, G3, P3, temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8, temp9, temp10;

	CLA_8 first_block(S32[7:0], X32[7:0], Y32[7:0], Cin32, G0, P0);
	and	aa(temp1, P0, Cin32);
	or bb(carry[0], G0, temp1);

	CLA_8 second_block(S32[15:8], X32[15:8], Y32[15:8], carry[0], G1, P1);
	and	cc(temp2, P0, P1, Cin32);
	and dd(temp3, P1, G0);
	or ee(carry[1], G1, temp2, temp3);

	CLA_8 third_block(S32[23:16], X32[23:16], Y32[23:16], carry[1], G2, P2);
	and	ff(temp4, P0, P1, P2, Cin32);
	and	gg(temp5, P2, P1, G0);
	and hh(temp6, P2, G1);
	or ii(carry[2], G2, temp4, temp5, temp6);


	CLA_8 fourth_block(S32[31:24], X32[31:24], Y32[31:24], carry[2], G3, P3);
	and	jj(temp7, P0, P1, P2, P3, Cin32);
	and	kk(temp8, P1, P2, P3, G0);
	and	ll(temp9, P2, P3, G1);
	and mm(temp10, P3, G2);
	or nn(carry[3], G3, temp4, temp5, temp6);

	xnor a(w1C32, X32[31], Y32[31]);
	xnor b(w2C32, X32[31], S32[31]);
	not c(w3C32, w2C32);
	and d(overflow32, w1C32, w3C32);

endmodule