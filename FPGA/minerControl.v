module minerControl(blockHeader, satisfactoryHash, clock, ledControl, nonce, hashSuccess, reset, difficulty);
	input clock, reset;
	input [31:0] nonce;
	input [255:0] difficulty;
	input [639:0] blockHeader;
	output ledControl, hashSuccess;
	output [255:0] satisfactoryHash;

	wire [511:0] blockOne, blockTwo, blockNonce, blockFinal, blockToHash;
	wire [255:0] shaReturn, hashedVal, hashToCheck;
	// wire [63:0] nonce;
	wire [31:0] h0_init, h1_init, h2_init, h3_init, h4_init, h5_init, h6_init, h7_init;
	wire [31:0] q_h0, q_h1, q_h2, q_h3, q_h4, q_h5, q_h6, q_h7;
	wire [31:0] h0In, h1In, h2In, h3In, h4In, h5In, h6In, h7In, h0Out, h1Out, h2Out, h3Out, h4Out, h5Out, h6Out, h7Out;
	wire [15:0] test1;
	wire [1:0] outCount;
	wire counterAtThree, firstBlock, secondBlock, finalHash, legitReset, wasReset, hashCheck;

	dffe_ref resetDFF(wasReset, reset, ~clock, 1'b1, 1'b0);
	assign legitReset = (reset & ~wasReset);

	wire [6:0] cycle_counter;

	wire cycle_counter_reset;
	assign cycle_counter_reset = cycle_counter == 65;

	mineCounter #(.SIZE(7)) count_cycle(cycle_counter, clock, (cycle_counter_reset | legitReset));

	

    mineCounter count(outCount, cycle_counter_reset, (counterAtThree | legitReset));
    assign firstBlock = (outCount == 2'b00);
    assign secondBlock = (outCount == 2'b01);
    assign finalHash = (outCount == 2'b10);
    assign counterAtThree = (outCount == 2'b11);
    
	

	assign h0_init = 32'b01101010000010011110011001100111;
	assign h1_init = 32'b10111011011001111010111010000101;
	assign h2_init = 32'b00111100011011101111001101110010;
	assign h3_init = 32'b10100101010011111111010100111010;
	assign h4_init = 32'b01010001000011100101001001111111;
	assign h5_init = 32'b10011011000001010110100010001100;
	assign h6_init = 32'b00011111100000111101100110101011;
	assign h7_init = 32'b01011011111000001100110100011001;

	assign h0In = secondBlock ? q_h0 : h0_init;
	assign h1In = secondBlock ? q_h1 : h1_init;
	assign h2In = secondBlock ? q_h2 : h2_init;
	assign h3In = secondBlock ? q_h3 : h3_init;
	assign h4In = secondBlock ? q_h4 : h4_init;
	assign h5In = secondBlock ? q_h5 : h5_init;
	assign h6In = secondBlock ? q_h6 : h6_init;
	assign h7In = secondBlock ? q_h7 : h7_init;


	assign blockOne = blockHeader[639:128];
    assign blockTwo = {blockHeader[127:32], nonce, 1'b1, 373'b0, 10'b1010000000};

	assign blockFinal = {hashedVal, 1'b1, 246'b0, 9'b100000000};

	assign blockToHash = firstBlock ? blockOne : secondBlock ? blockTwo : blockFinal;

	SHA256 hashFunction(blockToHash, shaReturn, clock, 
		   				h0In, h1In, h2In, h3In, h4In, h5In, h6In, h7In,
		   				h0Out, h1Out, h2Out, h3Out, h4Out, h5Out, h6Out, h7Out);

	wire write_hash_reg;
	assign write_hash_reg = ~clock & (cycle_counter == 64);

	reg32 h0_reg(q_h0, h0Out, write_hash_reg, 1'b1, 1'b0);
	reg32 h1_reg(q_h1, h1Out, write_hash_reg, 1'b1, 1'b0);
	reg32 h2_reg(q_h2, h2Out, write_hash_reg, 1'b1, 1'b0);
	reg32 h3_reg(q_h3, h3Out, write_hash_reg, 1'b1, 1'b0);
	reg32 h4_reg(q_h4, h4Out, write_hash_reg, 1'b1, 1'b0);
	reg32 h5_reg(q_h5, h5Out, write_hash_reg, 1'b1, 1'b0);
	reg32 h6_reg(q_h6, h6Out, write_hash_reg, 1'b1, 1'b0);
	reg32 h7_reg(q_h7, h7Out, write_hash_reg, 1'b1, 1'b0);
	reg256 return_reg(hashedVal, shaReturn, write_hash_reg, 1'b1, 1'b0);

	// reg64 nonceReg(nonce, blockToHash[191:128] + 1'b1, ~clock, firstBlock, 1'b0);
	// assign nonce = 32'h42a14695;

	// assign shaReturn = firstBlock ? 256'b1 : secondBlock ? 256'b1 : 256'b0;
	//assign shaReturn = 256'b0;

	assign hashToCheck = {shaReturn[7], shaReturn[6], shaReturn[5], shaReturn[4], shaReturn[3], shaReturn[2], shaReturn[1], shaReturn[0], 
						  shaReturn[15], shaReturn[14], shaReturn[13], shaReturn[12], shaReturn[11], shaReturn[10], shaReturn[9], shaReturn[8], 
						  shaReturn[23], shaReturn[22], shaReturn[21], shaReturn[20], shaReturn[19], shaReturn[18], shaReturn[17], shaReturn[16], 
						  shaReturn[31], shaReturn[30], shaReturn[29], shaReturn[28], shaReturn[27], shaReturn[26], shaReturn[25], shaReturn[24], 
						  shaReturn[39], shaReturn[38], shaReturn[37], shaReturn[36], shaReturn[35], shaReturn[34], shaReturn[33], shaReturn[32], 
						  shaReturn[47], shaReturn[46], shaReturn[45], shaReturn[44], shaReturn[43], shaReturn[42], shaReturn[41], shaReturn[40], 
						  shaReturn[55], shaReturn[54], shaReturn[53], shaReturn[52], shaReturn[51], shaReturn[50], shaReturn[49], shaReturn[48], 
						  shaReturn[63], shaReturn[62], shaReturn[61], shaReturn[60], shaReturn[59], shaReturn[58], shaReturn[57], shaReturn[56], 
						  shaReturn[71], shaReturn[70], shaReturn[69], shaReturn[68], shaReturn[67], shaReturn[66], shaReturn[65], shaReturn[64], 
						  shaReturn[79], shaReturn[78], shaReturn[77], shaReturn[76], shaReturn[75], shaReturn[74], shaReturn[73], shaReturn[72], 
						  shaReturn[87], shaReturn[86], shaReturn[85], shaReturn[84], shaReturn[83], shaReturn[82], shaReturn[81], shaReturn[80], 
						  shaReturn[95], shaReturn[94], shaReturn[93], shaReturn[92], shaReturn[91], shaReturn[90], shaReturn[89], shaReturn[88], 
						  shaReturn[103], shaReturn[102], shaReturn[101], shaReturn[100], shaReturn[99], shaReturn[98], shaReturn[97], shaReturn[96], 
						  shaReturn[111], shaReturn[110], shaReturn[109], shaReturn[108], shaReturn[107], shaReturn[106], shaReturn[105], shaReturn[104], 
						  shaReturn[119], shaReturn[118], shaReturn[117], shaReturn[116], shaReturn[115], shaReturn[114], shaReturn[113], shaReturn[112], 
						  shaReturn[127], shaReturn[126], shaReturn[125], shaReturn[124], shaReturn[123], shaReturn[122], shaReturn[121], shaReturn[120], 
						  shaReturn[135], shaReturn[134], shaReturn[133], shaReturn[132], shaReturn[131], shaReturn[130], shaReturn[129], shaReturn[128], 
						  shaReturn[143], shaReturn[142], shaReturn[141], shaReturn[140], shaReturn[139], shaReturn[138], shaReturn[137], shaReturn[136], 
						  shaReturn[151], shaReturn[150], shaReturn[149], shaReturn[148], shaReturn[147], shaReturn[146], shaReturn[145], shaReturn[144], 
						  shaReturn[159], shaReturn[158], shaReturn[157], shaReturn[156], shaReturn[155], shaReturn[154], shaReturn[153], shaReturn[152], 
						  shaReturn[167], shaReturn[166], shaReturn[165], shaReturn[164], shaReturn[163], shaReturn[162], shaReturn[161], shaReturn[160], 
						  shaReturn[175], shaReturn[174], shaReturn[173], shaReturn[172], shaReturn[171], shaReturn[170], shaReturn[169], shaReturn[168], 
						  shaReturn[183], shaReturn[182], shaReturn[181], shaReturn[180], shaReturn[179], shaReturn[178], shaReturn[177], shaReturn[176], 
						  shaReturn[191], shaReturn[190], shaReturn[189], shaReturn[188], shaReturn[187], shaReturn[186], shaReturn[185], shaReturn[184], 
						  shaReturn[199], shaReturn[198], shaReturn[197], shaReturn[196], shaReturn[195], shaReturn[194], shaReturn[193], shaReturn[192], 
						  shaReturn[207], shaReturn[206], shaReturn[205], shaReturn[204], shaReturn[203], shaReturn[202], shaReturn[201], shaReturn[200], 
						  shaReturn[215], shaReturn[214], shaReturn[213], shaReturn[212], shaReturn[211], shaReturn[210], shaReturn[209], shaReturn[208], 
						  shaReturn[223], shaReturn[222], shaReturn[221], shaReturn[220], shaReturn[219], shaReturn[218], shaReturn[217], shaReturn[216], 
						  shaReturn[231], shaReturn[230], shaReturn[229], shaReturn[228], shaReturn[227], shaReturn[226], shaReturn[225], shaReturn[224], 
						  shaReturn[239], shaReturn[238], shaReturn[237], shaReturn[236], shaReturn[235], shaReturn[234], shaReturn[233], shaReturn[232], 
						  shaReturn[247], shaReturn[246], shaReturn[245], shaReturn[244], shaReturn[243], shaReturn[242], shaReturn[241], shaReturn[240], 
						  shaReturn[255], shaReturn[254], shaReturn[253], shaReturn[252], shaReturn[251], shaReturn[250], shaReturn[249], shaReturn[248]};
	
	assign hashCheck = ((difficulty > hashToCheck) & (finalHash));
	dffe_ref goodHash(hashSuccess, hashCheck, ~clock, 1'b1, 1'b0);

	assign satisfactoryHash = hashSuccess ? shaReturn : 256'b0;

	dffe_ref ledDFF(ledControl, hashSuccess, clock, hashSuccess, reset);






endmodule