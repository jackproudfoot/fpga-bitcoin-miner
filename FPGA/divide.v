module divide(div_result, dividend, divisor, clk, ctrl_div, ready, exception);
	input [31:0] dividend, divisor;
	input clk, ctrl_div;

	output [31:0] div_result;
	output ready, exception;

	wire DivisorMSB, DividendMSB, NegDivisorMSB, NegDividendMSB, MSB, addVsub, ovf1, ovf2, ovf3, first;
	wire Nc0a, Nc1a, Nc2a, Nc3a, Nc4a, Nc5a, Nc0b, Nc1b, Nc2b, Nc3b, Nc4b, Nc5b, temp1, temp2, maxNegAns, maxNeg;
	wire [5:0] outCount;
	wire [31:0] NegDivisor, NegDividend, notDividend, notDivisor, toDivide, dividendToReg, notQ, div_result_1;
	wire [31:0] AplusQ, AminusQ, notToDivide, remainder, quotient, posQuotient, negQuotient, quo, postXNOR, postXNOR1, postXNOR2;
	wire [63:0] intoReg1, intoReg2, inReg, outReg, outRegShift;

	// Run Counter and check if it is done
    counter32 count(outCount, clk, ctrl_div);
    assign Nc0a = ~outCount[0];
    assign Nc1a = ~outCount[1];
    assign Nc2a = ~outCount[2];
    assign Nc3a = ~outCount[3];
    assign Nc4a = ~outCount[4];
    assign Nc5a = ~outCount[5];
    and doneCheck(ready, outCount[0], Nc1a, Nc2a, Nc3a, Nc4a, outCount[5]);
    assign notReady = ~ready;

    assign Nc0b = ~outCount[0];
    assign Nc1b = ~outCount[1];
    assign Nc2b = ~outCount[2];
    assign Nc3b = ~outCount[3];
    assign Nc4b = ~outCount[4];
    assign Nc5b = ~outCount[5];
    and First(first, outCount[0], Nc1b, Nc2b, Nc3b, Nc4b, Nc5b);
    and init(initReg, Nc0b, Nc1b, Nc2b, Nc3b, Nc4b, Nc5b);

	// Turn the divisor into a positive number if it is negative
	assign DivisorMSB = divisor[31];
	assign notDivisor = ~divisor;
	CLA_32 negDsor(NegDivisor, ovf, notDivisor, 32'b1, 1'b0);
	assign NegDivisorMSB = NegDivisor[31];

	// Turn the dividend into a positive number if it is negative
	assign DividendMSB = dividend[31];
	assign notDividend = ~dividend;
	CLA_32 nedDend(NegDividend, ovf, notDividend, 32'b1, 1'b0);
	assign NegDividendMSB = NegDividend[31];

	// Chose between the positive dividend
	mux_2 posOrNegDividend(dividendToReg, NegDividendMSB, NegDividend, dividend);

	// Chose between the positive divisor
	mux_2 posOrNegDivisor(toDivide, NegDivisorMSB, NegDivisor, divisor);

	// Subtract divisor from the output of the product register
	assign notToDivide = ~toDivide;
	CLA_32 AMQ(AminusQ, ovf1, notToDivide, remainder, 1'b1);

	CLA_32 APQ(AplusQ, ovf2, toDivide, remainder, 1'b0);

	mux_2 addOrSub(quo, addVsub, AminusQ, AplusQ);
	assign MSB = quo[31];
	
	mux_2_1B posOrNeg(intoReg1[0], MSB, 1'b1, 1'b0);
	assign intoReg1[31:1] = quotient;
	assign intoReg1[63:32] = quo;

	// Prepare divident to go into the register if it is the first time
	assign intoReg2[31:0] = dividendToReg;
	assign intoReg2[63:32] = 32'b0;

	// Choose what goes into the register
	mux_2_64B intoReg(inReg, ~first, intoReg2, intoReg1);

	// 64-bit Register and controls
	reg64 regi(outReg, inReg, clk, notReady, ctrl_div);

	// Take MSB of register output for choseing operation
	assign addVsub = outReg[63];

	// Logical Left Shift of register output by 1
	assign outRegShift = outReg << 1;

	// Isolate intermediate quotient and remainder
	assign remainder = outRegShift[63:32];
	assign quotient = outRegShift[31:1];

	// Isolate final quotient
	assign posQuotient = intoReg1[31:0];
	assign notQ = ~intoReg1[31:0];
	CLA_32 negQ(negQuotient, ovf3, notQ, 32'b1, 1'b0);
	xor ifNeg(sel, DivisorMSB, DividendMSB);
	mux_2 chosePosQ(div_result, sel, posQuotient, negQuotient);

	// Calculate if overflow occured
  	bitwiseXNOR checkEqual(postXNOR, divisor, 32'b0);
  	and checkExecption(exception, postXNOR[0], postXNOR[1], postXNOR[2], postXNOR[3], postXNOR[4], postXNOR[5], postXNOR[6], postXNOR[7], postXNOR[8], postXNOR[9], postXNOR[10], postXNOR[11], postXNOR[12], postXNOR[13], postXNOR[14], postXNOR[15], postXNOR[16], postXNOR[17], postXNOR[18], postXNOR[19], postXNOR[20], postXNOR[21], postXNOR[22], postXNOR[23], postXNOR[24], postXNOR[25], postXNOR[26], postXNOR[27], postXNOR[28], postXNOR[29], postXNOR[30], postXNOR[31]);
  	// Test
  	// mux_2 check0(div_result, exception, div_result_1, 32'b0);

endmodule