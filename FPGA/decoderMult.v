module decoderMult(register, select);
	input [2:0] select;
	output [7:0] register;

	wire w3, w2, w1;
	wire w3N, w2N, w1N;

	assign w3 = select[2];
	assign w2 = select[1];
	assign w1 = select[0];

	not Notw3(w3N, w3);
	not Notw4(w2N, w2);
	not Notw5(w1N, w1);

	and r0(register[0], w3N, w2N, w1N);
	and r1(register[1], w3N, w2N, w1);
	and r2(register[2], w3N, w2, w1N);
	and r3(register[3], w3N, w2, w1);
	and r4(register[4], w3, w2N, w1N);
	and r5(register[5], w3, w2N, w1);
	and r6(register[6], w3, w2, w1N);
	and r7(register[7], w3, w2, w1);
	

endmodule