# ECE 350 Checkpoint 4: Processor
##### Due: 10/19/2020
##### Matthew Belissary (mab185)

### General Process:
1. Creating the pipeline latches:
	- The first step was to implement the 4 different latches that would enable this processor to be pipelined.
		- These latches pass along the instruction and the outputs from step to step
		- In some cases, the latches pass along the PC+1 
	- This step also is where the instruction (q_imem) is calculated by taking the bottom 12 bits of the PC which goes into the ROM module which is clocked on the falling edge. <br>
2. Implmenting the addi instruction:
	- The next step was adding the capabilities for the addi instruction.  This was the first instruction implemented since the ISA code to test the processor needs to have addi instructions to initialize register values.
		- The first step was to properly parse through the instruction and assign the the processor outputs that go into RegFile.  The outputs of the RegFile (data_readRegA and data_readRegB) are the passed into the DX latch along with the current instruction and the current PC+1 value
		- In the execute stage, the instruction that is outputted from the DX latch is parsed to check if it is an addi instruction.  This sets a control flag high that sets the ALU opcode to be "00000" which forces an add in the ALU.  This flag also is used in a mux to change the data_operandB to be a sign extended immediate that will be added to the data in $rs.
		- The next step passes the instruction and the output of the ALU to the XM latch; however, since the addi instruction is the only thing that is being implemented, this stage does not do anything.
		- In the write back stage, the instruction from the MW reigster is parsed to determine the $rd value and that output from the ALU (aluToWrite) is set to be data_writeReg for the RegFile which is clocked on the falling edge. <br>
3. Implementing the ALU instructions:
	- The next step was to get the ALU instructions to work:
		- No major changes were made other than making the value of data_operandB be the value of data_readRegB as opposed to the sign extended immediate <br>
4. Implementing Loads and Stores:
	- After the R-type instructions (other than MULT/DIV) were implemented and validated in GTKWave, loads and stores were the next instructions to be added.  
		- The first part of this was to set the value of ctrl_readRegB to be the index of $rd when parsed from the current decode instruction. 
		- In the execute stage, the flag that checks for addi instructions was expanded to also look for loads and stores, so the ALU can be manually set to add for those instructions.
		- The first step in the memory stage is to see if the current instruction from the XM latch is a store.  This is used as a control flag for a mux that determines the write enable for the RAM module.  The data variable of the RAM module was set to be data_readRegB (rtDataBy) which was the value stored in the $rd register.
		- In the write-back stage, a check is made to see if the current instruction from the MW latch is a load, and this flag is used in a MUX to chose between the output of the RAM module or the execute from the MW latch (memToWrite and aluToWrite respectively). The ctrl_writeEnable is expanded to flag high for loads in addtion to addi and ALU instructions. <br>
5. Imlementing Jumps:
	- Jumps were the next type of instruction to be implemented:
		- In the execute stage, the opcode is checked and sets flags for J and JAL (isJ), and JR (isJR).  These flags are OR'd together to create an isJumping flag.  If the isJ flag is high, the zero-extended target is set to be the next input into the PC register, and if isJR is high, the next input for the PC register is the value in the $rd register.  Muxes are used along with the control signals of isJ and isJR to chose the appropriate value for the input to the PC register.
		- At the PC register, a mux with the control signal isJumping is used to determine whether to used PC+1 or the modified value of PC as the input.  The isJumping flag is also used to insert No-Ops into the instruction input of the FD and DX latch for flushing purposes.
		- For the "linking" in jump-and-link instructions, a control flag is set if a JAL instruction is being executed.  This flag is used in a mux to change the data_result that goes into the XM latch to be the PC+1 of the execute stage (PCoutDX). <br>
6. Implementing MULT/DIV instructions:
	- The next step was implementing mult and div instructions:
		- The first step was using the multiplier that was previously made in the MULT/DIV checkpoint using that values data_operandA and data_operandB and setting a control flags signals high if the opcode is a mult (multOP) or a div (divOP).
		- The next task was determining a control signal to stall the processor if a mult instruction is ongoing. This was done by using a D-Flip-Flop and some logic involving its output, data_resultRDY, and multOP to ensure that ctrl_MULT/DIV was only asserted high for a single clock cycle.  To determine the control signal for an ongoing mult or div, the output of the mult/div D-Flip-Flop (mult/divTime) was OR'd with ctrl_MULT/DIV. This was used a control signal to stall the write enables of the each latch and the PC register.
		- Another mux is added to set the execute output passed to the XM latch to be the result of the MULT/DIV module if data_resultRDY is high. <br>
7. Implementing Branches:
	- The next instruction type to be implemented was branching:
		- The first step was to add a mux at the PC register step to chose between the altered PC value and the output of the jump mux to be the input to the PC register via a control signal (branchTaken).
		- A control signal is then made to check if a BNE or a BLT is called.  This control signal is used to set a varible equal to the PC+1 in the execute stage plus the sign extended immediate.  This is then used as the input to the branching mux that feeds into the PC register to allow for branching.
		- Similar to jumps, the branchTaken control signal is used to insert No-Ops into the instruction input of the FD and DX latch for flushing purposes. <br>
8. Implementing Bypassing:
	- The next task was implementing bypassing:
		- The first step in getting bypassing to work was to create the control signals for the different kinds of bypassing
		- XM bypassing occurs for my by data_operandA and data_operandB in the execute stage.  This control signal is set high in cases where either data operand is the same register as the $rd register of the stage in the memory stage.  This flag is set by checking the opcodes in the respectives stages.  The signal is then used in a mux to set the operands to be the value in the next stage to ensure the right value is used. Similarly, MW bypassing is done when data operand is the same register as the $rd register of the stage in the write-back stage. This control signal sets the operand to data_writeReg.
		- In the XM stage, another set of bypass logic is implemented to ensure that stores and loads are able to follow each other and have the expected values.  This logic checks the instruction to see if the $rd register of the memory stage is the same as the write-back stage and sets a control signal which goes into a mux to select between data_writeReg and the data from data_readRegB to be the input data to the RAM module. <br>
9. Implementing SetX/Bex:
	- The final instructions to be implemented were the setx and bex instructions.
		- The first step was to ensure that overflow detection is written into $r30 if it occurs.  This was done by checking what the ALU opcode was and AND'ing it with the value of overflow for ALU instructions or the value of data_exceptions in the cases of a MULT/DIV instruction.  These control signals are then used in a mux chain that sets the value to equal the specific integer that indicates what type of overflow occured.  Another control signal is made by OR'ing all of the overflow signals together which is then used change the instruction going into the XM latch to be an addi instruction with the $rd equal to $r30 to write the value of the specific integer indicating overflow into $r30. The data_result passed to the XM latch is then set to be equal to the final value of the status mux chain (statusToWriteIn) which is the value that will go into $r30.
		- The bex logic was added to the working branching logic by adding first checking if a bex instruction is called in the decode instruction. If that is the case, $r30 is set to be ctrl_readRegA and $r0 is set to be ctrl_readRegB. This was done in order to have the data of $r31 to be compared to 0 which is the value of $r0.  This comparison is done in the execute stage since the ALU has an isNotEqual flag.  Another flag is made to see if a bex instruction is called in the execute stage AND'd with the isNotEqual output.  This flag is then used in a mux to determine whether the modifed value for the branch PC is a zero-extended target or the output of the previous branch PC calculation (branchBneBlt).  This final value is then set to the mux chain that changes the input for the PC register.
		- The setx instruction was immpleted by first creating a control signal that checks if the opcode is a setx instruction. This control signal is added to larger OR'ing over the overflow signals and added to the mux chain where the value added to the modified output (statusToWriteIn) is the zero-extended target. The logic then follows the same as the overflow logic previously discussed. <br>


### Debugging:
- The compiling lead to a lot of small syntax errors being revealed which took some time to deal with.  Mainly improperly naming module ports and missing commas and semicolons.
- When testing jumps, I had to set the clock to the falling edge for the RegFile, ROM, and RAM modules after discussing the errors in GTKWave with TAs.
- Mult/Div lead to some issues in debugging with the original way that I was implementing (using a counter), but those errors were fixed with the D-Flip-Flops
- There were some clocking errors with branching at first, but the lecture slides and office hours helped fix these issues

### Edgecases and Associated Errors:
1. Bypassing:
	- The bypassing edge cases were tested by doing all of the forms of bypassing I could thing in consequtive order (testBypass) such as instructions that use that values of the prior two instructions testing both XM and MW bypassing. Other instructions tested were doing loads immediately after stores with the value for the stores being bypassed or the address of the store being bypassed. Other tests involved using bypassing to see if branches would check these values to branch as expected in the ISA. <br>
2. Flushing:
	- This test was to test jumps within jumps (testFlush) and see if the processor would still do the expected instructions <br>
3. Bypassing $r0:
	- This edge cases was stated in the project guides that $r0 must be zero, so additional logic was added so if a value was written into $r0, this value would not be bypassed <br>
4. Double Mult:
	- This edge case test if multiple mult/div instructions could occur in immediate succession (testDoubleMult). <br>
5.  Load Then Use
	- This edge case tests if an instructions requires a value loaded from RAM is immediately proceded by a load instruction (testLoadAdd).  In this case, the DX latch is give a No-Op, and the FD latch and PC register are stalled for a single cycle. <br>
6. Double JAL:
	- This edge case tests if a JAL jump leads to another JAL instruction (testDoubleJAL) and what occurs when the JR instruction is called. <br>
7. Instructions Reading from $rd Bypassing:
	- This edge case occurs when a branch is not taken, but bypassing uses the output of the ALU for the next instruction which leads to the wrong value being used. This was tested in (testBranchNEBypass).  This was solved by checking if an instruction reading from $rd is further along in the pipeline and using that to create a control signal to prevent bypassing. <br>

### Sources:
Sources for this project included lecture slides from class and TA assistance in office hours