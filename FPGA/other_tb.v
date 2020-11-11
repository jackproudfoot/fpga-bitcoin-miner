`timescale 1 ns / 100 ps
module other_tb;
    ////// Module Instantiation //////
    // inputs to the module (reg)

    reg [31:0] data_operandA, data_operandB;
    reg ctrl_MULT, ctrl_DIV, clock;
    reg [5:0] counter;

    wire [31:0] data_result, dividend, divisor;
    wire data_exception, data_resultRDY;


    divide ander(data_result, data_operandA, data_operandB, clock, ctrl_DIV, data_resultRDY, data_exception);
    //multiply ander(data_result, data_operandA, data_operandB, clock, ctrl_MULT, data_resultRDY, data_exception);

    ////// Input Initialization //////
    // Initialize the inputs and specify the runtime
    initial begin
        // Initialize the inputs to 0
        // data_operandA = -2147483648;
        // data_operandB = 2;
        data_operandA = -2147483648;
        data_operandB = -2147483648;
        ctrl_MULT = 0;
        ctrl_DIV = 1;
        clock = 0;
        counter = 0;
        // Set a time delay, in nanoseconds

        // Ends the testbench
        //$finish;

    end
    
    ////// Input Manipulation //////
    // Toggle input A every 10 nanoseconds
    always
        #10 clock = ~clock;
    always 
        #20 ctrl_DIV = 0;
    always 
        #20 counter = counter +1;

    // Print the inputs and outputs whenever inputs change

    ////// Output Results //////
        always @(clock, counter) begin
            if (counter == 33) begin
                $finish;
            end
        // Small Delay so outputs can stabilize
        #1;
        //$display(" A    : %b\n*B    : %b\n =      %b\n  data_result: %d       product_reg_out: %b", data_operandA, data_operandB, data_result, $signed(data_result), helper);
       // $display(" A    : %b\n*B    : %b\n =      %b\n  data_result: %d", data_operandA, data_operandB, data_result, $signed(data_result));
        
        $display("Count: %d", counter);
        // $display("Count: %d", ander.outCount);
        // $display("Count: %b %b %b %b %b %b", ander.Nc5b, ander.Nc4b, ander.Nc3b, ander.Nc2b, ander.outCount[1], ander.Nc0b);
        // $display("Dividend: %b", data_operandA);
        // $display("notDividend: %b", ander.notDividend);
        // $display("NegDividend: %b", ander.NegDividend);
        // $display("NegDividend: %b", ander.NegDividend);
        // $display("NegDivisorMSB: %b", ander.NegDivisorMSB);
        // $display("Divisor: %b", data_operandB);
        // $display("notDivisor: %b", ander.notDivisor);
        // $display("NegDivisor: %b", ander.NegDivisor);
        // $display("addVsub: %b", ander.addVsub);
        // $display("remainder: %b", ander.remainder);
        // $display("notToDivide: %b", ander.notToDivide);
        // $display("AminusQ: %b", ander.AminusQ);
        // $display("toDivide: %b", ander.toDivide);
        // $display("AplusQ: %b", ander.AplusQ);
        // $display("quo: %b", ander.quo);
        // $display("intoReg1: %b", ander.intoReg1);
        // $display("dividendToReg: %b", ander.dividendToReg);
        // $display("intoReg2: %b", ander.intoReg2);
        // $display("first: %b", ander.first);
        // $display("inReg: %b", ander.inReg);
        // $display("outReg: %b", ander.outReg);
        // $display("outRegShift: %b", ander.outRegShift);
        // $display("quotient: %bn", ander.quotient);
        // $display("posQuotient: %b", ander.posQuotient);
        // $display("negQuotient: %b", ander.negQuotient);
        // $display("except: %b", ander.except);
        // $display("exce: %b", ander.exce);
        // $display("eeee: %b", ander.eeee);
        // $display("multiplicand: %b", ander.multiplicand);
        $display("maxNeg: %b", ander.maxNeg);
        // $display("postXNOR: %b", ander.postXNOR);
        // $display("maxNegOvf: %b", ander.maxNegOvf);
        // $display("mostCasesEx: %b", ander.mostCasesEx);
        // $display("exception: %b", ander.exception);
        // $display("ready: %b", ander.ready);
        // $display("result: %b\n", data_result);
        // $display("\n");
        // $display("\n");
        
        
        
        
    end

endmodule