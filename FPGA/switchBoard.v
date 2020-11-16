module switchBoard(switch1, switch2, switch3, switch4, switch5, switch6, switch7, switch8,
				   switch9, switch10, switch11, switch12, switch13, switch14, switch15, switch16,
				   blockHeader, difficulty);
	input switch1, switch2, switch3, switch4, switch5, switch6, switch7, switch8, switch9, switch10, switch11, switch12, switch13, switch14, switch15, switch16;
	output [255:0] difficulty;
	output [639:0] blockHeader;

	// Wires for difficulty and blockheaders
	wire [255:0] diffZero, diffOne, diffTwo, diffThree, diffFour, diffFive, diffSix, diffSeven, diffEight, diffNine, diffTen, diffEleven, diffTwelve, diffThirteen, diffFourteen, diffFifteen, diffSixteen;
	wire [255:0] difficultyTemp0, difficultyTemp1, difficultyTemp2, difficultyTemp3, difficultyTemp4, difficultyTemp5, difficultyTemp6, difficultyTemp7, difficultyTemp8, difficultyTemp9, difficultyTemp10, difficultyTemp11, difficultyTemp12, difficultyTemp13, difficultyTemp14;
	wire [639:0] blockZero, blockOne, blockTwo, blockThree, blockFour, blockFive, blockSix, blockSeven, blockEight, blockNine, blockTen, blockEleven, blockTwelve, blockThirteen, blockFourteen, blockFifteen, blockSixteen;
	wire [639:0] blockHeaderTemp0, blockHeaderTemp1, blockHeaderTemp2, blockHeaderTemp3, blockHeaderTemp4, blockHeaderTemp5, blockHeaderTemp6, blockHeaderTemp7, blockHeaderTemp8, blockHeaderTemp9, blockHeaderTemp10, blockHeaderTemp11, blockHeaderTemp12, blockHeaderTemp13, blockHeaderTemp14;

	// Assign blockHeader constants
	assign blockZero = 640'h0100000050120119172a610421a6c3011dd330d9df07b63616c2cc1f1cd00200000000006657a9252aacd5c0b2940996ecff952228c3067cc38d4885efb5a4ac4247e9f337221b4d4c86041b0f2b5710;
	assign blockOne = 640'h0100000081cd02ab7e569e8bcd9317e2fe99f2de44d49ab2b8851ba4a308000000000000e320b6c2fffc8d750423db8b1eb942ae710e951ed797f7affc8892b0f1fc122bc7f5d74df2b9441a42a14695;
	assign blockTwo = 640'h010000009500c43a25c624520b5100adf82cb9f9da72fd2447a496bc600b0000000000006cd862370395dedf1da2841ccda0fc489e3039de5f1ccddef0e834991a65600ea6c8cb4db3936a1ae3143991;
	assign blockThree = 640'h02000000b6ff0b1b1680a2862a30ca44d346d9e8910d334beb48ca0c00000000000000009d10aa52ee949386ca9385695f04ede270dda20810decd12bc9b048aaab3147124d95a5430c31b18fe9f0864;
	assign blockFour = 640'h0200000017975b97c18ed1f7e255adf297599b55330edab87803c81701000000000000008a97295a2747b4f1a0b3948df3990344c0e19fa6b2b92b3a19c8e6badc141787358b0553535f011948750833;
	assign blockFive = 640'h010000004944469562ae1c2c74d9a535e00b6f3e40ffbad4f2fda3895501b582000000007a06ea98cd40ba2e3288262b28638cec5337c1456aaf5eedc8e9e5a20f062bdf8cc16649ffff001d2bfee0a9;
	assign blockSix = 640'h0100000050e593d3b22034cfc9884df842e85d398b5c3cfd77b1aa2a86f221ac000000005fafe0e1824bb9995f12eeb4183eaa1fde889f4590191cd63a92a61a1eee9a43f9e16849ffff001d30339e19;
	assign blockSeven = 640'h010000002100cacac549da7d2a879cfbefc18cac6fbb9931d7da48c3e818e38600000000c654ae2f49a83f60d62dfafca02a221c9cb45ad96a5cb1539b22077bfa87d25e7d6d6949ffff001d32d01813;
	assign blockEight = 640'h0100000095194b8567fe2e8bbda931afd01a7acd399b9325cb54683e64129bcd00000000660802c98f18fd34fd16d61c63cf447568370124ac5f3be626c2e1c3c9f0052d19a76949ffff001d33f3c25d;
	assign blockNine = 640'h01000000713c6c20e18ace81b09f7de4367c8e81a89711ebd6e96ee05e80f27b00000000fb4361f015fd0ba2b6d7baf685f0cf6eacf1397f84b2744ff063e63ce76ebfbb3bd76949ffff001d2ddd0ec7;
	assign blockTen = 640'h01000000f018084fc61ea557815ad3e8a2fff8058c865e8060c86dea337ba0dd00000000bea5824628bd47b2edeb32cb6a46225a2b74c498a9fd4c5077bb259ffa381f9a58fe6949ffff001d1622a06b;
	assign blockEleven = 640'h01000000a0f148b9bb7f77d788518de7a781c4e3e8e84e871f2bc6becafc2c3b00000000cb91588c55e281c32f01fee8948999acd618fe33a04999e1bafe53c7459c87034b1d7449ffff001df2c7c506;
	assign blockTwelve = 640'h010000004cd744b906380af0fc1410f6c8f0ceec52d5fd962e170889bf590df0000000004c6598b79a69378aa479b4d38574bf591f279fcb14210676b8c277e04efd9580c3dc7649ffff001d30c4df9b;
	assign blockThirteen = 640'h010000006b860f68f6c5369c60f68ed45cadb55d4a700679647e57dbee65000000000000cf17eb2f03031f9187ea91d6045133d4310da9d3eb06c7c94a45df91ac139ddfa021cc4db3936a1af5d103b0;
	assign blockFourteen = 640'h020000007ef055e1674d2e6551dba41cd214debbee34aeb544c7ec670000000000000000d3998963f80c5bab43fe8c26228e98d030edf4dcbe48a666f5c39e2d7a885c9102c86d536c890019593a470d;
	assign blockFifteen = 640'h0400000039fa821848781f027a2e6dfabbf6bda920d9ae61b63400030000000000000000ecae536a304042e3154be0e3e9a8220e5568c3433a9ab49ac4cbb74f8df8e8b0cc2acf569fb9061806652c27;
	assign blockSixteen = 640'h040000008c8ad09da4379278344ccdc313f4efb47967d47ffe845c0200000000000000004bca16cf77652c0799e01b9e892bf922271e26f4cb43df51a253ca98d2286805adeefb56c3a406185954d686;

	// Assign Difficulty constants
	assign diffZero = {16'b0, 240'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff};
	assign diffOne = {16'b0, 240'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff};
	assign diffTwo = {12'b0, 240'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff};
	assign diffThree = {16'b0, 240'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff};
	assign diffFour = {16'b0, 240'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff};
	assign diffFive = {8'b0, 246'hfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff};
	assign diffSix = {8'b0, 246'hfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff};
	assign diffSeven = {8'b0, 246'hfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff};
	assign diffEight = {8'b0, 246'hfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff};
	assign diffNine = {8'b0, 246'hfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff};
	assign diffTen = {8'b0, 246'hfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff};
	assign diffEleven = {8'b0, 246'hfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff};
	assign diffTwelve = {8'b0, 246'hfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff};
	assign diffThirteen = {12'b0, 240'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff};
	assign diffFourteen = {16'b0, 240'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff};
	assign diffFifteen = {16'b0, 240'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff};
	assign diffSixteen = {16'b0, 240'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff};

	// Determine which blockHeader constant to use based on switch
	assign blockHeaderTemp0 = switch1 ? blockOne : blockZero;
	assign blockHeaderTemp1 = switch2 ? blockTwo : blockHeaderTemp0;
	assign blockHeaderTemp2 = switch3 ? blockThree : blockHeaderTemp1;
	assign blockHeaderTemp3 = switch4 ? blockFour : blockHeaderTemp2;
	assign blockHeaderTemp4 = switch5 ? blockFive : blockHeaderTemp3;
	assign blockHeaderTemp5 = switch6 ? blockSix : blockHeaderTemp4;
	assign blockHeaderTemp6 = switch7 ? blockSeven : blockHeaderTemp5;
	assign blockHeaderTemp7 = switch8 ? blockEight : blockHeaderTemp6;
	assign blockHeaderTemp8 = switch9 ? blockNine : blockHeaderTemp7;
	assign blockHeaderTemp9 = switch10 ? blockTen : blockHeaderTemp8;
	assign blockHeaderTemp10 = switch11 ? blockEleven : blockHeaderTemp9;
	assign blockHeaderTemp11 = switch12 ? blockTwelve : blockHeaderTemp10;
	assign blockHeaderTemp12 = switch13 ? blockThirteen : blockHeaderTemp11;
	assign blockHeaderTemp13 = switch14 ? blockFourteen : blockHeaderTemp12;
	assign blockHeaderTemp14 = switch15 ? blockFifteen : blockHeaderTemp13;
	assign blockHeader = switch16 ? blockSixteen : blockHeaderTemp14;

	// Determine which difficulty constant to use based on switch
	assign difficultyTemp0 = switch1 ? diffOne : diffZero;
	assign difficultyTemp1 = switch2 ? diffTwo : difficultyTemp0;
	assign difficultyTemp2 = switch3 ? diffThree : difficultyTemp1;
	assign difficultyTemp3 = switch4 ? diffFour : difficultyTemp2;
	assign difficultyTemp4 = switch5 ? diffFive : difficultyTemp3;
	assign difficultyTemp5 = switch6 ? diffSix : difficultyTemp4;
	assign difficultyTemp6 = switch7 ? diffSeven : difficultyTemp5;
	assign difficultyTemp7 = switch8 ? diffEight : difficultyTemp6;
	assign difficultyTemp8 = switch9 ? diffNine : difficultyTemp7;
	assign difficultyTemp9 = switch10 ? diffTen : difficultyTemp8;
	assign difficultyTemp10 = switch11 ? diffEleven : difficultyTemp9;
	assign difficultyTemp11 = switch12 ? diffTwelve : difficultyTemp10;
	assign difficultyTemp12 = switch13 ? diffThirteen : difficultyTemp11;
	assign difficultyTemp13 = switch14 ? diffFourteen : difficultyTemp12;
	assign difficultyTemp14 = switch15 ? diffFifteen : difficultyTemp13;
	assign difficulty = switch16 ? diffSixteen : difficultyTemp14;

endmodule