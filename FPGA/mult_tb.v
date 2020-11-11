`timescale 1 ns / 100 ps
module mult_tb;
    ////// Module Instantiation //////
    // inputs to the module (reg)

    reg [31:0] data_operandA, data_operandB;
    reg ctrl_MULT, ctrl_DIV, clock;

    wire [64:0] combined, combToShift, outReg, Mplier;
    wire [31:0] data_result, multiplicand, multiplier, mult_result;
    wire [31:0] multShift, firstMux, secondMux, multToAdd, additionResult;
    wire data_exception, data_resultRDY, add, sub, add2M, sub2M, doNothing, notFirst, notReady, w2;
    reg [5:0] counter;
    //wire [64:0] helper;

    multiply ander(data_result, data_operandA, data_operandB, clock, ctrl_MULT, data_resultRDY, data_exception);

    ////// Input Initialization //////
    // Initialize the inputs and specify the runtime
    initial begin
        // Initialize the inputs to 0
        data_operandA = 4;
        data_operandB = -3;
        ctrl_MULT = 1;
        ctrl_DIV = 0;
        clock = 0;
        counter = 0;
        // Set a time delay, in nanoseconds
        #400;
        // Ends the testbench
        $finish;
    end
    
    ////// Input Manipulation //////
    // Toggle input A every 10 nanoseconds
    always
        #10 clock = ~clock;
    always 
        #20 ctrl_MULT = 0;
    always 
        #20 counter = counter +1;

    // Print the inputs and outputs whenever inputs change

    ////// Output Results //////
        always @(clock, counter) begin
        // Small Delay so outputs can stabilize
        #1;
        //$display(" A    : %b\n*B    : %b\n =      %b\n  data_result: %d       product_reg_out: %b", data_operandA, data_operandB, data_result, $signed(data_result), helper);
       // $display(" A    : %b\n*B    : %b\n =      %b\n  data_result: %d", data_operandA, data_operandB, data_result, $signed(data_result));
        
        // $display("Multiplicand: %b", ander.multiplicand);
        // $display("Multiplier: %b", ander.multiplier);
        $display("Count: %d", counter);
        $display("control: %b", ander.control);
        $display("ADD: %b", ander.add);
        $display("ADD2M: %b", ander.add2M);
        $display("SUB: %b", ander.sub);
        $display("SUB2M: %b", ander.sub2M);
        $display("doNothing: %b", ander.doNothing);
        // $display("multShift: %b", ander.multShift);
        // $display("firstMux: %b", ander.firstMux);
        // $display("secondMux: %b", ander.secondMux);
        // $display("multShift: %b", ander.multShift);
        // $display("multToAdd: %b", ander.multToAdd);
        // $display("outRegTop: %b", ander.outRegTop);
        // $display("Cin: %b", ander.w2);
        $display("additionResult: %b", ander.additionResult);
        // $display("Combined: %b", ander.combined);
        // $display("outRegBot: %b", ander.outRegBot);
        $display("Combined Shift: %b", ander.combToShift);
        // $display("Mplier: %b", ander.Mplier); 
        // $display("notFirst: %b", ander.notFirst); 
        $display("inToReg: %b", ander.inToReg);
        // $display("notReady: %b", ander.notReady);
        $display("outReg: %b\n", ander.outReg);
        // $display("outRegTop: %b", ander.outRegTop);
        $display("ready: %b", data_resultRDY);
        $display("result: %b\n", data_result);
        
        
        
        
    end

endmodule