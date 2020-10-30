module SHA256(originalValue, hashedValue, clock);
	// input [639:0] originalValue;
	// output [255:0] hashedValue;

	input clock;
	input [87:0] originalValue;
	output [255:0] hashedValue;

	wire [31:0] hash0, hash1, hash2, hash3, hash4, hash5, hash6, hash7;
	// wire [31:0] k0, k1, k2, k3, k4, k5, k6, k7, k8, k9, k10, k11, k12, k13, k14, k15, k16, k17, k18, k19, k20, k21, k22, k23, k24, k25, k26, k27, k28, k29, k30, k31;

	// 64-element arrays of 32-bit wide reg
	wire [31:0] k [0:63];
	wire [31:0] w [0:63];

	wire [31:0] s0, s1, s2, s3, s4, s5, s6, s7, s8, 
				s9, s10, s11, s12, s13, s14, s15, s16, 
				s17, s18, s19, s20, s21, s22, s23, s24, 
				s25, s26, s27, s28, s29, s30, s31, s32, 
				s33, s34, s35, s36, s37, s38, s39, s40, 
				s41, s42, s43, s44, s45, s46, s47, s48, 
				s49, s50, s51, s52, s53, s54, s55, s56, 
				s57, s58, s59, s60, s61, s62, s63, s64, 
				s65, s66, s67, s68, s69, s70, s71, s72, 
				s73, s74, s75, s76, s77, s78, s79, s80, 
				s81, s82, s83, s84, s85, s86, s87, s88, 
				s89, s90, s91, s92, s93, s94, s95;

	wire [31:0] rot7_16, rot7_17, rot7_18, rot7_19, rot7_20, rot7_21, rot7_22, rot7_23, rot7_24,
				rot7_25, rot7_26, rot7_27, rot7_28, rot7_29, rot7_30, rot7_31, rot7_32, rot7_33, 
				rot7_34, rot7_35, rot7_36, rot7_37, rot7_38, rot7_39, rot7_40, rot7_41, rot7_42, 
				rot7_43, rot7_44, rot7_45, rot7_46, rot7_47, rot7_48, rot7_49, rot7_50, rot7_51, 
				rot7_52, rot7_53, rot7_54, rot7_55, rot7_56, rot7_57, rot7_58, rot7_59, rot7_60, 
				rot7_61, rot7_62, rot7_63;

	wire [31:0] rot18_16, rot18_17, rot18_18, rot18_19, rot18_20, rot18_21, rot18_22, rot18_23, rot18_24,
				rot18_25, rot18_26, rot18_27, rot18_28, rot18_29, rot18_30, rot18_31, rot18_32, rot18_33, 
				rot18_34, rot18_35, rot18_36, rot18_37, rot18_38, rot18_39, rot18_40, rot18_41, rot18_42, 
				rot18_43, rot18_44, rot18_45, rot18_46, rot18_47, rot18_48, rot18_49, rot18_50, rot18_51, 
				rot18_52, rot18_53, rot18_54, rot18_55, rot18_56, rot18_57, rot18_58, rot18_59, rot18_60, 
				rot18_61, rot18_62, rot18_63;

	wire [31:0] rot3_16, rot3_17, rot3_18, rot3_19, rot3_20, rot3_21, rot3_22, rot3_23, rot3_24, rot3_25, 
				rot3_26, rot3_27, rot3_28, rot3_29, rot3_30, rot3_31, rot3_32, rot3_33, rot3_34, rot3_35, 
				rot3_36, rot3_37, rot3_38, rot3_39, rot3_40, rot3_41, rot3_42, rot3_43, rot3_44, rot3_45, 
				rot3_46, rot3_47, rot3_48, rot3_49, rot3_50, rot3_51, rot3_52, rot3_53, rot3_54, rot3_55, 
				rot3_56, rot3_57, rot3_58, rot3_59, rot3_60, rot3_61, rot3_62, rot3_63;

	wire [31:0] rot17_16, rot17_17, rot17_18, rot17_19, rot17_20, rot17_21, rot17_22, rot17_23, rot17_24,
				rot17_25, rot17_26, rot17_27, rot17_28, rot17_29, rot17_30, rot17_31, rot17_32, rot17_33, 
				rot17_34, rot17_35, rot17_36, rot17_37, rot17_38, rot17_39, rot17_40, rot17_41, rot17_42, 
				rot17_43, rot17_44, rot17_45, rot17_46, rot17_47, rot17_48, rot17_49, rot17_50, rot17_51, 
				rot17_52, rot17_53, rot17_54, rot17_55, rot17_56, rot17_57, rot17_58, rot17_59, rot17_60, 
				rot17_61, rot17_62, rot17_63;

	wire [31:0] rot19_16, rot19_17, rot19_18, rot19_19, rot19_20, rot19_21, rot19_22, rot19_23, rot19_24, 
				rot19_25, rot19_26, rot19_27, rot19_28, rot19_29, rot19_30, rot19_31, rot19_32, rot19_33, 
				rot19_34, rot19_35, rot19_36, rot19_37, rot19_38, rot19_39, rot19_40, rot19_41, rot19_42,
				rot19_43, rot19_44, rot19_45, rot19_46, rot19_47, rot19_48, rot19_49, rot19_50, rot19_51,
				rot19_52, rot19_53, rot19_54, rot19_55, rot19_56, rot19_57, rot19_58, rot19_59, rot19_60,
				rot19_61, rot19_62, rot19_63;

	wire [31:0] rot10_16, rot10_17, rot10_18, rot10_19, rot10_20, rot10_21, rot10_22, rot10_23, rot10_24,
				rot10_25, rot10_26, rot10_27, rot10_28, rot10_29, rot10_30, rot10_31, rot10_32, rot10_33,
				rot10_34, rot10_35, rot10_36, rot10_37, rot10_38, rot10_39, rot10_40, rot10_41, rot10_42,
				rot10_43, rot10_44, rot10_45, rot10_46, rot10_47, rot10_48, rot10_49, rot10_50, rot10_51,
				rot10_52, rot10_53, rot10_54, rot10_55, rot10_56, rot10_57, rot10_58, rot10_59, rot10_60,
				rot10_61, rot10_62, rot10_63;


	wire [31:0] S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16,
				S17, S18, S19, S20, S21, S22, S23, S24, S25, S26, S27, S28, S29, S30, S31, S32,
				S33, S34, S35, S36, S37, S38, S39, S40, S41, S42, S43, S44, S45, S46, S47, S48,
				S49, S50, S51, S52, S53, S54, S55, S56, S57, S58, S59, S60, S61, S62, S63, S64,
				S65, S66, S67, S68, S69, S70, S71, S72, S73, S74, S75, S76, S77, S78, S79, S80,
				S81, S82, S83, S84, S85, S86, S87, S88, S89, S90, S91, S92, S93, S94, S95, S96,
				S97, S98, S99, S100, S101, S102, S103, S104, S105, S106, S107, S108, S109, S110, S111, S112,
				S113, S114, S115, S116, S117, S118, S119, S120, S121, S122, S123, S124, S125, S126, S127;

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

	wire [31:0] temp0, temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8,
				temp9, temp10, temp11, temp12, temp13, temp14, temp15, temp16,
				temp17, temp18, temp19, temp20, temp21, temp22, temp23, temp24,
				temp25, temp26, temp27, temp28, temp29, temp30, temp31, temp32,
				temp33, temp34, temp35, temp36, temp37, temp38, temp39, temp40,
				temp41, temp42, temp43, temp44, temp45, temp46, temp47, temp48,
				temp49, temp50, temp51, temp52, temp53, temp54, temp55, temp56,
				temp57, temp58, temp59, temp60, temp61, temp62, temp63, temp64,
				temp65, temp66, temp67, temp68, temp69, temp70, temp71, temp72,
				temp73, temp74, temp75, temp76, temp77, temp78, temp79, temp80,
				temp81, temp82, temp83, temp84, temp85, temp86, temp87, temp88,
				temp89, temp90, temp91, temp92, temp93, temp94, temp95, temp96,
				temp97, temp98, temp99, temp100, temp101, temp102, temp103, temp104,
				temp105, temp106, temp107, temp108, temp109, temp110, temp111, temp112,
				temp113, temp114, temp115, temp116, temp117, temp118, temp119, temp120,
				temp121, temp122, temp123, temp124, temp125, temp126, temp127;


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

	wire [88:0] inPlusOne;
	wire [447:0] paddedInput;
	wire [511:0] inputSchedule;

	assign hash0 = 32'b01101010000010011110011001100111;
	assign hash1 = 32'b10111011011001111010111010000101;
	assign hash2 = 32'b00111100011011101111001101110010;
	assign hash3 = 32'b10100101010011111111010100111010;
	assign hash4 = 32'b01010001000011100101001001111111;
	assign hash5 = 32'b10011011000001010110100010001100;
	assign hash6 = 32'b00011111100000111101100110101011;
	assign hash7 = 32'b01011011111000001100110100011001;

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

	assign inPlusOne[88:1] = originalValue;
	assign inPlusOne[0] = 1'b1;

	padTo448 pad(paddedInput, inPlusOne);

	assign inputSchedule[511:64] = paddedInput;
	assign inputSchedule[63:8] = 56'b0;
	assign inputSchedule[7:0] = 8'b01011000;

	assign w[0] = inputSchedule[31:0];
	assign w[1] = inputSchedule[63:32];
	assign w[2] = inputSchedule[95:64];
	assign w[3] = inputSchedule[127:96];
	assign w[4] = inputSchedule[159:128];
	assign w[5] = inputSchedule[191:160];
	assign w[6] = inputSchedule[223:192];
	assign w[7] = inputSchedule[255:224];
	assign w[8] = inputSchedule[287:256];
	assign w[9] = inputSchedule[319:288];
	assign w[10] = inputSchedule[351:320];
	assign w[11] = inputSchedule[383:352];
	assign w[12] = inputSchedule[415:384];
	assign w[13] = inputSchedule[447:416];
	assign w[14] = inputSchedule[479:448];
	assign w[15] = inputSchedule[511:480];

	rightrotate7 rotate7_16(rot7_16, w[1]);
	rightrotate18 rotate18_16(rot18_16, w[1]);
	rightrotate3 rotate3_16(rot3_16, w[1]);
	assign s0 = (rot7_16 ^ rot18_16 ^ rot3_16);
	rightrotate17 rotate17_16(rot17_16, w[14]);
	rightrotate19 rotate19_16(rot19_16, w[14]);
	rightrotate10 rotate10_16(rot10_16, w[14]);
	assign s1 = (rot17_16 ^ rot19_16 ^ rot10_16);
	assign w[16] = w[0] + s0 + w[9] + s1;


	rightrotate7 rotate7_17(rot7_17, w[2]);
	rightrotate18 rotate18_17(rot18_17, w[2]);
	rightrotate3 rotate3_17(rot3_17, w[2]);
	assign s2 = (rot7_17 ^ rot18_17 ^ rot3_17);
	rightrotate17 rotate17_17(rot17_17, w[15]);
	rightrotate19 rotate19_17(rot19_17, w[15]);
	rightrotate10 rotate10_17(rot10_17, w[15]);
	assign s3 = (rot17_17 ^ rot19_17 ^ rot10_17);
	assign w[17] = w[1] + s2 + w[10] + s3;


	rightrotate7 rotate7_18(rot7_18, w[3]);
	rightrotate18 rotate18_18(rot18_18, w[3]);
	rightrotate3 rotate3_18(rot3_18, w[3]);
	assign s4 = (rot7_18 ^ rot18_18 ^ rot3_18);
	rightrotate17 rotate17_18(rot17_18, w[16]);
	rightrotate19 rotate19_18(rot19_18, w[16]);
	rightrotate10 rotate10_18(rot10_18, w[16]);
	assign s5 = (rot17_18 ^ rot19_18 ^ rot10_18);
	assign w[18] = w[2] + s4 + w[11] + s5;


	rightrotate7 rotate7_19(rot7_19, w[4]);
	rightrotate18 rotate18_19(rot18_19, w[4]);
	rightrotate3 rotate3_19(rot3_19, w[4]);
	assign s6 = (rot7_19 ^ rot18_19 ^ rot3_19);
	rightrotate17 rotate17_19(rot17_19, w[17]);
	rightrotate19 rotate19_19(rot19_19, w[17]);
	rightrotate10 rotate10_19(rot10_19, w[17]);
	assign s7 = (rot17_19 ^ rot19_19 ^ rot10_19);
	assign w[19] = w[3] + s6 + w[12] + s7;


	rightrotate7 rotate7_20(rot7_20, w[5]);
	rightrotate18 rotate18_20(rot18_20, w[5]);
	rightrotate3 rotate3_20(rot3_20, w[5]);
	assign s8 = (rot7_20 ^ rot18_20 ^ rot3_20);
	rightrotate17 rotate17_20(rot17_20, w[18]);
	rightrotate19 rotate19_20(rot19_20, w[18]);
	rightrotate10 rotate10_20(rot10_20, w[18]);
	assign s9 = (rot17_20 ^ rot19_20 ^ rot10_20);
	assign w[20] = w[4] + s8 + w[13] + s9;


	rightrotate7 rotate7_21(rot7_21, w[6]);
	rightrotate18 rotate18_21(rot18_21, w[6]);
	rightrotate3 rotate3_21(rot3_21, w[6]);
	assign s10 = (rot7_21 ^ rot18_21 ^ rot3_21);
	rightrotate17 rotate17_21(rot17_21, w[19]);
	rightrotate19 rotate19_21(rot19_21, w[19]);
	rightrotate10 rotate10_21(rot10_21, w[19]);
	assign s11 = (rot17_21 ^ rot19_21 ^ rot10_21);
	assign w[21] = w[5] + s10 + w[14] + s11;


	rightrotate7 rotate7_22(rot7_22, w[7]);
	rightrotate18 rotate18_22(rot18_22, w[7]);
	rightrotate3 rotate3_22(rot3_22, w[7]);
	assign s12 = (rot7_22 ^ rot18_22 ^ rot3_22);
	rightrotate17 rotate17_22(rot17_22, w[20]);
	rightrotate19 rotate19_22(rot19_22, w[20]);
	rightrotate10 rotate10_22(rot10_22, w[20]);
	assign s13 = (rot17_22 ^ rot19_22 ^ rot10_22);
	assign w[22] = w[6] + s12 + w[15] + s13;


	rightrotate7 rotate7_23(rot7_23, w[8]);
	rightrotate18 rotate18_23(rot18_23, w[8]);
	rightrotate3 rotate3_23(rot3_23, w[8]);
	assign s14 = (rot7_23 ^ rot18_23 ^ rot3_23);
	rightrotate17 rotate17_23(rot17_23, w[21]);
	rightrotate19 rotate19_23(rot19_23, w[21]);
	rightrotate10 rotate10_23(rot10_23, w[21]);
	assign s15 = (rot17_23 ^ rot19_23 ^ rot10_23);
	assign w[23] = w[7] + s14 + w[16] + s15;


	rightrotate7 rotate7_24(rot7_24, w[9]);
	rightrotate18 rotate18_24(rot18_24, w[9]);
	rightrotate3 rotate3_24(rot3_24, w[9]);
	assign s16 = (rot7_24 ^ rot18_24 ^ rot3_24);
	rightrotate17 rotate17_24(rot17_24, w[22]);
	rightrotate19 rotate19_24(rot19_24, w[22]);
	rightrotate10 rotate10_24(rot10_24, w[22]);
	assign s17 = (rot17_24 ^ rot19_24 ^ rot10_24);
	assign w[24] = w[8] + s16 + w[17] + s17;


	rightrotate7 rotate7_25(rot7_25, w[10]);
	rightrotate18 rotate18_25(rot18_25, w[10]);
	rightrotate3 rotate3_25(rot3_25, w[10]);
	assign s18 = (rot7_25 ^ rot18_25 ^ rot3_25);
	rightrotate17 rotate17_25(rot17_25, w[23]);
	rightrotate19 rotate19_25(rot19_25, w[23]);
	rightrotate10 rotate10_25(rot10_25, w[23]);
	assign s19 = (rot17_25 ^ rot19_25 ^ rot10_25);
	assign w[25] = w[9] + s18 + w[18] + s19;


	rightrotate7 rotate7_26(rot7_26, w[11]);
	rightrotate18 rotate18_26(rot18_26, w[11]);
	rightrotate3 rotate3_26(rot3_26, w[11]);
	assign s20 = (rot7_26 ^ rot18_26 ^ rot3_26);
	rightrotate17 rotate17_26(rot17_26, w[24]);
	rightrotate19 rotate19_26(rot19_26, w[24]);
	rightrotate10 rotate10_26(rot10_26, w[24]);
	assign s21 = (rot17_26 ^ rot19_26 ^ rot10_26);
	assign w[26] = w[10] + s20 + w[19] + s21;


	rightrotate7 rotate7_27(rot7_27, w[12]);
	rightrotate18 rotate18_27(rot18_27, w[12]);
	rightrotate3 rotate3_27(rot3_27, w[12]);
	assign s22 = (rot7_27 ^ rot18_27 ^ rot3_27);
	rightrotate17 rotate17_27(rot17_27, w[25]);
	rightrotate19 rotate19_27(rot19_27, w[25]);
	rightrotate10 rotate10_27(rot10_27, w[25]);
	assign s23 = (rot17_27 ^ rot19_27 ^ rot10_27);
	assign w[27] = w[11] + s22 + w[20] + s23;


	rightrotate7 rotate7_28(rot7_28, w[13]);
	rightrotate18 rotate18_28(rot18_28, w[13]);
	rightrotate3 rotate3_28(rot3_28, w[13]);
	assign s24 = (rot7_28 ^ rot18_28 ^ rot3_28);
	rightrotate17 rotate17_28(rot17_28, w[26]);
	rightrotate19 rotate19_28(rot19_28, w[26]);
	rightrotate10 rotate10_28(rot10_28, w[26]);
	assign s25 = (rot17_28 ^ rot19_28 ^ rot10_28);
	assign w[28] = w[12] + s24 + w[21] + s25;


	rightrotate7 rotate7_29(rot7_29, w[14]);
	rightrotate18 rotate18_29(rot18_29, w[14]);
	rightrotate3 rotate3_29(rot3_29, w[14]);
	assign s26 = (rot7_29 ^ rot18_29 ^ rot3_29);
	rightrotate17 rotate17_29(rot17_29, w[27]);
	rightrotate19 rotate19_29(rot19_29, w[27]);
	rightrotate10 rotate10_29(rot10_29, w[27]);
	assign s27 = (rot17_29 ^ rot19_29 ^ rot10_29);
	assign w[29] = w[13] + s26 + w[22] + s27;


	rightrotate7 rotate7_30(rot7_30, w[15]);
	rightrotate18 rotate18_30(rot18_30, w[15]);
	rightrotate3 rotate3_30(rot3_30, w[15]);
	assign s28 = (rot7_30 ^ rot18_30 ^ rot3_30);
	rightrotate17 rotate17_30(rot17_30, w[28]);
	rightrotate19 rotate19_30(rot19_30, w[28]);
	rightrotate10 rotate10_30(rot10_30, w[28]);
	assign s29 = (rot17_30 ^ rot19_30 ^ rot10_30);
	assign w[30] = w[14] + s28 + w[23] + s29;


	rightrotate7 rotate7_31(rot7_31, w[16]);
	rightrotate18 rotate18_31(rot18_31, w[16]);
	rightrotate3 rotate3_31(rot3_31, w[16]);
	assign s30 = (rot7_31 ^ rot18_31 ^ rot3_31);
	rightrotate17 rotate17_31(rot17_31, w[29]);
	rightrotate19 rotate19_31(rot19_31, w[29]);
	rightrotate10 rotate10_31(rot10_31, w[29]);
	assign s31 = (rot17_31 ^ rot19_31 ^ rot10_31);
	assign w[31] = w[15] + s30 + w[24] + s31;


	rightrotate7 rotate7_32(rot7_32, w[17]);
	rightrotate18 rotate18_32(rot18_32, w[17]);
	rightrotate3 rotate3_32(rot3_32, w[17]);
	assign s32 = (rot7_32 ^ rot18_32 ^ rot3_32);
	rightrotate17 rotate17_32(rot17_32, w[30]);
	rightrotate19 rotate19_32(rot19_32, w[30]);
	rightrotate10 rotate10_32(rot10_32, w[30]);
	assign s33 = (rot17_32 ^ rot19_32 ^ rot10_32);
	assign w[32] = w[16] + s32 + w[25] + s33;


	rightrotate7 rotate7_33(rot7_33, w[18]);
	rightrotate18 rotate18_33(rot18_33, w[18]);
	rightrotate3 rotate3_33(rot3_33, w[18]);
	assign s34 = (rot7_33 ^ rot18_33 ^ rot3_33);
	rightrotate17 rotate17_33(rot17_33, w[31]);
	rightrotate19 rotate19_33(rot19_33, w[31]);
	rightrotate10 rotate10_33(rot10_33, w[31]);
	assign s35 = (rot17_33 ^ rot19_33 ^ rot10_33);
	assign w[33] = w[17] + s34 + w[26] + s35;


	rightrotate7 rotate7_34(rot7_34, w[19]);
	rightrotate18 rotate18_34(rot18_34, w[19]);
	rightrotate3 rotate3_34(rot3_34, w[19]);
	assign s36 = (rot7_34 ^ rot18_34 ^ rot3_34);
	rightrotate17 rotate17_34(rot17_34, w[32]);
	rightrotate19 rotate19_34(rot19_34, w[32]);
	rightrotate10 rotate10_34(rot10_34, w[32]);
	assign s37 = (rot17_34 ^ rot19_34 ^ rot10_34);
	assign w[34] = w[18] + s36 + w[27] + s37;


	rightrotate7 rotate7_35(rot7_35, w[20]);
	rightrotate18 rotate18_35(rot18_35, w[20]);
	rightrotate3 rotate3_35(rot3_35, w[20]);
	assign s38 = (rot7_35 ^ rot18_35 ^ rot3_35);
	rightrotate17 rotate17_35(rot17_35, w[33]);
	rightrotate19 rotate19_35(rot19_35, w[33]);
	rightrotate10 rotate10_35(rot10_35, w[33]);
	assign s39 = (rot17_35 ^ rot19_35 ^ rot10_35);
	assign w[35] = w[19] + s38 + w[28] + s39;


	rightrotate7 rotate7_36(rot7_36, w[21]);
	rightrotate18 rotate18_36(rot18_36, w[21]);
	rightrotate3 rotate3_36(rot3_36, w[21]);
	assign s40 = (rot7_36 ^ rot18_36 ^ rot3_36);
	rightrotate17 rotate17_36(rot17_36, w[34]);
	rightrotate19 rotate19_36(rot19_36, w[34]);
	rightrotate10 rotate10_36(rot10_36, w[34]);
	assign s41 = (rot17_36 ^ rot19_36 ^ rot10_36);
	assign w[36] = w[20] + s40 + w[29] + s41;


	rightrotate7 rotate7_37(rot7_37, w[22]);
	rightrotate18 rotate18_37(rot18_37, w[22]);
	rightrotate3 rotate3_37(rot3_37, w[22]);
	assign s42 = (rot7_37 ^ rot18_37 ^ rot3_37);
	rightrotate17 rotate17_37(rot17_37, w[35]);
	rightrotate19 rotate19_37(rot19_37, w[35]);
	rightrotate10 rotate10_37(rot10_37, w[35]);
	assign s43 = (rot17_37 ^ rot19_37 ^ rot10_37);
	assign w[37] = w[21] + s42 + w[30] + s43;


	rightrotate7 rotate7_38(rot7_38, w[23]);
	rightrotate18 rotate18_38(rot18_38, w[23]);
	rightrotate3 rotate3_38(rot3_38, w[23]);
	assign s44 = (rot7_38 ^ rot18_38 ^ rot3_38);
	rightrotate17 rotate17_38(rot17_38, w[36]);
	rightrotate19 rotate19_38(rot19_38, w[36]);
	rightrotate10 rotate10_38(rot10_38, w[36]);
	assign s45 = (rot17_38 ^ rot19_38 ^ rot10_38);
	assign w[38] = w[22] + s44 + w[31] + s45;


	rightrotate7 rotate7_39(rot7_39, w[24]);
	rightrotate18 rotate18_39(rot18_39, w[24]);
	rightrotate3 rotate3_39(rot3_39, w[24]);
	assign s46 = (rot7_39 ^ rot18_39 ^ rot3_39);
	rightrotate17 rotate17_39(rot17_39, w[37]);
	rightrotate19 rotate19_39(rot19_39, w[37]);
	rightrotate10 rotate10_39(rot10_39, w[37]);
	assign s47 = (rot17_39 ^ rot19_39 ^ rot10_39);
	assign w[39] = w[23] + s46 + w[32] + s47;


	rightrotate7 rotate7_40(rot7_40, w[25]);
	rightrotate18 rotate18_40(rot18_40, w[25]);
	rightrotate3 rotate3_40(rot3_40, w[25]);
	assign s48 = (rot7_40 ^ rot18_40 ^ rot3_40);
	rightrotate17 rotate17_40(rot17_40, w[38]);
	rightrotate19 rotate19_40(rot19_40, w[38]);
	rightrotate10 rotate10_40(rot10_40, w[38]);
	assign s49 = (rot17_40 ^ rot19_40 ^ rot10_40);
	assign w[40] = w[24] + s48 + w[33] + s49;


	rightrotate7 rotate7_41(rot7_41, w[26]);
	rightrotate18 rotate18_41(rot18_41, w[26]);
	rightrotate3 rotate3_41(rot3_41, w[26]);
	assign s50 = (rot7_41 ^ rot18_41 ^ rot3_41);
	rightrotate17 rotate17_41(rot17_41, w[39]);
	rightrotate19 rotate19_41(rot19_41, w[39]);
	rightrotate10 rotate10_41(rot10_41, w[39]);
	assign s51 = (rot17_41 ^ rot19_41 ^ rot10_41);
	assign w[41] = w[25] + s50 + w[34] + s51;


	rightrotate7 rotate7_42(rot7_42, w[27]);
	rightrotate18 rotate18_42(rot18_42, w[27]);
	rightrotate3 rotate3_42(rot3_42, w[27]);
	assign s52 = (rot7_42 ^ rot18_42 ^ rot3_42);
	rightrotate17 rotate17_42(rot17_42, w[40]);
	rightrotate19 rotate19_42(rot19_42, w[40]);
	rightrotate10 rotate10_42(rot10_42, w[40]);
	assign s53 = (rot17_42 ^ rot19_42 ^ rot10_42);
	assign w[42] = w[26] + s52 + w[35] + s53;


	rightrotate7 rotate7_43(rot7_43, w[28]);
	rightrotate18 rotate18_43(rot18_43, w[28]);
	rightrotate3 rotate3_43(rot3_43, w[28]);
	assign s54 = (rot7_43 ^ rot18_43 ^ rot3_43);
	rightrotate17 rotate17_43(rot17_43, w[41]);
	rightrotate19 rotate19_43(rot19_43, w[41]);
	rightrotate10 rotate10_43(rot10_43, w[41]);
	assign s55 = (rot17_43 ^ rot19_43 ^ rot10_43);
	assign w[43] = w[27] + s54 + w[36] + s55;


	rightrotate7 rotate7_44(rot7_44, w[29]);
	rightrotate18 rotate18_44(rot18_44, w[29]);
	rightrotate3 rotate3_44(rot3_44, w[29]);
	assign s56 = (rot7_44 ^ rot18_44 ^ rot3_44);
	rightrotate17 rotate17_44(rot17_44, w[42]);
	rightrotate19 rotate19_44(rot19_44, w[42]);
	rightrotate10 rotate10_44(rot10_44, w[42]);
	assign s57 = (rot17_44 ^ rot19_44 ^ rot10_44);
	assign w[44] = w[28] + s56 + w[37] + s57;


	rightrotate7 rotate7_45(rot7_45, w[30]);
	rightrotate18 rotate18_45(rot18_45, w[30]);
	rightrotate3 rotate3_45(rot3_45, w[30]);
	assign s58 = (rot7_45 ^ rot18_45 ^ rot3_45);
	rightrotate17 rotate17_45(rot17_45, w[43]);
	rightrotate19 rotate19_45(rot19_45, w[43]);
	rightrotate10 rotate10_45(rot10_45, w[43]);
	assign s59 = (rot17_45 ^ rot19_45 ^ rot10_45);
	assign w[45] = w[29] + s58 + w[38] + s59;


	rightrotate7 rotate7_46(rot7_46, w[31]);
	rightrotate18 rotate18_46(rot18_46, w[31]);
	rightrotate3 rotate3_46(rot3_46, w[31]);
	assign s60 = (rot7_46 ^ rot18_46 ^ rot3_46);
	rightrotate17 rotate17_46(rot17_46, w[44]);
	rightrotate19 rotate19_46(rot19_46, w[44]);
	rightrotate10 rotate10_46(rot10_46, w[44]);
	assign s61 = (rot17_46 ^ rot19_46 ^ rot10_46);
	assign w[46] = w[30] + s60 + w[39] + s61;


	rightrotate7 rotate7_47(rot7_47, w[32]);
	rightrotate18 rotate18_47(rot18_47, w[32]);
	rightrotate3 rotate3_47(rot3_47, w[32]);
	assign s62 = (rot7_47 ^ rot18_47 ^ rot3_47);
	rightrotate17 rotate17_47(rot17_47, w[45]);
	rightrotate19 rotate19_47(rot19_47, w[45]);
	rightrotate10 rotate10_47(rot10_47, w[45]);
	assign s63 = (rot17_47 ^ rot19_47 ^ rot10_47);
	assign w[47] = w[31] + s62 + w[40] + s63;


	rightrotate7 rotate7_48(rot7_48, w[33]);
	rightrotate18 rotate18_48(rot18_48, w[33]);
	rightrotate3 rotate3_48(rot3_48, w[33]);
	assign s64 = (rot7_48 ^ rot18_48 ^ rot3_48);
	rightrotate17 rotate17_48(rot17_48, w[46]);
	rightrotate19 rotate19_48(rot19_48, w[46]);
	rightrotate10 rotate10_48(rot10_48, w[46]);
	assign s65 = (rot17_48 ^ rot19_48 ^ rot10_48);
	assign w[48] = w[32] + s64 + w[41] + s65;


	rightrotate7 rotate7_49(rot7_49, w[34]);
	rightrotate18 rotate18_49(rot18_49, w[34]);
	rightrotate3 rotate3_49(rot3_49, w[34]);
	assign s66 = (rot7_49 ^ rot18_49 ^ rot3_49);
	rightrotate17 rotate17_49(rot17_49, w[47]);
	rightrotate19 rotate19_49(rot19_49, w[47]);
	rightrotate10 rotate10_49(rot10_49, w[47]);
	assign s67 = (rot17_49 ^ rot19_49 ^ rot10_49);
	assign w[49] = w[33] + s66 + w[42] + s67;


	rightrotate7 rotate7_50(rot7_50, w[35]);
	rightrotate18 rotate18_50(rot18_50, w[35]);
	rightrotate3 rotate3_50(rot3_50, w[35]);
	assign s68 = (rot7_50 ^ rot18_50 ^ rot3_50);
	rightrotate17 rotate17_50(rot17_50, w[48]);
	rightrotate19 rotate19_50(rot19_50, w[48]);
	rightrotate10 rotate10_50(rot10_50, w[48]);
	assign s69 = (rot17_50 ^ rot19_50 ^ rot10_50);
	assign w[50] = w[34] + s68 + w[43] + s69;


	rightrotate7 rotate7_51(rot7_51, w[36]);
	rightrotate18 rotate18_51(rot18_51, w[36]);
	rightrotate3 rotate3_51(rot3_51, w[36]);
	assign s70 = (rot7_51 ^ rot18_51 ^ rot3_51);
	rightrotate17 rotate17_51(rot17_51, w[49]);
	rightrotate19 rotate19_51(rot19_51, w[49]);
	rightrotate10 rotate10_51(rot10_51, w[49]);
	assign s71 = (rot17_51 ^ rot19_51 ^ rot10_51);
	assign w[51] = w[35] + s70 + w[44] + s71;


	rightrotate7 rotate7_52(rot7_52, w[37]);
	rightrotate18 rotate18_52(rot18_52, w[37]);
	rightrotate3 rotate3_52(rot3_52, w[37]);
	assign s72 = (rot7_52 ^ rot18_52 ^ rot3_52);
	rightrotate17 rotate17_52(rot17_52, w[50]);
	rightrotate19 rotate19_52(rot19_52, w[50]);
	rightrotate10 rotate10_52(rot10_52, w[50]);
	assign s73 = (rot17_52 ^ rot19_52 ^ rot10_52);
	assign w[52] = w[36] + s72 + w[45] + s73;


	rightrotate7 rotate7_53(rot7_53, w[38]);
	rightrotate18 rotate18_53(rot18_53, w[38]);
	rightrotate3 rotate3_53(rot3_53, w[38]);
	assign s74 = (rot7_53 ^ rot18_53 ^ rot3_53);
	rightrotate17 rotate17_53(rot17_53, w[51]);
	rightrotate19 rotate19_53(rot19_53, w[51]);
	rightrotate10 rotate10_53(rot10_53, w[51]);
	assign s75 = (rot17_53 ^ rot19_53 ^ rot10_53);
	assign w[53] = w[37] + s74 + w[46] + s75;


	rightrotate7 rotate7_54(rot7_54, w[39]);
	rightrotate18 rotate18_54(rot18_54, w[39]);
	rightrotate3 rotate3_54(rot3_54, w[39]);
	assign s76 = (rot7_54 ^ rot18_54 ^ rot3_54);
	rightrotate17 rotate17_54(rot17_54, w[52]);
	rightrotate19 rotate19_54(rot19_54, w[52]);
	rightrotate10 rotate10_54(rot10_54, w[52]);
	assign s77 = (rot17_54 ^ rot19_54 ^ rot10_54);
	assign w[54] = w[38] + s76 + w[47] + s77;


	rightrotate7 rotate7_55(rot7_55, w[40]);
	rightrotate18 rotate18_55(rot18_55, w[40]);
	rightrotate3 rotate3_55(rot3_55, w[40]);
	assign s78 = (rot7_55 ^ rot18_55 ^ rot3_55);
	rightrotate17 rotate17_55(rot17_55, w[53]);
	rightrotate19 rotate19_55(rot19_55, w[53]);
	rightrotate10 rotate10_55(rot10_55, w[53]);
	assign s79 = (rot17_55 ^ rot19_55 ^ rot10_55);
	assign w[55] = w[39] + s78 + w[48] + s79;


	rightrotate7 rotate7_56(rot7_56, w[41]);
	rightrotate18 rotate18_56(rot18_56, w[41]);
	rightrotate3 rotate3_56(rot3_56, w[41]);
	assign s80 = (rot7_56 ^ rot18_56 ^ rot3_56);
	rightrotate17 rotate17_56(rot17_56, w[54]);
	rightrotate19 rotate19_56(rot19_56, w[54]);
	rightrotate10 rotate10_56(rot10_56, w[54]);
	assign s81 = (rot17_56 ^ rot19_56 ^ rot10_56);
	assign w[56] = w[40] + s80 + w[49] + s81;


	rightrotate7 rotate7_57(rot7_57, w[42]);
	rightrotate18 rotate18_57(rot18_57, w[42]);
	rightrotate3 rotate3_57(rot3_57, w[42]);
	assign s82 = (rot7_57 ^ rot18_57 ^ rot3_57);
	rightrotate17 rotate17_57(rot17_57, w[55]);
	rightrotate19 rotate19_57(rot19_57, w[55]);
	rightrotate10 rotate10_57(rot10_57, w[55]);
	assign s83 = (rot17_57 ^ rot19_57 ^ rot10_57);
	assign w[57] = w[41] + s82 + w[50] + s83;


	rightrotate7 rotate7_58(rot7_58, w[43]);
	rightrotate18 rotate18_58(rot18_58, w[43]);
	rightrotate3 rotate3_58(rot3_58, w[43]);
	assign s84 = (rot7_58 ^ rot18_58 ^ rot3_58);
	rightrotate17 rotate17_58(rot17_58, w[56]);
	rightrotate19 rotate19_58(rot19_58, w[56]);
	rightrotate10 rotate10_58(rot10_58, w[56]);
	assign s85 = (rot17_58 ^ rot19_58 ^ rot10_58);
	assign w[58] = w[42] + s84 + w[51] + s85;


	rightrotate7 rotate7_59(rot7_59, w[44]);
	rightrotate18 rotate18_59(rot18_59, w[44]);
	rightrotate3 rotate3_59(rot3_59, w[44]);
	assign s86 = (rot7_59 ^ rot18_59 ^ rot3_59);
	rightrotate17 rotate17_59(rot17_59, w[57]);
	rightrotate19 rotate19_59(rot19_59, w[57]);
	rightrotate10 rotate10_59(rot10_59, w[57]);
	assign s87 = (rot17_59 ^ rot19_59 ^ rot10_59);
	assign w[59] = w[43] + s86 + w[52] + s87;


	rightrotate7 rotate7_60(rot7_60, w[45]);
	rightrotate18 rotate18_60(rot18_60, w[45]);
	rightrotate3 rotate3_60(rot3_60, w[45]);
	assign s88 = (rot7_60 ^ rot18_60 ^ rot3_60);
	rightrotate17 rotate17_60(rot17_60, w[58]);
	rightrotate19 rotate19_60(rot19_60, w[58]);
	rightrotate10 rotate10_60(rot10_60, w[58]);
	assign s89 = (rot17_60 ^ rot19_60 ^ rot10_60);
	assign w[60] = w[44] + s88 + w[53] + s89;


	rightrotate7 rotate7_61(rot7_61, w[46]);
	rightrotate18 rotate18_61(rot18_61, w[46]);
	rightrotate3 rotate3_61(rot3_61, w[46]);
	assign s90 = (rot7_61 ^ rot18_61 ^ rot3_61);
	rightrotate17 rotate17_61(rot17_61, w[59]);
	rightrotate19 rotate19_61(rot19_61, w[59]);
	rightrotate10 rotate10_61(rot10_61, w[59]);
	assign s91 = (rot17_61 ^ rot19_61 ^ rot10_61);
	assign w[61] = w[45] + s90 + w[54] + s91;


	rightrotate7 rotate7_62(rot7_62, w[47]);
	rightrotate18 rotate18_62(rot18_62, w[47]);
	rightrotate3 rotate3_62(rot3_62, w[47]);
	assign s92 = (rot7_62 ^ rot18_62 ^ rot3_62);
	rightrotate17 rotate17_62(rot17_62, w[60]);
	rightrotate19 rotate19_62(rot19_62, w[60]);
	rightrotate10 rotate10_62(rot10_62, w[60]);
	assign s93 = (rot17_62 ^ rot19_62 ^ rot10_62);
	assign w[62] = w[46] + s92 + w[55] + s93;


	rightrotate7 rotate7_63(rot7_63, w[48]);
	rightrotate18 rotate18_63(rot18_63, w[48]);
	rightrotate3 rotate3_63(rot3_63, w[48]);
	assign s94 = (rot7_63 ^ rot18_63 ^ rot3_63);
	rightrotate17 rotate17_63(rot17_63, w[61]);
	rightrotate19 rotate19_63(rot19_63, w[61]);
	rightrotate10 rotate10_63(rot10_63, w[61]);
	assign s95 = (rot17_63 ^ rot19_63 ^ rot10_63);
	assign w[63] = w[47] + s94 + w[56] + s95;



	assign a0 = hash0;
	assign b0 = hash1;
	assign c0 = hash2;
	assign d0 = hash3;
	assign e0 = hash4;
	assign f0 = hash5;
	assign g0 = hash6;
	assign h0 = hash7;

	rightrotate6 rotate6_0(rot6_0, e0);
	rightrotate11 rotate11_0(rot11_0, e0);
	rightrotate25 rotate25_0(rot25_0, e0);
	assign S0 = (rot6_0 ^ rot11_0 ^ rot25_0);
	assign ch0 = ((e0 & f0) ^ (~e0 & g0));
	assign temp1 = h0 + c0 + ch0 +k[0] + w[0];
	rightrotate2 rotate2_0(rot2_0, a0);
	rightrotate13 rotate13_0(rot13_0, a0);
	rightrotate22 rotate22_0(rot22_0, a0);
	assign S1 = (rot2_0 ^ rot13_0 ^ rot22_0);
	assign maj0 = ((a0 & b0) ^ (a0 & c0) ^ (b0 & c0));
	assign temp2 = c1 + maj0;
	assign h1 = g0;
	assign g1 = f0;
	assign f1 = e0;
	assign e1 = d0 + temp1;
	assign d1 = c0;
	assign c1 = b0;
	assign b1 = a0;
	assign a1 = temp1 + temp2;


	rightrotate6 rotate6_1(rot6_1, e1);
	rightrotate11 rotate11_1(rot11_1, e1);
	rightrotate25 rotate25_1(rot25_1, e1);
	assign S2 = (rot6_1 ^ rot11_1 ^ rot25_1);
	assign ch1 = ((e1 & f1) ^ (~e1 & g1));
	assign temp3 = h1 + c1 + ch1 +k[1] + w[1];
	rightrotate2 rotate2_1(rot2_1, a1);
	rightrotate13 rotate13_1(rot13_1, a1);
	rightrotate22 rotate22_1(rot22_1, a1);
	assign S3 = (rot2_1 ^ rot13_1 ^ rot22_1);
	assign maj1 = ((a1 & b1) ^ (a1 & c1) ^ (b1 & c1));
	assign temp4 = c2 + maj1;
	assign h2 = g1;
	assign g2 = f1;
	assign f2 = e1;
	assign e2 = d1 + temp3;
	assign d2 = c1;
	assign c2 = b1;
	assign b2 = a1;
	assign a2 = temp3 + temp4;


	rightrotate6 rotate6_2(rot6_2, e2);
	rightrotate11 rotate11_2(rot11_2, e2);
	rightrotate25 rotate25_2(rot25_2, e2);
	assign S4 = (rot6_2 ^ rot11_2 ^ rot25_2);
	assign ch2 = ((e2 & f2) ^ (~e2 & g2));
	assign temp5 = h2 + c2 + ch2 +k[2] + w[2];
	rightrotate2 rotate2_2(rot2_2, a2);
	rightrotate13 rotate13_2(rot13_2, a2);
	rightrotate22 rotate22_2(rot22_2, a2);
	assign S5 = (rot2_2 ^ rot13_2 ^ rot22_2);
	assign maj2 = ((a2 & b2) ^ (a2 & c2) ^ (b2 & c2));
	assign temp6 = c3 + maj2;
	assign h3 = g2;
	assign g3 = f2;
	assign f3 = e2;
	assign e3 = d2 + temp5;
	assign d3 = c2;
	assign c3 = b2;
	assign b3 = a2;
	assign a3 = temp5 + temp6;


	rightrotate6 rotate6_3(rot6_3, e3);
	rightrotate11 rotate11_3(rot11_3, e3);
	rightrotate25 rotate25_3(rot25_3, e3);
	assign S6 = (rot6_3 ^ rot11_3 ^ rot25_3);
	assign ch3 = ((e3 & f3) ^ (~e3 & g3));
	assign temp7 = h3 + c3 + ch3 +k[3] + w[3];
	rightrotate2 rotate2_3(rot2_3, a3);
	rightrotate13 rotate13_3(rot13_3, a3);
	rightrotate22 rotate22_3(rot22_3, a3);
	assign S7 = (rot2_3 ^ rot13_3 ^ rot22_3);
	assign maj3 = ((a3 & b3) ^ (a3 & c3) ^ (b3 & c3));
	assign temp8 = c4 + maj3;
	assign h4 = g3;
	assign g4 = f3;
	assign f4 = e3;
	assign e4 = d3 + temp7;
	assign d4 = c3;
	assign c4 = b3;
	assign b4 = a3;
	assign a4 = temp7 + temp8;


	rightrotate6 rotate6_4(rot6_4, e4);
	rightrotate11 rotate11_4(rot11_4, e4);
	rightrotate25 rotate25_4(rot25_4, e4);
	assign S8 = (rot6_4 ^ rot11_4 ^ rot25_4);
	assign ch4 = ((e4 & f4) ^ (~e4 & g4));
	assign temp9 = h4 + c4 + ch4 +k[4] + w[4];
	rightrotate2 rotate2_4(rot2_4, a4);
	rightrotate13 rotate13_4(rot13_4, a4);
	rightrotate22 rotate22_4(rot22_4, a4);
	assign S9 = (rot2_4 ^ rot13_4 ^ rot22_4);
	assign maj4 = ((a4 & b4) ^ (a4 & c4) ^ (b4 & c4));
	assign temp10 = c5 + maj4;
	assign h5 = g4;
	assign g5 = f4;
	assign f5 = e4;
	assign e5 = d4 + temp9;
	assign d5 = c4;
	assign c5 = b4;
	assign b5 = a4;
	assign a5 = temp9 + temp10;


	rightrotate6 rotate6_5(rot6_5, e5);
	rightrotate11 rotate11_5(rot11_5, e5);
	rightrotate25 rotate25_5(rot25_5, e5);
	assign S10 = (rot6_5 ^ rot11_5 ^ rot25_5);
	assign ch5 = ((e5 & f5) ^ (~e5 & g5));
	assign temp11 = h5 + c5 + ch5 +k[5] + w[5];
	rightrotate2 rotate2_5(rot2_5, a5);
	rightrotate13 rotate13_5(rot13_5, a5);
	rightrotate22 rotate22_5(rot22_5, a5);
	assign S11 = (rot2_5 ^ rot13_5 ^ rot22_5);
	assign maj5 = ((a5 & b5) ^ (a5 & c5) ^ (b5 & c5));
	assign temp12 = c6 + maj5;
	assign h6 = g5;
	assign g6 = f5;
	assign f6 = e5;
	assign e6 = d5 + temp11;
	assign d6 = c5;
	assign c6 = b5;
	assign b6 = a5;
	assign a6 = temp11 + temp12;


	rightrotate6 rotate6_6(rot6_6, e6);
	rightrotate11 rotate11_6(rot11_6, e6);
	rightrotate25 rotate25_6(rot25_6, e6);
	assign S12 = (rot6_6 ^ rot11_6 ^ rot25_6);
	assign ch6 = ((e6 & f6) ^ (~e6 & g6));
	assign temp13 = h6 + c6 + ch6 +k[6] + w[6];
	rightrotate2 rotate2_6(rot2_6, a6);
	rightrotate13 rotate13_6(rot13_6, a6);
	rightrotate22 rotate22_6(rot22_6, a6);
	assign S13 = (rot2_6 ^ rot13_6 ^ rot22_6);
	assign maj6 = ((a6 & b6) ^ (a6 & c6) ^ (b6 & c6));
	assign temp14 = c7 + maj6;
	assign h7 = g6;
	assign g7 = f6;
	assign f7 = e6;
	assign e7 = d6 + temp13;
	assign d7 = c6;
	assign c7 = b6;
	assign b7 = a6;
	assign a7 = temp13 + temp14;


	rightrotate6 rotate6_7(rot6_7, e7);
	rightrotate11 rotate11_7(rot11_7, e7);
	rightrotate25 rotate25_7(rot25_7, e7);
	assign S14 = (rot6_7 ^ rot11_7 ^ rot25_7);
	assign ch7 = ((e7 & f7) ^ (~e7 & g7));
	assign temp15 = h7 + c7 + ch7 +k[7] + w[7];
	rightrotate2 rotate2_7(rot2_7, a7);
	rightrotate13 rotate13_7(rot13_7, a7);
	rightrotate22 rotate22_7(rot22_7, a7);
	assign S15 = (rot2_7 ^ rot13_7 ^ rot22_7);
	assign maj7 = ((a7 & b7) ^ (a7 & c7) ^ (b7 & c7));
	assign temp16 = c8 + maj7;
	assign h8 = g7;
	assign g8 = f7;
	assign f8 = e7;
	assign e8 = d7 + temp15;
	assign d8 = c7;
	assign c8 = b7;
	assign b8 = a7;
	assign a8 = temp15 + temp16;


	rightrotate6 rotate6_8(rot6_8, e8);
	rightrotate11 rotate11_8(rot11_8, e8);
	rightrotate25 rotate25_8(rot25_8, e8);
	assign S16 = (rot6_8 ^ rot11_8 ^ rot25_8);
	assign ch8 = ((e8 & f8) ^ (~e8 & g8));
	assign temp17 = h8 + c8 + ch8 +k[8] + w[8];
	rightrotate2 rotate2_8(rot2_8, a8);
	rightrotate13 rotate13_8(rot13_8, a8);
	rightrotate22 rotate22_8(rot22_8, a8);
	assign S17 = (rot2_8 ^ rot13_8 ^ rot22_8);
	assign maj8 = ((a8 & b8) ^ (a8 & c8) ^ (b8 & c8));
	assign temp18 = c9 + maj8;
	assign h9 = g8;
	assign g9 = f8;
	assign f9 = e8;
	assign e9 = d8 + temp17;
	assign d9 = c8;
	assign c9 = b8;
	assign b9 = a8;
	assign a9 = temp17 + temp18;


	rightrotate6 rotate6_9(rot6_9, e9);
	rightrotate11 rotate11_9(rot11_9, e9);
	rightrotate25 rotate25_9(rot25_9, e9);
	assign S18 = (rot6_9 ^ rot11_9 ^ rot25_9);
	assign ch9 = ((e9 & f9) ^ (~e9 & g9));
	assign temp19 = h9 + c9 + ch9 +k[9] + w[9];
	rightrotate2 rotate2_9(rot2_9, a9);
	rightrotate13 rotate13_9(rot13_9, a9);
	rightrotate22 rotate22_9(rot22_9, a9);
	assign S19 = (rot2_9 ^ rot13_9 ^ rot22_9);
	assign maj9 = ((a9 & b9) ^ (a9 & c9) ^ (b9 & c9));
	assign temp20 = c10 + maj9;
	assign h10 = g9;
	assign g10 = f9;
	assign f10 = e9;
	assign e10 = d9 + temp19;
	assign d10 = c9;
	assign c10 = b9;
	assign b10 = a9;
	assign a10 = temp19 + temp20;


	rightrotate6 rotate6_10(rot6_10, e10);
	rightrotate11 rotate11_10(rot11_10, e10);
	rightrotate25 rotate25_10(rot25_10, e10);
	assign S20 = (rot6_10 ^ rot11_10 ^ rot25_10);
	assign ch10 = ((e10 & f10) ^ (~e10 & g10));
	assign temp21 = h10 + c10 + ch10 +k[10] + w[10];
	rightrotate2 rotate2_10(rot2_10, a10);
	rightrotate13 rotate13_10(rot13_10, a10);
	rightrotate22 rotate22_10(rot22_10, a10);
	assign S21 = (rot2_10 ^ rot13_10 ^ rot22_10);
	assign maj10 = ((a10 & b10) ^ (a10 & c10) ^ (b10 & c10));
	assign temp22 = c11 + maj10;
	assign h11 = g10;
	assign g11 = f10;
	assign f11 = e10;
	assign e11 = d10 + temp21;
	assign d11 = c10;
	assign c11 = b10;
	assign b11 = a10;
	assign a11 = temp21 + temp22;


	rightrotate6 rotate6_11(rot6_11, e11);
	rightrotate11 rotate11_11(rot11_11, e11);
	rightrotate25 rotate25_11(rot25_11, e11);
	assign S22 = (rot6_11 ^ rot11_11 ^ rot25_11);
	assign ch11 = ((e11 & f11) ^ (~e11 & g11));
	assign temp23 = h11 + c11 + ch11 +k[11] + w[11];
	rightrotate2 rotate2_11(rot2_11, a11);
	rightrotate13 rotate13_11(rot13_11, a11);
	rightrotate22 rotate22_11(rot22_11, a11);
	assign S23 = (rot2_11 ^ rot13_11 ^ rot22_11);
	assign maj11 = ((a11 & b11) ^ (a11 & c11) ^ (b11 & c11));
	assign temp24 = c12 + maj11;
	assign h12 = g11;
	assign g12 = f11;
	assign f12 = e11;
	assign e12 = d11 + temp23;
	assign d12 = c11;
	assign c12 = b11;
	assign b12 = a11;
	assign a12 = temp23 + temp24;


	rightrotate6 rotate6_12(rot6_12, e12);
	rightrotate11 rotate11_12(rot11_12, e12);
	rightrotate25 rotate25_12(rot25_12, e12);
	assign S24 = (rot6_12 ^ rot11_12 ^ rot25_12);
	assign ch12 = ((e12 & f12) ^ (~e12 & g12));
	assign temp25 = h12 + c12 + ch12 +k[12] + w[12];
	rightrotate2 rotate2_12(rot2_12, a12);
	rightrotate13 rotate13_12(rot13_12, a12);
	rightrotate22 rotate22_12(rot22_12, a12);
	assign S25 = (rot2_12 ^ rot13_12 ^ rot22_12);
	assign maj12 = ((a12 & b12) ^ (a12 & c12) ^ (b12 & c12));
	assign temp26 = c13 + maj12;
	assign h13 = g12;
	assign g13 = f12;
	assign f13 = e12;
	assign e13 = d12 + temp25;
	assign d13 = c12;
	assign c13 = b12;
	assign b13 = a12;
	assign a13 = temp25 + temp26;


	rightrotate6 rotate6_13(rot6_13, e13);
	rightrotate11 rotate11_13(rot11_13, e13);
	rightrotate25 rotate25_13(rot25_13, e13);
	assign S26 = (rot6_13 ^ rot11_13 ^ rot25_13);
	assign ch13 = ((e13 & f13) ^ (~e13 & g13));
	assign temp27 = h13 + c13 + ch13 +k[13] + w[13];
	rightrotate2 rotate2_13(rot2_13, a13);
	rightrotate13 rotate13_13(rot13_13, a13);
	rightrotate22 rotate22_13(rot22_13, a13);
	assign S27 = (rot2_13 ^ rot13_13 ^ rot22_13);
	assign maj13 = ((a13 & b13) ^ (a13 & c13) ^ (b13 & c13));
	assign temp28 = c14 + maj13;
	assign h14 = g13;
	assign g14 = f13;
	assign f14 = e13;
	assign e14 = d13 + temp27;
	assign d14 = c13;
	assign c14 = b13;
	assign b14 = a13;
	assign a14 = temp27 + temp28;


	rightrotate6 rotate6_14(rot6_14, e14);
	rightrotate11 rotate11_14(rot11_14, e14);
	rightrotate25 rotate25_14(rot25_14, e14);
	assign S28 = (rot6_14 ^ rot11_14 ^ rot25_14);
	assign ch14 = ((e14 & f14) ^ (~e14 & g14));
	assign temp29 = h14 + c14 + ch14 +k[14] + w[14];
	rightrotate2 rotate2_14(rot2_14, a14);
	rightrotate13 rotate13_14(rot13_14, a14);
	rightrotate22 rotate22_14(rot22_14, a14);
	assign S29 = (rot2_14 ^ rot13_14 ^ rot22_14);
	assign maj14 = ((a14 & b14) ^ (a14 & c14) ^ (b14 & c14));
	assign temp30 = c15 + maj14;
	assign h15 = g14;
	assign g15 = f14;
	assign f15 = e14;
	assign e15 = d14 + temp29;
	assign d15 = c14;
	assign c15 = b14;
	assign b15 = a14;
	assign a15 = temp29 + temp30;


	rightrotate6 rotate6_15(rot6_15, e15);
	rightrotate11 rotate11_15(rot11_15, e15);
	rightrotate25 rotate25_15(rot25_15, e15);
	assign S30 = (rot6_15 ^ rot11_15 ^ rot25_15);
	assign ch15 = ((e15 & f15) ^ (~e15 & g15));
	assign temp31 = h15 + c15 + ch15 +k[15] + w[15];
	rightrotate2 rotate2_15(rot2_15, a15);
	rightrotate13 rotate13_15(rot13_15, a15);
	rightrotate22 rotate22_15(rot22_15, a15);
	assign S31 = (rot2_15 ^ rot13_15 ^ rot22_15);
	assign maj15 = ((a15 & b15) ^ (a15 & c15) ^ (b15 & c15));
	assign temp32 = c16 + maj15;
	assign h16 = g15;
	assign g16 = f15;
	assign f16 = e15;
	assign e16 = d15 + temp31;
	assign d16 = c15;
	assign c16 = b15;
	assign b16 = a15;
	assign a16 = temp31 + temp32;


	rightrotate6 rotate6_16(rot6_16, e16);
	rightrotate11 rotate11_16(rot11_16, e16);
	rightrotate25 rotate25_16(rot25_16, e16);
	assign S32 = (rot6_16 ^ rot11_16 ^ rot25_16);
	assign ch16 = ((e16 & f16) ^ (~e16 & g16));
	assign temp33 = h16 + c16 + ch16 +k[16] + w[16];
	rightrotate2 rotate2_16(rot2_16, a16);
	rightrotate13 rotate13_16(rot13_16, a16);
	rightrotate22 rotate22_16(rot22_16, a16);
	assign S33 = (rot2_16 ^ rot13_16 ^ rot22_16);
	assign maj16 = ((a16 & b16) ^ (a16 & c16) ^ (b16 & c16));
	assign temp34 = c17 + maj16;
	assign h17 = g16;
	assign g17 = f16;
	assign f17 = e16;
	assign e17 = d16 + temp33;
	assign d17 = c16;
	assign c17 = b16;
	assign b17 = a16;
	assign a17 = temp33 + temp34;


	rightrotate6 rotate6_17(rot6_17, e17);
	rightrotate11 rotate11_17(rot11_17, e17);
	rightrotate25 rotate25_17(rot25_17, e17);
	assign S34 = (rot6_17 ^ rot11_17 ^ rot25_17);
	assign ch17 = ((e17 & f17) ^ (~e17 & g17));
	assign temp35 = h17 + c17 + ch17 +k[17] + w[17];
	rightrotate2 rotate2_17(rot2_17, a17);
	rightrotate13 rotate13_17(rot13_17, a17);
	rightrotate22 rotate22_17(rot22_17, a17);
	assign S35 = (rot2_17 ^ rot13_17 ^ rot22_17);
	assign maj17 = ((a17 & b17) ^ (a17 & c17) ^ (b17 & c17));
	assign temp36 = c18 + maj17;
	assign h18 = g17;
	assign g18 = f17;
	assign f18 = e17;
	assign e18 = d17 + temp35;
	assign d18 = c17;
	assign c18 = b17;
	assign b18 = a17;
	assign a18 = temp35 + temp36;


	rightrotate6 rotate6_18(rot6_18, e18);
	rightrotate11 rotate11_18(rot11_18, e18);
	rightrotate25 rotate25_18(rot25_18, e18);
	assign S36 = (rot6_18 ^ rot11_18 ^ rot25_18);
	assign ch18 = ((e18 & f18) ^ (~e18 & g18));
	assign temp37 = h18 + c18 + ch18 +k[18] + w[18];
	rightrotate2 rotate2_18(rot2_18, a18);
	rightrotate13 rotate13_18(rot13_18, a18);
	rightrotate22 rotate22_18(rot22_18, a18);
	assign S37 = (rot2_18 ^ rot13_18 ^ rot22_18);
	assign maj18 = ((a18 & b18) ^ (a18 & c18) ^ (b18 & c18));
	assign temp38 = c19 + maj18;
	assign h19 = g18;
	assign g19 = f18;
	assign f19 = e18;
	assign e19 = d18 + temp37;
	assign d19 = c18;
	assign c19 = b18;
	assign b19 = a18;
	assign a19 = temp37 + temp38;


	rightrotate6 rotate6_19(rot6_19, e19);
	rightrotate11 rotate11_19(rot11_19, e19);
	rightrotate25 rotate25_19(rot25_19, e19);
	assign S38 = (rot6_19 ^ rot11_19 ^ rot25_19);
	assign ch19 = ((e19 & f19) ^ (~e19 & g19));
	assign temp39 = h19 + c19 + ch19 +k[19] + w[19];
	rightrotate2 rotate2_19(rot2_19, a19);
	rightrotate13 rotate13_19(rot13_19, a19);
	rightrotate22 rotate22_19(rot22_19, a19);
	assign S39 = (rot2_19 ^ rot13_19 ^ rot22_19);
	assign maj19 = ((a19 & b19) ^ (a19 & c19) ^ (b19 & c19));
	assign temp40 = c20 + maj19;
	assign h20 = g19;
	assign g20 = f19;
	assign f20 = e19;
	assign e20 = d19 + temp39;
	assign d20 = c19;
	assign c20 = b19;
	assign b20 = a19;
	assign a20 = temp39 + temp40;


	rightrotate6 rotate6_20(rot6_20, e20);
	rightrotate11 rotate11_20(rot11_20, e20);
	rightrotate25 rotate25_20(rot25_20, e20);
	assign S40 = (rot6_20 ^ rot11_20 ^ rot25_20);
	assign ch20 = ((e20 & f20) ^ (~e20 & g20));
	assign temp41 = h20 + c20 + ch20 +k[20] + w[20];
	rightrotate2 rotate2_20(rot2_20, a20);
	rightrotate13 rotate13_20(rot13_20, a20);
	rightrotate22 rotate22_20(rot22_20, a20);
	assign S41 = (rot2_20 ^ rot13_20 ^ rot22_20);
	assign maj20 = ((a20 & b20) ^ (a20 & c20) ^ (b20 & c20));
	assign temp42 = c21 + maj20;
	assign h21 = g20;
	assign g21 = f20;
	assign f21 = e20;
	assign e21 = d20 + temp41;
	assign d21 = c20;
	assign c21 = b20;
	assign b21 = a20;
	assign a21 = temp41 + temp42;


	rightrotate6 rotate6_21(rot6_21, e21);
	rightrotate11 rotate11_21(rot11_21, e21);
	rightrotate25 rotate25_21(rot25_21, e21);
	assign S42 = (rot6_21 ^ rot11_21 ^ rot25_21);
	assign ch21 = ((e21 & f21) ^ (~e21 & g21));
	assign temp43 = h21 + c21 + ch21 +k[21] + w[21];
	rightrotate2 rotate2_21(rot2_21, a21);
	rightrotate13 rotate13_21(rot13_21, a21);
	rightrotate22 rotate22_21(rot22_21, a21);
	assign S43 = (rot2_21 ^ rot13_21 ^ rot22_21);
	assign maj21 = ((a21 & b21) ^ (a21 & c21) ^ (b21 & c21));
	assign temp44 = c22 + maj21;
	assign h22 = g21;
	assign g22 = f21;
	assign f22 = e21;
	assign e22 = d21 + temp43;
	assign d22 = c21;
	assign c22 = b21;
	assign b22 = a21;
	assign a22 = temp43 + temp44;


	rightrotate6 rotate6_22(rot6_22, e22);
	rightrotate11 rotate11_22(rot11_22, e22);
	rightrotate25 rotate25_22(rot25_22, e22);
	assign S44 = (rot6_22 ^ rot11_22 ^ rot25_22);
	assign ch22 = ((e22 & f22) ^ (~e22 & g22));
	assign temp45 = h22 + c22 + ch22 +k[22] + w[22];
	rightrotate2 rotate2_22(rot2_22, a22);
	rightrotate13 rotate13_22(rot13_22, a22);
	rightrotate22 rotate22_22(rot22_22, a22);
	assign S45 = (rot2_22 ^ rot13_22 ^ rot22_22);
	assign maj22 = ((a22 & b22) ^ (a22 & c22) ^ (b22 & c22));
	assign temp46 = c23 + maj22;
	assign h23 = g22;
	assign g23 = f22;
	assign f23 = e22;
	assign e23 = d22 + temp45;
	assign d23 = c22;
	assign c23 = b22;
	assign b23 = a22;
	assign a23 = temp45 + temp46;


	rightrotate6 rotate6_23(rot6_23, e23);
	rightrotate11 rotate11_23(rot11_23, e23);
	rightrotate25 rotate25_23(rot25_23, e23);
	assign S46 = (rot6_23 ^ rot11_23 ^ rot25_23);
	assign ch23 = ((e23 & f23) ^ (~e23 & g23));
	assign temp47 = h23 + c23 + ch23 +k[23] + w[23];
	rightrotate2 rotate2_23(rot2_23, a23);
	rightrotate13 rotate13_23(rot13_23, a23);
	rightrotate22 rotate22_23(rot22_23, a23);
	assign S47 = (rot2_23 ^ rot13_23 ^ rot22_23);
	assign maj23 = ((a23 & b23) ^ (a23 & c23) ^ (b23 & c23));
	assign temp48 = c24 + maj23;
	assign h24 = g23;
	assign g24 = f23;
	assign f24 = e23;
	assign e24 = d23 + temp47;
	assign d24 = c23;
	assign c24 = b23;
	assign b24 = a23;
	assign a24 = temp47 + temp48;


	rightrotate6 rotate6_24(rot6_24, e24);
	rightrotate11 rotate11_24(rot11_24, e24);
	rightrotate25 rotate25_24(rot25_24, e24);
	assign S48 = (rot6_24 ^ rot11_24 ^ rot25_24);
	assign ch24 = ((e24 & f24) ^ (~e24 & g24));
	assign temp49 = h24 + c24 + ch24 +k[24] + w[24];
	rightrotate2 rotate2_24(rot2_24, a24);
	rightrotate13 rotate13_24(rot13_24, a24);
	rightrotate22 rotate22_24(rot22_24, a24);
	assign S49 = (rot2_24 ^ rot13_24 ^ rot22_24);
	assign maj24 = ((a24 & b24) ^ (a24 & c24) ^ (b24 & c24));
	assign temp50 = c25 + maj24;
	assign h25 = g24;
	assign g25 = f24;
	assign f25 = e24;
	assign e25 = d24 + temp49;
	assign d25 = c24;
	assign c25 = b24;
	assign b25 = a24;
	assign a25 = temp49 + temp50;


	rightrotate6 rotate6_25(rot6_25, e25);
	rightrotate11 rotate11_25(rot11_25, e25);
	rightrotate25 rotate25_25(rot25_25, e25);
	assign S50 = (rot6_25 ^ rot11_25 ^ rot25_25);
	assign ch25 = ((e25 & f25) ^ (~e25 & g25));
	assign temp51 = h25 + c25 + ch25 +k[25] + w[25];
	rightrotate2 rotate2_25(rot2_25, a25);
	rightrotate13 rotate13_25(rot13_25, a25);
	rightrotate22 rotate22_25(rot22_25, a25);
	assign S51 = (rot2_25 ^ rot13_25 ^ rot22_25);
	assign maj25 = ((a25 & b25) ^ (a25 & c25) ^ (b25 & c25));
	assign temp52 = c26 + maj25;
	assign h26 = g25;
	assign g26 = f25;
	assign f26 = e25;
	assign e26 = d25 + temp51;
	assign d26 = c25;
	assign c26 = b25;
	assign b26 = a25;
	assign a26 = temp51 + temp52;


	rightrotate6 rotate6_26(rot6_26, e26);
	rightrotate11 rotate11_26(rot11_26, e26);
	rightrotate25 rotate25_26(rot25_26, e26);
	assign S52 = (rot6_26 ^ rot11_26 ^ rot25_26);
	assign ch26 = ((e26 & f26) ^ (~e26 & g26));
	assign temp53 = h26 + c26 + ch26 +k[26] + w[26];
	rightrotate2 rotate2_26(rot2_26, a26);
	rightrotate13 rotate13_26(rot13_26, a26);
	rightrotate22 rotate22_26(rot22_26, a26);
	assign S53 = (rot2_26 ^ rot13_26 ^ rot22_26);
	assign maj26 = ((a26 & b26) ^ (a26 & c26) ^ (b26 & c26));
	assign temp54 = c27 + maj26;
	assign h27 = g26;
	assign g27 = f26;
	assign f27 = e26;
	assign e27 = d26 + temp53;
	assign d27 = c26;
	assign c27 = b26;
	assign b27 = a26;
	assign a27 = temp53 + temp54;


	rightrotate6 rotate6_27(rot6_27, e27);
	rightrotate11 rotate11_27(rot11_27, e27);
	rightrotate25 rotate25_27(rot25_27, e27);
	assign S54 = (rot6_27 ^ rot11_27 ^ rot25_27);
	assign ch27 = ((e27 & f27) ^ (~e27 & g27));
	assign temp55 = h27 + c27 + ch27 +k[27] + w[27];
	rightrotate2 rotate2_27(rot2_27, a27);
	rightrotate13 rotate13_27(rot13_27, a27);
	rightrotate22 rotate22_27(rot22_27, a27);
	assign S55 = (rot2_27 ^ rot13_27 ^ rot22_27);
	assign maj27 = ((a27 & b27) ^ (a27 & c27) ^ (b27 & c27));
	assign temp56 = c28 + maj27;
	assign h28 = g27;
	assign g28 = f27;
	assign f28 = e27;
	assign e28 = d27 + temp55;
	assign d28 = c27;
	assign c28 = b27;
	assign b28 = a27;
	assign a28 = temp55 + temp56;


	rightrotate6 rotate6_28(rot6_28, e28);
	rightrotate11 rotate11_28(rot11_28, e28);
	rightrotate25 rotate25_28(rot25_28, e28);
	assign S56 = (rot6_28 ^ rot11_28 ^ rot25_28);
	assign ch28 = ((e28 & f28) ^ (~e28 & g28));
	assign temp57 = h28 + c28 + ch28 +k[28] + w[28];
	rightrotate2 rotate2_28(rot2_28, a28);
	rightrotate13 rotate13_28(rot13_28, a28);
	rightrotate22 rotate22_28(rot22_28, a28);
	assign S57 = (rot2_28 ^ rot13_28 ^ rot22_28);
	assign maj28 = ((a28 & b28) ^ (a28 & c28) ^ (b28 & c28));
	assign temp58 = c29 + maj28;
	assign h29 = g28;
	assign g29 = f28;
	assign f29 = e28;
	assign e29 = d28 + temp57;
	assign d29 = c28;
	assign c29 = b28;
	assign b29 = a28;
	assign a29 = temp57 + temp58;


	rightrotate6 rotate6_29(rot6_29, e29);
	rightrotate11 rotate11_29(rot11_29, e29);
	rightrotate25 rotate25_29(rot25_29, e29);
	assign S58 = (rot6_29 ^ rot11_29 ^ rot25_29);
	assign ch29 = ((e29 & f29) ^ (~e29 & g29));
	assign temp59 = h29 + c29 + ch29 +k[29] + w[29];
	rightrotate2 rotate2_29(rot2_29, a29);
	rightrotate13 rotate13_29(rot13_29, a29);
	rightrotate22 rotate22_29(rot22_29, a29);
	assign S59 = (rot2_29 ^ rot13_29 ^ rot22_29);
	assign maj29 = ((a29 & b29) ^ (a29 & c29) ^ (b29 & c29));
	assign temp60 = c30 + maj29;
	assign h30 = g29;
	assign g30 = f29;
	assign f30 = e29;
	assign e30 = d29 + temp59;
	assign d30 = c29;
	assign c30 = b29;
	assign b30 = a29;
	assign a30 = temp59 + temp60;


	rightrotate6 rotate6_30(rot6_30, e30);
	rightrotate11 rotate11_30(rot11_30, e30);
	rightrotate25 rotate25_30(rot25_30, e30);
	assign S60 = (rot6_30 ^ rot11_30 ^ rot25_30);
	assign ch30 = ((e30 & f30) ^ (~e30 & g30));
	assign temp61 = h30 + c30 + ch30 +k[30] + w[30];
	rightrotate2 rotate2_30(rot2_30, a30);
	rightrotate13 rotate13_30(rot13_30, a30);
	rightrotate22 rotate22_30(rot22_30, a30);
	assign S61 = (rot2_30 ^ rot13_30 ^ rot22_30);
	assign maj30 = ((a30 & b30) ^ (a30 & c30) ^ (b30 & c30));
	assign temp62 = c31 + maj30;
	assign h31 = g30;
	assign g31 = f30;
	assign f31 = e30;
	assign e31 = d30 + temp61;
	assign d31 = c30;
	assign c31 = b30;
	assign b31 = a30;
	assign a31 = temp61 + temp62;


	rightrotate6 rotate6_31(rot6_31, e31);
	rightrotate11 rotate11_31(rot11_31, e31);
	rightrotate25 rotate25_31(rot25_31, e31);
	assign S62 = (rot6_31 ^ rot11_31 ^ rot25_31);
	assign ch31 = ((e31 & f31) ^ (~e31 & g31));
	assign temp63 = h31 + c31 + ch31 +k[31] + w[31];
	rightrotate2 rotate2_31(rot2_31, a31);
	rightrotate13 rotate13_31(rot13_31, a31);
	rightrotate22 rotate22_31(rot22_31, a31);
	assign S63 = (rot2_31 ^ rot13_31 ^ rot22_31);
	assign maj31 = ((a31 & b31) ^ (a31 & c31) ^ (b31 & c31));
	assign temp64 = c32 + maj31;
	assign h32 = g31;
	assign g32 = f31;
	assign f32 = e31;
	assign e32 = d31 + temp63;
	assign d32 = c31;
	assign c32 = b31;
	assign b32 = a31;
	assign a32 = temp63 + temp64;


	rightrotate6 rotate6_32(rot6_32, e32);
	rightrotate11 rotate11_32(rot11_32, e32);
	rightrotate25 rotate25_32(rot25_32, e32);
	assign S64 = (rot6_32 ^ rot11_32 ^ rot25_32);
	assign ch32 = ((e32 & f32) ^ (~e32 & g32));
	assign temp65 = h32 + c32 + ch32 +k[32] + w[32];
	rightrotate2 rotate2_32(rot2_32, a32);
	rightrotate13 rotate13_32(rot13_32, a32);
	rightrotate22 rotate22_32(rot22_32, a32);
	assign S65 = (rot2_32 ^ rot13_32 ^ rot22_32);
	assign maj32 = ((a32 & b32) ^ (a32 & c32) ^ (b32 & c32));
	assign temp66 = c33 + maj32;
	assign h33 = g32;
	assign g33 = f32;
	assign f33 = e32;
	assign e33 = d32 + temp65;
	assign d33 = c32;
	assign c33 = b32;
	assign b33 = a32;
	assign a33 = temp65 + temp66;


	rightrotate6 rotate6_33(rot6_33, e33);
	rightrotate11 rotate11_33(rot11_33, e33);
	rightrotate25 rotate25_33(rot25_33, e33);
	assign S66 = (rot6_33 ^ rot11_33 ^ rot25_33);
	assign ch33 = ((e33 & f33) ^ (~e33 & g33));
	assign temp67 = h33 + c33 + ch33 +k[33] + w[33];
	rightrotate2 rotate2_33(rot2_33, a33);
	rightrotate13 rotate13_33(rot13_33, a33);
	rightrotate22 rotate22_33(rot22_33, a33);
	assign S67 = (rot2_33 ^ rot13_33 ^ rot22_33);
	assign maj33 = ((a33 & b33) ^ (a33 & c33) ^ (b33 & c33));
	assign temp68 = c34 + maj33;
	assign h34 = g33;
	assign g34 = f33;
	assign f34 = e33;
	assign e34 = d33 + temp67;
	assign d34 = c33;
	assign c34 = b33;
	assign b34 = a33;
	assign a34 = temp67 + temp68;


	rightrotate6 rotate6_34(rot6_34, e34);
	rightrotate11 rotate11_34(rot11_34, e34);
	rightrotate25 rotate25_34(rot25_34, e34);
	assign S68 = (rot6_34 ^ rot11_34 ^ rot25_34);
	assign ch34 = ((e34 & f34) ^ (~e34 & g34));
	assign temp69 = h34 + c34 + ch34 +k[34] + w[34];
	rightrotate2 rotate2_34(rot2_34, a34);
	rightrotate13 rotate13_34(rot13_34, a34);
	rightrotate22 rotate22_34(rot22_34, a34);
	assign S69 = (rot2_34 ^ rot13_34 ^ rot22_34);
	assign maj34 = ((a34 & b34) ^ (a34 & c34) ^ (b34 & c34));
	assign temp70 = c35 + maj34;
	assign h35 = g34;
	assign g35 = f34;
	assign f35 = e34;
	assign e35 = d34 + temp69;
	assign d35 = c34;
	assign c35 = b34;
	assign b35 = a34;
	assign a35 = temp69 + temp70;


	rightrotate6 rotate6_35(rot6_35, e35);
	rightrotate11 rotate11_35(rot11_35, e35);
	rightrotate25 rotate25_35(rot25_35, e35);
	assign S70 = (rot6_35 ^ rot11_35 ^ rot25_35);
	assign ch35 = ((e35 & f35) ^ (~e35 & g35));
	assign temp71 = h35 + c35 + ch35 +k[35] + w[35];
	rightrotate2 rotate2_35(rot2_35, a35);
	rightrotate13 rotate13_35(rot13_35, a35);
	rightrotate22 rotate22_35(rot22_35, a35);
	assign S71 = (rot2_35 ^ rot13_35 ^ rot22_35);
	assign maj35 = ((a35 & b35) ^ (a35 & c35) ^ (b35 & c35));
	assign temp72 = c36 + maj35;
	assign h36 = g35;
	assign g36 = f35;
	assign f36 = e35;
	assign e36 = d35 + temp71;
	assign d36 = c35;
	assign c36 = b35;
	assign b36 = a35;
	assign a36 = temp71 + temp72;


	rightrotate6 rotate6_36(rot6_36, e36);
	rightrotate11 rotate11_36(rot11_36, e36);
	rightrotate25 rotate25_36(rot25_36, e36);
	assign S72 = (rot6_36 ^ rot11_36 ^ rot25_36);
	assign ch36 = ((e36 & f36) ^ (~e36 & g36));
	assign temp73 = h36 + c36 + ch36 +k[36] + w[36];
	rightrotate2 rotate2_36(rot2_36, a36);
	rightrotate13 rotate13_36(rot13_36, a36);
	rightrotate22 rotate22_36(rot22_36, a36);
	assign S73 = (rot2_36 ^ rot13_36 ^ rot22_36);
	assign maj36 = ((a36 & b36) ^ (a36 & c36) ^ (b36 & c36));
	assign temp74 = c37 + maj36;
	assign h37 = g36;
	assign g37 = f36;
	assign f37 = e36;
	assign e37 = d36 + temp73;
	assign d37 = c36;
	assign c37 = b36;
	assign b37 = a36;
	assign a37 = temp73 + temp74;


	rightrotate6 rotate6_37(rot6_37, e37);
	rightrotate11 rotate11_37(rot11_37, e37);
	rightrotate25 rotate25_37(rot25_37, e37);
	assign S74 = (rot6_37 ^ rot11_37 ^ rot25_37);
	assign ch37 = ((e37 & f37) ^ (~e37 & g37));
	assign temp75 = h37 + c37 + ch37 +k[37] + w[37];
	rightrotate2 rotate2_37(rot2_37, a37);
	rightrotate13 rotate13_37(rot13_37, a37);
	rightrotate22 rotate22_37(rot22_37, a37);
	assign S75 = (rot2_37 ^ rot13_37 ^ rot22_37);
	assign maj37 = ((a37 & b37) ^ (a37 & c37) ^ (b37 & c37));
	assign temp76 = c38 + maj37;
	assign h38 = g37;
	assign g38 = f37;
	assign f38 = e37;
	assign e38 = d37 + temp75;
	assign d38 = c37;
	assign c38 = b37;
	assign b38 = a37;
	assign a38 = temp75 + temp76;


	rightrotate6 rotate6_38(rot6_38, e38);
	rightrotate11 rotate11_38(rot11_38, e38);
	rightrotate25 rotate25_38(rot25_38, e38);
	assign S76 = (rot6_38 ^ rot11_38 ^ rot25_38);
	assign ch38 = ((e38 & f38) ^ (~e38 & g38));
	assign temp77 = h38 + c38 + ch38 +k[38] + w[38];
	rightrotate2 rotate2_38(rot2_38, a38);
	rightrotate13 rotate13_38(rot13_38, a38);
	rightrotate22 rotate22_38(rot22_38, a38);
	assign S77 = (rot2_38 ^ rot13_38 ^ rot22_38);
	assign maj38 = ((a38 & b38) ^ (a38 & c38) ^ (b38 & c38));
	assign temp78 = c39 + maj38;
	assign h39 = g38;
	assign g39 = f38;
	assign f39 = e38;
	assign e39 = d38 + temp77;
	assign d39 = c38;
	assign c39 = b38;
	assign b39 = a38;
	assign a39 = temp77 + temp78;


	rightrotate6 rotate6_39(rot6_39, e39);
	rightrotate11 rotate11_39(rot11_39, e39);
	rightrotate25 rotate25_39(rot25_39, e39);
	assign S78 = (rot6_39 ^ rot11_39 ^ rot25_39);
	assign ch39 = ((e39 & f39) ^ (~e39 & g39));
	assign temp79 = h39 + c39 + ch39 +k[39] + w[39];
	rightrotate2 rotate2_39(rot2_39, a39);
	rightrotate13 rotate13_39(rot13_39, a39);
	rightrotate22 rotate22_39(rot22_39, a39);
	assign S79 = (rot2_39 ^ rot13_39 ^ rot22_39);
	assign maj39 = ((a39 & b39) ^ (a39 & c39) ^ (b39 & c39));
	assign temp80 = c40 + maj39;
	assign h40 = g39;
	assign g40 = f39;
	assign f40 = e39;
	assign e40 = d39 + temp79;
	assign d40 = c39;
	assign c40 = b39;
	assign b40 = a39;
	assign a40 = temp79 + temp80;


	rightrotate6 rotate6_40(rot6_40, e40);
	rightrotate11 rotate11_40(rot11_40, e40);
	rightrotate25 rotate25_40(rot25_40, e40);
	assign S80 = (rot6_40 ^ rot11_40 ^ rot25_40);
	assign ch40 = ((e40 & f40) ^ (~e40 & g40));
	assign temp81 = h40 + c40 + ch40 +k[40] + w[40];
	rightrotate2 rotate2_40(rot2_40, a40);
	rightrotate13 rotate13_40(rot13_40, a40);
	rightrotate22 rotate22_40(rot22_40, a40);
	assign S81 = (rot2_40 ^ rot13_40 ^ rot22_40);
	assign maj40 = ((a40 & b40) ^ (a40 & c40) ^ (b40 & c40));
	assign temp82 = c41 + maj40;
	assign h41 = g40;
	assign g41 = f40;
	assign f41 = e40;
	assign e41 = d40 + temp81;
	assign d41 = c40;
	assign c41 = b40;
	assign b41 = a40;
	assign a41 = temp81 + temp82;


	rightrotate6 rotate6_41(rot6_41, e41);
	rightrotate11 rotate11_41(rot11_41, e41);
	rightrotate25 rotate25_41(rot25_41, e41);
	assign S82 = (rot6_41 ^ rot11_41 ^ rot25_41);
	assign ch41 = ((e41 & f41) ^ (~e41 & g41));
	assign temp83 = h41 + c41 + ch41 +k[41] + w[41];
	rightrotate2 rotate2_41(rot2_41, a41);
	rightrotate13 rotate13_41(rot13_41, a41);
	rightrotate22 rotate22_41(rot22_41, a41);
	assign S83 = (rot2_41 ^ rot13_41 ^ rot22_41);
	assign maj41 = ((a41 & b41) ^ (a41 & c41) ^ (b41 & c41));
	assign temp84 = c42 + maj41;
	assign h42 = g41;
	assign g42 = f41;
	assign f42 = e41;
	assign e42 = d41 + temp83;
	assign d42 = c41;
	assign c42 = b41;
	assign b42 = a41;
	assign a42 = temp83 + temp84;


	rightrotate6 rotate6_42(rot6_42, e42);
	rightrotate11 rotate11_42(rot11_42, e42);
	rightrotate25 rotate25_42(rot25_42, e42);
	assign S84 = (rot6_42 ^ rot11_42 ^ rot25_42);
	assign ch42 = ((e42 & f42) ^ (~e42 & g42));
	assign temp85 = h42 + c42 + ch42 +k[42] + w[42];
	rightrotate2 rotate2_42(rot2_42, a42);
	rightrotate13 rotate13_42(rot13_42, a42);
	rightrotate22 rotate22_42(rot22_42, a42);
	assign S85 = (rot2_42 ^ rot13_42 ^ rot22_42);
	assign maj42 = ((a42 & b42) ^ (a42 & c42) ^ (b42 & c42));
	assign temp86 = c43 + maj42;
	assign h43 = g42;
	assign g43 = f42;
	assign f43 = e42;
	assign e43 = d42 + temp85;
	assign d43 = c42;
	assign c43 = b42;
	assign b43 = a42;
	assign a43 = temp85 + temp86;


	rightrotate6 rotate6_43(rot6_43, e43);
	rightrotate11 rotate11_43(rot11_43, e43);
	rightrotate25 rotate25_43(rot25_43, e43);
	assign S86 = (rot6_43 ^ rot11_43 ^ rot25_43);
	assign ch43 = ((e43 & f43) ^ (~e43 & g43));
	assign temp87 = h43 + c43 + ch43 +k[43] + w[43];
	rightrotate2 rotate2_43(rot2_43, a43);
	rightrotate13 rotate13_43(rot13_43, a43);
	rightrotate22 rotate22_43(rot22_43, a43);
	assign S87 = (rot2_43 ^ rot13_43 ^ rot22_43);
	assign maj43 = ((a43 & b43) ^ (a43 & c43) ^ (b43 & c43));
	assign temp88 = c44 + maj43;
	assign h44 = g43;
	assign g44 = f43;
	assign f44 = e43;
	assign e44 = d43 + temp87;
	assign d44 = c43;
	assign c44 = b43;
	assign b44 = a43;
	assign a44 = temp87 + temp88;


	rightrotate6 rotate6_44(rot6_44, e44);
	rightrotate11 rotate11_44(rot11_44, e44);
	rightrotate25 rotate25_44(rot25_44, e44);
	assign S88 = (rot6_44 ^ rot11_44 ^ rot25_44);
	assign ch44 = ((e44 & f44) ^ (~e44 & g44));
	assign temp89 = h44 + c44 + ch44 +k[44] + w[44];
	rightrotate2 rotate2_44(rot2_44, a44);
	rightrotate13 rotate13_44(rot13_44, a44);
	rightrotate22 rotate22_44(rot22_44, a44);
	assign S89 = (rot2_44 ^ rot13_44 ^ rot22_44);
	assign maj44 = ((a44 & b44) ^ (a44 & c44) ^ (b44 & c44));
	assign temp90 = c45 + maj44;
	assign h45 = g44;
	assign g45 = f44;
	assign f45 = e44;
	assign e45 = d44 + temp89;
	assign d45 = c44;
	assign c45 = b44;
	assign b45 = a44;
	assign a45 = temp89 + temp90;


	rightrotate6 rotate6_45(rot6_45, e45);
	rightrotate11 rotate11_45(rot11_45, e45);
	rightrotate25 rotate25_45(rot25_45, e45);
	assign S90 = (rot6_45 ^ rot11_45 ^ rot25_45);
	assign ch45 = ((e45 & f45) ^ (~e45 & g45));
	assign temp91 = h45 + c45 + ch45 +k[45] + w[45];
	rightrotate2 rotate2_45(rot2_45, a45);
	rightrotate13 rotate13_45(rot13_45, a45);
	rightrotate22 rotate22_45(rot22_45, a45);
	assign S91 = (rot2_45 ^ rot13_45 ^ rot22_45);
	assign maj45 = ((a45 & b45) ^ (a45 & c45) ^ (b45 & c45));
	assign temp92 = c46 + maj45;
	assign h46 = g45;
	assign g46 = f45;
	assign f46 = e45;
	assign e46 = d45 + temp91;
	assign d46 = c45;
	assign c46 = b45;
	assign b46 = a45;
	assign a46 = temp91 + temp92;


	rightrotate6 rotate6_46(rot6_46, e46);
	rightrotate11 rotate11_46(rot11_46, e46);
	rightrotate25 rotate25_46(rot25_46, e46);
	assign S92 = (rot6_46 ^ rot11_46 ^ rot25_46);
	assign ch46 = ((e46 & f46) ^ (~e46 & g46));
	assign temp93 = h46 + c46 + ch46 +k[46] + w[46];
	rightrotate2 rotate2_46(rot2_46, a46);
	rightrotate13 rotate13_46(rot13_46, a46);
	rightrotate22 rotate22_46(rot22_46, a46);
	assign S93 = (rot2_46 ^ rot13_46 ^ rot22_46);
	assign maj46 = ((a46 & b46) ^ (a46 & c46) ^ (b46 & c46));
	assign temp94 = c47 + maj46;
	assign h47 = g46;
	assign g47 = f46;
	assign f47 = e46;
	assign e47 = d46 + temp93;
	assign d47 = c46;
	assign c47 = b46;
	assign b47 = a46;
	assign a47 = temp93 + temp94;


	rightrotate6 rotate6_47(rot6_47, e47);
	rightrotate11 rotate11_47(rot11_47, e47);
	rightrotate25 rotate25_47(rot25_47, e47);
	assign S94 = (rot6_47 ^ rot11_47 ^ rot25_47);
	assign ch47 = ((e47 & f47) ^ (~e47 & g47));
	assign temp95 = h47 + c47 + ch47 +k[47] + w[47];
	rightrotate2 rotate2_47(rot2_47, a47);
	rightrotate13 rotate13_47(rot13_47, a47);
	rightrotate22 rotate22_47(rot22_47, a47);
	assign S95 = (rot2_47 ^ rot13_47 ^ rot22_47);
	assign maj47 = ((a47 & b47) ^ (a47 & c47) ^ (b47 & c47));
	assign temp96 = c48 + maj47;
	assign h48 = g47;
	assign g48 = f47;
	assign f48 = e47;
	assign e48 = d47 + temp95;
	assign d48 = c47;
	assign c48 = b47;
	assign b48 = a47;
	assign a48 = temp95 + temp96;


	rightrotate6 rotate6_48(rot6_48, e48);
	rightrotate11 rotate11_48(rot11_48, e48);
	rightrotate25 rotate25_48(rot25_48, e48);
	assign S96 = (rot6_48 ^ rot11_48 ^ rot25_48);
	assign ch48 = ((e48 & f48) ^ (~e48 & g48));
	assign temp97 = h48 + c48 + ch48 +k[48] + w[48];
	rightrotate2 rotate2_48(rot2_48, a48);
	rightrotate13 rotate13_48(rot13_48, a48);
	rightrotate22 rotate22_48(rot22_48, a48);
	assign S97 = (rot2_48 ^ rot13_48 ^ rot22_48);
	assign maj48 = ((a48 & b48) ^ (a48 & c48) ^ (b48 & c48));
	assign temp98 = c49 + maj48;
	assign h49 = g48;
	assign g49 = f48;
	assign f49 = e48;
	assign e49 = d48 + temp97;
	assign d49 = c48;
	assign c49 = b48;
	assign b49 = a48;
	assign a49 = temp97 + temp98;


	rightrotate6 rotate6_49(rot6_49, e49);
	rightrotate11 rotate11_49(rot11_49, e49);
	rightrotate25 rotate25_49(rot25_49, e49);
	assign S98 = (rot6_49 ^ rot11_49 ^ rot25_49);
	assign ch49 = ((e49 & f49) ^ (~e49 & g49));
	assign temp99 = h49 + c49 + ch49 +k[49] + w[49];
	rightrotate2 rotate2_49(rot2_49, a49);
	rightrotate13 rotate13_49(rot13_49, a49);
	rightrotate22 rotate22_49(rot22_49, a49);
	assign S99 = (rot2_49 ^ rot13_49 ^ rot22_49);
	assign maj49 = ((a49 & b49) ^ (a49 & c49) ^ (b49 & c49));
	assign temp100 = c50 + maj49;
	assign h50 = g49;
	assign g50 = f49;
	assign f50 = e49;
	assign e50 = d49 + temp99;
	assign d50 = c49;
	assign c50 = b49;
	assign b50 = a49;
	assign a50 = temp99 + temp100;


	rightrotate6 rotate6_50(rot6_50, e50);
	rightrotate11 rotate11_50(rot11_50, e50);
	rightrotate25 rotate25_50(rot25_50, e50);
	assign S100 = (rot6_50 ^ rot11_50 ^ rot25_50);
	assign ch50 = ((e50 & f50) ^ (~e50 & g50));
	assign temp101 = h50 + c50 + ch50 +k[50] + w[50];
	rightrotate2 rotate2_50(rot2_50, a50);
	rightrotate13 rotate13_50(rot13_50, a50);
	rightrotate22 rotate22_50(rot22_50, a50);
	assign S101 = (rot2_50 ^ rot13_50 ^ rot22_50);
	assign maj50 = ((a50 & b50) ^ (a50 & c50) ^ (b50 & c50));
	assign temp102 = c51 + maj50;
	assign h51 = g50;
	assign g51 = f50;
	assign f51 = e50;
	assign e51 = d50 + temp101;
	assign d51 = c50;
	assign c51 = b50;
	assign b51 = a50;
	assign a51 = temp101 + temp102;


	rightrotate6 rotate6_51(rot6_51, e51);
	rightrotate11 rotate11_51(rot11_51, e51);
	rightrotate25 rotate25_51(rot25_51, e51);
	assign S102 = (rot6_51 ^ rot11_51 ^ rot25_51);
	assign ch51 = ((e51 & f51) ^ (~e51 & g51));
	assign temp103 = h51 + c51 + ch51 +k[51] + w[51];
	rightrotate2 rotate2_51(rot2_51, a51);
	rightrotate13 rotate13_51(rot13_51, a51);
	rightrotate22 rotate22_51(rot22_51, a51);
	assign S103 = (rot2_51 ^ rot13_51 ^ rot22_51);
	assign maj51 = ((a51 & b51) ^ (a51 & c51) ^ (b51 & c51));
	assign temp104 = c52 + maj51;
	assign h52 = g51;
	assign g52 = f51;
	assign f52 = e51;
	assign e52 = d51 + temp103;
	assign d52 = c51;
	assign c52 = b51;
	assign b52 = a51;
	assign a52 = temp103 + temp104;


	rightrotate6 rotate6_52(rot6_52, e52);
	rightrotate11 rotate11_52(rot11_52, e52);
	rightrotate25 rotate25_52(rot25_52, e52);
	assign S104 = (rot6_52 ^ rot11_52 ^ rot25_52);
	assign ch52 = ((e52 & f52) ^ (~e52 & g52));
	assign temp105 = h52 + c52 + ch52 +k[52] + w[52];
	rightrotate2 rotate2_52(rot2_52, a52);
	rightrotate13 rotate13_52(rot13_52, a52);
	rightrotate22 rotate22_52(rot22_52, a52);
	assign S105 = (rot2_52 ^ rot13_52 ^ rot22_52);
	assign maj52 = ((a52 & b52) ^ (a52 & c52) ^ (b52 & c52));
	assign temp106 = c53 + maj52;
	assign h53 = g52;
	assign g53 = f52;
	assign f53 = e52;
	assign e53 = d52 + temp105;
	assign d53 = c52;
	assign c53 = b52;
	assign b53 = a52;
	assign a53 = temp105 + temp106;


	rightrotate6 rotate6_53(rot6_53, e53);
	rightrotate11 rotate11_53(rot11_53, e53);
	rightrotate25 rotate25_53(rot25_53, e53);
	assign S106 = (rot6_53 ^ rot11_53 ^ rot25_53);
	assign ch53 = ((e53 & f53) ^ (~e53 & g53));
	assign temp107 = h53 + c53 + ch53 +k[53] + w[53];
	rightrotate2 rotate2_53(rot2_53, a53);
	rightrotate13 rotate13_53(rot13_53, a53);
	rightrotate22 rotate22_53(rot22_53, a53);
	assign S107 = (rot2_53 ^ rot13_53 ^ rot22_53);
	assign maj53 = ((a53 & b53) ^ (a53 & c53) ^ (b53 & c53));
	assign temp108 = c54 + maj53;
	assign h54 = g53;
	assign g54 = f53;
	assign f54 = e53;
	assign e54 = d53 + temp107;
	assign d54 = c53;
	assign c54 = b53;
	assign b54 = a53;
	assign a54 = temp107 + temp108;


	rightrotate6 rotate6_54(rot6_54, e54);
	rightrotate11 rotate11_54(rot11_54, e54);
	rightrotate25 rotate25_54(rot25_54, e54);
	assign S108 = (rot6_54 ^ rot11_54 ^ rot25_54);
	assign ch54 = ((e54 & f54) ^ (~e54 & g54));
	assign temp109 = h54 + c54 + ch54 +k[54] + w[54];
	rightrotate2 rotate2_54(rot2_54, a54);
	rightrotate13 rotate13_54(rot13_54, a54);
	rightrotate22 rotate22_54(rot22_54, a54);
	assign S109 = (rot2_54 ^ rot13_54 ^ rot22_54);
	assign maj54 = ((a54 & b54) ^ (a54 & c54) ^ (b54 & c54));
	assign temp110 = c55 + maj54;
	assign h55 = g54;
	assign g55 = f54;
	assign f55 = e54;
	assign e55 = d54 + temp109;
	assign d55 = c54;
	assign c55 = b54;
	assign b55 = a54;
	assign a55 = temp109 + temp110;


	rightrotate6 rotate6_55(rot6_55, e55);
	rightrotate11 rotate11_55(rot11_55, e55);
	rightrotate25 rotate25_55(rot25_55, e55);
	assign S110 = (rot6_55 ^ rot11_55 ^ rot25_55);
	assign ch55 = ((e55 & f55) ^ (~e55 & g55));
	assign temp111 = h55 + c55 + ch55 +k[55] + w[55];
	rightrotate2 rotate2_55(rot2_55, a55);
	rightrotate13 rotate13_55(rot13_55, a55);
	rightrotate22 rotate22_55(rot22_55, a55);
	assign S111 = (rot2_55 ^ rot13_55 ^ rot22_55);
	assign maj55 = ((a55 & b55) ^ (a55 & c55) ^ (b55 & c55));
	assign temp112 = c56 + maj55;
	assign h56 = g55;
	assign g56 = f55;
	assign f56 = e55;
	assign e56 = d55 + temp111;
	assign d56 = c55;
	assign c56 = b55;
	assign b56 = a55;
	assign a56 = temp111 + temp112;


	rightrotate6 rotate6_56(rot6_56, e56);
	rightrotate11 rotate11_56(rot11_56, e56);
	rightrotate25 rotate25_56(rot25_56, e56);
	assign S112 = (rot6_56 ^ rot11_56 ^ rot25_56);
	assign ch56 = ((e56 & f56) ^ (~e56 & g56));
	assign temp113 = h56 + c56 + ch56 +k[56] + w[56];
	rightrotate2 rotate2_56(rot2_56, a56);
	rightrotate13 rotate13_56(rot13_56, a56);
	rightrotate22 rotate22_56(rot22_56, a56);
	assign S113 = (rot2_56 ^ rot13_56 ^ rot22_56);
	assign maj56 = ((a56 & b56) ^ (a56 & c56) ^ (b56 & c56));
	assign temp114 = c57 + maj56;
	assign h57 = g56;
	assign g57 = f56;
	assign f57 = e56;
	assign e57 = d56 + temp113;
	assign d57 = c56;
	assign c57 = b56;
	assign b57 = a56;
	assign a57 = temp113 + temp114;


	rightrotate6 rotate6_57(rot6_57, e57);
	rightrotate11 rotate11_57(rot11_57, e57);
	rightrotate25 rotate25_57(rot25_57, e57);
	assign S114 = (rot6_57 ^ rot11_57 ^ rot25_57);
	assign ch57 = ((e57 & f57) ^ (~e57 & g57));
	assign temp115 = h57 + c57 + ch57 +k[57] + w[57];
	rightrotate2 rotate2_57(rot2_57, a57);
	rightrotate13 rotate13_57(rot13_57, a57);
	rightrotate22 rotate22_57(rot22_57, a57);
	assign S115 = (rot2_57 ^ rot13_57 ^ rot22_57);
	assign maj57 = ((a57 & b57) ^ (a57 & c57) ^ (b57 & c57));
	assign temp116 = c58 + maj57;
	assign h58 = g57;
	assign g58 = f57;
	assign f58 = e57;
	assign e58 = d57 + temp115;
	assign d58 = c57;
	assign c58 = b57;
	assign b58 = a57;
	assign a58 = temp115 + temp116;


	rightrotate6 rotate6_58(rot6_58, e58);
	rightrotate11 rotate11_58(rot11_58, e58);
	rightrotate25 rotate25_58(rot25_58, e58);
	assign S116 = (rot6_58 ^ rot11_58 ^ rot25_58);
	assign ch58 = ((e58 & f58) ^ (~e58 & g58));
	assign temp117 = h58 + c58 + ch58 +k[58] + w[58];
	rightrotate2 rotate2_58(rot2_58, a58);
	rightrotate13 rotate13_58(rot13_58, a58);
	rightrotate22 rotate22_58(rot22_58, a58);
	assign S117 = (rot2_58 ^ rot13_58 ^ rot22_58);
	assign maj58 = ((a58 & b58) ^ (a58 & c58) ^ (b58 & c58));
	assign temp118 = c59 + maj58;
	assign h59 = g58;
	assign g59 = f58;
	assign f59 = e58;
	assign e59 = d58 + temp117;
	assign d59 = c58;
	assign c59 = b58;
	assign b59 = a58;
	assign a59 = temp117 + temp118;


	rightrotate6 rotate6_59(rot6_59, e59);
	rightrotate11 rotate11_59(rot11_59, e59);
	rightrotate25 rotate25_59(rot25_59, e59);
	assign S118 = (rot6_59 ^ rot11_59 ^ rot25_59);
	assign ch59 = ((e59 & f59) ^ (~e59 & g59));
	assign temp119 = h59 + c59 + ch59 +k[59] + w[59];
	rightrotate2 rotate2_59(rot2_59, a59);
	rightrotate13 rotate13_59(rot13_59, a59);
	rightrotate22 rotate22_59(rot22_59, a59);
	assign S119 = (rot2_59 ^ rot13_59 ^ rot22_59);
	assign maj59 = ((a59 & b59) ^ (a59 & c59) ^ (b59 & c59));
	assign temp120 = c60 + maj59;
	assign h60 = g59;
	assign g60 = f59;
	assign f60 = e59;
	assign e60 = d59 + temp119;
	assign d60 = c59;
	assign c60 = b59;
	assign b60 = a59;
	assign a60 = temp119 + temp120;


	rightrotate6 rotate6_60(rot6_60, e60);
	rightrotate11 rotate11_60(rot11_60, e60);
	rightrotate25 rotate25_60(rot25_60, e60);
	assign S120 = (rot6_60 ^ rot11_60 ^ rot25_60);
	assign ch60 = ((e60 & f60) ^ (~e60 & g60));
	assign temp121 = h60 + c60 + ch60 +k[60] + w[60];
	rightrotate2 rotate2_60(rot2_60, a60);
	rightrotate13 rotate13_60(rot13_60, a60);
	rightrotate22 rotate22_60(rot22_60, a60);
	assign S121 = (rot2_60 ^ rot13_60 ^ rot22_60);
	assign maj60 = ((a60 & b60) ^ (a60 & c60) ^ (b60 & c60));
	assign temp122 = c61 + maj60;
	assign h61 = g60;
	assign g61 = f60;
	assign f61 = e60;
	assign e61 = d60 + temp121;
	assign d61 = c60;
	assign c61 = b60;
	assign b61 = a60;
	assign a61 = temp121 + temp122;


	rightrotate6 rotate6_61(rot6_61, e61);
	rightrotate11 rotate11_61(rot11_61, e61);
	rightrotate25 rotate25_61(rot25_61, e61);
	assign S122 = (rot6_61 ^ rot11_61 ^ rot25_61);
	assign ch61 = ((e61 & f61) ^ (~e61 & g61));
	assign temp123 = h61 + c61 + ch61 +k[61] + w[61];
	rightrotate2 rotate2_61(rot2_61, a61);
	rightrotate13 rotate13_61(rot13_61, a61);
	rightrotate22 rotate22_61(rot22_61, a61);
	assign S123 = (rot2_61 ^ rot13_61 ^ rot22_61);
	assign maj61 = ((a61 & b61) ^ (a61 & c61) ^ (b61 & c61));
	assign temp124 = c62 + maj61;
	assign h62 = g61;
	assign g62 = f61;
	assign f62 = e61;
	assign e62 = d61 + temp123;
	assign d62 = c61;
	assign c62 = b61;
	assign b62 = a61;
	assign a62 = temp123 + temp124;


	rightrotate6 rotate6_62(rot6_62, e62);
	rightrotate11 rotate11_62(rot11_62, e62);
	rightrotate25 rotate25_62(rot25_62, e62);
	assign S124 = (rot6_62 ^ rot11_62 ^ rot25_62);
	assign ch62 = ((e62 & f62) ^ (~e62 & g62));
	assign temp125 = h62 + c62 + ch62 +k[62] + w[62];
	rightrotate2 rotate2_62(rot2_62, a62);
	rightrotate13 rotate13_62(rot13_62, a62);
	rightrotate22 rotate22_62(rot22_62, a62);
	assign S125 = (rot2_62 ^ rot13_62 ^ rot22_62);
	assign maj62 = ((a62 & b62) ^ (a62 & c62) ^ (b62 & c62));
	assign temp126 = c63 + maj62;
	assign h63 = g62;
	assign g63 = f62;
	assign f63 = e62;
	assign e63 = d62 + temp125;
	assign d63 = c62;
	assign c63 = b62;
	assign b63 = a62;
	assign a63 = temp125 + temp126;


	rightrotate6 rotate6_63(rot6_63, e63);
	rightrotate11 rotate11_63(rot11_63, e63);
	rightrotate25 rotate25_63(rot25_63, e63);
	assign S126 = (rot6_63 ^ rot11_63 ^ rot25_63);
	assign ch63 = ((e63 & f63) ^ (~e63 & g63));
	assign temp127 = h63 + c63 + ch63 +k[63] + w[63];
	rightrotate2 rotate2_63(rot2_63, a63);
	rightrotate13 rotate13_63(rot13_63, a63);
	rightrotate22 rotate22_63(rot22_63, a63);
	assign S127 = (rot2_63 ^ rot13_63 ^ rot22_63);
	assign maj63 = ((a63 & b63) ^ (a63 & c63) ^ (b63 & c63));
	assign temp128 = c64 + maj63;
	assign h64 = g63;
	assign g64 = f63;
	assign f64 = e63;
	assign e64 = d63 + temp127;
	assign d64 = c63;
	assign c64 = b63;
	assign b64 = a63;
	assign a64 = temp127 + temp128;


	assign hashFinal0 = hash0 + a64;
	assign hashFinal1 = hash1 + b64;
	assign hashFinal2 = hash2 + c64;
	assign hashFinal3 = hash3 + d64;
	assign hashFinal4 = hash4 + e64;
	assign hashFinal5 = hash5 + f64;
	assign hashFinal6 = hash6 + g64;
	assign hashFinal7 = hash7 + h64;

	assign hashedValue[255:224] = hashFinal0;
	assign hashedValue[223:192] = hashFinal1;
	assign hashedValue[191:160] = hashFinal2;
	assign hashedValue[159:128] = hashFinal3;
	assign hashedValue[127:96] = hashFinal4;
	assign hashedValue[95:64] = hashFinal5;
	assign hashedValue[63:32] = hashFinal6;
	assign hashedValue[31:0] = hashFinal7;

endmodule