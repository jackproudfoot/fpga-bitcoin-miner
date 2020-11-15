module alu (data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);
        
    input [31:0] data_operandA, data_operandB;
    input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

    output [31:0] data_result;
    output isNotEqual, isLessThan, overflow;

    wire [31:0] data1, data2, data3, data4, data5, data6, data_operandA_NEG, data_operandB_NEG, data_result_NEG, interMed;
    wire w1, w2, w3, Cin, temp1, temp2, temp3, overAdd, overSub;


    // add your code here:

    // Negate for subtraction and overflow calculation
    negate negateB(data_operandB_NEG, data_operandB);
    negate negateA(data_operandA_NEG, data_operandB);
	negate negateData(data_result_NEG, data_operandB);

	// A + B
	CLA_32 adder(data1, overAdd, data_operandA, data_operandB, 1'b0);

	// A - B
	CLA_32 sub(data2, overSub, data_operandA, data_operandB_NEG, 1'b1);

	// Choose overflow
	mux_2_1B AddSub(overflow, ctrl_ALUopcode[0], overAdd, overSub);

	// And
	bitwiseAND bitA(data3, data_operandA, data_operandB);

	// Or
	bitwiseOR bitO(data4, data_operandA, data_operandB);

	// Left Logitcal Shift
	LeftBarrelShifter SLL(ctrl_shiftamt, data_operandA, data5);

	// Right Arithmetic Shift
	RightBarrelShifter SRA(ctrl_shiftamt, data_operandA, data6);

	// Choose right output
	mux_32 pick(data_result, ctrl_ALUopcode, data1, data2, data3, data4, data5, data6, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0);

	// Is A != B?
	or gg(isNotEqual, data2[0], data2[1], data2[2], data2[3], data2[4], data2[5], data2[6], data2[7], data2[8], data2[9], data2[10], data2[11], data2[12], data2[13], data2[14], data2[15], data2[16], data2[17], data2[18], data2[19], data2[20], data2[21], data2[22], data2[23], data2[24], data2[25], data2[26], data2[27], data2[28], data2[29], data2[30], data2[31]);

	//Is A<B
	and three(temp1, data_operandA[31], data_operandB_NEG[31]);
	and two(temp2, data_operandA[31], data_operandB[31], data2[31]);
	and one(temp3, data_operandA_NEG[31], data_operandB_NEG[31], data2[31]);
	
	

	or isL(isLessThan, temp1, temp2, temp3);


endmodule