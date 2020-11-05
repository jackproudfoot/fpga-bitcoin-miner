module reg256(q, d, clk, en, clr);
	input [255:0] d; 
	input clk, en, clr;
	output [255:0] q;

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
	dffe_ref flipFlop12(q[12], d[12], clk, en, clr);
	dffe_ref flipFlop13(q[13], d[13], clk, en, clr);
	dffe_ref flipFlop14(q[14], d[14], clk, en, clr);
	dffe_ref flipFlop15(q[15], d[15], clk, en, clr);
	dffe_ref flipFlop16(q[16], d[16], clk, en, clr);
	dffe_ref flipFlop17(q[17], d[17], clk, en, clr);
	dffe_ref flipFlop18(q[18], d[18], clk, en, clr);
	dffe_ref flipFlop19(q[19], d[19], clk, en, clr);
	dffe_ref flipFlop20(q[20], d[20], clk, en, clr);
	dffe_ref flipFlop21(q[21], d[21], clk, en, clr);
	dffe_ref flipFlop22(q[22], d[22], clk, en, clr);
	dffe_ref flipFlop23(q[23], d[23], clk, en, clr);
	dffe_ref flipFlop24(q[24], d[24], clk, en, clr);
	dffe_ref flipFlop25(q[25], d[25], clk, en, clr);
	dffe_ref flipFlop26(q[26], d[26], clk, en, clr);
	dffe_ref flipFlop27(q[27], d[27], clk, en, clr);
	dffe_ref flipFlop28(q[28], d[28], clk, en, clr);
	dffe_ref flipFlop29(q[29], d[29], clk, en, clr);
	dffe_ref flipFlop30(q[30], d[30], clk, en, clr);
	dffe_ref flipFlop31(q[31], d[31], clk, en, clr);
	dffe_ref flipFlop32(q[32], d[32], clk, en, clr);
	dffe_ref flipFlop33(q[33], d[33], clk, en, clr);
	dffe_ref flipFlop34(q[34], d[34], clk, en, clr);
	dffe_ref flipFlop35(q[35], d[35], clk, en, clr);
	dffe_ref flipFlop36(q[36], d[36], clk, en, clr);
	dffe_ref flipFlop37(q[37], d[37], clk, en, clr);
	dffe_ref flipFlop38(q[38], d[38], clk, en, clr);
	dffe_ref flipFlop39(q[39], d[39], clk, en, clr);
	dffe_ref flipFlop40(q[40], d[40], clk, en, clr);
	dffe_ref flipFlop41(q[41], d[41], clk, en, clr);
	dffe_ref flipFlop42(q[42], d[42], clk, en, clr);
	dffe_ref flipFlop43(q[43], d[43], clk, en, clr);
	dffe_ref flipFlop44(q[44], d[44], clk, en, clr);
	dffe_ref flipFlop45(q[45], d[45], clk, en, clr);
	dffe_ref flipFlop46(q[46], d[46], clk, en, clr);
	dffe_ref flipFlop47(q[47], d[47], clk, en, clr);
	dffe_ref flipFlop48(q[48], d[48], clk, en, clr);
	dffe_ref flipFlop49(q[49], d[49], clk, en, clr);
	dffe_ref flipFlop50(q[50], d[50], clk, en, clr);
	dffe_ref flipFlop51(q[51], d[51], clk, en, clr);
	dffe_ref flipFlop52(q[52], d[52], clk, en, clr);
	dffe_ref flipFlop53(q[53], d[53], clk, en, clr);
	dffe_ref flipFlop54(q[54], d[54], clk, en, clr);
	dffe_ref flipFlop55(q[55], d[55], clk, en, clr);
	dffe_ref flipFlop56(q[56], d[56], clk, en, clr);
	dffe_ref flipFlop57(q[57], d[57], clk, en, clr);
	dffe_ref flipFlop58(q[58], d[58], clk, en, clr);
	dffe_ref flipFlop59(q[59], d[59], clk, en, clr);
	dffe_ref flipFlop60(q[60], d[60], clk, en, clr);
	dffe_ref flipFlop61(q[61], d[61], clk, en, clr);
	dffe_ref flipFlop62(q[62], d[62], clk, en, clr);
	dffe_ref flipFlop63(q[63], d[63], clk, en, clr);
	dffe_ref flipFlop64(q[64], d[64], clk, en, clr);
	dffe_ref flipFlop65(q[65], d[65], clk, en, clr);
	dffe_ref flipFlop66(q[66], d[66], clk, en, clr);
	dffe_ref flipFlop67(q[67], d[67], clk, en, clr);
	dffe_ref flipFlop68(q[68], d[68], clk, en, clr);
	dffe_ref flipFlop69(q[69], d[69], clk, en, clr);
	dffe_ref flipFlop70(q[70], d[70], clk, en, clr);
	dffe_ref flipFlop71(q[71], d[71], clk, en, clr);
	dffe_ref flipFlop72(q[72], d[72], clk, en, clr);
	dffe_ref flipFlop73(q[73], d[73], clk, en, clr);
	dffe_ref flipFlop74(q[74], d[74], clk, en, clr);
	dffe_ref flipFlop75(q[75], d[75], clk, en, clr);
	dffe_ref flipFlop76(q[76], d[76], clk, en, clr);
	dffe_ref flipFlop77(q[77], d[77], clk, en, clr);
	dffe_ref flipFlop78(q[78], d[78], clk, en, clr);
	dffe_ref flipFlop79(q[79], d[79], clk, en, clr);
	dffe_ref flipFlop80(q[80], d[80], clk, en, clr);
	dffe_ref flipFlop81(q[81], d[81], clk, en, clr);
	dffe_ref flipFlop82(q[82], d[82], clk, en, clr);
	dffe_ref flipFlop83(q[83], d[83], clk, en, clr);
	dffe_ref flipFlop84(q[84], d[84], clk, en, clr);
	dffe_ref flipFlop85(q[85], d[85], clk, en, clr);
	dffe_ref flipFlop86(q[86], d[86], clk, en, clr);
	dffe_ref flipFlop87(q[87], d[87], clk, en, clr);
	dffe_ref flipFlop88(q[88], d[88], clk, en, clr);
	dffe_ref flipFlop89(q[89], d[89], clk, en, clr);
	dffe_ref flipFlop90(q[90], d[90], clk, en, clr);
	dffe_ref flipFlop91(q[91], d[91], clk, en, clr);
	dffe_ref flipFlop92(q[92], d[92], clk, en, clr);
	dffe_ref flipFlop93(q[93], d[93], clk, en, clr);
	dffe_ref flipFlop94(q[94], d[94], clk, en, clr);
	dffe_ref flipFlop95(q[95], d[95], clk, en, clr);
	dffe_ref flipFlop96(q[96], d[96], clk, en, clr);
	dffe_ref flipFlop97(q[97], d[97], clk, en, clr);
	dffe_ref flipFlop98(q[98], d[98], clk, en, clr);
	dffe_ref flipFlop99(q[99], d[99], clk, en, clr);
	dffe_ref flipFlop100(q[100], d[100], clk, en, clr);
	dffe_ref flipFlop101(q[101], d[101], clk, en, clr);
	dffe_ref flipFlop102(q[102], d[102], clk, en, clr);
	dffe_ref flipFlop103(q[103], d[103], clk, en, clr);
	dffe_ref flipFlop104(q[104], d[104], clk, en, clr);
	dffe_ref flipFlop105(q[105], d[105], clk, en, clr);
	dffe_ref flipFlop106(q[106], d[106], clk, en, clr);
	dffe_ref flipFlop107(q[107], d[107], clk, en, clr);
	dffe_ref flipFlop108(q[108], d[108], clk, en, clr);
	dffe_ref flipFlop109(q[109], d[109], clk, en, clr);
	dffe_ref flipFlop110(q[110], d[110], clk, en, clr);
	dffe_ref flipFlop111(q[111], d[111], clk, en, clr);
	dffe_ref flipFlop112(q[112], d[112], clk, en, clr);
	dffe_ref flipFlop113(q[113], d[113], clk, en, clr);
	dffe_ref flipFlop114(q[114], d[114], clk, en, clr);
	dffe_ref flipFlop115(q[115], d[115], clk, en, clr);
	dffe_ref flipFlop116(q[116], d[116], clk, en, clr);
	dffe_ref flipFlop117(q[117], d[117], clk, en, clr);
	dffe_ref flipFlop118(q[118], d[118], clk, en, clr);
	dffe_ref flipFlop119(q[119], d[119], clk, en, clr);
	dffe_ref flipFlop120(q[120], d[120], clk, en, clr);
	dffe_ref flipFlop121(q[121], d[121], clk, en, clr);
	dffe_ref flipFlop122(q[122], d[122], clk, en, clr);
	dffe_ref flipFlop123(q[123], d[123], clk, en, clr);
	dffe_ref flipFlop124(q[124], d[124], clk, en, clr);
	dffe_ref flipFlop125(q[125], d[125], clk, en, clr);
	dffe_ref flipFlop126(q[126], d[126], clk, en, clr);
	dffe_ref flipFlop127(q[127], d[127], clk, en, clr);
	dffe_ref flipFlop128(q[128], d[128], clk, en, clr);
	dffe_ref flipFlop129(q[129], d[129], clk, en, clr);
	dffe_ref flipFlop130(q[130], d[130], clk, en, clr);
	dffe_ref flipFlop131(q[131], d[131], clk, en, clr);
	dffe_ref flipFlop132(q[132], d[132], clk, en, clr);
	dffe_ref flipFlop133(q[133], d[133], clk, en, clr);
	dffe_ref flipFlop134(q[134], d[134], clk, en, clr);
	dffe_ref flipFlop135(q[135], d[135], clk, en, clr);
	dffe_ref flipFlop136(q[136], d[136], clk, en, clr);
	dffe_ref flipFlop137(q[137], d[137], clk, en, clr);
	dffe_ref flipFlop138(q[138], d[138], clk, en, clr);
	dffe_ref flipFlop139(q[139], d[139], clk, en, clr);
	dffe_ref flipFlop140(q[140], d[140], clk, en, clr);
	dffe_ref flipFlop141(q[141], d[141], clk, en, clr);
	dffe_ref flipFlop142(q[142], d[142], clk, en, clr);
	dffe_ref flipFlop143(q[143], d[143], clk, en, clr);
	dffe_ref flipFlop144(q[144], d[144], clk, en, clr);
	dffe_ref flipFlop145(q[145], d[145], clk, en, clr);
	dffe_ref flipFlop146(q[146], d[146], clk, en, clr);
	dffe_ref flipFlop147(q[147], d[147], clk, en, clr);
	dffe_ref flipFlop148(q[148], d[148], clk, en, clr);
	dffe_ref flipFlop149(q[149], d[149], clk, en, clr);
	dffe_ref flipFlop150(q[150], d[150], clk, en, clr);
	dffe_ref flipFlop151(q[151], d[151], clk, en, clr);
	dffe_ref flipFlop152(q[152], d[152], clk, en, clr);
	dffe_ref flipFlop153(q[153], d[153], clk, en, clr);
	dffe_ref flipFlop154(q[154], d[154], clk, en, clr);
	dffe_ref flipFlop155(q[155], d[155], clk, en, clr);
	dffe_ref flipFlop156(q[156], d[156], clk, en, clr);
	dffe_ref flipFlop157(q[157], d[157], clk, en, clr);
	dffe_ref flipFlop158(q[158], d[158], clk, en, clr);
	dffe_ref flipFlop159(q[159], d[159], clk, en, clr);
	dffe_ref flipFlop160(q[160], d[160], clk, en, clr);
	dffe_ref flipFlop161(q[161], d[161], clk, en, clr);
	dffe_ref flipFlop162(q[162], d[162], clk, en, clr);
	dffe_ref flipFlop163(q[163], d[163], clk, en, clr);
	dffe_ref flipFlop164(q[164], d[164], clk, en, clr);
	dffe_ref flipFlop165(q[165], d[165], clk, en, clr);
	dffe_ref flipFlop166(q[166], d[166], clk, en, clr);
	dffe_ref flipFlop167(q[167], d[167], clk, en, clr);
	dffe_ref flipFlop168(q[168], d[168], clk, en, clr);
	dffe_ref flipFlop169(q[169], d[169], clk, en, clr);
	dffe_ref flipFlop170(q[170], d[170], clk, en, clr);
	dffe_ref flipFlop171(q[171], d[171], clk, en, clr);
	dffe_ref flipFlop172(q[172], d[172], clk, en, clr);
	dffe_ref flipFlop173(q[173], d[173], clk, en, clr);
	dffe_ref flipFlop174(q[174], d[174], clk, en, clr);
	dffe_ref flipFlop175(q[175], d[175], clk, en, clr);
	dffe_ref flipFlop176(q[176], d[176], clk, en, clr);
	dffe_ref flipFlop177(q[177], d[177], clk, en, clr);
	dffe_ref flipFlop178(q[178], d[178], clk, en, clr);
	dffe_ref flipFlop179(q[179], d[179], clk, en, clr);
	dffe_ref flipFlop180(q[180], d[180], clk, en, clr);
	dffe_ref flipFlop181(q[181], d[181], clk, en, clr);
	dffe_ref flipFlop182(q[182], d[182], clk, en, clr);
	dffe_ref flipFlop183(q[183], d[183], clk, en, clr);
	dffe_ref flipFlop184(q[184], d[184], clk, en, clr);
	dffe_ref flipFlop185(q[185], d[185], clk, en, clr);
	dffe_ref flipFlop186(q[186], d[186], clk, en, clr);
	dffe_ref flipFlop187(q[187], d[187], clk, en, clr);
	dffe_ref flipFlop188(q[188], d[188], clk, en, clr);
	dffe_ref flipFlop189(q[189], d[189], clk, en, clr);
	dffe_ref flipFlop190(q[190], d[190], clk, en, clr);
	dffe_ref flipFlop191(q[191], d[191], clk, en, clr);
	dffe_ref flipFlop192(q[192], d[192], clk, en, clr);
	dffe_ref flipFlop193(q[193], d[193], clk, en, clr);
	dffe_ref flipFlop194(q[194], d[194], clk, en, clr);
	dffe_ref flipFlop195(q[195], d[195], clk, en, clr);
	dffe_ref flipFlop196(q[196], d[196], clk, en, clr);
	dffe_ref flipFlop197(q[197], d[197], clk, en, clr);
	dffe_ref flipFlop198(q[198], d[198], clk, en, clr);
	dffe_ref flipFlop199(q[199], d[199], clk, en, clr);
	dffe_ref flipFlop200(q[200], d[200], clk, en, clr);
	dffe_ref flipFlop201(q[201], d[201], clk, en, clr);
	dffe_ref flipFlop202(q[202], d[202], clk, en, clr);
	dffe_ref flipFlop203(q[203], d[203], clk, en, clr);
	dffe_ref flipFlop204(q[204], d[204], clk, en, clr);
	dffe_ref flipFlop205(q[205], d[205], clk, en, clr);
	dffe_ref flipFlop206(q[206], d[206], clk, en, clr);
	dffe_ref flipFlop207(q[207], d[207], clk, en, clr);
	dffe_ref flipFlop208(q[208], d[208], clk, en, clr);
	dffe_ref flipFlop209(q[209], d[209], clk, en, clr);
	dffe_ref flipFlop210(q[210], d[210], clk, en, clr);
	dffe_ref flipFlop211(q[211], d[211], clk, en, clr);
	dffe_ref flipFlop212(q[212], d[212], clk, en, clr);
	dffe_ref flipFlop213(q[213], d[213], clk, en, clr);
	dffe_ref flipFlop214(q[214], d[214], clk, en, clr);
	dffe_ref flipFlop215(q[215], d[215], clk, en, clr);
	dffe_ref flipFlop216(q[216], d[216], clk, en, clr);
	dffe_ref flipFlop217(q[217], d[217], clk, en, clr);
	dffe_ref flipFlop218(q[218], d[218], clk, en, clr);
	dffe_ref flipFlop219(q[219], d[219], clk, en, clr);
	dffe_ref flipFlop220(q[220], d[220], clk, en, clr);
	dffe_ref flipFlop221(q[221], d[221], clk, en, clr);
	dffe_ref flipFlop222(q[222], d[222], clk, en, clr);
	dffe_ref flipFlop223(q[223], d[223], clk, en, clr);
	dffe_ref flipFlop224(q[224], d[224], clk, en, clr);
	dffe_ref flipFlop225(q[225], d[225], clk, en, clr);
	dffe_ref flipFlop226(q[226], d[226], clk, en, clr);
	dffe_ref flipFlop227(q[227], d[227], clk, en, clr);
	dffe_ref flipFlop228(q[228], d[228], clk, en, clr);
	dffe_ref flipFlop229(q[229], d[229], clk, en, clr);
	dffe_ref flipFlop230(q[230], d[230], clk, en, clr);
	dffe_ref flipFlop231(q[231], d[231], clk, en, clr);
	dffe_ref flipFlop232(q[232], d[232], clk, en, clr);
	dffe_ref flipFlop233(q[233], d[233], clk, en, clr);
	dffe_ref flipFlop234(q[234], d[234], clk, en, clr);
	dffe_ref flipFlop235(q[235], d[235], clk, en, clr);
	dffe_ref flipFlop236(q[236], d[236], clk, en, clr);
	dffe_ref flipFlop237(q[237], d[237], clk, en, clr);
	dffe_ref flipFlop238(q[238], d[238], clk, en, clr);
	dffe_ref flipFlop239(q[239], d[239], clk, en, clr);
	dffe_ref flipFlop240(q[240], d[240], clk, en, clr);
	dffe_ref flipFlop241(q[241], d[241], clk, en, clr);
	dffe_ref flipFlop242(q[242], d[242], clk, en, clr);
	dffe_ref flipFlop243(q[243], d[243], clk, en, clr);
	dffe_ref flipFlop244(q[244], d[244], clk, en, clr);
	dffe_ref flipFlop245(q[245], d[245], clk, en, clr);
	dffe_ref flipFlop246(q[246], d[246], clk, en, clr);
	dffe_ref flipFlop247(q[247], d[247], clk, en, clr);
	dffe_ref flipFlop248(q[248], d[248], clk, en, clr);
	dffe_ref flipFlop249(q[249], d[249], clk, en, clr);
	dffe_ref flipFlop250(q[250], d[250], clk, en, clr);
	dffe_ref flipFlop251(q[251], d[251], clk, en, clr);
	dffe_ref flipFlop252(q[252], d[252], clk, en, clr);
	dffe_ref flipFlop253(q[253], d[253], clk, en, clr);
	dffe_ref flipFlop254(q[254], d[254], clk, en, clr);
	dffe_ref flipFlop255(q[255], d[255], clk, en, clr);

endmodule