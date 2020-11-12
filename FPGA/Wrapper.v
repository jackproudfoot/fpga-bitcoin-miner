`timescale 1ns / 1ps
/**
 * 
 * READ THIS DESCRIPTION:
 *
 * This is the Wrapper module that will serve as the header file combining your processor, RegFile and Memory elements together.
 * 
 * We will be using our own separate Wrapper.v to test your code. You are allowed to make changes to the Wrapper file for your
 * own individual testing, but we expect your final processor.v and memory modules to work with the 
 * provided Wrapper interface.
 * 
 * Refer to Lab 5 documents for detailed instructions on how to interface 
 * with the memory elements. Each imem and dmem modules will take 12-bit 
 * addresses and will allow for storing of 32-bit values at each address. 
 * Each memory module should receive a single clock. At which edges, is 
 * purely a design choice (and thereby up to you). 
 * 
 * You must change line 47 to add the memory file of the test you created using the assembler
 * For example, you would add sample.mem inside of the quotes after assembling sample.s
 *
 **/

module Wrapper(clock, reset, led);
    input clock, reset;
    output led;

    wire rwe, mwe;
    wire[4:0] rd, rs1, rs2;
    wire[31:0] instAddr, instData, 
               rData, regA, regB,
               memAddr, memDataIn, memDataOut;

    wire hashSuccess;
    wire [31:0] nonce;
    wire [255:0] outHash;
    wire [639:0] blockHeader;

    // Changing 100 MHz clock to 60 MHz
    reg mineClock = 1;
    integer mineCounter = 0;
    always @(posedge clock) begin
      if(mineCounter == 3) begin
         mineCounter = 1;
         mineClock = ~mineClock;
      end else begin
         mineCounter = mineCounter + 1;
      end
    end

    // Changing 100 MHz clock to 20 MHz
    reg procClock = 1;
    integer procCounter = 0;
    always @(posedge clock) begin
      if(procCounter == 18) begin
         procCounter = 1;
         procClock = ~procClock;
      end else begin
         procCounter = procCounter + 1;
      end
    end
    
    ///// Main Processing Unit
    processor CPU(.clock(procClock), .reset(reset), 
                  
		  ///// ROM
                  .address_imem(instAddr), .q_imem(instData),
                  
		  ///// Regfile
                  .ctrl_writeEnable(rwe),     .ctrl_writeReg(rd),
                  .ctrl_readRegA(rs1),     .ctrl_readRegB(rs2), 
                  .data_writeReg(rData), .data_readRegA(regA), .data_readRegB(regB),
                  
		  ///// RAM
                  .wren(mwe), .address_dmem(memAddr), 
                  .data(memDataIn), .q_dmem(memDataOut),

      ///// minerControl 
                  .nonce(nonce),
                  .hashSuccess(hashSuccess));
                  
    ///// Instruction Memory (ROM)
    ROM #(.MEMFILE("")) // Add your memory file here
    InstMem(.clk(procClock), 
            .wEn(1'b0), 
            .addr(instAddr[11:0]), 
            .dataIn(32'b0), 
            .dataOut(instData));
    
    ///// Register File
    regfile RegisterFile(.clock(procClock), 
             .ctrl_writeEnable(rwe), .ctrl_reset(reset), 
             .ctrl_writeReg(rd),
             .ctrl_readRegA(rs1), .ctrl_readRegB(rs2), 
             .data_writeReg(rData), .data_readRegA(regA), .data_readRegB(regB));
             
    ///// Processor Memory (RAM)
    RAM ProcMem(.clk(procClock), 
            .wEn(mwe), 
            .addr(memAddr[11:0]), 
            .dataIn(memDataIn), 
            .dataOut(memDataOut));

    ///// Mining Operation
    assign nonce = 32'h42a14695;
    assign blockHeader = 640'h0100000081cd02ab7e569e8bcd9317e2fe99f2de44d49ab2b8851ba4a308000000000000e320b6c2fffc8d750423db8b1eb942ae710e951ed797f7affc8892b0f1fc122bc7f5d74df2b9441a42a14695;
    minerControl mineTime(.blockHeader(blockHeader),
                          .satisfactoryHash(outHash),
                          .clock(mineClock),
                          .ledControl(led),
                          .nonce(nonce),
                          .hashSuccess(hashSuccess));

endmodule
