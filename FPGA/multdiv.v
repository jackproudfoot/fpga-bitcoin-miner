module multdiv(
	data_operandA, data_operandB, 
	ctrl_MULT, ctrl_DIV, 
	clock, 
	data_result, data_exception, data_resultRDY);

    input [31:0] data_operandA, data_operandB;
    input ctrl_MULT, ctrl_DIV, clock;

    output [31:0] data_result;
    output data_exception, data_resultRDY;

    wire [31:0] data_result_DIV, data_result_MULT;
    wire data_resultRDY_DIV, data_resultRDY_MULT, data_exception_DIV, data_exception_MULT, isMult;

    multiply multi(data_result_MULT, data_operandA, data_operandB, clock, ctrl_MULT, data_resultRDY_MULT, data_exception_MULT);

	divide divi(data_result_DIV, data_operandA, data_operandB, clock, ctrl_DIV, data_resultRDY_DIV, data_exception_DIV);

    dffe_ref check(isMult, 1'b1, clock, ctrl_MULT, ctrl_DIV);

    mux_2 resultMux(data_result, isMult, data_result_DIV, data_result_MULT);
    mux_2_1B exceptionMux(data_exception, isMult, data_exception_DIV, data_exception_MULT);
    mux_2_1B readyMux(data_resultRDY, isMult, data_resultRDY_DIV, data_resultRDY_MULT);

endmodule