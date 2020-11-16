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

module Wrapper(clock, reset, ca, an, txd, rxd, display_toggle);
    input clock, reset;
    output [7:0] ca, an;

    wire rwe, mwe;
    wire[4:0] rd, rs1, rs2;
    wire[31:0] instAddr, instData, 
               rData, regA, regB,
               memAddr, memDataIn, memDataOut;

    wire hashSuccess;
    wire [31:0] nonce;
    wire [255:0] outHash;
    wire [639:0] blockHeader;

    wire [31:0] finalNonce;

    wire [31:0] nonceIn;
    assign nonceIn = blockHeader[31:0];

    input rxd;
    output txd;

    input [3:0] display_toggle;

    wire timeToSend;
    wire rxce;

    //Changing 100 MHz clock to 50 MHz
    reg uartClock = 0;
    always @(posedge clock) begin
        uartClock = ~uartClock;
    end

    //Changing 100 MHz clock to 33.3 MHz
    //reg mineClock = 0;
    wire mineClock;
    assign mineClock = uartClock;
//     integer mineCounter = 0;
//     always @(posedge clock) begin
//       if(mineCounter == 2) begin
//          mineCounter = 0;
//          mineClock = ~mineClock;
//       end else begin
//          mineCounter = mineCounter + 1;
//       end
//     end

    // Changing 33.3 MHz to 11.1 Mhz
    reg procClock = 0;
    integer procCounter = 0;
    always @(posedge mineClock) begin
      if(procCounter == 2) begin
         procCounter = 0;
         procClock = ~procClock;
      end else begin
         procCounter = procCounter + 1;
      end
    end
    
    wire procReset, rxce_sat, reset_sat;
    wire [2:0] prev_rxce, prev_reset;
    saturating_counter rxcesatcount(rxce_sat, prev_rxce, rxce, uartClock);
    saturating_counter resetsatcount(reset_sat, prev_reset, reset, uartClock);
    assign procReset = (prev_reset[2] | prev_reset[1] | prev_reset[0] | reset) | rxce_sat;

    ///// Main Processing Unit
    processor CPU(.clock(procClock), .reset(procReset), 
                  
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
                  .hashSuccess(hashSuccess),
                  .resetMine(resetMine),
      ///// Send
                  .timeToSend(timeToSend),
                  .nonceIn(nonceIn));
                  
    ///// Instruction Memory (ROM)
    ROM #(.MEMFILE("testMine.mem")) // Add your memory file here
    InstMem(.clk(procClock), 
            .wEn(1'b0), 
            .addr(instAddr[11:0]), 
            .dataIn(32'b0), 
            .dataOut(instData));
    
    ///// Register File
    regfile RegisterFile(.clock(procClock), 
             .ctrl_writeEnable(rwe), .ctrl_reset(procReset), 
             .ctrl_writeReg(rd),
             .ctrl_readRegA(rs1), .ctrl_readRegB(rs2), 
             .data_writeReg(rData), .data_readRegA(regA), .data_readRegB(regB));
             
    ///// Processor Memory (RAM)
    RAM ProcMem(.clk(procClock), 
            .wEn(mwe), 
            .addr(memAddr[11:0]), 
            .dataIn(memDataIn), 
            .dataOut(memDataOut));

    // assign hashSuccess = 1'b0;
    // assign nonce = 32'h42a14695;

    ///// Mining Operation
    // assign nonce = 32'h42a14695;
    //assign blockHeader = 640'h0100000081cd02ab7e569e8bcd9317e2fe99f2de44d49ab2b8851ba4a308000000000000e320b6c2fffc8d750423db8b1eb942ae710e951ed797f7affc8892b0f1fc122bc7f5d74df2b9441a42a14695;
    
    wire hashFound;
    dffe_ref goodHash(hashSuccess, hashSuccess | hashFound, ~clock, 1'b1, procReset);
    
    minerControl mineTime(.blockHeader(blockHeader),
                          .satisfactoryHash(outHash),
                          .clock(mineClock),
                          .ledControl(led),
                          .nonce(nonce),
                          .hashSuccess(hashFound),
                          .reset(resetMine));


    //// Serial UART Core
    wire [31:0] byteCount;
    uart_core serial_core(uartClock, reset, rxd, txd, nonce, timeToSend, blockHeader, rxce, byteCount);

    ///// Seven Segment Display

    reg32 goodNonce(finalNonce, nonce, ~clock, hashFound, procReset);
    
    wire [31:0] seven_segment_data;
    //assign seven_segment_data [31:0] = display_toggle[0] ? blockHeader[639:608] : display_toggle[1] ? nonce : display_toggle[2] ? byteCount : display_toggle[3] ? outHash[255:224] : finalNonce;
    assign seven_segment_data [31:0] = finalNonce[31:0];

    seven_segment disp(.ca(ca), .an(an), .data(seven_segment_data), .clock(clock));

endmodule
