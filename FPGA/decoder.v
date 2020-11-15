module decoder(register, select);
	input [4:0] select;
	output [31:0] register;

	wire w0, w1, w2, w3, w4;
	wire w0N, w1N, w2N, w3N, w4N;

	assign w0 = select[4];
	assign w1 = select[3];
	assign w2 = select[2];
	assign w3 = select[1];
	assign w4 = select[0];

	not Notw1(w0N, w0);
	not Notw2(w1N, w1);
	not Notw3(w2N, w2);
	not Notw4(w3N, w3);
	not Notw5(w4N, w4);

	and r0(register[0], w0N, w1N, w2N, w3N, w4N);
	and r1(register[1], w0N, w1N, w2N, w3N, w4);
	and r2(register[2], w0N, w1N, w2N, w3, w4N);
	and r3(register[3], w0N, w1N, w2N, w3, w4);
	and r4(register[4], w0N, w1N, w2, w3N, w4N);
	and r5(register[5], w0N, w1N, w2, w3N, w4);
	and r6(register[6], w0N, w1N, w2, w3, w4N);
	and r7(register[7], w0N, w1N, w2, w3, w4);
	and r8(register[8], w0N, w1, w2N, w3N, w4N);
	and r9(register[9], w0N, w1, w2N, w3N, w4);
	and r10(register[10], w0N, w1, w2N, w3, w4N);
	and r11(register[11], w0N, w1, w2N, w3, w4);
	and r12(register[12], w0N, w1, w2, w3N, w4N);
	and r13(register[13], w0N, w1, w2, w3N, w4);
	and r14(register[14], w0N, w1, w2, w3, w4N);
	and r15(register[15], w0N, w1, w2, w3, w4);
	and r16(register[16], w0, w1N, w2N, w3N, w4N);
	and r17(register[17], w0, w1N, w2N, w3N, w4);
	and r18(register[18], w0, w1N, w2N, w3, w4N);
	and r19(register[19], w0, w1N, w2N, w3, w4);
	and r20(register[20], w0, w1N, w2, w3N, w4N);
	and r21(register[21], w0, w1N, w2, w3N, w4);
	and r22(register[22], w0, w1N, w2, w3, w4N);
	and r23(register[23], w0, w1N, w2, w3, w4);
	and r24(register[24], w0, w1, w2N, w3N, w4N);
	and r25(register[25], w0, w1, w2N, w3N, w4);
	and r26(register[26], w0, w1, w2N, w3, w4N);
	and r27(register[27], w0, w1, w2N, w3, w4);
	and r28(register[28], w0, w1, w2, w3N, w4N);
	and r29(register[29], w0, w1, w2, w3N, w4);
	and r30(register[30], w0, w1, w2, w3, w4N);
	and r31(register[31], w0, w1, w2, w3, w4);

endmodule