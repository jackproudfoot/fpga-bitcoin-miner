module minerControl(blockHeader, satisfactoryHash, clock);
	input clock;
	input [639:0] blockHeader;
	output [255:0] satisfactoryHash;

	wire [447:0] blockOne;
	wire [191:0] blockTwo, blockTwoToHash;
	wire [31:0] h0, h1, h2, h3, h4, h5, h6, h7;
	wire [1:0] outCount;
	wire counterAtThree;

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

	assign h0temp = (secondBlock | finalHash) ? h0Out : h0_init;
	assign h1temp = (secondBlock | finalHash) ? h1Out : h1_init;
	assign h2temp = (secondBlock | finalHash) ? h2Out : h2_init;
	assign h3temp = (secondBlock | finalHash) ? h3Out : h3_init;
	assign h4temp = (secondBlock | finalHash) ? h4Out : h4_init;
	assign h5temp = (secondBlock | finalHash) ? h5Out : h5_init;
	assign h6temp = (secondBlock | finalHash) ? h6Out : h6_init;
	assign h7temp = (secondBlock | finalHash) ? h7Out : h7_init;

	assign h0In = firstBlock ? h0_init : h0temp;
	assign h1In = firstBlock ? h1_init : h1temp;
	assign h2In = firstBlock ? h2_init : h2temp;
	assign h3In = firstBlock ? h3_init : h3temp;
	assign h4In = firstBlock ? h4_init : h4temp;
	assign h5In = firstBlock ? h5_init : h5temp;
	assign h6In = firstBlock ? h6_init : h6temp;
	assign h7In = firstBlock ? h7_init : h7temp;

	assign blockToHashTemp1 = secondBlock ? blockTwoToHash : blockOne;
	assign blockToHashTemp2 = finalHash ? shaReturn : blockToHashTemp1;
	assign blockToHash = (secondBlock & nonceIncrement) ? blockTwoToHash : blockToHashTemp2;

	SHA256 hashFunction(blockToHash, length, shaReturn, clock, 
		   				h0In, h1In, h2In, h3In, h4In, h5In, h6In, h7In,
		   				h0Out, h1Out, h2Out, h3Out, h4Out, h5Out, h6Out, h7Out);

	assign nonceIncrement = ((shaReturn[255:237] != 19'b0) & (finalHash));
	assign hashSuccess = ((shaReturn[255:237] == 19'b0) & (finalHash));

	assign blockTwoToHash[191:32] = blockTwo[191:32];
	assign blockTwoToHash[31:0] = blockTwo[31:0] + 32'b1;
	

	assign satisfactoryHash = hashSuccess ? shaReturn : 256'b0;


endmodule