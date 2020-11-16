/**
 * READ THIS DESCRIPTION!
 *
 * This is your processor module that will contain the bulk of your code submission. You are to implement
 * a 5-stage pipelined processor in this module, accounting for hazards and implementing bypasses as
 * necessary.
 *
 * Ultimately, your processor will be tested by a master skeleton, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file, Wrapper.v, acts as a small wrapper around your processor for this purpose. Refer to Wrapper.v
 * for more details.
 *
 * As a result, this module will NOT contain the RegFile nor the memory modules. Study the inputs 
 * very carefully - the RegFile-related I/Os are merely signals to be sent to the RegFile instantiated
 * in your Wrapper module. This is the same for your memory elements. 
 *
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for RegFile
    ctrl_writeReg,                  // O: Register to write to in RegFile
    ctrl_readRegA,                  // O: Register to read from port A of RegFile
    ctrl_readRegB,                  // O: Register to read from port B of RegFile
    data_writeReg,                  // O: Data to write to for RegFile
    data_readRegA,                  // I: Data from port A of RegFile
    data_readRegB,                  // I: Data from port B of RegFile

    // minerControl
    nonce,                          // O: Nonce value for minerControl
    resetMine,                      // O: Resets Miner Control
    hashSuccess,                    // I: Sucessful hash bit flag
    
    // SerialCore
    timeToSend,                     // O: Control signal for serial core
    nonceIn,                         // I: Nonce input from serial core


    goodHashLed
    );

    // Control signals
    input clock, reset;
    
    // Imem
    output [31:0] address_imem;
    input [31:0] q_imem;

    // Dmem
    output [31:0] address_dmem, data;
    output wren;
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;

    // minerControl
    output resetMine;
    output [31:0] nonce;
    input hashSuccess;

    // Send
    output timeToSend;
    input [31:0] nonceIn;

    output goodHashLed;

    /* YOUR CODE STARTS HERE */

    // Wires for PC
    wire stallClock;
    wire [31:0] PCout, PCin, PCMuxTemp, PCplus1;

    // Wires for FD
    wire stallFD, wxStall;
    wire [31:0] instrInFD, instrOutFD, PCoutFD;

    // RegFile Wires
    wire writeEnable, usesRDasInput, stallDX;
    wire [4:0] rdDecode, rs, rt, rtrdIndex;
    wire [31:0] rdData, rsData, rtData, opCodeFD;

    // Wires for DX
    wire [31:0] instrInDX, instrOutDX, rsOut, rtOut, PCoutDX;

    // Wires for Bypassing in DX
    wire mwByALUA, xmByALUA, mwByALUB, xmByALUB, noBypassMW, noBypassXM;
    wire [4:0] rtrd;
    wire [31:0] bypassRSMW, rsDataBy, bypassRTMW, rtDataBy;

    // Wires for bitcoin mining
    wire timeToMine, goodHash, restart, hashStall;
    wire [6:0] hashStallCount;
    wire [31:0] data_resultMine1, data_resultMine2;
    wire grabNonce, storeNonce;
    wire [31:0] execute_inject;

    // Wires for ALU
    wire overflow, isNotEqual, isLessThan, rtrdSelect, immedCheck, isImmLoadStore, isBranching, isBLT;
    wire [4:0] opCodeDX, opCodeALU, shamt, opCodeALUtemp, opCodeToALU;
    wire [16:0] immediate;
    wire [31:0] data_result, data_resultALU, rtORrdData, extendedImm, data2ToALU, dataOpA, dataOpB;

    // Wires for Jumping
    wire isJumping, isJ, isJal, isJR;
    wire [31:0] extendT, jMuxTemp, jMux, PCisT, PCplusT, PCisRD;

    // Wires for Branching
    wire branchTaken, bneBltTaken, bexTaken;
    wire [31:0] branchPC, branchBneBlt;

    // Wires for SetX/Ovf
    wire isOvf, isSet, addOvf, addiOvf, subOvf, multExecption, divException;
    wire [31:0] statusToWriteIn, statusAdd, statusAddi, statusSub, statusMult, statusDiv, instrChange, instrOvf;

    // Wires for MultDiv
    wire data_resultRDY, data_exception, multOngoing, divOngoing, multDivOngoing, multOP, divOP, counting, isFirst, ctrl_MultDiv, multTime, divTime;
    wire [5:0] count;
    wire [31:0] dataMultDivA, dataMultDivB, data_resultMD, data_resultJumps, data_resultMultDiv;

    // Wires for XM
    wire isStore;
    wire [31:0] instrInXM, instrOutXM, ALUout, rdDataOut, rdIn;

    // Wires for Bypassing in XM
    wire bypassData, noBypassM;

    // Wires for dmem
    wire [31:0] memOut;

    // Wires for M/W
    wire [31:0] instrInMW, instrOutMW, aluToWrite, memToWrite;

    // Wires to determine what goes into RegFile
    wire dataToWrite, isMine;
    wire [4:0] opCodeMW, aluOPCodeMW, rdWrite, writeBackRegister, rdSetBex;
    wire [31:0] data_writeRegLoad, dataWriteTemp;
    
    // Take output of register to determine PC
    assign PCplus1 = PCout < 32'd100 ? PCout + 32'b1 : 32'd100;
    assign PCMuxTemp = isJumping ? jMux : PCplus1;
    assign PCin = branchTaken ? branchPC : PCMuxTemp;

    // Stall if a MULT or a DIV instruction is currently running or if the $rd of a LW is being used as an input in the next cycle
    assign stallClock = (multDivOngoing | wxStall | hashStall) ? 1'b0 : 1'b1;
    reg32 regPC(PCout, PCin, clock, stallClock, reset);

    assign address_imem = PCout[11:0];

    


    // Stall if a MULT or a DIV instruction is currently running or if the $rd of a LW is being used as an input in the next cycle
    assign stallFD = (multDivOngoing | wxStall | hashStall) ? 1'b0 : 1'b1;

    // No-Op if a jump/branch instruction is currently running
    assign instrInFD = (isJumping | branchTaken) ? 32'b0 : q_imem;

    // Fetch/Decode Register
    fetchDecode fDecode(instrInFD, PCplus1, instrOutFD, PCoutFD, clock, stallFD, reset);
                
    // Use instruction to determine $rd, $rs, and $rt
    assign rs = instrOutFD[21:17];
    assign rt = instrOutFD[16:12];
    assign rdDecode = instrOutFD[26:22];
    assign ctrl_writeReg = rdWrite;

    assign usesRDasInput = (instrOutFD[31:27] == 5'b00010) |
                           (instrOutFD[31:27] == 5'b00100) | 
                           (instrOutFD[31:27] == 5'b00110) | 
                           (instrOutFD[31:27] == 5'b00111) |
                           (instrOutFD[31:27] == 5'b01000);

    // assign OUT = SELECT ? in1 : in0
    assign rtrdIndex = usesRDasInput ? rdDecode : rt;

    // Determine if a Bex instruction is called and set $rs = $rstatus and $rt = $r0
    assign isBex = (instrOutFD[31:27] == 5'b10110);
    assign ctrl_readRegA = isBex ? 5'b11110 : rs;
    assign ctrl_readRegB = isBex ? 5'b00000 : rtrdIndex;

    // Stall/NoOp signal if the $rd of a LW is being used as an input in the next cycle
    assign wxStall = (instrOutDX[31:27] == 5'b01000) & ((rs == instrOutDX[26:22]) | ((rt == instrOutDX[26:22]) & (instrOutFD[31:27] != 5'b00111)));


    // Stall if a MULT or a DIV instruction is currently running
    assign stallDX = (multDivOngoing | hashStall) ? 1'b0 : 1'b1;

    // No-Op if a jump/branch instruction is currently running or if the $rd of a LW is being used as an input in the next cycle
    assign instrInDX = (isJumping | branchTaken | wxStall) ? 32'b0 : instrOutFD;

    assign execute_inject = grabNonce ? nonceIn : data_readRegA;

    // Decode/Execute Register
    DX decodeExecute(instrInDX, PCoutFD, execute_inject, data_readRegB, ctrl_readRegB, rsData, rtData, rtrd, instrOutDX, PCoutDX, clock, stallDX, reset);
    
    // Use instruction to determine ALU steps
    assign opCodeDX = instrOutDX[31:27];
    assign opCodeALU = instrOutDX[6:2];
    assign shamt = instrOutDX[11:7];

    // Determine if a Immediate, Load, or Store is being called
    assign isImmLoadStore = (opCodeDX == 5'b00101) | 
                            (opCodeDX == 5'b00111) | 
                            (opCodeDX == 5'b01000);

    // Determine if a branch is being taken
    assign isBranching = (opCodeDX == 5'b00010) | 
                         (opCodeDX == 5'b00110) | 
                         (opCodeDX == 5'b10110);

    assign noBypassMW = (instrOutMW[31:27] == 5'b00010) |
                        (instrOutMW[31:27] == 5'b00100) | 
                        (instrOutMW[31:27] == 5'b00110) | 
                        (instrOutMW[31:27] == 5'b00111);

    assign noBypassXM = (instrOutXM[31:27] == 5'b00010) |
                        (instrOutXM[31:27] == 5'b00100) | 
                        (instrOutXM[31:27] == 5'b00110) | 
                        (instrOutXM[31:27] == 5'b00111);

    // Determine if a jump is being taken
    assign isJ = (instrOutDX[31:27] == 5'b00001) | (instrOutDX[31:27] == 5'b00011);
    assign isJR = (instrOutDX[31:27] == 5'b00100);
    assign isJumping = (isJ | isJR);

    // PC =  Target
    signExtendTarget extendTarget(extendT, instrOutDX[26:0]);
    assign PCisT = extendT;

    // PC = $rd
    assign PCisRD = rtData;

    // Chose which type of jump is executed
    assign jMuxTemp = isJ ? PCisT : PCplus1;
    assign jMux = isJR ? PCisRD : jMuxTemp;

    assign immediate = instrOutDX[16:0];

    // Determine the ALU opcode depending on instruction type
    assign opCodeALUtemp = isImmLoadStore ? 5'b0 : opCodeALU;
    assign opCodeToALU = isBranching ? 5'b1 : opCodeALUtemp;

    ////BYPASSING////
    // Control signs for rsData bypass
    assign mwByALUA = ((instrOutDX[21:17] == instrOutMW[26:22]) & (instrOutDX[21:17] != 5'b0) & ~noBypassMW);
    assign xmByALUA = ((instrOutDX[21:17] == instrOutXM[26:22]) & (instrOutDX[21:17] != 5'b0) & ~noBypassXM);
    assign bexByMW = (opCodeDX == 5'b10110) & (instrOutMW[26:22] == 5'b11110);
    assign bexByXM = (opCodeDX == 5'b10110) & (instrOutXM[26:22] == 5'b11110);

    // Muxes to bypass rsData if needed
    assign bypassRSMW = (mwByALUA | bexByMW) ? data_writeReg : rsData;
    assign rsDataBy = (xmByALUA | bexByXM) ? address_dmem : bypassRSMW;

    // Control signs for rtData bypass
    assign mwByALUB = ((rtrd == instrOutMW[26:22]) & (rtrd != 5'b0) & (opCodeDX != 5'b10110) & ~noBypassMW);
    assign xmByALUB = ((rtrd == instrOutXM[26:22]) & (rtrd != 5'b0) & (opCodeDX != 5'b10110) & ~noBypassXM);

    // Muxes to bypass rtData if needed
    assign bypassRTMW = mwByALUB ? data_writeReg : rtData;
    assign rtDataBy = xmByALUB ? address_dmem : bypassRTMW;
    /////////////////

    // Sets nonce in minerControl to the value of $rs
    assign nonce = rsDataBy;

    // Counter for minerControl Module and Stalling
    assign restart = (hashStallCount > 33) & (timeToMine);
    stallCounter hashCounter(clock, reset, restart, hashStallCount);
    assign hashStall = (timeToMine & (hashStallCount < 32)) | restart;

    // Sign extend immediate and determine if addi instruction is called
    signExtend32 extendImm(extendedImm, immediate);
    assign data2ToALU = isImmLoadStore ? extendedImm : rtDataBy;

    // Determine if BLT is called $rd is DataA and $rs is DataB 
    assign isBLT = (opCodeDX == 5'b00110);
    assign dataOpA = isBLT ? data2ToALU : rsDataBy;
    assign dataOpB = isBLT ? rsDataBy : data2ToALU;

    alu logicUnit(dataOpA, dataOpB, opCodeToALU, shamt, data_resultALU, isNotEqual, isLessThan, overflow);

    // Set overflow flags for ALU
    assign addOvf = (overflow & (opCodeALU == 5'b00000) & (opCodeDX == 5'b00000));
    assign addiOvf = (overflow & (opCodeDX == 5'b00101));
    assign subOvf = (overflow & (opCodeALU == 5'b00001) & (opCodeDX == 5'b00000));

    // Determine Branch taken
    assign bneBltTaken = (isNotEqual & (opCodeDX == 5'b00010)) | (isLessThan & (opCodeDX == 5'b00110));
    assign bexTaken = (isNotEqual & (opCodeDX == 5'b10110));
    assign branchTaken = bneBltTaken | bexTaken;

     // PC+1+N (bne/blt) or PC=T (bex)
    assign branchBneBlt = (PCoutDX + extendedImm);
    assign branchPC = bexTaken ? extendT : branchBneBlt;

    // Determine if a MULT or a DIV instruction is given
    assign multOP = ((opCodeALU == 5'b00110) & (opCodeDX == 5'b00000));
    assign divOP = ((opCodeALU == 5'b00111) & (opCodeDX == 5'b00000));

    // Determine if the mult/div is still ongoing
    dffe_ref multFlop(multTime, multOP, clock, 1'b1, data_resultRDY);
    dffe_ref divFlop(divTime, divOP, clock, 1'b1, data_resultRDY);

    // Assert ctrl_MULT/DIV to be high only for the first clock cycle of instruction
    assign ctrl_MULT = (~multTime & multOP & ~data_resultRDY);
    assign ctrl_DIV = (~divTime & divOP & ~data_resultRDY);

    // Control signal for ongoing mults/divs
    assign multOngoing = ctrl_MULT | multTime;
    assign divOngoing = ctrl_DIV | divTime;
    assign multDivOngoing = multOngoing | divOngoing;

    // MULT/DIV unit
    multdivBehave md(rsDataBy, rtDataBy, ctrl_MULT, ctrl_DIV, clock, data_resultMD, data_exception, data_resultRDY);

    // Set overflow flags for MultDiv
    assign multExecption = (data_exception & (opCodeALU == 5'b00110) & (opCodeDX == 5'b00000));
    assign divException = (data_exception & (opCodeALU == 5'b00111) & (opCodeDX == 5'b00000));

    // Determine if a SetX instruction is taken
    assign isSet = (opCodeDX == 5'b10101);

    // Determine what value goes into $rstatus
    assign isOvf = (addOvf | addiOvf | subOvf | multExecption | divException);
    assign statusAdd = addOvf ? 32'b00000000000000000000000000000001 : 32'b0;
    assign statusAddi = addiOvf ? 32'b00000000000000000000000000000010 : statusAdd;
    assign statusSub = subOvf ? 32'b00000000000000000000000000000011 : statusAddi;
    assign statusMult = multExecption ? 32'b00000000000000000000000000000100 : statusSub;
    assign statusDiv = divException ? 32'b00000000000000000000000000000101 : statusMult;
    assign statusToWriteIn = isSet ? extendT : statusDiv;

    // Change instruction to addi $r30, $r0, 0 if there is an overflow
    assign instrOvf[16:0] = 17'b0;
    assign instrOvf[21:17] = 5'b00000;
    assign instrOvf[26:22] = 5'b11110;
    assign instrOvf[31:27] = 5'b00101;
    assign instrChange = (isOvf | isSet) ? instrOvf : instrOutDX;

    // Determine if a JAL instruction is taken
    assign isJumpAndLink = (opCodeDX == 5'b00011);

    // Determine if a call to minerControl is occuring
    assign timeToMine = (opCodeDX == 5'b11111);
    assign resetMine = timeToMine;

    // Set Send Signal high if a send instruction is called
    assign timeToSend = (opCodeDX == 5'b11110);

    // Set load nonce if a load nonce is called
    assign grabNonce = (instrOutFD[31:27] == 5'b11100);
    assign storeNonce = (instrOutMW[31:27] == 5'b11100);

    // Hold value of hashSuccess for 1 processor clock cycle
    dffe_ref hashSuc(goodHash, hashSuccess, ~clock, hashSuccess, reset);   
    assign goodHashLed = goodHash;

    // Chose 1 if hashSuccess is high
    assign data_resultMine1 = timeToMine ? 32'b0 : data_resultALU;
    assign data_resultMine2 = goodHash ? 32'b1 : data_resultMine1;

    // Chose PC + 1 to be output of execute if JAL instruction is called
    assign data_resultJumps = isJumpAndLink ? PCoutDX : data_resultMine2;

    // Chose MULT/DIV result if a MULT/DIV instruction was called
    assign data_resultMultDiv = data_resultRDY ? data_resultMD : data_resultJumps;

    // Chose T to write into $r30 for setx
    assign data_result = (isSet | isOvf) ? statusToWriteIn : data_resultMultDiv;


    // Stall if a MULT or a DIV instruction is currently running
    assign stallXM = (multDivOngoing | hashStall) ? 1'b0 : 1'b1;

    // Execute/Memory Register
    XM executeMemory(instrChange, data_result, rtDataBy, instrOutXM, address_dmem, rdDataOut, clock, stallXM, reset);

    // Access memory for loads and stores
    assign isStore = instrOutXM[31:27] == 5'b00111;
    assign wren = isStore ? 1'b1 : 1'b0;

    assign noBypassM = (instrOutXM[31:27] == 5'b00010) |
                       (instrOutXM[31:27] == 5'b00100) | 
                       (instrOutXM[31:27] == 5'b00110) | 
                       (instrOutXM[31:27] == 5'b00111);
    
    ////BYPASSING////
    // Control signs for rtData bypass
    assign bypassData = ((instrOutXM[26:22] == instrOutMW[26:22]) & ~noBypassM);

    // Muxes to bypass data if needed
    assign data = bypassData ? data_writeReg : rdDataOut;
    /////////////////
    



    assign instrInMW = instrOutXM;

    // Stall if a MULT or a DIV instruction is currently running
    assign stallMW = (multDivOngoing | hashStall) ? 1'b0 : 1'b1;


    // Memory/Write Registers
    MW memoryWrite(instrInMW, address_dmem, q_dmem, instrOutMW, aluToWrite, memToWrite, clock, stallMW, reset);

    // Determine if a JAL instruction is called
    assign jalTime = (instrOutMW[31:27] == 5'b00011); // (opCodeDX == 5'b00011)
    assign writeBackRegister = instrOutMW[26:22];

    // Chose $rd to be $r31 if a JAL instruction is called
    assign rdWrite = jalTime ? 5'b11111 : writeBackRegister;

    // Determine if a LW instruction is called
    assign isLoad = instrOutMW[31:27] == 5'b01000;

    // Determine if a LW instruction is called
    assign isMine = instrOutMW[31:27] == 5'b11111;

    // Chose value to go into $rd
    //assign dataWriteTemp = goodHash ? 32'b1 : aluToWrite;
    assign data_writeReg = isLoad ? memToWrite : aluToWrite;

    // Set writeEnable to high for addi, LW, JAL, and R-type instructions
    assign ctrl_writeEnable = (instrOutMW[31:27] == 5'b00101) |
                              (instrOutMW[31:27] == 5'b01000) | 
                              (instrOutMW[31:27] == 5'b00000) |
                              (instrOutMW[31:27] == 5'b11111) |
                              (instrOutMW[31:27] == 5'b00011) |
                              storeNonce;


    /* END CODE */

endmodule