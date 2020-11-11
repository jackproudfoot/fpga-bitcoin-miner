module multiply(mult_result, multiplicand, multiplier, clk, ctrl_mult, ready, exception);
	input [31:0] multiplicand, multiplier;
	input clk, ctrl_mult;

	output [31:0] mult_result;
	output ready, exception;

	// Define Wires
    wire [31:0] multShift, firstMux, secondMux, multToAdd, postXNOR1, postXNOR2, maxNeg;
    wire [31:0] additionResult, outRegTop, notMultiplicand, notOutRegTop;
    wire [32:0] outRegBot;
    wire [64:0] inToReg, combined, combToShift, Mplier, outReg;
    wire [2:0] control;
    wire [4:0] outCount;
    wire add, sub, add2M, sub2M, doNothing, overflowAdd, notFirst, notReady;
  	wire c2, c3, c4, a1, a2, a3, a4, a5, a6, a7, a8, a9, signCheck, w1, w2, maxNegOvf;
  	wire Nc0a, Nc2a, Nc3a, Nc1b, Nc2b, Nc3b, Nc4b, exce, except, eeee, mostCasesEx, temp1, temp2;

  	// Determine control
  	//findControl fC(control, multiplier, clk, notFirst);

    // Determine control signals for smallers muxs
    controller conOPs(control, add, sub, add2M, sub2M, doNothing);

    // Run Counter and check if it is done
    counter count(outCount, clk, ctrl_mult);
    assign Nc0a = ~outCount[0];
    // assign Nc1a = ~outCount[1];
    assign Nc2a = ~outCount[2];
    assign Nc3a = ~outCount[3];
    and doneCheck(ready, Nc0a, outCount[1], Nc2a, Nc3a, outCount[4]);
    assign notReady = ~ready;

    assign Nc1b = ~outCount[1];
    assign Nc2b = ~outCount[2];
    assign Nc3b = ~outCount[3];
    assign Nc4b = ~outCount[4];
    and nFirst(notFirst, outCount[0], Nc1b, Nc2b, Nc3b, Nc4b);
  	//nand nF(notFirst, outCount[0], outCount[1], outCount[2], outCount[3], outCount[4]);
  	//not nFirst(notFirst, ctrl_MULT);

    // Cases where multiplicand is shifted
  	assign w1 = add2M | sub2M;
    //or doWeShift(w1, add2M, sub2M);
    //SLL_1 shiftLeft(multShift, multiplicand);
    assign multShift = multiplicand << 1;
	  mux_2 shiftMux(firstMux, w1, multiplicand, multShift);

    // Cases where multiplicand is subtracted
    assign w2 = sub | sub2M;
    //or doWeSub(w2, sub, sub2M);
    assign notMultiplicand = ~firstMux;
    mux_2 subMux(secondMux, w2, firstMux, notMultiplicand);

    // Do nothing cases
  	mux_2 zeroMux(multToAdd, doNothing, secondMux, 32'b0);

  	// Add the modified Multiplicand with the modified multiplier	
  	CLA_32 adder(additionResult, overflowAdd, multToAdd, outRegTop, w2);

  	// Combine additionResult with bottom 33 bits from register
  	assign combined[32:0] = outRegBot;
  	assign combined[64:33] = additionResult;

  	// Shift bits right by 2 for all iterations but the first
  	SRA_2 shift(combToShift, combined);

  	// Add an implicit zero to the mux or use the last bits from the register
  	assign Mplier[0] = 1'b0;
  	assign Mplier[32:1] = multiplier;
  	assign Mplier[64:33] = 32'b0;

  	// Determine what value goes into the Register
  	mux_2_65B toReg(inToReg, notFirst, combToShift, Mplier);

  	// Place 65 bits into register
  	reg65 resultReg(outReg, inToReg, clk, notReady, ctrl_mult);

  	// Determine where the high and low of the register go 
  	assign outRegBot = outReg[32:0];
  	assign outRegTop = outReg[64:33];
  	assign control = outReg[2:0];
  	assign mult_result = outReg[32:1];

  	// // Calculate if overflow occured
  	// assign a1 =& outRegTop;
  	// assign notOutRegTop = ~outRegTop;
  	// assign a2 =& notOutRegTop;
  	// or (a3, a1, a2);

  	// xnor(signCheck, outReg[32], outReg[33]);

  	// assign a4 =| outRegBot;
  	// and botAnd(a5, a4, outReg[32]);

  	// assign a6 = ~| outRegBot;
  	// and topAnd(a7, a6, outReg[32]);

  	// nand botNand(a8, a4, a6);

  	// nand topNand(a9, signCheck, a8);

  	// nor ovf(except, a3, a9);

    nor didItOvf1(except, outReg[32], outReg[33], outReg[34], outReg[35], outReg[36], outReg[37], outReg[38], outReg[39], outReg[40], outReg[41], outReg[42], outReg[43], outReg[44], outReg[45], outReg[46], outReg[47], outReg[48], outReg[49], outReg[50], outReg[51], outReg[52], outReg[53], outReg[54], outReg[55], outReg[56], outReg[57], outReg[58], outReg[59], outReg[60], outReg[61], outReg[62], outReg[63], outReg[64]);
    and didItOvf2(exce, outReg[32], outReg[33], outReg[34], outReg[35], outReg[36], outReg[37], outReg[38], outReg[39], outReg[40], outReg[41], outReg[42], outReg[43], outReg[44], outReg[45], outReg[46], outReg[47], outReg[48], outReg[49], outReg[50], outReg[51], outReg[52], outReg[53], outReg[54], outReg[55], outReg[56], outReg[57], outReg[58], outReg[59], outReg[60], outReg[61], outReg[62], outReg[63], outReg[64]);

    // dffe_ref check(exce, 1'b1, clock, overflowAdd, ctrl_MULT);

    or finalovf(eeee, exce, except);
    assign mostCasesEx = ~eeee;

    assign maxNeg = 32'b10000000000000000000000000000000;
    bitwiseXNOR checkEqual(postXNOR1, multiplicand, maxNeg);
    and checkExecption(temp1, postXNOR1[0], postXNOR1[1], postXNOR1[2], postXNOR1[3], postXNOR1[4], postXNOR1[5], postXNOR1[6], postXNOR1[7], postXNOR1[8], postXNOR1[9], postXNOR1[10], postXNOR1[11], postXNOR1[12], postXNOR1[13], postXNOR1[14], postXNOR1[15], postXNOR1[16], postXNOR1[17], postXNOR1[18], postXNOR1[19], postXNOR1[20], postXNOR1[21], postXNOR1[22], postXNOR1[23], postXNOR1[24], postXNOR1[25], postXNOR1[26], postXNOR1[27], postXNOR1[28], postXNOR1[29], postXNOR1[30], postXNOR1[31]);

    bitwiseXNOR checkMult(postXNOR2, multiplier, 32'b11111111111111111111111111111111);
    and checkNeg1(temp2, postXNOR2[0], postXNOR2[1], postXNOR2[2], postXNOR2[3], postXNOR2[4], postXNOR2[5], postXNOR2[6], postXNOR2[7], postXNOR2[8], postXNOR2[9], postXNOR2[10], postXNOR2[11], postXNOR2[12], postXNOR2[13], postXNOR2[14], postXNOR2[15], postXNOR2[16], postXNOR2[17], postXNOR2[18], postXNOR2[19], postXNOR2[20], postXNOR2[21], postXNOR2[22], postXNOR2[23], postXNOR2[24], postXNOR2[25], postXNOR2[26], postXNOR2[27], postXNOR2[28], postXNOR2[29], postXNOR2[30], postXNOR2[31]);

    and failCase(maxNegOvf, temp1, temp2);

    mux_2_1B checkOvf(exception, maxNegOvf, mostCasesEx, 1'b1);    


endmodule