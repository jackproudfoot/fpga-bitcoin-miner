module SHA256(originalValue, length, hashedValue, clock, 
			  hash0In, hash1In, hash2In, hash3In, hash4In, hash5In, hash6In, hash7In, 
			  hash0Out, hash1Out, hash2Out, hash3Out, hash4Out, hash5Out, hash6Out, hash7Out);

	input clock;
	input [31:0] hash0In, hash1In, hash2In, hash3In, hash4In, hash5In, hash6In, hash7In;
	input [447:0] originalValue;
	input [63:0] length;
	output [31:0] hash0Out, hash1Out, hash2Out, hash3Out, hash4Out, hash5Out, hash6Out, hash7Out;
	output [255:0] hashedValue;


	// 64-element arrays of 32-bit wide reg
	wire [31:0] k [0:63];
	wire [31:0] w [0:63];

	wire [31:0] rot7_16, rot7_17, rot7_18, rot7_19, rot7_20, rot7_21, rot7_22, rot7_23, 
				rot7_24, rot7_25, rot7_26, rot7_27, rot7_28, rot7_29, rot7_30, rot7_31, 
				rot7_32, rot7_33, rot7_34, rot7_35, rot7_36, rot7_37, rot7_38, rot7_39, 
				rot7_40, rot7_41, rot7_42, rot7_43, rot7_44, rot7_45, rot7_46, rot7_47, 
				rot7_48, rot7_49, rot7_50, rot7_51, rot7_52, rot7_53, rot7_54, rot7_55, 
				rot7_56, rot7_57, rot7_58, rot7_59, rot7_60, rot7_61, rot7_62, rot7_63;

	wire [31:0] rot18_16, rot18_17, rot18_18, rot18_19, rot18_20, rot18_21, rot18_22, rot18_23, 
				rot18_24, rot18_25, rot18_26, rot18_27, rot18_28, rot18_29, rot18_30, rot18_31, 
				rot18_32, rot18_33, rot18_34, rot18_35, rot18_36, rot18_37, rot18_38, rot18_39, 
				rot18_40, rot18_41, rot18_42, rot18_43, rot18_44, rot18_45, rot18_46, rot18_47, 
				rot18_48, rot18_49, rot18_50, rot18_51, rot18_52, rot18_53, rot18_54, rot18_55, 
				rot18_56, rot18_57, rot18_58, rot18_59, rot18_60, rot18_61, rot18_62, rot18_63;

	wire [31:0] shift3_16, shift3_17, shift3_18, shift3_19, shift3_20, shift3_21, shift3_22, shift3_23, 
				shift3_24, shift3_25, shift3_26, shift3_27, shift3_28, shift3_29, shift3_30, shift3_31, 
				shift3_32, shift3_33, shift3_34, shift3_35, shift3_36, shift3_37, shift3_38, shift3_39, 
				shift3_40, shift3_41, shift3_42, shift3_43, shift3_44, shift3_45, shift3_46, shift3_47, 
				shift3_48, shift3_49, shift3_50, shift3_51, shift3_52, shift3_53, shift3_54, shift3_55, 
				shift3_56, shift3_57, shift3_58, shift3_59, shift3_60, shift3_61, shift3_62, shift3_63;

	wire [31:0] rot17_16, rot17_17, rot17_18, rot17_19, rot17_20, rot17_21, rot17_22, rot17_23, 
				rot17_24, rot17_25, rot17_26, rot17_27, rot17_28, rot17_29, rot17_30, rot17_31, 
				rot17_32, rot17_33, rot17_34, rot17_35, rot17_36, rot17_37, rot17_38, rot17_39, 
				rot17_40, rot17_41, rot17_42, rot17_43, rot17_44, rot17_45, rot17_46, rot17_47, 
				rot17_48, rot17_49, rot17_50, rot17_51, rot17_52, rot17_53, rot17_54, rot17_55, 
				rot17_56, rot17_57, rot17_58, rot17_59, rot17_60, rot17_61, rot17_62, rot17_63;

	wire [31:0] rot19_16, rot19_17, rot19_18, rot19_19, rot19_20, rot19_21, rot19_22, rot19_23, 
				rot19_24, rot19_25, rot19_26, rot19_27, rot19_28, rot19_29, rot19_30, rot19_31, 
				rot19_32, rot19_33, rot19_34, rot19_35, rot19_36, rot19_37, rot19_38, rot19_39, 
				rot19_40, rot19_41, rot19_42, rot19_43, rot19_44, rot19_45, rot19_46, rot19_47, 
				rot19_48, rot19_49, rot19_50, rot19_51, rot19_52, rot19_53, rot19_54, rot19_55, 
				rot19_56, rot19_57, rot19_58, rot19_59, rot19_60, rot19_61, rot19_62, rot19_63;

	wire [31:0] shift10_16, shift10_17, shift10_18, shift10_19, shift10_20, shift10_21, shift10_22, shift10_23, 
				shift10_24, shift10_25, shift10_26, shift10_27, shift10_28, shift10_29, shift10_30, shift10_31, 
				shift10_32, shift10_33, shift10_34, shift10_35, shift10_36, shift10_37, shift10_38, shift10_39, 
				shift10_40, shift10_41, shift10_42, shift10_43, shift10_44, shift10_45, shift10_46, shift10_47, 
				shift10_48, shift10_49, shift10_50, shift10_51, shift10_52, shift10_53, shift10_54, shift10_55, 
				shift10_56, shift10_57, shift10_58, shift10_59, shift10_60, shift10_61, shift10_62, shift10_63;

	wire [31:0] ch0, ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch8, ch9, ch10, ch11,
				ch12, ch13, ch14, ch15, ch16, ch17, ch18, ch19, ch20, ch21, 
				ch22, ch23, ch24, ch25, ch26, ch27, ch28, ch29, ch30, ch31, 
				ch32, ch33, ch34, ch35, ch36, ch37, ch38, ch39, ch40, ch41, 
				ch42, ch43, ch44, ch45, ch46, ch47, ch48, ch49, ch50, ch51, 
				ch52, ch53, ch54, ch55, ch56, ch57, ch58, ch59, ch60, ch61, 
				ch62, ch63;

	wire [31:0] a0, b0, c0, d0, e0, f0, g0, h0, 
				a1, b1, c1, d1, e1, f1, g1, h1, 
				a2, b2, c2, d2, e2, f2, g2, h2, 
				a3, b3, c3, d3, e3, f3, g3, h3, 
				a4, b4, c4, d4, e4, f4, g4, h4, 
				a5, b5, c5, d5, e5, f5, g5, h5, 
				a6, b6, c6, d6, e6, f6, g6, h6, 
				a7, b7, c7, d7, e7, f7, g7, h7, 
				a8, b8, c8, d8, e8, f8, g8, h8, 
				a9, b9, c9, d9, e9, f9, g9, h9, 
				a10, b10, c10, d10, e10, f10, g10, h10, 
				a11, b11, c11, d11, e11, f11, g11, h11, 
				a12, b12, c12, d12, e12, f12, g12, h12, 
				a13, b13, c13, d13, e13, f13, g13, h13, 
				a14, b14, c14, d14, e14, f14, g14, h14, 
				a15, b15, c15, d15, e15, f15, g15, h15, 
				a16, b16, c16, d16, e16, f16, g16, h16, 
				a17, b17, c17, d17, e17, f17, g17, h17, 
				a18, b18, c18, d18, e18, f18, g18, h18, 
				a19, b19, c19, d19, e19, f19, g19, h19, 
				a20, b20, c20, d20, e20, f20, g20, h20, 
				a21, b21, c21, d21, e21, f21, g21, h21, 
				a22, b22, c22, d22, e22, f22, g22, h22, 
				a23, b23, c23, d23, e23, f23, g23, h23, 
				a24, b24, c24, d24, e24, f24, g24, h24, 
				a25, b25, c25, d25, e25, f25, g25, h25, 
				a26, b26, c26, d26, e26, f26, g26, h26, 
				a27, b27, c27, d27, e27, f27, g27, h27, 
				a28, b28, c28, d28, e28, f28, g28, h28, 
				a29, b29, c29, d29, e29, f29, g29, h29, 
				a30, b30, c30, d30, e30, f30, g30, h30, 
				a31, b31, c31, d31, e31, f31, g31, h31, 
				a32, b32, c32, d32, e32, f32, g32, h32, 
				a33, b33, c33, d33, e33, f33, g33, h33, 
				a34, b34, c34, d34, e34, f34, g34, h34, 
				a35, b35, c35, d35, e35, f35, g35, h35, 
				a36, b36, c36, d36, e36, f36, g36, h36, 
				a37, b37, c37, d37, e37, f37, g37, h37, 
				a38, b38, c38, d38, e38, f38, g38, h38, 
				a39, b39, c39, d39, e39, f39, g39, h39, 
				a40, b40, c40, d40, e40, f40, g40, h40, 
				a41, b41, c41, d41, e41, f41, g41, h41, 
				a42, b42, c42, d42, e42, f42, g42, h42, 
				a43, b43, c43, d43, e43, f43, g43, h43, 
				a44, b44, c44, d44, e44, f44, g44, h44, 
				a45, b45, c45, d45, e45, f45, g45, h45, 
				a46, b46, c46, d46, e46, f46, g46, h46, 
				a47, b47, c47, d47, e47, f47, g47, h47, 
				a48, b48, c48, d48, e48, f48, g48, h48, 
				a49, b49, c49, d49, e49, f49, g49, h49, 
				a50, b50, c50, d50, e50, f50, g50, h50, 
				a51, b51, c51, d51, e51, f51, g51, h51, 
				a52, b52, c52, d52, e52, f52, g52, h52, 
				a53, b53, c53, d53, e53, f53, g53, h53, 
				a54, b54, c54, d54, e54, f54, g54, h54, 
				a55, b55, c55, d55, e55, f55, g55, h55, 
				a56, b56, c56, d56, e56, f56, g56, h56, 
				a57, b57, c57, d57, e57, f57, g57, h57, 
				a58, b58, c58, d58, e58, f58, g58, h58, 
				a59, b59, c59, d59, e59, f59, g59, h59, 
				a60, b60, c60, d60, e60, f60, g60, h60, 
				a61, b61, c61, d61, e61, f61, g61, h61, 
				a62, b62, c62, d62, e62, f62, g62, h62, 
				a63, b63, c63, d63, e63, f63, g63, h63,
				a64, b64, c64, d64, e64, f64, g64, h64;


	wire [31:0] maj0, maj1, maj2, maj3, maj4, maj5, maj6, maj7, maj8,
				maj9, maj10, maj11, maj12, maj13, maj14, maj15, maj16,
				maj17, maj18, maj19, maj20, maj21, maj22, maj23, maj24,
				maj25, maj26, maj27, maj28, maj29, maj30, maj31, maj32,
				maj33, maj34, maj35, maj36, maj37, maj38, maj39, maj40,
				maj41, maj42, maj43, maj44, maj45, maj46, maj47, maj48,
				maj49, maj50, maj51, maj52, maj53, maj54, maj55, maj56,
				maj57, maj58, maj59, maj60, maj61, maj62, maj63;


	wire [31:0] rot6_0, rot6_1, rot6_2, rot6_3, rot6_4, rot6_5, rot6_6, rot6_7, rot6_8,
				rot6_9, rot6_10, rot6_11, rot6_12, rot6_13, rot6_14, rot6_15, rot6_16,
				rot6_17, rot6_18, rot6_19, rot6_20, rot6_21, rot6_22, rot6_23, rot6_24,
				rot6_25, rot6_26, rot6_27, rot6_28, rot6_29, rot6_30, rot6_31, rot6_32,
				rot6_33, rot6_34, rot6_35, rot6_36, rot6_37, rot6_38, rot6_39, rot6_40,
				rot6_41, rot6_42, rot6_43, rot6_44, rot6_45, rot6_46, rot6_47, rot6_48,
				rot6_49, rot6_50, rot6_51, rot6_52, rot6_53, rot6_54, rot6_55, rot6_56,
				rot6_57, rot6_58, rot6_59, rot6_60, rot6_61, rot6_62, rot6_63;

	wire [31:0] rot11_0, rot11_1, rot11_2, rot11_3, rot11_4, rot11_5, rot11_6, rot11_7, rot11_8,
				rot11_9, rot11_10, rot11_11, rot11_12, rot11_13, rot11_14, rot11_15, rot11_16,
				rot11_17, rot11_18, rot11_19, rot11_20, rot11_21, rot11_22, rot11_23, rot11_24,
				rot11_25, rot11_26, rot11_27, rot11_28, rot11_29, rot11_30, rot11_31, rot11_32,
				rot11_33, rot11_34, rot11_35, rot11_36, rot11_37, rot11_38, rot11_39, rot11_40,
				rot11_41, rot11_42, rot11_43, rot11_44, rot11_45, rot11_46, rot11_47, rot11_48,
				rot11_49, rot11_50, rot11_51, rot11_52, rot11_53, rot11_54, rot11_55, rot11_56,
				rot11_57, rot11_58, rot11_59, rot11_60, rot11_61, rot11_62, rot11_63;

	wire [31:0] rot25_0, rot25_1, rot25_2, rot25_3, rot25_4, rot25_5, rot25_6, rot25_7, rot25_8,
				rot25_9, rot25_10, rot25_11, rot25_12, rot25_13, rot25_14, rot25_15, rot25_16,
				rot25_17, rot25_18, rot25_19, rot25_20, rot25_21, rot25_22, rot25_23, rot25_24,
				rot25_25, rot25_26, rot25_27, rot25_28, rot25_29, rot25_30, rot25_31, rot25_32,
				rot25_33, rot25_34, rot25_35, rot25_36, rot25_37, rot25_38, rot25_39, rot25_40,
				rot25_41, rot25_42, rot25_43, rot25_44, rot25_45, rot25_46, rot25_47, rot25_48,
				rot25_49, rot25_50, rot25_51, rot25_52, rot25_53, rot25_54, rot25_55, rot25_56,
				rot25_57, rot25_58, rot25_59, rot25_60, rot25_61, rot25_62, rot25_63;

	wire [31:0] rot2_0, rot2_1, rot2_2, rot2_3, rot2_4, rot2_5, rot2_6, rot2_7, rot2_8,
				rot2_9, rot2_10, rot2_11, rot2_12, rot2_13, rot2_14, rot2_15, rot2_16,
				rot2_17, rot2_18, rot2_19, rot2_20, rot2_21, rot2_22, rot2_23, rot2_24,
				rot2_25, rot2_26, rot2_27, rot2_28, rot2_29, rot2_30, rot2_31, rot2_32,
				rot2_33, rot2_34, rot2_35, rot2_36, rot2_37, rot2_38, rot2_39, rot2_40,
				rot2_41, rot2_42, rot2_43, rot2_44, rot2_45, rot2_46, rot2_47, rot2_48,
				rot2_49, rot2_50, rot2_51, rot2_52, rot2_53, rot2_54, rot2_55, rot2_56,
				rot2_57, rot2_58, rot2_59, rot2_60, rot2_61, rot2_62, rot2_63;

	wire [31:0] rot13_0, rot13_1, rot13_2, rot13_3, rot13_4, rot13_5, rot13_6, rot13_7, rot13_8,
				rot13_9, rot13_10, rot13_11, rot13_12, rot13_13, rot13_14, rot13_15, rot13_16,
				rot13_17, rot13_18, rot13_19, rot13_20, rot13_21, rot13_22, rot13_23, rot13_24,
				rot13_25, rot13_26, rot13_27, rot13_28, rot13_29, rot13_30, rot13_31, rot13_32,
				rot13_33, rot13_34, rot13_35, rot13_36, rot13_37, rot13_38, rot13_39, rot13_40,
				rot13_41, rot13_42, rot13_43, rot13_44, rot13_45, rot13_46, rot13_47, rot13_48,
				rot13_49, rot13_50, rot13_51, rot13_52, rot13_53, rot13_54, rot13_55, rot13_56,
				rot13_57, rot13_58, rot13_59, rot13_60, rot13_61, rot13_62, rot13_63;
	
	wire [31:0] rot22_0, rot22_1, rot22_2, rot22_3, rot22_4, rot22_5, rot22_6, rot22_7, rot22_8,
				rot22_9, rot22_10, rot22_11, rot22_12, rot22_13, rot22_14, rot22_15, rot22_16,
				rot22_17, rot22_18, rot22_19, rot22_20, rot22_21, rot22_22, rot22_23, rot22_24,
				rot22_25, rot22_26, rot22_27, rot22_28, rot22_29, rot22_30, rot22_31, rot22_32,
				rot22_33, rot22_34, rot22_35, rot22_36, rot22_37, rot22_38, rot22_39, rot22_40,
				rot22_41, rot22_42, rot22_43, rot22_44, rot22_45, rot22_46, rot22_47, rot22_48,
				rot22_49, rot22_50, rot22_51, rot22_52, rot22_53, rot22_54, rot22_55, rot22_56,
				rot22_57, rot22_58, rot22_59, rot22_60, rot22_61, rot22_62, rot22_63;

	wire [31:0] hashFinal0, hashFinal1, hashFinal2, hashFinal3, hashFinal4, hashFinal5, hashFinal6, hashFinal7;

	wire [511:0] inputSchedule;

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

	// Pad input
	assign inputSchedule = {originalValue, length};


	// message schedule (w)
	
	assign w[0] = inputSchedule[511:480];
	assign w[1] = inputSchedule[479:448];
	assign w[2] = inputSchedule[447:416];
	assign w[3] = inputSchedule[415:384];
	assign w[4] = inputSchedule[383:352];
	assign w[5] = inputSchedule[351:320];
	assign w[6] = inputSchedule[319:288];
	assign w[7] = inputSchedule[287:256];
	assign w[8] = inputSchedule[255:224];
	assign w[9] = inputSchedule[223:192];
	assign w[10] = inputSchedule[191:160];
	assign w[11] = inputSchedule[159:128];
	assign w[12] = inputSchedule[127:96];
	assign w[13] = inputSchedule[95:64];
	assign w[14] = inputSchedule[63:32];
	assign w[15]= inputSchedule[31:0];

    
    //w16
    assign rot7_16 = {w[1][6:0], w[1][31:7]};
    assign rot18_16 = {w[1][17:0], w[1][31:18]};
	assign shift3_16 = w[1] >> 3;

	assign rot17_16 = {w[14][16:0], w[14][31:17]};
	assign rot19_16 = {w[14][18:0], w[14][31:19]};
	assign shift10_16 = w[14] >> 10;

    wire [31:0] s0_16, s1_16;

	assign s0_16 = (rot7_16 ^ rot18_16 ^ shift3_16);
	assign s1_16 = (rot17_16 ^ rot19_16 ^ shift10_16);
	assign w[16] = w[0] + s0_16 + w[9] + s1_16;
    
    //w17
    assign rot7_17 = {w[2][6:0], w[2][31:7]};
    assign rot18_17 = {w[2][17:0], w[2][31:18]};
	assign shift3_17 = w[2] >> 3;

	assign rot17_17 = {w[15][16:0], w[15][31:17]};
	assign rot19_17 = {w[15][18:0], w[15][31:19]};
	assign shift10_17 = w[15] >> 10;

    wire [31:0] s0_17, s1_17;

	assign s0_17 = (rot7_17 ^ rot18_17 ^ shift3_17);
	assign s1_17 = (rot17_17 ^ rot19_17 ^ shift10_17);
	assign w[17] = w[1] + s0_17 + w[10] + s1_17;
    
    //w18
    assign rot7_18 = {w[3][6:0], w[3][31:7]};
    assign rot18_18 = {w[3][17:0], w[3][31:18]};
	assign shift3_18 = w[3] >> 3;

	assign rot17_18 = {w[16][16:0], w[16][31:17]};
	assign rot19_18 = {w[16][18:0], w[16][31:19]};
	assign shift10_18 = w[16] >> 10;

    wire [31:0] s0_18, s1_18;

	assign s0_18 = (rot7_18 ^ rot18_18 ^ shift3_18);
	assign s1_18 = (rot17_18 ^ rot19_18 ^ shift10_18);
	assign w[18] = w[2] + s0_18 + w[11] + s1_18;
    
    //w19
    assign rot7_19 = {w[4][6:0], w[4][31:7]};
    assign rot18_19 = {w[4][17:0], w[4][31:18]};
	assign shift3_19 = w[4] >> 3;

	assign rot17_19 = {w[17][16:0], w[17][31:17]};
	assign rot19_19 = {w[17][18:0], w[17][31:19]};
	assign shift10_19 = w[17] >> 10;

    wire [31:0] s0_19, s1_19;

	assign s0_19 = (rot7_19 ^ rot18_19 ^ shift3_19);
	assign s1_19 = (rot17_19 ^ rot19_19 ^ shift10_19);
	assign w[19] = w[3] + s0_19 + w[12] + s1_19;
    
    //w20
    assign rot7_20 = {w[5][6:0], w[5][31:7]};
    assign rot18_20 = {w[5][17:0], w[5][31:18]};
	assign shift3_20 = w[5] >> 3;

	assign rot17_20 = {w[18][16:0], w[18][31:17]};
	assign rot19_20 = {w[18][18:0], w[18][31:19]};
	assign shift10_20 = w[18] >> 10;

    wire [31:0] s0_20, s1_20;

	assign s0_20 = (rot7_20 ^ rot18_20 ^ shift3_20);
	assign s1_20 = (rot17_20 ^ rot19_20 ^ shift10_20);
	assign w[20] = w[4] + s0_20 + w[13] + s1_20;
    
    //w21
    assign rot7_21 = {w[6][6:0], w[6][31:7]};
    assign rot18_21 = {w[6][17:0], w[6][31:18]};
	assign shift3_21 = w[6] >> 3;

	assign rot17_21 = {w[19][16:0], w[19][31:17]};
	assign rot19_21 = {w[19][18:0], w[19][31:19]};
	assign shift10_21 = w[19] >> 10;

    wire [31:0] s0_21, s1_21;

	assign s0_21 = (rot7_21 ^ rot18_21 ^ shift3_21);
	assign s1_21 = (rot17_21 ^ rot19_21 ^ shift10_21);
	assign w[21] = w[5] + s0_21 + w[14] + s1_21;
    
    //w22
    assign rot7_22 = {w[7][6:0], w[7][31:7]};
    assign rot18_22 = {w[7][17:0], w[7][31:18]};
	assign shift3_22 = w[7] >> 3;

	assign rot17_22 = {w[20][16:0], w[20][31:17]};
	assign rot19_22 = {w[20][18:0], w[20][31:19]};
	assign shift10_22 = w[20] >> 10;

    wire [31:0] s0_22, s1_22;

	assign s0_22 = (rot7_22 ^ rot18_22 ^ shift3_22);
	assign s1_22 = (rot17_22 ^ rot19_22 ^ shift10_22);
	assign w[22] = w[6] + s0_22 + w[15] + s1_22;
    
    //w23
    assign rot7_23 = {w[8][6:0], w[8][31:7]};
    assign rot18_23 = {w[8][17:0], w[8][31:18]};
	assign shift3_23 = w[8] >> 3;

	assign rot17_23 = {w[21][16:0], w[21][31:17]};
	assign rot19_23 = {w[21][18:0], w[21][31:19]};
	assign shift10_23 = w[21] >> 10;

    wire [31:0] s0_23, s1_23;

	assign s0_23 = (rot7_23 ^ rot18_23 ^ shift3_23);
	assign s1_23 = (rot17_23 ^ rot19_23 ^ shift10_23);
	assign w[23] = w[7] + s0_23 + w[16] + s1_23;
    
    //w24
    assign rot7_24 = {w[9][6:0], w[9][31:7]};
    assign rot18_24 = {w[9][17:0], w[9][31:18]};
	assign shift3_24 = w[9] >> 3;

	assign rot17_24 = {w[22][16:0], w[22][31:17]};
	assign rot19_24 = {w[22][18:0], w[22][31:19]};
	assign shift10_24 = w[22] >> 10;

    wire [31:0] s0_24, s1_24;

	assign s0_24 = (rot7_24 ^ rot18_24 ^ shift3_24);
	assign s1_24 = (rot17_24 ^ rot19_24 ^ shift10_24);
	assign w[24] = w[8] + s0_24 + w[17] + s1_24;
    
    //w25
    assign rot7_25 = {w[10][6:0], w[10][31:7]};
    assign rot18_25 = {w[10][17:0], w[10][31:18]};
	assign shift3_25 = w[10] >> 3;

	assign rot17_25 = {w[23][16:0], w[23][31:17]};
	assign rot19_25 = {w[23][18:0], w[23][31:19]};
	assign shift10_25 = w[23] >> 10;

    wire [31:0] s0_25, s1_25;

	assign s0_25 = (rot7_25 ^ rot18_25 ^ shift3_25);
	assign s1_25 = (rot17_25 ^ rot19_25 ^ shift10_25);
	assign w[25] = w[9] + s0_25 + w[18] + s1_25;
    
    //w26
    assign rot7_26 = {w[11][6:0], w[11][31:7]};
    assign rot18_26 = {w[11][17:0], w[11][31:18]};
	assign shift3_26 = w[11] >> 3;

	assign rot17_26 = {w[24][16:0], w[24][31:17]};
	assign rot19_26 = {w[24][18:0], w[24][31:19]};
	assign shift10_26 = w[24] >> 10;

    wire [31:0] s0_26, s1_26;

	assign s0_26 = (rot7_26 ^ rot18_26 ^ shift3_26);
	assign s1_26 = (rot17_26 ^ rot19_26 ^ shift10_26);
	assign w[26] = w[10] + s0_26 + w[19] + s1_26;
    
    //w27
    assign rot7_27 = {w[12][6:0], w[12][31:7]};
    assign rot18_27 = {w[12][17:0], w[12][31:18]};
	assign shift3_27 = w[12] >> 3;

	assign rot17_27 = {w[25][16:0], w[25][31:17]};
	assign rot19_27 = {w[25][18:0], w[25][31:19]};
	assign shift10_27 = w[25] >> 10;

    wire [31:0] s0_27, s1_27;

	assign s0_27 = (rot7_27 ^ rot18_27 ^ shift3_27);
	assign s1_27 = (rot17_27 ^ rot19_27 ^ shift10_27);
	assign w[27] = w[11] + s0_27 + w[20] + s1_27;
    
    //w28
    assign rot7_28 = {w[13][6:0], w[13][31:7]};
    assign rot18_28 = {w[13][17:0], w[13][31:18]};
	assign shift3_28 = w[13] >> 3;

	assign rot17_28 = {w[26][16:0], w[26][31:17]};
	assign rot19_28 = {w[26][18:0], w[26][31:19]};
	assign shift10_28 = w[26] >> 10;

    wire [31:0] s0_28, s1_28;

	assign s0_28 = (rot7_28 ^ rot18_28 ^ shift3_28);
	assign s1_28 = (rot17_28 ^ rot19_28 ^ shift10_28);
	assign w[28] = w[12] + s0_28 + w[21] + s1_28;
    
    //w29
    assign rot7_29 = {w[14][6:0], w[14][31:7]};
    assign rot18_29 = {w[14][17:0], w[14][31:18]};
	assign shift3_29 = w[14] >> 3;

	assign rot17_29 = {w[27][16:0], w[27][31:17]};
	assign rot19_29 = {w[27][18:0], w[27][31:19]};
	assign shift10_29 = w[27] >> 10;

    wire [31:0] s0_29, s1_29;

	assign s0_29 = (rot7_29 ^ rot18_29 ^ shift3_29);
	assign s1_29 = (rot17_29 ^ rot19_29 ^ shift10_29);
	assign w[29] = w[13] + s0_29 + w[22] + s1_29;
    
    //w30
    assign rot7_30 = {w[15][6:0], w[15][31:7]};
    assign rot18_30 = {w[15][17:0], w[15][31:18]};
	assign shift3_30 = w[15] >> 3;

	assign rot17_30 = {w[28][16:0], w[28][31:17]};
	assign rot19_30 = {w[28][18:0], w[28][31:19]};
	assign shift10_30 = w[28] >> 10;

    wire [31:0] s0_30, s1_30;

	assign s0_30 = (rot7_30 ^ rot18_30 ^ shift3_30);
	assign s1_30 = (rot17_30 ^ rot19_30 ^ shift10_30);
	assign w[30] = w[14] + s0_30 + w[23] + s1_30;
    
    //w31
    assign rot7_31 = {w[16][6:0], w[16][31:7]};
    assign rot18_31 = {w[16][17:0], w[16][31:18]};
	assign shift3_31 = w[16] >> 3;

	assign rot17_31 = {w[29][16:0], w[29][31:17]};
	assign rot19_31 = {w[29][18:0], w[29][31:19]};
	assign shift10_31 = w[29] >> 10;

    wire [31:0] s0_31, s1_31;

	assign s0_31 = (rot7_31 ^ rot18_31 ^ shift3_31);
	assign s1_31 = (rot17_31 ^ rot19_31 ^ shift10_31);
	assign w[31] = w[15] + s0_31 + w[24] + s1_31;
    
    //w32
    assign rot7_32 = {w[17][6:0], w[17][31:7]};
    assign rot18_32 = {w[17][17:0], w[17][31:18]};
	assign shift3_32 = w[17] >> 3;

	assign rot17_32 = {w[30][16:0], w[30][31:17]};
	assign rot19_32 = {w[30][18:0], w[30][31:19]};
	assign shift10_32 = w[30] >> 10;

    wire [31:0] s0_32, s1_32;

	assign s0_32 = (rot7_32 ^ rot18_32 ^ shift3_32);
	assign s1_32 = (rot17_32 ^ rot19_32 ^ shift10_32);
	assign w[32] = w[16] + s0_32 + w[25] + s1_32;
    
    //w33
    assign rot7_33 = {w[18][6:0], w[18][31:7]};
    assign rot18_33 = {w[18][17:0], w[18][31:18]};
	assign shift3_33 = w[18] >> 3;

	assign rot17_33 = {w[31][16:0], w[31][31:17]};
	assign rot19_33 = {w[31][18:0], w[31][31:19]};
	assign shift10_33 = w[31] >> 10;

    wire [31:0] s0_33, s1_33;

	assign s0_33 = (rot7_33 ^ rot18_33 ^ shift3_33);
	assign s1_33 = (rot17_33 ^ rot19_33 ^ shift10_33);
	assign w[33] = w[17] + s0_33 + w[26] + s1_33;
    
    //w34
    assign rot7_34 = {w[19][6:0], w[19][31:7]};
    assign rot18_34 = {w[19][17:0], w[19][31:18]};
	assign shift3_34 = w[19] >> 3;

	assign rot17_34 = {w[32][16:0], w[32][31:17]};
	assign rot19_34 = {w[32][18:0], w[32][31:19]};
	assign shift10_34 = w[32] >> 10;

    wire [31:0] s0_34, s1_34;

	assign s0_34 = (rot7_34 ^ rot18_34 ^ shift3_34);
	assign s1_34 = (rot17_34 ^ rot19_34 ^ shift10_34);
	assign w[34] = w[18] + s0_34 + w[27] + s1_34;
    
    //w35
    assign rot7_35 = {w[20][6:0], w[20][31:7]};
    assign rot18_35 = {w[20][17:0], w[20][31:18]};
	assign shift3_35 = w[20] >> 3;

	assign rot17_35 = {w[33][16:0], w[33][31:17]};
	assign rot19_35 = {w[33][18:0], w[33][31:19]};
	assign shift10_35 = w[33] >> 10;

    wire [31:0] s0_35, s1_35;

	assign s0_35 = (rot7_35 ^ rot18_35 ^ shift3_35);
	assign s1_35 = (rot17_35 ^ rot19_35 ^ shift10_35);
	assign w[35] = w[19] + s0_35 + w[28] + s1_35;
    
    //w36
    assign rot7_36 = {w[21][6:0], w[21][31:7]};
    assign rot18_36 = {w[21][17:0], w[21][31:18]};
	assign shift3_36 = w[21] >> 3;

	assign rot17_36 = {w[34][16:0], w[34][31:17]};
	assign rot19_36 = {w[34][18:0], w[34][31:19]};
	assign shift10_36 = w[34] >> 10;

    wire [31:0] s0_36, s1_36;

	assign s0_36 = (rot7_36 ^ rot18_36 ^ shift3_36);
	assign s1_36 = (rot17_36 ^ rot19_36 ^ shift10_36);
	assign w[36] = w[20] + s0_36 + w[29] + s1_36;
    
    //w37
    assign rot7_37 = {w[22][6:0], w[22][31:7]};
    assign rot18_37 = {w[22][17:0], w[22][31:18]};
	assign shift3_37 = w[22] >> 3;

	assign rot17_37 = {w[35][16:0], w[35][31:17]};
	assign rot19_37 = {w[35][18:0], w[35][31:19]};
	assign shift10_37 = w[35] >> 10;

    wire [31:0] s0_37, s1_37;

	assign s0_37 = (rot7_37 ^ rot18_37 ^ shift3_37);
	assign s1_37 = (rot17_37 ^ rot19_37 ^ shift10_37);
	assign w[37] = w[21] + s0_37 + w[30] + s1_37;
    
    //w38
    assign rot7_38 = {w[23][6:0], w[23][31:7]};
    assign rot18_38 = {w[23][17:0], w[23][31:18]};
	assign shift3_38 = w[23] >> 3;

	assign rot17_38 = {w[36][16:0], w[36][31:17]};
	assign rot19_38 = {w[36][18:0], w[36][31:19]};
	assign shift10_38 = w[36] >> 10;

    wire [31:0] s0_38, s1_38;

	assign s0_38 = (rot7_38 ^ rot18_38 ^ shift3_38);
	assign s1_38 = (rot17_38 ^ rot19_38 ^ shift10_38);
	assign w[38] = w[22] + s0_38 + w[31] + s1_38;
    
    //w39
    assign rot7_39 = {w[24][6:0], w[24][31:7]};
    assign rot18_39 = {w[24][17:0], w[24][31:18]};
	assign shift3_39 = w[24] >> 3;

	assign rot17_39 = {w[37][16:0], w[37][31:17]};
	assign rot19_39 = {w[37][18:0], w[37][31:19]};
	assign shift10_39 = w[37] >> 10;

    wire [31:0] s0_39, s1_39;

	assign s0_39 = (rot7_39 ^ rot18_39 ^ shift3_39);
	assign s1_39 = (rot17_39 ^ rot19_39 ^ shift10_39);
	assign w[39] = w[23] + s0_39 + w[32] + s1_39;
    
    //w40
    assign rot7_40 = {w[25][6:0], w[25][31:7]};
    assign rot18_40 = {w[25][17:0], w[25][31:18]};
	assign shift3_40 = w[25] >> 3;

	assign rot17_40 = {w[38][16:0], w[38][31:17]};
	assign rot19_40 = {w[38][18:0], w[38][31:19]};
	assign shift10_40 = w[38] >> 10;

    wire [31:0] s0_40, s1_40;

	assign s0_40 = (rot7_40 ^ rot18_40 ^ shift3_40);
	assign s1_40 = (rot17_40 ^ rot19_40 ^ shift10_40);
	assign w[40] = w[24] + s0_40 + w[33] + s1_40;
    
    //w41
    assign rot7_41 = {w[26][6:0], w[26][31:7]};
    assign rot18_41 = {w[26][17:0], w[26][31:18]};
	assign shift3_41 = w[26] >> 3;

	assign rot17_41 = {w[39][16:0], w[39][31:17]};
	assign rot19_41 = {w[39][18:0], w[39][31:19]};
	assign shift10_41 = w[39] >> 10;

    wire [31:0] s0_41, s1_41;

	assign s0_41 = (rot7_41 ^ rot18_41 ^ shift3_41);
	assign s1_41 = (rot17_41 ^ rot19_41 ^ shift10_41);
	assign w[41] = w[25] + s0_41 + w[34] + s1_41;
    
    //w42
    assign rot7_42 = {w[27][6:0], w[27][31:7]};
    assign rot18_42 = {w[27][17:0], w[27][31:18]};
	assign shift3_42 = w[27] >> 3;

	assign rot17_42 = {w[40][16:0], w[40][31:17]};
	assign rot19_42 = {w[40][18:0], w[40][31:19]};
	assign shift10_42 = w[40] >> 10;

    wire [31:0] s0_42, s1_42;

	assign s0_42 = (rot7_42 ^ rot18_42 ^ shift3_42);
	assign s1_42 = (rot17_42 ^ rot19_42 ^ shift10_42);
	assign w[42] = w[26] + s0_42 + w[35] + s1_42;
    
    //w43
    assign rot7_43 = {w[28][6:0], w[28][31:7]};
    assign rot18_43 = {w[28][17:0], w[28][31:18]};
	assign shift3_43 = w[28] >> 3;

	assign rot17_43 = {w[41][16:0], w[41][31:17]};
	assign rot19_43 = {w[41][18:0], w[41][31:19]};
	assign shift10_43 = w[41] >> 10;

    wire [31:0] s0_43, s1_43;

	assign s0_43 = (rot7_43 ^ rot18_43 ^ shift3_43);
	assign s1_43 = (rot17_43 ^ rot19_43 ^ shift10_43);
	assign w[43] = w[27] + s0_43 + w[36] + s1_43;
    
    //w44
    assign rot7_44 = {w[29][6:0], w[29][31:7]};
    assign rot18_44 = {w[29][17:0], w[29][31:18]};
	assign shift3_44 = w[29] >> 3;

	assign rot17_44 = {w[42][16:0], w[42][31:17]};
	assign rot19_44 = {w[42][18:0], w[42][31:19]};
	assign shift10_44 = w[42] >> 10;

    wire [31:0] s0_44, s1_44;

	assign s0_44 = (rot7_44 ^ rot18_44 ^ shift3_44);
	assign s1_44 = (rot17_44 ^ rot19_44 ^ shift10_44);
	assign w[44] = w[28] + s0_44 + w[37] + s1_44;
    
    //w45
    assign rot7_45 = {w[30][6:0], w[30][31:7]};
    assign rot18_45 = {w[30][17:0], w[30][31:18]};
	assign shift3_45 = w[30] >> 3;

	assign rot17_45 = {w[43][16:0], w[43][31:17]};
	assign rot19_45 = {w[43][18:0], w[43][31:19]};
	assign shift10_45 = w[43] >> 10;

    wire [31:0] s0_45, s1_45;

	assign s0_45 = (rot7_45 ^ rot18_45 ^ shift3_45);
	assign s1_45 = (rot17_45 ^ rot19_45 ^ shift10_45);
	assign w[45] = w[29] + s0_45 + w[38] + s1_45;
    
    //w46
    assign rot7_46 = {w[31][6:0], w[31][31:7]};
    assign rot18_46 = {w[31][17:0], w[31][31:18]};
	assign shift3_46 = w[31] >> 3;

	assign rot17_46 = {w[44][16:0], w[44][31:17]};
	assign rot19_46 = {w[44][18:0], w[44][31:19]};
	assign shift10_46 = w[44] >> 10;

    wire [31:0] s0_46, s1_46;

	assign s0_46 = (rot7_46 ^ rot18_46 ^ shift3_46);
	assign s1_46 = (rot17_46 ^ rot19_46 ^ shift10_46);
	assign w[46] = w[30] + s0_46 + w[39] + s1_46;
    
    //w47
    assign rot7_47 = {w[32][6:0], w[32][31:7]};
    assign rot18_47 = {w[32][17:0], w[32][31:18]};
	assign shift3_47 = w[32] >> 3;

	assign rot17_47 = {w[45][16:0], w[45][31:17]};
	assign rot19_47 = {w[45][18:0], w[45][31:19]};
	assign shift10_47 = w[45] >> 10;

    wire [31:0] s0_47, s1_47;

	assign s0_47 = (rot7_47 ^ rot18_47 ^ shift3_47);
	assign s1_47 = (rot17_47 ^ rot19_47 ^ shift10_47);
	assign w[47] = w[31] + s0_47 + w[40] + s1_47;
    
    //w48
    assign rot7_48 = {w[33][6:0], w[33][31:7]};
    assign rot18_48 = {w[33][17:0], w[33][31:18]};
	assign shift3_48 = w[33] >> 3;

	assign rot17_48 = {w[46][16:0], w[46][31:17]};
	assign rot19_48 = {w[46][18:0], w[46][31:19]};
	assign shift10_48 = w[46] >> 10;

    wire [31:0] s0_48, s1_48;

	assign s0_48 = (rot7_48 ^ rot18_48 ^ shift3_48);
	assign s1_48 = (rot17_48 ^ rot19_48 ^ shift10_48);
	assign w[48] = w[32] + s0_48 + w[41] + s1_48;
    
    //w49
    assign rot7_49 = {w[34][6:0], w[34][31:7]};
    assign rot18_49 = {w[34][17:0], w[34][31:18]};
	assign shift3_49 = w[34] >> 3;

	assign rot17_49 = {w[47][16:0], w[47][31:17]};
	assign rot19_49 = {w[47][18:0], w[47][31:19]};
	assign shift10_49 = w[47] >> 10;

    wire [31:0] s0_49, s1_49;

	assign s0_49 = (rot7_49 ^ rot18_49 ^ shift3_49);
	assign s1_49 = (rot17_49 ^ rot19_49 ^ shift10_49);
	assign w[49] = w[33] + s0_49 + w[42] + s1_49;
    
    //w50
    assign rot7_50 = {w[35][6:0], w[35][31:7]};
    assign rot18_50 = {w[35][17:0], w[35][31:18]};
	assign shift3_50 = w[35] >> 3;

	assign rot17_50 = {w[48][16:0], w[48][31:17]};
	assign rot19_50 = {w[48][18:0], w[48][31:19]};
	assign shift10_50 = w[48] >> 10;

    wire [31:0] s0_50, s1_50;

	assign s0_50 = (rot7_50 ^ rot18_50 ^ shift3_50);
	assign s1_50 = (rot17_50 ^ rot19_50 ^ shift10_50);
	assign w[50] = w[34] + s0_50 + w[43] + s1_50;
    
    //w51
    assign rot7_51 = {w[36][6:0], w[36][31:7]};
    assign rot18_51 = {w[36][17:0], w[36][31:18]};
	assign shift3_51 = w[36] >> 3;

	assign rot17_51 = {w[49][16:0], w[49][31:17]};
	assign rot19_51 = {w[49][18:0], w[49][31:19]};
	assign shift10_51 = w[49] >> 10;

    wire [31:0] s0_51, s1_51;

	assign s0_51 = (rot7_51 ^ rot18_51 ^ shift3_51);
	assign s1_51 = (rot17_51 ^ rot19_51 ^ shift10_51);
	assign w[51] = w[35] + s0_51 + w[44] + s1_51;
    
    //w52
    assign rot7_52 = {w[37][6:0], w[37][31:7]};
    assign rot18_52 = {w[37][17:0], w[37][31:18]};
	assign shift3_52 = w[37] >> 3;

	assign rot17_52 = {w[50][16:0], w[50][31:17]};
	assign rot19_52 = {w[50][18:0], w[50][31:19]};
	assign shift10_52 = w[50] >> 10;

    wire [31:0] s0_52, s1_52;

	assign s0_52 = (rot7_52 ^ rot18_52 ^ shift3_52);
	assign s1_52 = (rot17_52 ^ rot19_52 ^ shift10_52);
	assign w[52] = w[36] + s0_52 + w[45] + s1_52;
    
    //w53
    assign rot7_53 = {w[38][6:0], w[38][31:7]};
    assign rot18_53 = {w[38][17:0], w[38][31:18]};
	assign shift3_53 = w[38] >> 3;

	assign rot17_53 = {w[51][16:0], w[51][31:17]};
	assign rot19_53 = {w[51][18:0], w[51][31:19]};
	assign shift10_53 = w[51] >> 10;

    wire [31:0] s0_53, s1_53;

	assign s0_53 = (rot7_53 ^ rot18_53 ^ shift3_53);
	assign s1_53 = (rot17_53 ^ rot19_53 ^ shift10_53);
	assign w[53] = w[37] + s0_53 + w[46] + s1_53;
    
    //w54
    assign rot7_54 = {w[39][6:0], w[39][31:7]};
    assign rot18_54 = {w[39][17:0], w[39][31:18]};
	assign shift3_54 = w[39] >> 3;

	assign rot17_54 = {w[52][16:0], w[52][31:17]};
	assign rot19_54 = {w[52][18:0], w[52][31:19]};
	assign shift10_54 = w[52] >> 10;

    wire [31:0] s0_54, s1_54;

	assign s0_54 = (rot7_54 ^ rot18_54 ^ shift3_54);
	assign s1_54 = (rot17_54 ^ rot19_54 ^ shift10_54);
	assign w[54] = w[38] + s0_54 + w[47] + s1_54;
    
    //w55
    assign rot7_55 = {w[40][6:0], w[40][31:7]};
    assign rot18_55 = {w[40][17:0], w[40][31:18]};
	assign shift3_55 = w[40] >> 3;

	assign rot17_55 = {w[53][16:0], w[53][31:17]};
	assign rot19_55 = {w[53][18:0], w[53][31:19]};
	assign shift10_55 = w[53] >> 10;

    wire [31:0] s0_55, s1_55;

	assign s0_55 = (rot7_55 ^ rot18_55 ^ shift3_55);
	assign s1_55 = (rot17_55 ^ rot19_55 ^ shift10_55);
	assign w[55] = w[39] + s0_55 + w[48] + s1_55;
    
    //w56
    assign rot7_56 = {w[41][6:0], w[41][31:7]};
    assign rot18_56 = {w[41][17:0], w[41][31:18]};
	assign shift3_56 = w[41] >> 3;

	assign rot17_56 = {w[54][16:0], w[54][31:17]};
	assign rot19_56 = {w[54][18:0], w[54][31:19]};
	assign shift10_56 = w[54] >> 10;

    wire [31:0] s0_56, s1_56;

	assign s0_56 = (rot7_56 ^ rot18_56 ^ shift3_56);
	assign s1_56 = (rot17_56 ^ rot19_56 ^ shift10_56);
	assign w[56] = w[40] + s0_56 + w[49] + s1_56;
    
    //w57
    assign rot7_57 = {w[42][6:0], w[42][31:7]};
    assign rot18_57 = {w[42][17:0], w[42][31:18]};
	assign shift3_57 = w[42] >> 3;

	assign rot17_57 = {w[55][16:0], w[55][31:17]};
	assign rot19_57 = {w[55][18:0], w[55][31:19]};
	assign shift10_57 = w[55] >> 10;

    wire [31:0] s0_57, s1_57;

	assign s0_57 = (rot7_57 ^ rot18_57 ^ shift3_57);
	assign s1_57 = (rot17_57 ^ rot19_57 ^ shift10_57);
	assign w[57] = w[41] + s0_57 + w[50] + s1_57;
    
    //w58
    assign rot7_58 = {w[43][6:0], w[43][31:7]};
    assign rot18_58 = {w[43][17:0], w[43][31:18]};
	assign shift3_58 = w[43] >> 3;

	assign rot17_58 = {w[56][16:0], w[56][31:17]};
	assign rot19_58 = {w[56][18:0], w[56][31:19]};
	assign shift10_58 = w[56] >> 10;

    wire [31:0] s0_58, s1_58;

	assign s0_58 = (rot7_58 ^ rot18_58 ^ shift3_58);
	assign s1_58 = (rot17_58 ^ rot19_58 ^ shift10_58);
	assign w[58] = w[42] + s0_58 + w[51] + s1_58;
    
    //w59
    assign rot7_59 = {w[44][6:0], w[44][31:7]};
    assign rot18_59 = {w[44][17:0], w[44][31:18]};
	assign shift3_59 = w[44] >> 3;

	assign rot17_59 = {w[57][16:0], w[57][31:17]};
	assign rot19_59 = {w[57][18:0], w[57][31:19]};
	assign shift10_59 = w[57] >> 10;

    wire [31:0] s0_59, s1_59;

	assign s0_59 = (rot7_59 ^ rot18_59 ^ shift3_59);
	assign s1_59 = (rot17_59 ^ rot19_59 ^ shift10_59);
	assign w[59] = w[43] + s0_59 + w[52] + s1_59;
    
    //w60
    assign rot7_60 = {w[45][6:0], w[45][31:7]};
    assign rot18_60 = {w[45][17:0], w[45][31:18]};
	assign shift3_60 = w[45] >> 3;

	assign rot17_60 = {w[58][16:0], w[58][31:17]};
	assign rot19_60 = {w[58][18:0], w[58][31:19]};
	assign shift10_60 = w[58] >> 10;

    wire [31:0] s0_60, s1_60;

	assign s0_60 = (rot7_60 ^ rot18_60 ^ shift3_60);
	assign s1_60 = (rot17_60 ^ rot19_60 ^ shift10_60);
	assign w[60] = w[44] + s0_60 + w[53] + s1_60;
    
    //w61
    assign rot7_61 = {w[46][6:0], w[46][31:7]};
    assign rot18_61 = {w[46][17:0], w[46][31:18]};
	assign shift3_61 = w[46] >> 3;

	assign rot17_61 = {w[59][16:0], w[59][31:17]};
	assign rot19_61 = {w[59][18:0], w[59][31:19]};
	assign shift10_61 = w[59] >> 10;

    wire [31:0] s0_61, s1_61;

	assign s0_61 = (rot7_61 ^ rot18_61 ^ shift3_61);
	assign s1_61 = (rot17_61 ^ rot19_61 ^ shift10_61);
	assign w[61] = w[45] + s0_61 + w[54] + s1_61;
    
    //w62
    assign rot7_62 = {w[47][6:0], w[47][31:7]};
    assign rot18_62 = {w[47][17:0], w[47][31:18]};
	assign shift3_62 = w[47] >> 3;

	assign rot17_62 = {w[60][16:0], w[60][31:17]};
	assign rot19_62 = {w[60][18:0], w[60][31:19]};
	assign shift10_62 = w[60] >> 10;

    wire [31:0] s0_62, s1_62;

	assign s0_62 = (rot7_62 ^ rot18_62 ^ shift3_62);
	assign s1_62 = (rot17_62 ^ rot19_62 ^ shift10_62);
	assign w[62] = w[46] + s0_62 + w[55] + s1_62;
    
    //w63
    assign rot7_63 = {w[48][6:0], w[48][31:7]};
    assign rot18_63 = {w[48][17:0], w[48][31:18]};
	assign shift3_63 = w[48] >> 3;

	assign rot17_63 = {w[61][16:0], w[61][31:17]};
	assign rot19_63 = {w[61][18:0], w[61][31:19]};
	assign shift10_63 = w[61] >> 10;

    wire [31:0] s0_63, s1_63;

	assign s0_63 = (rot7_63 ^ rot18_63 ^ shift3_63);
	assign s1_63 = (rot17_63 ^ rot19_63 ^ shift10_63);
	assign w[63] = w[47] + s0_63 + w[56] + s1_63;

	// Compression

	assign a0 = hash0In;
	assign b0 = hash1In;
	assign c0 = hash2In;
	assign d0 = hash3In;
	assign e0 = hash4In;
	assign f0 = hash5In;
	assign g0 = hash6In;
	assign h0 = hash7In;

	// // Compress block 0

	// assign rot6_0 = {e0[5:0], e0[31:6]};
	// assign rot11_0 = {e0[10:0], e0[31:11]};
	// assign rot25_0 = {e0[24:0], e0[31:25]};
	// assign S1 = (rot6_0 ^ rot11_0 ^ rot25_0);

	// assign ch0 = ((e0 & f0) ^ (~e0 & g0));

	// assign temp1 = h0 + S1 + ch0 + k[0] + w[0];

	// assign rot2_0 = {a0[1:0], a0[31:2]};
	// assign rot13_0 = {a0[12:0], a0[31:13]};
	// assign rot22_0 = {a0[21:0], a0[31:22]};
	// assign S0 = (rot2_0 ^ rot13_0 ^ rot22_0);

	// assign maj0 = ((a0 & b0) ^ (a0 & c0) ^ (b0 & c0));

	// assign temp2 = S0 + maj0;

	// assign h1 = g0;
	// assign g1 = f0;
	// assign f1 = e0;
	// assign e1 = d0 + temp1;
	// assign d1 = c0;
	// assign c1 = b0;
	// assign b1 = a0;
	// assign a1 = temp1 + temp2;


    
    
    // compress block 0
    wire [31:0] S0_0, S1_0;
    wire [31:0] temp1_0, temp2_0;

    assign rot6_0 = {e0[5:0], e0[31:6]};
	assign rot11_0 = {e0[10:0], e0[31:11]};
	assign rot25_0 = {e0[24:0], e0[31:25]};
	assign S1_0 = (rot6_0 ^ rot11_0 ^ rot25_0);

	assign ch0 = ((e0 & f0) ^ (~e0 & g0));

	assign temp1_0 = h0 + S1_0 + ch0 + k[0] + w[0];

	assign rot2_0 = {a0[1:0], a0[31:2]};
	assign rot13_0 = {a0[12:0], a0[31:13]};
	assign rot22_0 = {a0[21:0], a0[31:22]};
	assign S0_0 = (rot2_0 ^ rot13_0 ^ rot22_0);

	assign maj0 = ((a0 & b0) ^ (a0 & c0) ^ (b0 & c0));

	assign temp2_0 = S0_0 + maj0;

	assign h1 = g0;
	assign g1 = f0;
	assign f1 = e0;
	assign e1 = d0 + temp1_0;
	assign d1 = c0;
	assign c1 = b0;
	assign b1 = a0;
	assign a1 = temp1_0 + temp2_0;
    
    // compress block 1
    wire [31:0] S0_1, S1_1;
    wire [31:0] temp1_1, temp2_1;

    assign rot6_1 = {e1[5:0], e1[31:6]};
	assign rot11_1 = {e1[10:0], e1[31:11]};
	assign rot25_1 = {e1[24:0], e1[31:25]};
	assign S1_1 = (rot6_1 ^ rot11_1 ^ rot25_1);

	assign ch1 = ((e1 & f1) ^ (~e1 & g1));

	assign temp1_1 = h1 + S1_1 + ch1 + k[1] + w[1];

	assign rot2_1 = {a1[1:0], a1[31:2]};
	assign rot13_1 = {a1[12:0], a1[31:13]};
	assign rot22_1 = {a1[21:0], a1[31:22]};
	assign S0_1 = (rot2_1 ^ rot13_1 ^ rot22_1);

	assign maj1 = ((a1 & b1) ^ (a1 & c1) ^ (b1 & c1));

	assign temp2_1 = S0_1 + maj1;

	assign h2 = g1;
	assign g2 = f1;
	assign f2 = e1;
	assign e2 = d1 + temp1_1;
	assign d2 = c1;
	assign c2 = b1;
	assign b2 = a1;
	assign a2 = temp1_1 + temp2_1;
    
    // compress block 2
    wire [31:0] S0_2, S1_2;
    wire [31:0] temp1_2, temp2_2;

    assign rot6_2 = {e2[5:0], e2[31:6]};
	assign rot11_2 = {e2[10:0], e2[31:11]};
	assign rot25_2 = {e2[24:0], e2[31:25]};
	assign S1_2 = (rot6_2 ^ rot11_2 ^ rot25_2);

	assign ch2 = ((e2 & f2) ^ (~e2 & g2));

	assign temp1_2 = h2 + S1_2 + ch2 + k[2] + w[2];

	assign rot2_2 = {a2[1:0], a2[31:2]};
	assign rot13_2 = {a2[12:0], a2[31:13]};
	assign rot22_2 = {a2[21:0], a2[31:22]};
	assign S0_2 = (rot2_2 ^ rot13_2 ^ rot22_2);

	assign maj2 = ((a2 & b2) ^ (a2 & c2) ^ (b2 & c2));

	assign temp2_2 = S0_2 + maj2;

	assign h3 = g2;
	assign g3 = f2;
	assign f3 = e2;
	assign e3 = d2 + temp1_2;
	assign d3 = c2;
	assign c3 = b2;
	assign b3 = a2;
	assign a3 = temp1_2 + temp2_2;
    
    // compress block 3
    wire [31:0] S0_3, S1_3;
    wire [31:0] temp1_3, temp2_3;

    assign rot6_3 = {e3[5:0], e3[31:6]};
	assign rot11_3 = {e3[10:0], e3[31:11]};
	assign rot25_3 = {e3[24:0], e3[31:25]};
	assign S1_3 = (rot6_3 ^ rot11_3 ^ rot25_3);

	assign ch3 = ((e3 & f3) ^ (~e3 & g3));

	assign temp1_3 = h3 + S1_3 + ch3 + k[3] + w[3];

	assign rot2_3 = {a3[1:0], a3[31:2]};
	assign rot13_3 = {a3[12:0], a3[31:13]};
	assign rot22_3 = {a3[21:0], a3[31:22]};
	assign S0_3 = (rot2_3 ^ rot13_3 ^ rot22_3);

	assign maj3 = ((a3 & b3) ^ (a3 & c3) ^ (b3 & c3));

	assign temp2_3 = S0_3 + maj3;

	assign h4 = g3;
	assign g4 = f3;
	assign f4 = e3;
	assign e4 = d3 + temp1_3;
	assign d4 = c3;
	assign c4 = b3;
	assign b4 = a3;
	assign a4 = temp1_3 + temp2_3;
    
    // compress block 4
    wire [31:0] S0_4, S1_4;
    wire [31:0] temp1_4, temp2_4;

    assign rot6_4 = {e4[5:0], e4[31:6]};
	assign rot11_4 = {e4[10:0], e4[31:11]};
	assign rot25_4 = {e4[24:0], e4[31:25]};
	assign S1_4 = (rot6_4 ^ rot11_4 ^ rot25_4);

	assign ch4 = ((e4 & f4) ^ (~e4 & g4));

	assign temp1_4 = h4 + S1_4 + ch4 + k[4] + w[4];

	assign rot2_4 = {a4[1:0], a4[31:2]};
	assign rot13_4 = {a4[12:0], a4[31:13]};
	assign rot22_4 = {a4[21:0], a4[31:22]};
	assign S0_4 = (rot2_4 ^ rot13_4 ^ rot22_4);

	assign maj4 = ((a4 & b4) ^ (a4 & c4) ^ (b4 & c4));

	assign temp2_4 = S0_4 + maj4;

	assign h5 = g4;
	assign g5 = f4;
	assign f5 = e4;
	assign e5 = d4 + temp1_4;
	assign d5 = c4;
	assign c5 = b4;
	assign b5 = a4;
	assign a5 = temp1_4 + temp2_4;
    
    // compress block 5
    wire [31:0] S0_5, S1_5;
    wire [31:0] temp1_5, temp2_5;

    assign rot6_5 = {e5[5:0], e5[31:6]};
	assign rot11_5 = {e5[10:0], e5[31:11]};
	assign rot25_5 = {e5[24:0], e5[31:25]};
	assign S1_5 = (rot6_5 ^ rot11_5 ^ rot25_5);

	assign ch5 = ((e5 & f5) ^ (~e5 & g5));

	assign temp1_5 = h5 + S1_5 + ch5 + k[5] + w[5];

	assign rot2_5 = {a5[1:0], a5[31:2]};
	assign rot13_5 = {a5[12:0], a5[31:13]};
	assign rot22_5 = {a5[21:0], a5[31:22]};
	assign S0_5 = (rot2_5 ^ rot13_5 ^ rot22_5);

	assign maj5 = ((a5 & b5) ^ (a5 & c5) ^ (b5 & c5));

	assign temp2_5 = S0_5 + maj5;

	assign h6 = g5;
	assign g6 = f5;
	assign f6 = e5;
	assign e6 = d5 + temp1_5;
	assign d6 = c5;
	assign c6 = b5;
	assign b6 = a5;
	assign a6 = temp1_5 + temp2_5;
    
    // compress block 6
    wire [31:0] S0_6, S1_6;
    wire [31:0] temp1_6, temp2_6;

    assign rot6_6 = {e6[5:0], e6[31:6]};
	assign rot11_6 = {e6[10:0], e6[31:11]};
	assign rot25_6 = {e6[24:0], e6[31:25]};
	assign S1_6 = (rot6_6 ^ rot11_6 ^ rot25_6);

	assign ch6 = ((e6 & f6) ^ (~e6 & g6));

	assign temp1_6 = h6 + S1_6 + ch6 + k[6] + w[6];

	assign rot2_6 = {a6[1:0], a6[31:2]};
	assign rot13_6 = {a6[12:0], a6[31:13]};
	assign rot22_6 = {a6[21:0], a6[31:22]};
	assign S0_6 = (rot2_6 ^ rot13_6 ^ rot22_6);

	assign maj6 = ((a6 & b6) ^ (a6 & c6) ^ (b6 & c6));

	assign temp2_6 = S0_6 + maj6;

	assign h7 = g6;
	assign g7 = f6;
	assign f7 = e6;
	assign e7 = d6 + temp1_6;
	assign d7 = c6;
	assign c7 = b6;
	assign b7 = a6;
	assign a7 = temp1_6 + temp2_6;
    
    // compress block 7
    wire [31:0] S0_7, S1_7;
    wire [31:0] temp1_7, temp2_7;

    assign rot6_7 = {e7[5:0], e7[31:6]};
	assign rot11_7 = {e7[10:0], e7[31:11]};
	assign rot25_7 = {e7[24:0], e7[31:25]};
	assign S1_7 = (rot6_7 ^ rot11_7 ^ rot25_7);

	assign ch7 = ((e7 & f7) ^ (~e7 & g7));

	assign temp1_7 = h7 + S1_7 + ch7 + k[7] + w[7];

	assign rot2_7 = {a7[1:0], a7[31:2]};
	assign rot13_7 = {a7[12:0], a7[31:13]};
	assign rot22_7 = {a7[21:0], a7[31:22]};
	assign S0_7 = (rot2_7 ^ rot13_7 ^ rot22_7);

	assign maj7 = ((a7 & b7) ^ (a7 & c7) ^ (b7 & c7));

	assign temp2_7 = S0_7 + maj7;

	assign h8 = g7;
	assign g8 = f7;
	assign f8 = e7;
	assign e8 = d7 + temp1_7;
	assign d8 = c7;
	assign c8 = b7;
	assign b8 = a7;
	assign a8 = temp1_7 + temp2_7;
    
    // compress block 8
    wire [31:0] S0_8, S1_8;
    wire [31:0] temp1_8, temp2_8;

    assign rot6_8 = {e8[5:0], e8[31:6]};
	assign rot11_8 = {e8[10:0], e8[31:11]};
	assign rot25_8 = {e8[24:0], e8[31:25]};
	assign S1_8 = (rot6_8 ^ rot11_8 ^ rot25_8);

	assign ch8 = ((e8 & f8) ^ (~e8 & g8));

	assign temp1_8 = h8 + S1_8 + ch8 + k[8] + w[8];

	assign rot2_8 = {a8[1:0], a8[31:2]};
	assign rot13_8 = {a8[12:0], a8[31:13]};
	assign rot22_8 = {a8[21:0], a8[31:22]};
	assign S0_8 = (rot2_8 ^ rot13_8 ^ rot22_8);

	assign maj8 = ((a8 & b8) ^ (a8 & c8) ^ (b8 & c8));

	assign temp2_8 = S0_8 + maj8;

	assign h9 = g8;
	assign g9 = f8;
	assign f9 = e8;
	assign e9 = d8 + temp1_8;
	assign d9 = c8;
	assign c9 = b8;
	assign b9 = a8;
	assign a9 = temp1_8 + temp2_8;
    
    // compress block 9
    wire [31:0] S0_9, S1_9;
    wire [31:0] temp1_9, temp2_9;

    assign rot6_9 = {e9[5:0], e9[31:6]};
	assign rot11_9 = {e9[10:0], e9[31:11]};
	assign rot25_9 = {e9[24:0], e9[31:25]};
	assign S1_9 = (rot6_9 ^ rot11_9 ^ rot25_9);

	assign ch9 = ((e9 & f9) ^ (~e9 & g9));

	assign temp1_9 = h9 + S1_9 + ch9 + k[9] + w[9];

	assign rot2_9 = {a9[1:0], a9[31:2]};
	assign rot13_9 = {a9[12:0], a9[31:13]};
	assign rot22_9 = {a9[21:0], a9[31:22]};
	assign S0_9 = (rot2_9 ^ rot13_9 ^ rot22_9);

	assign maj9 = ((a9 & b9) ^ (a9 & c9) ^ (b9 & c9));

	assign temp2_9 = S0_9 + maj9;

	assign h10 = g9;
	assign g10 = f9;
	assign f10 = e9;
	assign e10 = d9 + temp1_9;
	assign d10 = c9;
	assign c10 = b9;
	assign b10 = a9;
	assign a10 = temp1_9 + temp2_9;
    
    // compress block 10
    wire [31:0] S0_10, S1_10;
    wire [31:0] temp1_10, temp2_10;

    assign rot6_10 = {e10[5:0], e10[31:6]};
	assign rot11_10 = {e10[10:0], e10[31:11]};
	assign rot25_10 = {e10[24:0], e10[31:25]};
	assign S1_10 = (rot6_10 ^ rot11_10 ^ rot25_10);

	assign ch10 = ((e10 & f10) ^ (~e10 & g10));

	assign temp1_10 = h10 + S1_10 + ch10 + k[10] + w[10];

	assign rot2_10 = {a10[1:0], a10[31:2]};
	assign rot13_10 = {a10[12:0], a10[31:13]};
	assign rot22_10 = {a10[21:0], a10[31:22]};
	assign S0_10 = (rot2_10 ^ rot13_10 ^ rot22_10);

	assign maj10 = ((a10 & b10) ^ (a10 & c10) ^ (b10 & c10));

	assign temp2_10 = S0_10 + maj10;

	assign h11 = g10;
	assign g11 = f10;
	assign f11 = e10;
	assign e11 = d10 + temp1_10;
	assign d11 = c10;
	assign c11 = b10;
	assign b11 = a10;
	assign a11 = temp1_10 + temp2_10;
    
    // compress block 11
    wire [31:0] S0_11, S1_11;
    wire [31:0] temp1_11, temp2_11;

    assign rot6_11 = {e11[5:0], e11[31:6]};
	assign rot11_11 = {e11[10:0], e11[31:11]};
	assign rot25_11 = {e11[24:0], e11[31:25]};
	assign S1_11 = (rot6_11 ^ rot11_11 ^ rot25_11);

	assign ch11 = ((e11 & f11) ^ (~e11 & g11));

	assign temp1_11 = h11 + S1_11 + ch11 + k[11] + w[11];

	assign rot2_11 = {a11[1:0], a11[31:2]};
	assign rot13_11 = {a11[12:0], a11[31:13]};
	assign rot22_11 = {a11[21:0], a11[31:22]};
	assign S0_11 = (rot2_11 ^ rot13_11 ^ rot22_11);

	assign maj11 = ((a11 & b11) ^ (a11 & c11) ^ (b11 & c11));

	assign temp2_11 = S0_11 + maj11;

	assign h12 = g11;
	assign g12 = f11;
	assign f12 = e11;
	assign e12 = d11 + temp1_11;
	assign d12 = c11;
	assign c12 = b11;
	assign b12 = a11;
	assign a12 = temp1_11 + temp2_11;
    
    // compress block 12
    wire [31:0] S0_12, S1_12;
    wire [31:0] temp1_12, temp2_12;

    assign rot6_12 = {e12[5:0], e12[31:6]};
	assign rot11_12 = {e12[10:0], e12[31:11]};
	assign rot25_12 = {e12[24:0], e12[31:25]};
	assign S1_12 = (rot6_12 ^ rot11_12 ^ rot25_12);

	assign ch12 = ((e12 & f12) ^ (~e12 & g12));

	assign temp1_12 = h12 + S1_12 + ch12 + k[12] + w[12];

	assign rot2_12 = {a12[1:0], a12[31:2]};
	assign rot13_12 = {a12[12:0], a12[31:13]};
	assign rot22_12 = {a12[21:0], a12[31:22]};
	assign S0_12 = (rot2_12 ^ rot13_12 ^ rot22_12);

	assign maj12 = ((a12 & b12) ^ (a12 & c12) ^ (b12 & c12));

	assign temp2_12 = S0_12 + maj12;

	assign h13 = g12;
	assign g13 = f12;
	assign f13 = e12;
	assign e13 = d12 + temp1_12;
	assign d13 = c12;
	assign c13 = b12;
	assign b13 = a12;
	assign a13 = temp1_12 + temp2_12;
    
    // compress block 13
    wire [31:0] S0_13, S1_13;
    wire [31:0] temp1_13, temp2_13;

    assign rot6_13 = {e13[5:0], e13[31:6]};
	assign rot11_13 = {e13[10:0], e13[31:11]};
	assign rot25_13 = {e13[24:0], e13[31:25]};
	assign S1_13 = (rot6_13 ^ rot11_13 ^ rot25_13);

	assign ch13 = ((e13 & f13) ^ (~e13 & g13));

	assign temp1_13 = h13 + S1_13 + ch13 + k[13] + w[13];

	assign rot2_13 = {a13[1:0], a13[31:2]};
	assign rot13_13 = {a13[12:0], a13[31:13]};
	assign rot22_13 = {a13[21:0], a13[31:22]};
	assign S0_13 = (rot2_13 ^ rot13_13 ^ rot22_13);

	assign maj13 = ((a13 & b13) ^ (a13 & c13) ^ (b13 & c13));

	assign temp2_13 = S0_13 + maj13;

	assign h14 = g13;
	assign g14 = f13;
	assign f14 = e13;
	assign e14 = d13 + temp1_13;
	assign d14 = c13;
	assign c14 = b13;
	assign b14 = a13;
	assign a14 = temp1_13 + temp2_13;
    
    // compress block 14
    wire [31:0] S0_14, S1_14;
    wire [31:0] temp1_14, temp2_14;

    assign rot6_14 = {e14[5:0], e14[31:6]};
	assign rot11_14 = {e14[10:0], e14[31:11]};
	assign rot25_14 = {e14[24:0], e14[31:25]};
	assign S1_14 = (rot6_14 ^ rot11_14 ^ rot25_14);

	assign ch14 = ((e14 & f14) ^ (~e14 & g14));

	assign temp1_14 = h14 + S1_14 + ch14 + k[14] + w[14];

	assign rot2_14 = {a14[1:0], a14[31:2]};
	assign rot13_14 = {a14[12:0], a14[31:13]};
	assign rot22_14 = {a14[21:0], a14[31:22]};
	assign S0_14 = (rot2_14 ^ rot13_14 ^ rot22_14);

	assign maj14 = ((a14 & b14) ^ (a14 & c14) ^ (b14 & c14));

	assign temp2_14 = S0_14 + maj14;

	assign h15 = g14;
	assign g15 = f14;
	assign f15 = e14;
	assign e15 = d14 + temp1_14;
	assign d15 = c14;
	assign c15 = b14;
	assign b15 = a14;
	assign a15 = temp1_14 + temp2_14;
    
    // compress block 15
    wire [31:0] S0_15, S1_15;
    wire [31:0] temp1_15, temp2_15;

    assign rot6_15 = {e15[5:0], e15[31:6]};
	assign rot11_15 = {e15[10:0], e15[31:11]};
	assign rot25_15 = {e15[24:0], e15[31:25]};
	assign S1_15 = (rot6_15 ^ rot11_15 ^ rot25_15);

	assign ch15 = ((e15 & f15) ^ (~e15 & g15));

	assign temp1_15 = h15 + S1_15 + ch15 + k[15] + w[15];

	assign rot2_15 = {a15[1:0], a15[31:2]};
	assign rot13_15 = {a15[12:0], a15[31:13]};
	assign rot22_15 = {a15[21:0], a15[31:22]};
	assign S0_15 = (rot2_15 ^ rot13_15 ^ rot22_15);

	assign maj15 = ((a15 & b15) ^ (a15 & c15) ^ (b15 & c15));

	assign temp2_15 = S0_15 + maj15;

	assign h16 = g15;
	assign g16 = f15;
	assign f16 = e15;
	assign e16 = d15 + temp1_15;
	assign d16 = c15;
	assign c16 = b15;
	assign b16 = a15;
	assign a16 = temp1_15 + temp2_15;
    
    // compress block 16
    wire [31:0] S0_16, S1_16;
    wire [31:0] temp1_16, temp2_16;

    assign rot6_16 = {e16[5:0], e16[31:6]};
	assign rot11_16 = {e16[10:0], e16[31:11]};
	assign rot25_16 = {e16[24:0], e16[31:25]};
	assign S1_16 = (rot6_16 ^ rot11_16 ^ rot25_16);

	assign ch16 = ((e16 & f16) ^ (~e16 & g16));

	assign temp1_16 = h16 + S1_16 + ch16 + k[16] + w[16];

	assign rot2_16 = {a16[1:0], a16[31:2]};
	assign rot13_16 = {a16[12:0], a16[31:13]};
	assign rot22_16 = {a16[21:0], a16[31:22]};
	assign S0_16 = (rot2_16 ^ rot13_16 ^ rot22_16);

	assign maj16 = ((a16 & b16) ^ (a16 & c16) ^ (b16 & c16));

	assign temp2_16 = S0_16 + maj16;

	assign h17 = g16;
	assign g17 = f16;
	assign f17 = e16;
	assign e17 = d16 + temp1_16;
	assign d17 = c16;
	assign c17 = b16;
	assign b17 = a16;
	assign a17 = temp1_16 + temp2_16;
    
    // compress block 17
    wire [31:0] S0_17, S1_17;
    wire [31:0] temp1_17, temp2_17;

    assign rot6_17 = {e17[5:0], e17[31:6]};
	assign rot11_17 = {e17[10:0], e17[31:11]};
	assign rot25_17 = {e17[24:0], e17[31:25]};
	assign S1_17 = (rot6_17 ^ rot11_17 ^ rot25_17);

	assign ch17 = ((e17 & f17) ^ (~e17 & g17));

	assign temp1_17 = h17 + S1_17 + ch17 + k[17] + w[17];

	assign rot2_17 = {a17[1:0], a17[31:2]};
	assign rot13_17 = {a17[12:0], a17[31:13]};
	assign rot22_17 = {a17[21:0], a17[31:22]};
	assign S0_17 = (rot2_17 ^ rot13_17 ^ rot22_17);

	assign maj17 = ((a17 & b17) ^ (a17 & c17) ^ (b17 & c17));

	assign temp2_17 = S0_17 + maj17;

	assign h18 = g17;
	assign g18 = f17;
	assign f18 = e17;
	assign e18 = d17 + temp1_17;
	assign d18 = c17;
	assign c18 = b17;
	assign b18 = a17;
	assign a18 = temp1_17 + temp2_17;
    
    // compress block 18
    wire [31:0] S0_18, S1_18;
    wire [31:0] temp1_18, temp2_18;

    assign rot6_18 = {e18[5:0], e18[31:6]};
	assign rot11_18 = {e18[10:0], e18[31:11]};
	assign rot25_18 = {e18[24:0], e18[31:25]};
	assign S1_18 = (rot6_18 ^ rot11_18 ^ rot25_18);

	assign ch18 = ((e18 & f18) ^ (~e18 & g18));

	assign temp1_18 = h18 + S1_18 + ch18 + k[18] + w[18];

	assign rot2_18 = {a18[1:0], a18[31:2]};
	assign rot13_18 = {a18[12:0], a18[31:13]};
	assign rot22_18 = {a18[21:0], a18[31:22]};
	assign S0_18 = (rot2_18 ^ rot13_18 ^ rot22_18);

	assign maj18 = ((a18 & b18) ^ (a18 & c18) ^ (b18 & c18));

	assign temp2_18 = S0_18 + maj18;

	assign h19 = g18;
	assign g19 = f18;
	assign f19 = e18;
	assign e19 = d18 + temp1_18;
	assign d19 = c18;
	assign c19 = b18;
	assign b19 = a18;
	assign a19 = temp1_18 + temp2_18;
    
    // compress block 19
    wire [31:0] S0_19, S1_19;
    wire [31:0] temp1_19, temp2_19;

    assign rot6_19 = {e19[5:0], e19[31:6]};
	assign rot11_19 = {e19[10:0], e19[31:11]};
	assign rot25_19 = {e19[24:0], e19[31:25]};
	assign S1_19 = (rot6_19 ^ rot11_19 ^ rot25_19);

	assign ch19 = ((e19 & f19) ^ (~e19 & g19));

	assign temp1_19 = h19 + S1_19 + ch19 + k[19] + w[19];

	assign rot2_19 = {a19[1:0], a19[31:2]};
	assign rot13_19 = {a19[12:0], a19[31:13]};
	assign rot22_19 = {a19[21:0], a19[31:22]};
	assign S0_19 = (rot2_19 ^ rot13_19 ^ rot22_19);

	assign maj19 = ((a19 & b19) ^ (a19 & c19) ^ (b19 & c19));

	assign temp2_19 = S0_19 + maj19;

	assign h20 = g19;
	assign g20 = f19;
	assign f20 = e19;
	assign e20 = d19 + temp1_19;
	assign d20 = c19;
	assign c20 = b19;
	assign b20 = a19;
	assign a20 = temp1_19 + temp2_19;
    
    // compress block 20
    wire [31:0] S0_20, S1_20;
    wire [31:0] temp1_20, temp2_20;

    assign rot6_20 = {e20[5:0], e20[31:6]};
	assign rot11_20 = {e20[10:0], e20[31:11]};
	assign rot25_20 = {e20[24:0], e20[31:25]};
	assign S1_20 = (rot6_20 ^ rot11_20 ^ rot25_20);

	assign ch20 = ((e20 & f20) ^ (~e20 & g20));

	assign temp1_20 = h20 + S1_20 + ch20 + k[20] + w[20];

	assign rot2_20 = {a20[1:0], a20[31:2]};
	assign rot13_20 = {a20[12:0], a20[31:13]};
	assign rot22_20 = {a20[21:0], a20[31:22]};
	assign S0_20 = (rot2_20 ^ rot13_20 ^ rot22_20);

	assign maj20 = ((a20 & b20) ^ (a20 & c20) ^ (b20 & c20));

	assign temp2_20 = S0_20 + maj20;

	assign h21 = g20;
	assign g21 = f20;
	assign f21 = e20;
	assign e21 = d20 + temp1_20;
	assign d21 = c20;
	assign c21 = b20;
	assign b21 = a20;
	assign a21 = temp1_20 + temp2_20;
    
    // compress block 21
    wire [31:0] S0_21, S1_21;
    wire [31:0] temp1_21, temp2_21;

    assign rot6_21 = {e21[5:0], e21[31:6]};
	assign rot11_21 = {e21[10:0], e21[31:11]};
	assign rot25_21 = {e21[24:0], e21[31:25]};
	assign S1_21 = (rot6_21 ^ rot11_21 ^ rot25_21);

	assign ch21 = ((e21 & f21) ^ (~e21 & g21));

	assign temp1_21 = h21 + S1_21 + ch21 + k[21] + w[21];

	assign rot2_21 = {a21[1:0], a21[31:2]};
	assign rot13_21 = {a21[12:0], a21[31:13]};
	assign rot22_21 = {a21[21:0], a21[31:22]};
	assign S0_21 = (rot2_21 ^ rot13_21 ^ rot22_21);

	assign maj21 = ((a21 & b21) ^ (a21 & c21) ^ (b21 & c21));

	assign temp2_21 = S0_21 + maj21;

	assign h22 = g21;
	assign g22 = f21;
	assign f22 = e21;
	assign e22 = d21 + temp1_21;
	assign d22 = c21;
	assign c22 = b21;
	assign b22 = a21;
	assign a22 = temp1_21 + temp2_21;
    
    // compress block 22
    wire [31:0] S0_22, S1_22;
    wire [31:0] temp1_22, temp2_22;

    assign rot6_22 = {e22[5:0], e22[31:6]};
	assign rot11_22 = {e22[10:0], e22[31:11]};
	assign rot25_22 = {e22[24:0], e22[31:25]};
	assign S1_22 = (rot6_22 ^ rot11_22 ^ rot25_22);

	assign ch22 = ((e22 & f22) ^ (~e22 & g22));

	assign temp1_22 = h22 + S1_22 + ch22 + k[22] + w[22];

	assign rot2_22 = {a22[1:0], a22[31:2]};
	assign rot13_22 = {a22[12:0], a22[31:13]};
	assign rot22_22 = {a22[21:0], a22[31:22]};
	assign S0_22 = (rot2_22 ^ rot13_22 ^ rot22_22);

	assign maj22 = ((a22 & b22) ^ (a22 & c22) ^ (b22 & c22));

	assign temp2_22 = S0_22 + maj22;

	assign h23 = g22;
	assign g23 = f22;
	assign f23 = e22;
	assign e23 = d22 + temp1_22;
	assign d23 = c22;
	assign c23 = b22;
	assign b23 = a22;
	assign a23 = temp1_22 + temp2_22;
    
    // compress block 23
    wire [31:0] S0_23, S1_23;
    wire [31:0] temp1_23, temp2_23;

    assign rot6_23 = {e23[5:0], e23[31:6]};
	assign rot11_23 = {e23[10:0], e23[31:11]};
	assign rot25_23 = {e23[24:0], e23[31:25]};
	assign S1_23 = (rot6_23 ^ rot11_23 ^ rot25_23);

	assign ch23 = ((e23 & f23) ^ (~e23 & g23));

	assign temp1_23 = h23 + S1_23 + ch23 + k[23] + w[23];

	assign rot2_23 = {a23[1:0], a23[31:2]};
	assign rot13_23 = {a23[12:0], a23[31:13]};
	assign rot22_23 = {a23[21:0], a23[31:22]};
	assign S0_23 = (rot2_23 ^ rot13_23 ^ rot22_23);

	assign maj23 = ((a23 & b23) ^ (a23 & c23) ^ (b23 & c23));

	assign temp2_23 = S0_23 + maj23;

	assign h24 = g23;
	assign g24 = f23;
	assign f24 = e23;
	assign e24 = d23 + temp1_23;
	assign d24 = c23;
	assign c24 = b23;
	assign b24 = a23;
	assign a24 = temp1_23 + temp2_23;
    
    // compress block 24
    wire [31:0] S0_24, S1_24;
    wire [31:0] temp1_24, temp2_24;

    assign rot6_24 = {e24[5:0], e24[31:6]};
	assign rot11_24 = {e24[10:0], e24[31:11]};
	assign rot25_24 = {e24[24:0], e24[31:25]};
	assign S1_24 = (rot6_24 ^ rot11_24 ^ rot25_24);

	assign ch24 = ((e24 & f24) ^ (~e24 & g24));

	assign temp1_24 = h24 + S1_24 + ch24 + k[24] + w[24];

	assign rot2_24 = {a24[1:0], a24[31:2]};
	assign rot13_24 = {a24[12:0], a24[31:13]};
	assign rot22_24 = {a24[21:0], a24[31:22]};
	assign S0_24 = (rot2_24 ^ rot13_24 ^ rot22_24);

	assign maj24 = ((a24 & b24) ^ (a24 & c24) ^ (b24 & c24));

	assign temp2_24 = S0_24 + maj24;

	assign h25 = g24;
	assign g25 = f24;
	assign f25 = e24;
	assign e25 = d24 + temp1_24;
	assign d25 = c24;
	assign c25 = b24;
	assign b25 = a24;
	assign a25 = temp1_24 + temp2_24;
    
    // compress block 25
    wire [31:0] S0_25, S1_25;
    wire [31:0] temp1_25, temp2_25;

    assign rot6_25 = {e25[5:0], e25[31:6]};
	assign rot11_25 = {e25[10:0], e25[31:11]};
	assign rot25_25 = {e25[24:0], e25[31:25]};
	assign S1_25 = (rot6_25 ^ rot11_25 ^ rot25_25);

	assign ch25 = ((e25 & f25) ^ (~e25 & g25));

	assign temp1_25 = h25 + S1_25 + ch25 + k[25] + w[25];

	assign rot2_25 = {a25[1:0], a25[31:2]};
	assign rot13_25 = {a25[12:0], a25[31:13]};
	assign rot22_25 = {a25[21:0], a25[31:22]};
	assign S0_25 = (rot2_25 ^ rot13_25 ^ rot22_25);

	assign maj25 = ((a25 & b25) ^ (a25 & c25) ^ (b25 & c25));

	assign temp2_25 = S0_25 + maj25;

	assign h26 = g25;
	assign g26 = f25;
	assign f26 = e25;
	assign e26 = d25 + temp1_25;
	assign d26 = c25;
	assign c26 = b25;
	assign b26 = a25;
	assign a26 = temp1_25 + temp2_25;
    
    // compress block 26
    wire [31:0] S0_26, S1_26;
    wire [31:0] temp1_26, temp2_26;

    assign rot6_26 = {e26[5:0], e26[31:6]};
	assign rot11_26 = {e26[10:0], e26[31:11]};
	assign rot25_26 = {e26[24:0], e26[31:25]};
	assign S1_26 = (rot6_26 ^ rot11_26 ^ rot25_26);

	assign ch26 = ((e26 & f26) ^ (~e26 & g26));

	assign temp1_26 = h26 + S1_26 + ch26 + k[26] + w[26];

	assign rot2_26 = {a26[1:0], a26[31:2]};
	assign rot13_26 = {a26[12:0], a26[31:13]};
	assign rot22_26 = {a26[21:0], a26[31:22]};
	assign S0_26 = (rot2_26 ^ rot13_26 ^ rot22_26);

	assign maj26 = ((a26 & b26) ^ (a26 & c26) ^ (b26 & c26));

	assign temp2_26 = S0_26 + maj26;

	assign h27 = g26;
	assign g27 = f26;
	assign f27 = e26;
	assign e27 = d26 + temp1_26;
	assign d27 = c26;
	assign c27 = b26;
	assign b27 = a26;
	assign a27 = temp1_26 + temp2_26;
    
    // compress block 27
    wire [31:0] S0_27, S1_27;
    wire [31:0] temp1_27, temp2_27;

    assign rot6_27 = {e27[5:0], e27[31:6]};
	assign rot11_27 = {e27[10:0], e27[31:11]};
	assign rot25_27 = {e27[24:0], e27[31:25]};
	assign S1_27 = (rot6_27 ^ rot11_27 ^ rot25_27);

	assign ch27 = ((e27 & f27) ^ (~e27 & g27));

	assign temp1_27 = h27 + S1_27 + ch27 + k[27] + w[27];

	assign rot2_27 = {a27[1:0], a27[31:2]};
	assign rot13_27 = {a27[12:0], a27[31:13]};
	assign rot22_27 = {a27[21:0], a27[31:22]};
	assign S0_27 = (rot2_27 ^ rot13_27 ^ rot22_27);

	assign maj27 = ((a27 & b27) ^ (a27 & c27) ^ (b27 & c27));

	assign temp2_27 = S0_27 + maj27;

	assign h28 = g27;
	assign g28 = f27;
	assign f28 = e27;
	assign e28 = d27 + temp1_27;
	assign d28 = c27;
	assign c28 = b27;
	assign b28 = a27;
	assign a28 = temp1_27 + temp2_27;
    
    // compress block 28
    wire [31:0] S0_28, S1_28;
    wire [31:0] temp1_28, temp2_28;

    assign rot6_28 = {e28[5:0], e28[31:6]};
	assign rot11_28 = {e28[10:0], e28[31:11]};
	assign rot25_28 = {e28[24:0], e28[31:25]};
	assign S1_28 = (rot6_28 ^ rot11_28 ^ rot25_28);

	assign ch28 = ((e28 & f28) ^ (~e28 & g28));

	assign temp1_28 = h28 + S1_28 + ch28 + k[28] + w[28];

	assign rot2_28 = {a28[1:0], a28[31:2]};
	assign rot13_28 = {a28[12:0], a28[31:13]};
	assign rot22_28 = {a28[21:0], a28[31:22]};
	assign S0_28 = (rot2_28 ^ rot13_28 ^ rot22_28);

	assign maj28 = ((a28 & b28) ^ (a28 & c28) ^ (b28 & c28));

	assign temp2_28 = S0_28 + maj28;

	assign h29 = g28;
	assign g29 = f28;
	assign f29 = e28;
	assign e29 = d28 + temp1_28;
	assign d29 = c28;
	assign c29 = b28;
	assign b29 = a28;
	assign a29 = temp1_28 + temp2_28;
    
    // compress block 29
    wire [31:0] S0_29, S1_29;
    wire [31:0] temp1_29, temp2_29;

    assign rot6_29 = {e29[5:0], e29[31:6]};
	assign rot11_29 = {e29[10:0], e29[31:11]};
	assign rot25_29 = {e29[24:0], e29[31:25]};
	assign S1_29 = (rot6_29 ^ rot11_29 ^ rot25_29);

	assign ch29 = ((e29 & f29) ^ (~e29 & g29));

	assign temp1_29 = h29 + S1_29 + ch29 + k[29] + w[29];

	assign rot2_29 = {a29[1:0], a29[31:2]};
	assign rot13_29 = {a29[12:0], a29[31:13]};
	assign rot22_29 = {a29[21:0], a29[31:22]};
	assign S0_29 = (rot2_29 ^ rot13_29 ^ rot22_29);

	assign maj29 = ((a29 & b29) ^ (a29 & c29) ^ (b29 & c29));

	assign temp2_29 = S0_29 + maj29;

	assign h30 = g29;
	assign g30 = f29;
	assign f30 = e29;
	assign e30 = d29 + temp1_29;
	assign d30 = c29;
	assign c30 = b29;
	assign b30 = a29;
	assign a30 = temp1_29 + temp2_29;
    
    // compress block 30
    wire [31:0] S0_30, S1_30;
    wire [31:0] temp1_30, temp2_30;

    assign rot6_30 = {e30[5:0], e30[31:6]};
	assign rot11_30 = {e30[10:0], e30[31:11]};
	assign rot25_30 = {e30[24:0], e30[31:25]};
	assign S1_30 = (rot6_30 ^ rot11_30 ^ rot25_30);

	assign ch30 = ((e30 & f30) ^ (~e30 & g30));

	assign temp1_30 = h30 + S1_30 + ch30 + k[30] + w[30];

	assign rot2_30 = {a30[1:0], a30[31:2]};
	assign rot13_30 = {a30[12:0], a30[31:13]};
	assign rot22_30 = {a30[21:0], a30[31:22]};
	assign S0_30 = (rot2_30 ^ rot13_30 ^ rot22_30);

	assign maj30 = ((a30 & b30) ^ (a30 & c30) ^ (b30 & c30));

	assign temp2_30 = S0_30 + maj30;

	assign h31 = g30;
	assign g31 = f30;
	assign f31 = e30;
	assign e31 = d30 + temp1_30;
	assign d31 = c30;
	assign c31 = b30;
	assign b31 = a30;
	assign a31 = temp1_30 + temp2_30;
    
    // compress block 31
    wire [31:0] S0_31, S1_31;
    wire [31:0] temp1_31, temp2_31;

    assign rot6_31 = {e31[5:0], e31[31:6]};
	assign rot11_31 = {e31[10:0], e31[31:11]};
	assign rot25_31 = {e31[24:0], e31[31:25]};
	assign S1_31 = (rot6_31 ^ rot11_31 ^ rot25_31);

	assign ch31 = ((e31 & f31) ^ (~e31 & g31));

	assign temp1_31 = h31 + S1_31 + ch31 + k[31] + w[31];

	assign rot2_31 = {a31[1:0], a31[31:2]};
	assign rot13_31 = {a31[12:0], a31[31:13]};
	assign rot22_31 = {a31[21:0], a31[31:22]};
	assign S0_31 = (rot2_31 ^ rot13_31 ^ rot22_31);

	assign maj31 = ((a31 & b31) ^ (a31 & c31) ^ (b31 & c31));

	assign temp2_31 = S0_31 + maj31;

	assign h32 = g31;
	assign g32 = f31;
	assign f32 = e31;
	assign e32 = d31 + temp1_31;
	assign d32 = c31;
	assign c32 = b31;
	assign b32 = a31;
	assign a32 = temp1_31 + temp2_31;
    
    // compress block 32
    wire [31:0] S0_32, S1_32;
    wire [31:0] temp1_32, temp2_32;

    assign rot6_32 = {e32[5:0], e32[31:6]};
	assign rot11_32 = {e32[10:0], e32[31:11]};
	assign rot25_32 = {e32[24:0], e32[31:25]};
	assign S1_32 = (rot6_32 ^ rot11_32 ^ rot25_32);

	assign ch32 = ((e32 & f32) ^ (~e32 & g32));

	assign temp1_32 = h32 + S1_32 + ch32 + k[32] + w[32];

	assign rot2_32 = {a32[1:0], a32[31:2]};
	assign rot13_32 = {a32[12:0], a32[31:13]};
	assign rot22_32 = {a32[21:0], a32[31:22]};
	assign S0_32 = (rot2_32 ^ rot13_32 ^ rot22_32);

	assign maj32 = ((a32 & b32) ^ (a32 & c32) ^ (b32 & c32));

	assign temp2_32 = S0_32 + maj32;

	assign h33 = g32;
	assign g33 = f32;
	assign f33 = e32;
	assign e33 = d32 + temp1_32;
	assign d33 = c32;
	assign c33 = b32;
	assign b33 = a32;
	assign a33 = temp1_32 + temp2_32;
    
    // compress block 33
    wire [31:0] S0_33, S1_33;
    wire [31:0] temp1_33, temp2_33;

    assign rot6_33 = {e33[5:0], e33[31:6]};
	assign rot11_33 = {e33[10:0], e33[31:11]};
	assign rot25_33 = {e33[24:0], e33[31:25]};
	assign S1_33 = (rot6_33 ^ rot11_33 ^ rot25_33);

	assign ch33 = ((e33 & f33) ^ (~e33 & g33));

	assign temp1_33 = h33 + S1_33 + ch33 + k[33] + w[33];

	assign rot2_33 = {a33[1:0], a33[31:2]};
	assign rot13_33 = {a33[12:0], a33[31:13]};
	assign rot22_33 = {a33[21:0], a33[31:22]};
	assign S0_33 = (rot2_33 ^ rot13_33 ^ rot22_33);

	assign maj33 = ((a33 & b33) ^ (a33 & c33) ^ (b33 & c33));

	assign temp2_33 = S0_33 + maj33;

	assign h34 = g33;
	assign g34 = f33;
	assign f34 = e33;
	assign e34 = d33 + temp1_33;
	assign d34 = c33;
	assign c34 = b33;
	assign b34 = a33;
	assign a34 = temp1_33 + temp2_33;
    
    // compress block 34
    wire [31:0] S0_34, S1_34;
    wire [31:0] temp1_34, temp2_34;

    assign rot6_34 = {e34[5:0], e34[31:6]};
	assign rot11_34 = {e34[10:0], e34[31:11]};
	assign rot25_34 = {e34[24:0], e34[31:25]};
	assign S1_34 = (rot6_34 ^ rot11_34 ^ rot25_34);

	assign ch34 = ((e34 & f34) ^ (~e34 & g34));

	assign temp1_34 = h34 + S1_34 + ch34 + k[34] + w[34];

	assign rot2_34 = {a34[1:0], a34[31:2]};
	assign rot13_34 = {a34[12:0], a34[31:13]};
	assign rot22_34 = {a34[21:0], a34[31:22]};
	assign S0_34 = (rot2_34 ^ rot13_34 ^ rot22_34);

	assign maj34 = ((a34 & b34) ^ (a34 & c34) ^ (b34 & c34));

	assign temp2_34 = S0_34 + maj34;

	assign h35 = g34;
	assign g35 = f34;
	assign f35 = e34;
	assign e35 = d34 + temp1_34;
	assign d35 = c34;
	assign c35 = b34;
	assign b35 = a34;
	assign a35 = temp1_34 + temp2_34;
    
    // compress block 35
    wire [31:0] S0_35, S1_35;
    wire [31:0] temp1_35, temp2_35;

    assign rot6_35 = {e35[5:0], e35[31:6]};
	assign rot11_35 = {e35[10:0], e35[31:11]};
	assign rot25_35 = {e35[24:0], e35[31:25]};
	assign S1_35 = (rot6_35 ^ rot11_35 ^ rot25_35);

	assign ch35 = ((e35 & f35) ^ (~e35 & g35));

	assign temp1_35 = h35 + S1_35 + ch35 + k[35] + w[35];

	assign rot2_35 = {a35[1:0], a35[31:2]};
	assign rot13_35 = {a35[12:0], a35[31:13]};
	assign rot22_35 = {a35[21:0], a35[31:22]};
	assign S0_35 = (rot2_35 ^ rot13_35 ^ rot22_35);

	assign maj35 = ((a35 & b35) ^ (a35 & c35) ^ (b35 & c35));

	assign temp2_35 = S0_35 + maj35;

	assign h36 = g35;
	assign g36 = f35;
	assign f36 = e35;
	assign e36 = d35 + temp1_35;
	assign d36 = c35;
	assign c36 = b35;
	assign b36 = a35;
	assign a36 = temp1_35 + temp2_35;
    
    // compress block 36
    wire [31:0] S0_36, S1_36;
    wire [31:0] temp1_36, temp2_36;

    assign rot6_36 = {e36[5:0], e36[31:6]};
	assign rot11_36 = {e36[10:0], e36[31:11]};
	assign rot25_36 = {e36[24:0], e36[31:25]};
	assign S1_36 = (rot6_36 ^ rot11_36 ^ rot25_36);

	assign ch36 = ((e36 & f36) ^ (~e36 & g36));

	assign temp1_36 = h36 + S1_36 + ch36 + k[36] + w[36];

	assign rot2_36 = {a36[1:0], a36[31:2]};
	assign rot13_36 = {a36[12:0], a36[31:13]};
	assign rot22_36 = {a36[21:0], a36[31:22]};
	assign S0_36 = (rot2_36 ^ rot13_36 ^ rot22_36);

	assign maj36 = ((a36 & b36) ^ (a36 & c36) ^ (b36 & c36));

	assign temp2_36 = S0_36 + maj36;

	assign h37 = g36;
	assign g37 = f36;
	assign f37 = e36;
	assign e37 = d36 + temp1_36;
	assign d37 = c36;
	assign c37 = b36;
	assign b37 = a36;
	assign a37 = temp1_36 + temp2_36;
    
    // compress block 37
    wire [31:0] S0_37, S1_37;
    wire [31:0] temp1_37, temp2_37;

    assign rot6_37 = {e37[5:0], e37[31:6]};
	assign rot11_37 = {e37[10:0], e37[31:11]};
	assign rot25_37 = {e37[24:0], e37[31:25]};
	assign S1_37 = (rot6_37 ^ rot11_37 ^ rot25_37);

	assign ch37 = ((e37 & f37) ^ (~e37 & g37));

	assign temp1_37 = h37 + S1_37 + ch37 + k[37] + w[37];

	assign rot2_37 = {a37[1:0], a37[31:2]};
	assign rot13_37 = {a37[12:0], a37[31:13]};
	assign rot22_37 = {a37[21:0], a37[31:22]};
	assign S0_37 = (rot2_37 ^ rot13_37 ^ rot22_37);

	assign maj37 = ((a37 & b37) ^ (a37 & c37) ^ (b37 & c37));

	assign temp2_37 = S0_37 + maj37;

	assign h38 = g37;
	assign g38 = f37;
	assign f38 = e37;
	assign e38 = d37 + temp1_37;
	assign d38 = c37;
	assign c38 = b37;
	assign b38 = a37;
	assign a38 = temp1_37 + temp2_37;
    
    // compress block 38
    wire [31:0] S0_38, S1_38;
    wire [31:0] temp1_38, temp2_38;

    assign rot6_38 = {e38[5:0], e38[31:6]};
	assign rot11_38 = {e38[10:0], e38[31:11]};
	assign rot25_38 = {e38[24:0], e38[31:25]};
	assign S1_38 = (rot6_38 ^ rot11_38 ^ rot25_38);

	assign ch38 = ((e38 & f38) ^ (~e38 & g38));

	assign temp1_38 = h38 + S1_38 + ch38 + k[38] + w[38];

	assign rot2_38 = {a38[1:0], a38[31:2]};
	assign rot13_38 = {a38[12:0], a38[31:13]};
	assign rot22_38 = {a38[21:0], a38[31:22]};
	assign S0_38 = (rot2_38 ^ rot13_38 ^ rot22_38);

	assign maj38 = ((a38 & b38) ^ (a38 & c38) ^ (b38 & c38));

	assign temp2_38 = S0_38 + maj38;

	assign h39 = g38;
	assign g39 = f38;
	assign f39 = e38;
	assign e39 = d38 + temp1_38;
	assign d39 = c38;
	assign c39 = b38;
	assign b39 = a38;
	assign a39 = temp1_38 + temp2_38;
    
    // compress block 39
    wire [31:0] S0_39, S1_39;
    wire [31:0] temp1_39, temp2_39;

    assign rot6_39 = {e39[5:0], e39[31:6]};
	assign rot11_39 = {e39[10:0], e39[31:11]};
	assign rot25_39 = {e39[24:0], e39[31:25]};
	assign S1_39 = (rot6_39 ^ rot11_39 ^ rot25_39);

	assign ch39 = ((e39 & f39) ^ (~e39 & g39));

	assign temp1_39 = h39 + S1_39 + ch39 + k[39] + w[39];

	assign rot2_39 = {a39[1:0], a39[31:2]};
	assign rot13_39 = {a39[12:0], a39[31:13]};
	assign rot22_39 = {a39[21:0], a39[31:22]};
	assign S0_39 = (rot2_39 ^ rot13_39 ^ rot22_39);

	assign maj39 = ((a39 & b39) ^ (a39 & c39) ^ (b39 & c39));

	assign temp2_39 = S0_39 + maj39;

	assign h40 = g39;
	assign g40 = f39;
	assign f40 = e39;
	assign e40 = d39 + temp1_39;
	assign d40 = c39;
	assign c40 = b39;
	assign b40 = a39;
	assign a40 = temp1_39 + temp2_39;
    
    // compress block 40
    wire [31:0] S0_40, S1_40;
    wire [31:0] temp1_40, temp2_40;

    assign rot6_40 = {e40[5:0], e40[31:6]};
	assign rot11_40 = {e40[10:0], e40[31:11]};
	assign rot25_40 = {e40[24:0], e40[31:25]};
	assign S1_40 = (rot6_40 ^ rot11_40 ^ rot25_40);

	assign ch40 = ((e40 & f40) ^ (~e40 & g40));

	assign temp1_40 = h40 + S1_40 + ch40 + k[40] + w[40];

	assign rot2_40 = {a40[1:0], a40[31:2]};
	assign rot13_40 = {a40[12:0], a40[31:13]};
	assign rot22_40 = {a40[21:0], a40[31:22]};
	assign S0_40 = (rot2_40 ^ rot13_40 ^ rot22_40);

	assign maj40 = ((a40 & b40) ^ (a40 & c40) ^ (b40 & c40));

	assign temp2_40 = S0_40 + maj40;

	assign h41 = g40;
	assign g41 = f40;
	assign f41 = e40;
	assign e41 = d40 + temp1_40;
	assign d41 = c40;
	assign c41 = b40;
	assign b41 = a40;
	assign a41 = temp1_40 + temp2_40;
    
    // compress block 41
    wire [31:0] S0_41, S1_41;
    wire [31:0] temp1_41, temp2_41;

    assign rot6_41 = {e41[5:0], e41[31:6]};
	assign rot11_41 = {e41[10:0], e41[31:11]};
	assign rot25_41 = {e41[24:0], e41[31:25]};
	assign S1_41 = (rot6_41 ^ rot11_41 ^ rot25_41);

	assign ch41 = ((e41 & f41) ^ (~e41 & g41));

	assign temp1_41 = h41 + S1_41 + ch41 + k[41] + w[41];

	assign rot2_41 = {a41[1:0], a41[31:2]};
	assign rot13_41 = {a41[12:0], a41[31:13]};
	assign rot22_41 = {a41[21:0], a41[31:22]};
	assign S0_41 = (rot2_41 ^ rot13_41 ^ rot22_41);

	assign maj41 = ((a41 & b41) ^ (a41 & c41) ^ (b41 & c41));

	assign temp2_41 = S0_41 + maj41;

	assign h42 = g41;
	assign g42 = f41;
	assign f42 = e41;
	assign e42 = d41 + temp1_41;
	assign d42 = c41;
	assign c42 = b41;
	assign b42 = a41;
	assign a42 = temp1_41 + temp2_41;
    
    // compress block 42
    wire [31:0] S0_42, S1_42;
    wire [31:0] temp1_42, temp2_42;

    assign rot6_42 = {e42[5:0], e42[31:6]};
	assign rot11_42 = {e42[10:0], e42[31:11]};
	assign rot25_42 = {e42[24:0], e42[31:25]};
	assign S1_42 = (rot6_42 ^ rot11_42 ^ rot25_42);

	assign ch42 = ((e42 & f42) ^ (~e42 & g42));

	assign temp1_42 = h42 + S1_42 + ch42 + k[42] + w[42];

	assign rot2_42 = {a42[1:0], a42[31:2]};
	assign rot13_42 = {a42[12:0], a42[31:13]};
	assign rot22_42 = {a42[21:0], a42[31:22]};
	assign S0_42 = (rot2_42 ^ rot13_42 ^ rot22_42);

	assign maj42 = ((a42 & b42) ^ (a42 & c42) ^ (b42 & c42));

	assign temp2_42 = S0_42 + maj42;

	assign h43 = g42;
	assign g43 = f42;
	assign f43 = e42;
	assign e43 = d42 + temp1_42;
	assign d43 = c42;
	assign c43 = b42;
	assign b43 = a42;
	assign a43 = temp1_42 + temp2_42;
    
    // compress block 43
    wire [31:0] S0_43, S1_43;
    wire [31:0] temp1_43, temp2_43;

    assign rot6_43 = {e43[5:0], e43[31:6]};
	assign rot11_43 = {e43[10:0], e43[31:11]};
	assign rot25_43 = {e43[24:0], e43[31:25]};
	assign S1_43 = (rot6_43 ^ rot11_43 ^ rot25_43);

	assign ch43 = ((e43 & f43) ^ (~e43 & g43));

	assign temp1_43 = h43 + S1_43 + ch43 + k[43] + w[43];

	assign rot2_43 = {a43[1:0], a43[31:2]};
	assign rot13_43 = {a43[12:0], a43[31:13]};
	assign rot22_43 = {a43[21:0], a43[31:22]};
	assign S0_43 = (rot2_43 ^ rot13_43 ^ rot22_43);

	assign maj43 = ((a43 & b43) ^ (a43 & c43) ^ (b43 & c43));

	assign temp2_43 = S0_43 + maj43;

	assign h44 = g43;
	assign g44 = f43;
	assign f44 = e43;
	assign e44 = d43 + temp1_43;
	assign d44 = c43;
	assign c44 = b43;
	assign b44 = a43;
	assign a44 = temp1_43 + temp2_43;
    
    // compress block 44
    wire [31:0] S0_44, S1_44;
    wire [31:0] temp1_44, temp2_44;

    assign rot6_44 = {e44[5:0], e44[31:6]};
	assign rot11_44 = {e44[10:0], e44[31:11]};
	assign rot25_44 = {e44[24:0], e44[31:25]};
	assign S1_44 = (rot6_44 ^ rot11_44 ^ rot25_44);

	assign ch44 = ((e44 & f44) ^ (~e44 & g44));

	assign temp1_44 = h44 + S1_44 + ch44 + k[44] + w[44];

	assign rot2_44 = {a44[1:0], a44[31:2]};
	assign rot13_44 = {a44[12:0], a44[31:13]};
	assign rot22_44 = {a44[21:0], a44[31:22]};
	assign S0_44 = (rot2_44 ^ rot13_44 ^ rot22_44);

	assign maj44 = ((a44 & b44) ^ (a44 & c44) ^ (b44 & c44));

	assign temp2_44 = S0_44 + maj44;

	assign h45 = g44;
	assign g45 = f44;
	assign f45 = e44;
	assign e45 = d44 + temp1_44;
	assign d45 = c44;
	assign c45 = b44;
	assign b45 = a44;
	assign a45 = temp1_44 + temp2_44;
    
    // compress block 45
    wire [31:0] S0_45, S1_45;
    wire [31:0] temp1_45, temp2_45;

    assign rot6_45 = {e45[5:0], e45[31:6]};
	assign rot11_45 = {e45[10:0], e45[31:11]};
	assign rot25_45 = {e45[24:0], e45[31:25]};
	assign S1_45 = (rot6_45 ^ rot11_45 ^ rot25_45);

	assign ch45 = ((e45 & f45) ^ (~e45 & g45));

	assign temp1_45 = h45 + S1_45 + ch45 + k[45] + w[45];

	assign rot2_45 = {a45[1:0], a45[31:2]};
	assign rot13_45 = {a45[12:0], a45[31:13]};
	assign rot22_45 = {a45[21:0], a45[31:22]};
	assign S0_45 = (rot2_45 ^ rot13_45 ^ rot22_45);

	assign maj45 = ((a45 & b45) ^ (a45 & c45) ^ (b45 & c45));

	assign temp2_45 = S0_45 + maj45;

	assign h46 = g45;
	assign g46 = f45;
	assign f46 = e45;
	assign e46 = d45 + temp1_45;
	assign d46 = c45;
	assign c46 = b45;
	assign b46 = a45;
	assign a46 = temp1_45 + temp2_45;
    
    // compress block 46
    wire [31:0] S0_46, S1_46;
    wire [31:0] temp1_46, temp2_46;

    assign rot6_46 = {e46[5:0], e46[31:6]};
	assign rot11_46 = {e46[10:0], e46[31:11]};
	assign rot25_46 = {e46[24:0], e46[31:25]};
	assign S1_46 = (rot6_46 ^ rot11_46 ^ rot25_46);

	assign ch46 = ((e46 & f46) ^ (~e46 & g46));

	assign temp1_46 = h46 + S1_46 + ch46 + k[46] + w[46];

	assign rot2_46 = {a46[1:0], a46[31:2]};
	assign rot13_46 = {a46[12:0], a46[31:13]};
	assign rot22_46 = {a46[21:0], a46[31:22]};
	assign S0_46 = (rot2_46 ^ rot13_46 ^ rot22_46);

	assign maj46 = ((a46 & b46) ^ (a46 & c46) ^ (b46 & c46));

	assign temp2_46 = S0_46 + maj46;

	assign h47 = g46;
	assign g47 = f46;
	assign f47 = e46;
	assign e47 = d46 + temp1_46;
	assign d47 = c46;
	assign c47 = b46;
	assign b47 = a46;
	assign a47 = temp1_46 + temp2_46;
    
    // compress block 47
    wire [31:0] S0_47, S1_47;
    wire [31:0] temp1_47, temp2_47;

    assign rot6_47 = {e47[5:0], e47[31:6]};
	assign rot11_47 = {e47[10:0], e47[31:11]};
	assign rot25_47 = {e47[24:0], e47[31:25]};
	assign S1_47 = (rot6_47 ^ rot11_47 ^ rot25_47);

	assign ch47 = ((e47 & f47) ^ (~e47 & g47));

	assign temp1_47 = h47 + S1_47 + ch47 + k[47] + w[47];

	assign rot2_47 = {a47[1:0], a47[31:2]};
	assign rot13_47 = {a47[12:0], a47[31:13]};
	assign rot22_47 = {a47[21:0], a47[31:22]};
	assign S0_47 = (rot2_47 ^ rot13_47 ^ rot22_47);

	assign maj47 = ((a47 & b47) ^ (a47 & c47) ^ (b47 & c47));

	assign temp2_47 = S0_47 + maj47;

	assign h48 = g47;
	assign g48 = f47;
	assign f48 = e47;
	assign e48 = d47 + temp1_47;
	assign d48 = c47;
	assign c48 = b47;
	assign b48 = a47;
	assign a48 = temp1_47 + temp2_47;
    
    // compress block 48
    wire [31:0] S0_48, S1_48;
    wire [31:0] temp1_48, temp2_48;

    assign rot6_48 = {e48[5:0], e48[31:6]};
	assign rot11_48 = {e48[10:0], e48[31:11]};
	assign rot25_48 = {e48[24:0], e48[31:25]};
	assign S1_48 = (rot6_48 ^ rot11_48 ^ rot25_48);

	assign ch48 = ((e48 & f48) ^ (~e48 & g48));

	assign temp1_48 = h48 + S1_48 + ch48 + k[48] + w[48];

	assign rot2_48 = {a48[1:0], a48[31:2]};
	assign rot13_48 = {a48[12:0], a48[31:13]};
	assign rot22_48 = {a48[21:0], a48[31:22]};
	assign S0_48 = (rot2_48 ^ rot13_48 ^ rot22_48);

	assign maj48 = ((a48 & b48) ^ (a48 & c48) ^ (b48 & c48));

	assign temp2_48 = S0_48 + maj48;

	assign h49 = g48;
	assign g49 = f48;
	assign f49 = e48;
	assign e49 = d48 + temp1_48;
	assign d49 = c48;
	assign c49 = b48;
	assign b49 = a48;
	assign a49 = temp1_48 + temp2_48;
    
    // compress block 49
    wire [31:0] S0_49, S1_49;
    wire [31:0] temp1_49, temp2_49;

    assign rot6_49 = {e49[5:0], e49[31:6]};
	assign rot11_49 = {e49[10:0], e49[31:11]};
	assign rot25_49 = {e49[24:0], e49[31:25]};
	assign S1_49 = (rot6_49 ^ rot11_49 ^ rot25_49);

	assign ch49 = ((e49 & f49) ^ (~e49 & g49));

	assign temp1_49 = h49 + S1_49 + ch49 + k[49] + w[49];

	assign rot2_49 = {a49[1:0], a49[31:2]};
	assign rot13_49 = {a49[12:0], a49[31:13]};
	assign rot22_49 = {a49[21:0], a49[31:22]};
	assign S0_49 = (rot2_49 ^ rot13_49 ^ rot22_49);

	assign maj49 = ((a49 & b49) ^ (a49 & c49) ^ (b49 & c49));

	assign temp2_49 = S0_49 + maj49;

	assign h50 = g49;
	assign g50 = f49;
	assign f50 = e49;
	assign e50 = d49 + temp1_49;
	assign d50 = c49;
	assign c50 = b49;
	assign b50 = a49;
	assign a50 = temp1_49 + temp2_49;
    
    // compress block 50
    wire [31:0] S0_50, S1_50;
    wire [31:0] temp1_50, temp2_50;

    assign rot6_50 = {e50[5:0], e50[31:6]};
	assign rot11_50 = {e50[10:0], e50[31:11]};
	assign rot25_50 = {e50[24:0], e50[31:25]};
	assign S1_50 = (rot6_50 ^ rot11_50 ^ rot25_50);

	assign ch50 = ((e50 & f50) ^ (~e50 & g50));

	assign temp1_50 = h50 + S1_50 + ch50 + k[50] + w[50];

	assign rot2_50 = {a50[1:0], a50[31:2]};
	assign rot13_50 = {a50[12:0], a50[31:13]};
	assign rot22_50 = {a50[21:0], a50[31:22]};
	assign S0_50 = (rot2_50 ^ rot13_50 ^ rot22_50);

	assign maj50 = ((a50 & b50) ^ (a50 & c50) ^ (b50 & c50));

	assign temp2_50 = S0_50 + maj50;

	assign h51 = g50;
	assign g51 = f50;
	assign f51 = e50;
	assign e51 = d50 + temp1_50;
	assign d51 = c50;
	assign c51 = b50;
	assign b51 = a50;
	assign a51 = temp1_50 + temp2_50;
    
    // compress block 51
    wire [31:0] S0_51, S1_51;
    wire [31:0] temp1_51, temp2_51;

    assign rot6_51 = {e51[5:0], e51[31:6]};
	assign rot11_51 = {e51[10:0], e51[31:11]};
	assign rot25_51 = {e51[24:0], e51[31:25]};
	assign S1_51 = (rot6_51 ^ rot11_51 ^ rot25_51);

	assign ch51 = ((e51 & f51) ^ (~e51 & g51));

	assign temp1_51 = h51 + S1_51 + ch51 + k[51] + w[51];

	assign rot2_51 = {a51[1:0], a51[31:2]};
	assign rot13_51 = {a51[12:0], a51[31:13]};
	assign rot22_51 = {a51[21:0], a51[31:22]};
	assign S0_51 = (rot2_51 ^ rot13_51 ^ rot22_51);

	assign maj51 = ((a51 & b51) ^ (a51 & c51) ^ (b51 & c51));

	assign temp2_51 = S0_51 + maj51;

	assign h52 = g51;
	assign g52 = f51;
	assign f52 = e51;
	assign e52 = d51 + temp1_51;
	assign d52 = c51;
	assign c52 = b51;
	assign b52 = a51;
	assign a52 = temp1_51 + temp2_51;
    
    // compress block 52
    wire [31:0] S0_52, S1_52;
    wire [31:0] temp1_52, temp2_52;

    assign rot6_52 = {e52[5:0], e52[31:6]};
	assign rot11_52 = {e52[10:0], e52[31:11]};
	assign rot25_52 = {e52[24:0], e52[31:25]};
	assign S1_52 = (rot6_52 ^ rot11_52 ^ rot25_52);

	assign ch52 = ((e52 & f52) ^ (~e52 & g52));

	assign temp1_52 = h52 + S1_52 + ch52 + k[52] + w[52];

	assign rot2_52 = {a52[1:0], a52[31:2]};
	assign rot13_52 = {a52[12:0], a52[31:13]};
	assign rot22_52 = {a52[21:0], a52[31:22]};
	assign S0_52 = (rot2_52 ^ rot13_52 ^ rot22_52);

	assign maj52 = ((a52 & b52) ^ (a52 & c52) ^ (b52 & c52));

	assign temp2_52 = S0_52 + maj52;

	assign h53 = g52;
	assign g53 = f52;
	assign f53 = e52;
	assign e53 = d52 + temp1_52;
	assign d53 = c52;
	assign c53 = b52;
	assign b53 = a52;
	assign a53 = temp1_52 + temp2_52;
    
    // compress block 53
    wire [31:0] S0_53, S1_53;
    wire [31:0] temp1_53, temp2_53;

    assign rot6_53 = {e53[5:0], e53[31:6]};
	assign rot11_53 = {e53[10:0], e53[31:11]};
	assign rot25_53 = {e53[24:0], e53[31:25]};
	assign S1_53 = (rot6_53 ^ rot11_53 ^ rot25_53);

	assign ch53 = ((e53 & f53) ^ (~e53 & g53));

	assign temp1_53 = h53 + S1_53 + ch53 + k[53] + w[53];

	assign rot2_53 = {a53[1:0], a53[31:2]};
	assign rot13_53 = {a53[12:0], a53[31:13]};
	assign rot22_53 = {a53[21:0], a53[31:22]};
	assign S0_53 = (rot2_53 ^ rot13_53 ^ rot22_53);

	assign maj53 = ((a53 & b53) ^ (a53 & c53) ^ (b53 & c53));

	assign temp2_53 = S0_53 + maj53;

	assign h54 = g53;
	assign g54 = f53;
	assign f54 = e53;
	assign e54 = d53 + temp1_53;
	assign d54 = c53;
	assign c54 = b53;
	assign b54 = a53;
	assign a54 = temp1_53 + temp2_53;
    
    // compress block 54
    wire [31:0] S0_54, S1_54;
    wire [31:0] temp1_54, temp2_54;

    assign rot6_54 = {e54[5:0], e54[31:6]};
	assign rot11_54 = {e54[10:0], e54[31:11]};
	assign rot25_54 = {e54[24:0], e54[31:25]};
	assign S1_54 = (rot6_54 ^ rot11_54 ^ rot25_54);

	assign ch54 = ((e54 & f54) ^ (~e54 & g54));

	assign temp1_54 = h54 + S1_54 + ch54 + k[54] + w[54];

	assign rot2_54 = {a54[1:0], a54[31:2]};
	assign rot13_54 = {a54[12:0], a54[31:13]};
	assign rot22_54 = {a54[21:0], a54[31:22]};
	assign S0_54 = (rot2_54 ^ rot13_54 ^ rot22_54);

	assign maj54 = ((a54 & b54) ^ (a54 & c54) ^ (b54 & c54));

	assign temp2_54 = S0_54 + maj54;

	assign h55 = g54;
	assign g55 = f54;
	assign f55 = e54;
	assign e55 = d54 + temp1_54;
	assign d55 = c54;
	assign c55 = b54;
	assign b55 = a54;
	assign a55 = temp1_54 + temp2_54;
    
    // compress block 55
    wire [31:0] S0_55, S1_55;
    wire [31:0] temp1_55, temp2_55;

    assign rot6_55 = {e55[5:0], e55[31:6]};
	assign rot11_55 = {e55[10:0], e55[31:11]};
	assign rot25_55 = {e55[24:0], e55[31:25]};
	assign S1_55 = (rot6_55 ^ rot11_55 ^ rot25_55);

	assign ch55 = ((e55 & f55) ^ (~e55 & g55));

	assign temp1_55 = h55 + S1_55 + ch55 + k[55] + w[55];

	assign rot2_55 = {a55[1:0], a55[31:2]};
	assign rot13_55 = {a55[12:0], a55[31:13]};
	assign rot22_55 = {a55[21:0], a55[31:22]};
	assign S0_55 = (rot2_55 ^ rot13_55 ^ rot22_55);

	assign maj55 = ((a55 & b55) ^ (a55 & c55) ^ (b55 & c55));

	assign temp2_55 = S0_55 + maj55;

	assign h56 = g55;
	assign g56 = f55;
	assign f56 = e55;
	assign e56 = d55 + temp1_55;
	assign d56 = c55;
	assign c56 = b55;
	assign b56 = a55;
	assign a56 = temp1_55 + temp2_55;
    
    // compress block 56
    wire [31:0] S0_56, S1_56;
    wire [31:0] temp1_56, temp2_56;

    assign rot6_56 = {e56[5:0], e56[31:6]};
	assign rot11_56 = {e56[10:0], e56[31:11]};
	assign rot25_56 = {e56[24:0], e56[31:25]};
	assign S1_56 = (rot6_56 ^ rot11_56 ^ rot25_56);

	assign ch56 = ((e56 & f56) ^ (~e56 & g56));

	assign temp1_56 = h56 + S1_56 + ch56 + k[56] + w[56];

	assign rot2_56 = {a56[1:0], a56[31:2]};
	assign rot13_56 = {a56[12:0], a56[31:13]};
	assign rot22_56 = {a56[21:0], a56[31:22]};
	assign S0_56 = (rot2_56 ^ rot13_56 ^ rot22_56);

	assign maj56 = ((a56 & b56) ^ (a56 & c56) ^ (b56 & c56));

	assign temp2_56 = S0_56 + maj56;

	assign h57 = g56;
	assign g57 = f56;
	assign f57 = e56;
	assign e57 = d56 + temp1_56;
	assign d57 = c56;
	assign c57 = b56;
	assign b57 = a56;
	assign a57 = temp1_56 + temp2_56;
    
    // compress block 57
    wire [31:0] S0_57, S1_57;
    wire [31:0] temp1_57, temp2_57;

    assign rot6_57 = {e57[5:0], e57[31:6]};
	assign rot11_57 = {e57[10:0], e57[31:11]};
	assign rot25_57 = {e57[24:0], e57[31:25]};
	assign S1_57 = (rot6_57 ^ rot11_57 ^ rot25_57);

	assign ch57 = ((e57 & f57) ^ (~e57 & g57));

	assign temp1_57 = h57 + S1_57 + ch57 + k[57] + w[57];

	assign rot2_57 = {a57[1:0], a57[31:2]};
	assign rot13_57 = {a57[12:0], a57[31:13]};
	assign rot22_57 = {a57[21:0], a57[31:22]};
	assign S0_57 = (rot2_57 ^ rot13_57 ^ rot22_57);

	assign maj57 = ((a57 & b57) ^ (a57 & c57) ^ (b57 & c57));

	assign temp2_57 = S0_57 + maj57;

	assign h58 = g57;
	assign g58 = f57;
	assign f58 = e57;
	assign e58 = d57 + temp1_57;
	assign d58 = c57;
	assign c58 = b57;
	assign b58 = a57;
	assign a58 = temp1_57 + temp2_57;
    
    // compress block 58
    wire [31:0] S0_58, S1_58;
    wire [31:0] temp1_58, temp2_58;

    assign rot6_58 = {e58[5:0], e58[31:6]};
	assign rot11_58 = {e58[10:0], e58[31:11]};
	assign rot25_58 = {e58[24:0], e58[31:25]};
	assign S1_58 = (rot6_58 ^ rot11_58 ^ rot25_58);

	assign ch58 = ((e58 & f58) ^ (~e58 & g58));

	assign temp1_58 = h58 + S1_58 + ch58 + k[58] + w[58];

	assign rot2_58 = {a58[1:0], a58[31:2]};
	assign rot13_58 = {a58[12:0], a58[31:13]};
	assign rot22_58 = {a58[21:0], a58[31:22]};
	assign S0_58 = (rot2_58 ^ rot13_58 ^ rot22_58);

	assign maj58 = ((a58 & b58) ^ (a58 & c58) ^ (b58 & c58));

	assign temp2_58 = S0_58 + maj58;

	assign h59 = g58;
	assign g59 = f58;
	assign f59 = e58;
	assign e59 = d58 + temp1_58;
	assign d59 = c58;
	assign c59 = b58;
	assign b59 = a58;
	assign a59 = temp1_58 + temp2_58;
    
    // compress block 59
    wire [31:0] S0_59, S1_59;
    wire [31:0] temp1_59, temp2_59;

    assign rot6_59 = {e59[5:0], e59[31:6]};
	assign rot11_59 = {e59[10:0], e59[31:11]};
	assign rot25_59 = {e59[24:0], e59[31:25]};
	assign S1_59 = (rot6_59 ^ rot11_59 ^ rot25_59);

	assign ch59 = ((e59 & f59) ^ (~e59 & g59));

	assign temp1_59 = h59 + S1_59 + ch59 + k[59] + w[59];

	assign rot2_59 = {a59[1:0], a59[31:2]};
	assign rot13_59 = {a59[12:0], a59[31:13]};
	assign rot22_59 = {a59[21:0], a59[31:22]};
	assign S0_59 = (rot2_59 ^ rot13_59 ^ rot22_59);

	assign maj59 = ((a59 & b59) ^ (a59 & c59) ^ (b59 & c59));

	assign temp2_59 = S0_59 + maj59;

	assign h60 = g59;
	assign g60 = f59;
	assign f60 = e59;
	assign e60 = d59 + temp1_59;
	assign d60 = c59;
	assign c60 = b59;
	assign b60 = a59;
	assign a60 = temp1_59 + temp2_59;
    
    // compress block 60
    wire [31:0] S0_60, S1_60;
    wire [31:0] temp1_60, temp2_60;

    assign rot6_60 = {e60[5:0], e60[31:6]};
	assign rot11_60 = {e60[10:0], e60[31:11]};
	assign rot25_60 = {e60[24:0], e60[31:25]};
	assign S1_60 = (rot6_60 ^ rot11_60 ^ rot25_60);

	assign ch60 = ((e60 & f60) ^ (~e60 & g60));

	assign temp1_60 = h60 + S1_60 + ch60 + k[60] + w[60];

	assign rot2_60 = {a60[1:0], a60[31:2]};
	assign rot13_60 = {a60[12:0], a60[31:13]};
	assign rot22_60 = {a60[21:0], a60[31:22]};
	assign S0_60 = (rot2_60 ^ rot13_60 ^ rot22_60);

	assign maj60 = ((a60 & b60) ^ (a60 & c60) ^ (b60 & c60));

	assign temp2_60 = S0_60 + maj60;

	assign h61 = g60;
	assign g61 = f60;
	assign f61 = e60;
	assign e61 = d60 + temp1_60;
	assign d61 = c60;
	assign c61 = b60;
	assign b61 = a60;
	assign a61 = temp1_60 + temp2_60;
    
    // compress block 61
    wire [31:0] S0_61, S1_61;
    wire [31:0] temp1_61, temp2_61;

    assign rot6_61 = {e61[5:0], e61[31:6]};
	assign rot11_61 = {e61[10:0], e61[31:11]};
	assign rot25_61 = {e61[24:0], e61[31:25]};
	assign S1_61 = (rot6_61 ^ rot11_61 ^ rot25_61);

	assign ch61 = ((e61 & f61) ^ (~e61 & g61));

	assign temp1_61 = h61 + S1_61 + ch61 + k[61] + w[61];

	assign rot2_61 = {a61[1:0], a61[31:2]};
	assign rot13_61 = {a61[12:0], a61[31:13]};
	assign rot22_61 = {a61[21:0], a61[31:22]};
	assign S0_61 = (rot2_61 ^ rot13_61 ^ rot22_61);

	assign maj61 = ((a61 & b61) ^ (a61 & c61) ^ (b61 & c61));

	assign temp2_61 = S0_61 + maj61;

	assign h62 = g61;
	assign g62 = f61;
	assign f62 = e61;
	assign e62 = d61 + temp1_61;
	assign d62 = c61;
	assign c62 = b61;
	assign b62 = a61;
	assign a62 = temp1_61 + temp2_61;
    
    // compress block 62
    wire [31:0] S0_62, S1_62;
    wire [31:0] temp1_62, temp2_62;

    assign rot6_62 = {e62[5:0], e62[31:6]};
	assign rot11_62 = {e62[10:0], e62[31:11]};
	assign rot25_62 = {e62[24:0], e62[31:25]};
	assign S1_62 = (rot6_62 ^ rot11_62 ^ rot25_62);

	assign ch62 = ((e62 & f62) ^ (~e62 & g62));

	assign temp1_62 = h62 + S1_62 + ch62 + k[62] + w[62];

	assign rot2_62 = {a62[1:0], a62[31:2]};
	assign rot13_62 = {a62[12:0], a62[31:13]};
	assign rot22_62 = {a62[21:0], a62[31:22]};
	assign S0_62 = (rot2_62 ^ rot13_62 ^ rot22_62);

	assign maj62 = ((a62 & b62) ^ (a62 & c62) ^ (b62 & c62));

	assign temp2_62 = S0_62 + maj62;

	assign h63 = g62;
	assign g63 = f62;
	assign f63 = e62;
	assign e63 = d62 + temp1_62;
	assign d63 = c62;
	assign c63 = b62;
	assign b63 = a62;
	assign a63 = temp1_62 + temp2_62;
    
    // compress block 63
    wire [31:0] S0_63, S1_63;
    wire [31:0] temp1_63, temp2_63;

    assign rot6_63 = {e63[5:0], e63[31:6]};
	assign rot11_63 = {e63[10:0], e63[31:11]};
	assign rot25_63 = {e63[24:0], e63[31:25]};
	assign S1_63 = (rot6_63 ^ rot11_63 ^ rot25_63);

	assign ch63 = ((e63 & f63) ^ (~e63 & g63));

	assign temp1_63 = h63 + S1_63 + ch63 + k[63] + w[63];

	assign rot2_63 = {a63[1:0], a63[31:2]};
	assign rot13_63 = {a63[12:0], a63[31:13]};
	assign rot22_63 = {a63[21:0], a63[31:22]};
	assign S0_63 = (rot2_63 ^ rot13_63 ^ rot22_63);

	assign maj63 = ((a63 & b63) ^ (a63 & c63) ^ (b63 & c63));

	assign temp2_63 = S0_63 + maj63;

	assign h64 = g63;
	assign g64 = f63;
	assign f64 = e63;
	assign e64 = d63 + temp1_63;
	assign d64 = c63;
	assign c64 = b63;
	assign b64 = a63;
	assign a64 = temp1_63 + temp2_63;
    
    assign hash0Out = a64;
    assign hash1Out = b64;
    assign hash2Out = c64;
    assign hash3Out = d64;
    assign hash4Out = e64;
    assign hash5Out = f64;
    assign hash6Out = g64;
    assign hash7Out = h64;
    
	assign hashFinal0 = hash0In + a64;
	assign hashFinal1 = hash1In + b64;
	assign hashFinal2 = hash2In + c64;
	assign hashFinal3 = hash3In + d64;
	assign hashFinal4 = hash4In + e64;
	assign hashFinal5 = hash5In + f64;
	assign hashFinal6 = hash6In + g64;
	assign hashFinal7 = hash7In + h64;

	assign hashedValue = {hashFinal0, hashFinal1, hashFinal2, hashFinal3, hashFinal4, hashFinal5, hashFinal6, hashFinal7};
endmodule