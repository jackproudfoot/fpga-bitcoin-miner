module minerControl(blockHeader, satisfactoryHash, clock);
	input clock;
	input [639:0] blockHeader;
	output [255:0] satisfactoryHash;

	wire [447:0] blockOne, blockNonce, blockFinal, blockToHashTemp1, blockToHashTemp2, blockToHash;
	wire [255:0] shaReturn, hashedVal;
	wire [191:0] blockTwo;
	wire [63:0] nonce;
	wire [63:0] length, lengthBlockOne, lengthBlockTwo, lengthFinal, lengthTemp1, lengthTemp2;
	wire [31:0] h0_init, h1_init, h2_init, h3_init, h4_init, h5_init, h6_init, h7_init;
	wire [31:0] q_h0, q_h1, q_h2, q_h3, q_h4, q_h5, q_h6, q_h7;
	wire [31:0] h0In, h1In, h2In, h3In, h4In, h5In, h6In, h7In, h0Out, h1Out, h2Out, h3Out, h4Out, h5Out, h6Out, h7Out;
	wire [1:0] outCount;
	wire counterAtThree, firstBlock, secondBlock, finalHash, hashSuccesss;

    counter count(outCount, clock, counterAtThree);
    assign firstBlock = (outCount == 2'b00);
    assign secondBlock = (outCount == 2'b01);
    assign finalHash = (outCount == 2'b10);
    assign counterAtThree = (outCount == 2'b11);

    assign blockOne = blockHeader[639:192];
    assign blockTwo = blockHeader[191:0];

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

	// assign h0In = secondBlock ? h7_init : h0_init;
	// assign h1In = secondBlock ? h6_init : h1_init;
	// assign h2In = secondBlock ? h5_init : h2_init;
	// assign h3In = secondBlock ? h4_init : h3_init;
	// assign h4In = secondBlock ? h3_init : h4_init;
	// assign h5In = secondBlock ? h2_init : h5_init;
	// assign h6In = secondBlock ? h1_init : h6_init;
	// assign h7In = secondBlock ? h0_init : h7_init;

	// assign h0In = h0_init;
	// assign h1In = h1_init;
	// assign h2In = h2_init;
	// assign h3In = h3_init;
	// assign h4In = h4_init;
	// assign h5In = h5_init;
	// assign h6In = h6_init;
	// assign h7In = h7_init;

	assign blockNonce = {255'b0, 1'b1, nonce, blockTwo[127:0]};
	assign blockFinal = {191'b0, 1'b1, hashedVal};
	// assign blockFinal = 448'b0;

	assign blockToHashTemp1 = secondBlock ? blockNonce : blockOne;
	assign blockToHashTemp2 = finalHash ? blockFinal : blockToHashTemp1;
	assign blockToHash = firstBlock ? blockOne : blockToHashTemp2;

	// assign blockToHash = blockOne; 

	assign lengthBlockOne = {55'b0, 9'b111000000};
	assign lengthBlockTwo = {56'b0, 8'b11000000};
	assign lengthFinal = {55'b0, 9'b100000000};

	assign lengthTemp1 = secondBlock ? lengthBlockTwo : lengthBlockOne;
	assign lengthTemp2 = finalHash ? lengthFinal : lengthTemp1;
	assign length = firstBlock ? lengthBlockOne : lengthTemp2;

	// assign length = lengthBlockOne;

	SHA256 hashFunction(blockToHash, length, shaReturn, clock, 
		   				h0In, h1In, h2In, h3In, h4In, h5In, h6In, h7In,
		   				h0Out, h1Out, h2Out, h3Out, h4Out, h5Out, h6Out, h7Out);

	reg32 h0_reg(q_h0, h0Out, ~clock, 1'b1, 1'b0);
	reg32 h1_reg(q_h1, h1Out, ~clock, 1'b1, 1'b0);
	reg32 h2_reg(q_h2, h2Out, ~clock, 1'b1, 1'b0);
	reg32 h3_reg(q_h3, h3Out, ~clock, 1'b1, 1'b0);
	reg32 h4_reg(q_h4, h4Out, ~clock, 1'b1, 1'b0);
	reg32 h5_reg(q_h5, h5Out, ~clock, 1'b1, 1'b0);
	reg32 h6_reg(q_h6, h6Out, ~clock, 1'b1, 1'b0);
	reg32 h7_reg(q_h7, h7Out, ~clock, 1'b1, 1'b0);
	reg256 return_reg(hashedVal, shaReturn, ~clock, 1'b1, 1'b0);

	// reg64 nonceReg(nonce, blockToHash[191:128] + 1'b1, ~clock, firstBlock, 1'b0);
	assign nonce = 64'h42a14695;

	assign hashSuccess = ((shaReturn[255:237] == 19'b0) & (finalHash));
	
	assign satisfactoryHash = hashSuccess ? shaReturn : 256'b0;


endmodule