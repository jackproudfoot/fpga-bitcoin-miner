module SHA256(inputSchedule, hashedValue, clock, 
			  hash0In, hash1In, hash2In, hash3In, hash4In, hash5In, hash6In, hash7In, 
			  hash0Out, hash1Out, hash2Out, hash3Out, hash4Out, hash5Out, hash6Out, hash7Out);

	input clock;
	input [31:0] hash0In, hash1In, hash2In, hash3In, hash4In, hash5In, hash6In, hash7In;
	input [511:0] inputSchedule;
	output [31:0] hash0Out, hash1Out, hash2Out, hash3Out, hash4Out, hash5Out, hash6Out, hash7Out;
	output [255:0] hashedValue;

	// 64-element arrays of 32-bit wide reg
	wire [31:0] k [0:63];


	wire [31:0] hashFinal0, hashFinal1, hashFinal2, hashFinal3, hashFinal4, hashFinal5, hashFinal6, hashFinal7;


	// // assign (h)ash values

	// assign hash0 = 32'b01101010000010011110011001100111;
	// assign hash1 = 32'b10111011011001111010111010000101;
	// assign hash2 = 32'b00111100011011101111001101110010;
	// assign hash3 = 32'b10100101010011111111010100111010;
	// assign hash4 = 32'b01010001000011100101001001111111;
	// assign hash5 = 32'b10011011000001010110100010001100;
	// assign hash6 = 32'b00011111100000111101100110101011;
	// assign hash7 = 32'b01011011111000001100110100011001;

	// Assign (k)onstants

	assign k[0] = 32'b01000010100010100010111110011000;
	assign k[1] = 32'b01110001001101110100010010010001;
	assign k[2] = 32'b10110101110000001111101111001111;
	assign k[3] = 32'b11101001101101011101101110100101;
	assign k[4] = 32'b00111001010101101100001001011011;
	assign k[5] = 32'b01011001111100010001000111110001;
	assign k[6] = 32'b10010010001111111000001010100100;
	assign k[7] = 32'b10101011000111000101111011010101;
	assign k[8] = 32'b11011000000001111010101010011000;
	assign k[9] = 32'b00010010100000110101101100000001;
	assign k[10] = 32'b00100100001100011000010110111110;
	assign k[11] = 32'b01010101000011000111110111000011;
	assign k[12] = 32'b01110010101111100101110101110100;
	assign k[13] = 32'b10000000110111101011000111111110;
	assign k[14] = 32'b10011011110111000000011010100111;
	assign k[15] = 32'b11000001100110111111000101110100;
	assign k[16] = 32'b11100100100110110110100111000001;
	assign k[17] = 32'b11101111101111100100011110000110;
	assign k[18] = 32'b00001111110000011001110111000110;
	assign k[19] = 32'b00100100000011001010000111001100;
	assign k[20] = 32'b00101101111010010010110001101111;
	assign k[21] = 32'b01001010011101001000010010101010;
	assign k[22] = 32'b01011100101100001010100111011100;
	assign k[23] = 32'b01110110111110011000100011011010;
	assign k[24] = 32'b10011000001111100101000101010010;
	assign k[25] = 32'b10101000001100011100011001101101;
	assign k[26] = 32'b10110000000000110010011111001000;
	assign k[27] = 32'b10111111010110010111111111000111;
	assign k[28] = 32'b11000110111000000000101111110011;
	assign k[29] = 32'b11010101101001111001000101000111;
	assign k[30] = 32'b00000110110010100110001101010001;
	assign k[31] = 32'b00010100001010010010100101100111;
	assign k[32] = 32'b00100111101101110000101010000101;
	assign k[33] = 32'b00101110000110110010000100111000;
	assign k[34] = 32'b01001101001011000110110111111100;
	assign k[35] = 32'b01010011001110000000110100010011;
	assign k[36] = 32'b01100101000010100111001101010100;
	assign k[37] = 32'b01110110011010100000101010111011;
	assign k[38] = 32'b10000001110000101100100100101110;
	assign k[39] = 32'b10010010011100100010110010000101;
	assign k[40] = 32'b10100010101111111110100010100001;
	assign k[41] = 32'b10101000000110100110011001001011;
	assign k[42] = 32'b11000010010010111000101101110000;
	assign k[43] = 32'b11000111011011000101000110100011;
	assign k[44] = 32'b11010001100100101110100000011001;
	assign k[45] = 32'b11010110100110010000011000100100;
	assign k[46] = 32'b11110100000011100011010110000101;
	assign k[47] = 32'b00010000011010101010000001110000;
	assign k[48] = 32'b00011001101001001100000100010110;
	assign k[49] = 32'b00011110001101110110110000001000;
	assign k[50] = 32'b00100111010010000111011101001100;
	assign k[51] = 32'b00110100101100001011110010110101;
	assign k[52] = 32'b00111001000111000000110010110011;
	assign k[53] = 32'b01001110110110001010101001001010;
	assign k[54] = 32'b01011011100111001100101001001111;
	assign k[55] = 32'b01101000001011100110111111110011;
	assign k[56] = 32'b01110100100011111000001011101110;
	assign k[57] = 32'b01111000101001010110001101101111;
	assign k[58] = 32'b10000100110010000111100000010100;
	assign k[59] = 32'b10001100110001110000001000001000;
	assign k[60] = 32'b10010000101111101111111111111010;
	assign k[61] = 32'b10100100010100000110110011101011;
	assign k[62] = 32'b10111110111110011010001111110111;
	assign k[63] = 32'b11000110011100010111100011110010;


	// message schedule (w)
	
	// assign w[0] = inputSchedule[511:480];
	// assign w[1] = inputSchedule[479:448];
	// assign w[2] = inputSchedule[447:416];
	// assign w[3] = inputSchedule[415:384];
	// assign w[4] = inputSchedule[383:352];
	// assign w[5] = inputSchedule[351:320];
	// assign w[6] = inputSchedule[319:288];
	// assign w[7] = inputSchedule[287:256];
	// assign w[8] = inputSchedule[255:224];
	// assign w[9] = inputSchedule[223:192];
	// assign w[10] = inputSchedule[191:160];
	// assign w[11] = inputSchedule[159:128];
	// assign w[12] = inputSchedule[127:96];
	// assign w[13] = inputSchedule[95:64];
	// assign w[14] = inputSchedule[63:32];
	// assign w[15]= inputSchedule[31:0];

	wire [511:0] initial_w;
	assign initial_w = {
		inputSchedule[31:0], inputSchedule[63:32], inputSchedule[95:64], inputSchedule[127:96],
		inputSchedule[159:128], inputSchedule[191:160], inputSchedule[223:192], inputSchedule[255:224],
		inputSchedule[287:256], inputSchedule[319:288], inputSchedule[351:320], inputSchedule[383:352],
		inputSchedule[415:384], inputSchedule[447:416], inputSchedule[479:448], inputSchedule[511:480]
	};


	

	wire [255:0] initial_state;
	assign initial_state = {hash7In, hash6In, hash5In, hash4In, hash3In, hash2In, hash1In, hash0In};

	wire [511:0] 	w_out0, w_out1, w_out2, w_out3, w_out4, w_out5, w_out6, w_out7, 
					w_out8, w_out9, w_out10, w_out11, w_out12, w_out13, w_out14, 
					w_out15, w_out16, w_out17, w_out18, w_out19, w_out20, w_out21, 
					w_out22, w_out23, w_out24, w_out25, w_out26, w_out27, w_out28, 
					w_out29, w_out30, w_out31, w_out32, w_out33, w_out34, w_out35, 
					w_out36, w_out37, w_out38, w_out39, w_out40, w_out41, w_out42, 
					w_out43, w_out44, w_out45, w_out46, w_out47, w_out48, w_out49, 
					w_out50, w_out51, w_out52, w_out53, w_out54, w_out55, w_out56, 
					w_out57, w_out58, w_out59, w_out60, w_out61, w_out62, w_out63;
	
	wire [255:0] 	state_out0, state_out1, state_out2, state_out3, state_out4, state_out5, state_out6, state_out7, 
					state_out8, state_out9, state_out10, state_out11, state_out12, state_out13, state_out14, 
					state_out15, state_out16, state_out17, state_out18, state_out19, state_out20, state_out21, 
					state_out22, state_out23, state_out24, state_out25, state_out26, state_out27, state_out28, 
					state_out29, state_out30, state_out31, state_out32, state_out33, state_out34, state_out35, 
					state_out36, state_out37, state_out38, state_out39, state_out40, state_out41, state_out42, 
					state_out43, state_out44, state_out45, state_out46, state_out47, state_out48, state_out49, 
					state_out50, state_out51, state_out52, state_out53, state_out54, state_out55, state_out56, 
					state_out57, state_out58, state_out59, state_out60, state_out61, state_out62, state_out63;
	

	SHA256_slice slice0(clock, initial_w, k[0], initial_state, w_out0, state_out0);
	SHA256_slice slice1(clock, w_out0, k[1], state_out0, w_out1, state_out1);
	SHA256_slice slice2(clock, w_out1, k[2], state_out1, w_out2, state_out2);
	SHA256_slice slice3(clock, w_out2, k[3], state_out2, w_out3, state_out3);
	SHA256_slice slice4(clock, w_out3, k[4], state_out3, w_out4, state_out4);
	SHA256_slice slice5(clock, w_out4, k[5], state_out4, w_out5, state_out5);
	SHA256_slice slice6(clock, w_out5, k[6], state_out5, w_out6, state_out6);
	SHA256_slice slice7(clock, w_out6, k[7], state_out6, w_out7, state_out7);
	SHA256_slice slice8(clock, w_out7, k[8], state_out7, w_out8, state_out8);
	SHA256_slice slice9(clock, w_out8, k[9], state_out8, w_out9, state_out9);
	SHA256_slice slice10(clock, w_out9, k[10], state_out9, w_out10, state_out10);
	SHA256_slice slice11(clock, w_out10, k[11], state_out10, w_out11, state_out11);
	SHA256_slice slice12(clock, w_out11, k[12], state_out11, w_out12, state_out12);
	SHA256_slice slice13(clock, w_out12, k[13], state_out12, w_out13, state_out13);
	SHA256_slice slice14(clock, w_out13, k[14], state_out13, w_out14, state_out14);
	SHA256_slice slice15(clock, w_out14, k[15], state_out14, w_out15, state_out15);
	SHA256_slice slice16(clock, w_out15, k[16], state_out15, w_out16, state_out16);
	SHA256_slice slice17(clock, w_out16, k[17], state_out16, w_out17, state_out17);
	SHA256_slice slice18(clock, w_out17, k[18], state_out17, w_out18, state_out18);
	SHA256_slice slice19(clock, w_out18, k[19], state_out18, w_out19, state_out19);
	SHA256_slice slice20(clock, w_out19, k[20], state_out19, w_out20, state_out20);
	SHA256_slice slice21(clock, w_out20, k[21], state_out20, w_out21, state_out21);
	SHA256_slice slice22(clock, w_out21, k[22], state_out21, w_out22, state_out22);
	SHA256_slice slice23(clock, w_out22, k[23], state_out22, w_out23, state_out23);
	SHA256_slice slice24(clock, w_out23, k[24], state_out23, w_out24, state_out24);
	SHA256_slice slice25(clock, w_out24, k[25], state_out24, w_out25, state_out25);
	SHA256_slice slice26(clock, w_out25, k[26], state_out25, w_out26, state_out26);
	SHA256_slice slice27(clock, w_out26, k[27], state_out26, w_out27, state_out27);
	SHA256_slice slice28(clock, w_out27, k[28], state_out27, w_out28, state_out28);
	SHA256_slice slice29(clock, w_out28, k[29], state_out28, w_out29, state_out29);
	SHA256_slice slice30(clock, w_out29, k[30], state_out29, w_out30, state_out30);
	SHA256_slice slice31(clock, w_out30, k[31], state_out30, w_out31, state_out31);
	SHA256_slice slice32(clock, w_out31, k[32], state_out31, w_out32, state_out32);
	SHA256_slice slice33(clock, w_out32, k[33], state_out32, w_out33, state_out33);
	SHA256_slice slice34(clock, w_out33, k[34], state_out33, w_out34, state_out34);
	SHA256_slice slice35(clock, w_out34, k[35], state_out34, w_out35, state_out35);
	SHA256_slice slice36(clock, w_out35, k[36], state_out35, w_out36, state_out36);
	SHA256_slice slice37(clock, w_out36, k[37], state_out36, w_out37, state_out37);
	SHA256_slice slice38(clock, w_out37, k[38], state_out37, w_out38, state_out38);
	SHA256_slice slice39(clock, w_out38, k[39], state_out38, w_out39, state_out39);
	SHA256_slice slice40(clock, w_out39, k[40], state_out39, w_out40, state_out40);
	SHA256_slice slice41(clock, w_out40, k[41], state_out40, w_out41, state_out41);
	SHA256_slice slice42(clock, w_out41, k[42], state_out41, w_out42, state_out42);
	SHA256_slice slice43(clock, w_out42, k[43], state_out42, w_out43, state_out43);
	SHA256_slice slice44(clock, w_out43, k[44], state_out43, w_out44, state_out44);
	SHA256_slice slice45(clock, w_out44, k[45], state_out44, w_out45, state_out45);
	SHA256_slice slice46(clock, w_out45, k[46], state_out45, w_out46, state_out46);
	SHA256_slice slice47(clock, w_out46, k[47], state_out46, w_out47, state_out47);
	SHA256_slice slice48(clock, w_out47, k[48], state_out47, w_out48, state_out48);
	SHA256_slice slice49(clock, w_out48, k[49], state_out48, w_out49, state_out49);
	SHA256_slice slice50(clock, w_out49, k[50], state_out49, w_out50, state_out50);
	SHA256_slice slice51(clock, w_out50, k[51], state_out50, w_out51, state_out51);
	SHA256_slice slice52(clock, w_out51, k[52], state_out51, w_out52, state_out52);
	SHA256_slice slice53(clock, w_out52, k[53], state_out52, w_out53, state_out53);
	SHA256_slice slice54(clock, w_out53, k[54], state_out53, w_out54, state_out54);
	SHA256_slice slice55(clock, w_out54, k[55], state_out54, w_out55, state_out55);
	SHA256_slice slice56(clock, w_out55, k[56], state_out55, w_out56, state_out56);
	SHA256_slice slice57(clock, w_out56, k[57], state_out56, w_out57, state_out57);
	SHA256_slice slice58(clock, w_out57, k[58], state_out57, w_out58, state_out58);
	SHA256_slice slice59(clock, w_out58, k[59], state_out58, w_out59, state_out59);
	SHA256_slice slice60(clock, w_out59, k[60], state_out59, w_out60, state_out60);
	SHA256_slice slice61(clock, w_out60, k[61], state_out60, w_out61, state_out61);
	SHA256_slice slice62(clock, w_out61, k[62], state_out61, w_out62, state_out62);
	SHA256_slice slice63(clock, w_out62, k[63], state_out62, w_out63, state_out63);


    
	assign hashFinal0 = hash0In + state_out63[31:0];
	assign hashFinal1 = hash1In + state_out63[63:32];
	assign hashFinal2 = hash2In + state_out63[95:64];
	assign hashFinal3 = hash3In + state_out63[127:96];
	assign hashFinal4 = hash4In + state_out63[159:128];
	assign hashFinal5 = hash5In + state_out63[191:160];
	assign hashFinal6 = hash6In + state_out63[191:160];
	assign hashFinal7 = hash7In + state_out63[255:224];


    assign hash0Out = hashFinal0;
    assign hash1Out = hashFinal1;
    assign hash2Out = hashFinal2;
    assign hash3Out = hashFinal3;
    assign hash4Out = hashFinal4;
    assign hash5Out = hashFinal5;
    assign hash6Out = hashFinal6;
    assign hash7Out = hashFinal7;
    
	

	assign hashedValue = {hashFinal0, hashFinal1, hashFinal2, hashFinal3, hashFinal4, hashFinal5, hashFinal6, hashFinal7};
endmodule


module SHA256_slice(clock, w_in, k, state_in, w_out, state_out);
	input clock;

	input [511:0] w_in;
	input [31:0] k;
	input [255:0] state_in;

	output reg [511:0] w_out;
	output reg [255:0] state_out;

	wire [31:0] rot7, rot18, shift3, rot17, rot19, shift10;

	// Block Generation
	rotate #(.AMOUNT(7)) rotate7(rot7, w_in[63:32]);
	rotate #(.AMOUNT(18)) rotate18(rot18, w_in[63:32]);
	assign shift3 = w_in[63:32] >> 3;

	rotate #(.AMOUNT(17)) rotate17(rot17, w_in[479:448]);
	rotate #(.AMOUNT(19)) rotate19(rot19, w_in[479:448]);
	assign shift10 = w_in[479:448] >> 10;

	wire [31:0] s0, s1;

	assign s0 = (rot7 ^ rot18 ^ shift3);
	assign s1 = (rot17 ^ rot19 ^ shift10);

	wire [31:0] next_w;
	assign next_w = w_in[31:0] + s0 + w_in[319:288] + s1;


	// Block Compression

	// a - 31:0; b - 63:32; c - 95:64; d - 127:96; 
	// e - 159:128; f - 191:160; g - 223:192; h - 255:224

	wire [31:0] S0, S1, maj, ch;
    wire [31:0] temp1, temp2;

	wire [31:0] rot6, rot11, rot25;
	rotate #(.AMOUNT(6)) rotate6(rot6, state_in[159:128]);
	rotate #(.AMOUNT(11)) rotate11(rot11, state_in[159:128]);
	rotate #(.AMOUNT(25)) rotate25(rot25, state_in[159:128]);

	assign S1 = (rot6 ^ rot11 ^ rot25);

	assign ch = ((state_in[159:128] & state_in[191:160]) ^ (~state_in[159:128] & state_in[223:192]));

	assign temp1 = state_in[255:224] + S1 + ch + k + w_in[31:0];

	wire [31:0] rot2, rot13, rot22;
	rotate #(.AMOUNT(2)) rotate2(rot2, state_in[31:0]);
	rotate #(.AMOUNT(13)) rotate13(rot13, state_in[31:0]);
	rotate #(.AMOUNT(22)) rotate22(rot22, state_in[31:0]);
	
	assign S0 = (rot2 ^ rot13 ^ rot22);

	assign maj = ((state_in[31:0] & state_in[63:32]) ^ (state_in[31:0] & state_in[95:64]) ^ (state_in[63:32] & state_in[95:64]));

	assign temp2 = S0 + maj;

	// State Handler
	initial begin
		w_out[511:0] <= 512'b0;
		state_out[255:0] <= 256'b0;
	end

	always @(posedge clock) begin
		w_out[479:0] <= w_in[511:32];
		w_out[511:480] <= next_w;

		state_out[255:224] <= state_in[223:192];
		state_out[223:192] <= state_in[191:160];
		state_out[191:160] <= state_in[159:128];
		state_out[159:128] <= state_in[127:96] + temp1;
		state_out[127:96] <= state_in[95:64];
		state_out[95:64] <= state_in[63:32];
		state_out[63:32] <= state_in[31:0];
		state_out[31:0] <= temp1 + temp2;
	end

	// Debug
	wire [31:0] a, b, c, d, e, f, g, h;

	assign h = state_out[255:224];
	assign g = state_out[223:192];
	assign f = state_out[191:160];
	assign e = state_out[159:128];
	assign d = state_out[127:96];
	assign c = state_out[95:64];
	assign b = state_out[63:32];
	assign a = state_out[31:0];


endmodule

module rotate #(parameter AMOUNT=0, SIZE=32) (q, d);
	input [SIZE-1:0] d;

	output [SIZE-1:0] q;

	assign q = {d[AMOUNT-1:0], d[SIZE-1:AMOUNT]};

endmodule