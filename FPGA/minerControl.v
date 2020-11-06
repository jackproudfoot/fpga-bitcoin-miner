module minerControl(blockHeader, satisfactoryHash, clock);
	input clock;
	input [639:0] blockHeader;
	output [255:0] satisfactoryHash;

	wire [511:0] blockOne, blockTwo, blockNonce, blockFinal, blockToHash;
	wire [255:0] shaReturn, hashedVal;
	wire [63:0] nonce;
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
    assign blockTwo = {blockHeader[127:0], 1'b1, 373'b0, 10'b1010000000};

	assign blockFinal = {hashedVal, 1'b1, 246'b0, 9'b100000000};

	assign blockToHash = firstBlock ? blockOne : secondBlock ? blockTwo : blockFinal;

	SHA256 hashFunction(blockToHash, shaReturn, clock, 
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