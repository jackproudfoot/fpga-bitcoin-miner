module regfile(clock, ctrl_writeEnable, ctrl_reset, ctrl_writeReg, ctrl_readRegA, ctrl_readRegB, data_writeReg, data_readRegA, data_readRegB);
input clock, ctrl_writeEnable, ctrl_reset;
input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
input [31:0] data_writeReg;

output [31:0] data_readRegA, data_readRegB;

wire [31:0] register, regA, regB;
wire enable0, enable1, enable2, enable3, enable4, enable5, enable6, enable7, enable8, enable9, enable10, enable11, enable12, enable13, enable14, enable15, enable16, enable17, enable18, enable19, enable20, enable21, enable22, enable23, enable24, enable25, enable26, enable27, enable28, enable29, enable30, enable31; 
wire [31:0] q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25, q26, q27, q28, q29, q30, q31;

decoder decode(register, ctrl_writeReg);
decoder decodeA(regA, ctrl_readRegA);
decoder decodeB(regB, ctrl_readRegB);

reg32 reg0(q0, 32'b0, ~clock, 1'b1, ctrl_reset);
triStateBuffer tri0A(data_readRegA, regA[0], q0);
triStateBuffer tri0B(data_readRegB, regB[0], q0);

and r1(enable1, register[1], ctrl_writeEnable);
reg32 reg1(q1, data_writeReg, ~clock, enable1, ctrl_reset);
triStateBuffer tri1A(data_readRegA, regA[1], q1);
triStateBuffer tri1B(data_readRegB, regB[1], q1);

and r2(enable2, register[2], ctrl_writeEnable);
reg32 reg2(q2, data_writeReg, ~clock, enable2, ctrl_reset);
triStateBuffer tri2A(data_readRegA, regA[2], q2);
triStateBuffer tri2B(data_readRegB, regB[2], q2);

and r3(enable3, register[3], ctrl_writeEnable);
reg32 reg3(q3, data_writeReg, ~clock, enable3, ctrl_reset);
triStateBuffer tri3A(data_readRegA, regA[3], q3);
triStateBuffer tri3B(data_readRegB, regB[3], q3);

and r4(enable4, register[4], ctrl_writeEnable);
reg32 reg4(q4, data_writeReg, ~clock, enable4, ctrl_reset);
triStateBuffer tri4A(data_readRegA, regA[4], q4);
triStateBuffer tri4B(data_readRegB, regB[4], q4);

and r5(enable5, register[5], ctrl_writeEnable);
reg32 reg5(q5, data_writeReg, ~clock, enable5, ctrl_reset);
triStateBuffer tri5A(data_readRegA, regA[5], q5);
triStateBuffer tri5B(data_readRegB, regB[5], q5);

and r6(enable6, register[6], ctrl_writeEnable);
reg32 reg6(q6, data_writeReg, ~clock, enable6, ctrl_reset);
triStateBuffer tri6A(data_readRegA, regA[6], q6);
triStateBuffer tri6B(data_readRegB, regB[6], q6);

and r7(enable7, register[7], ctrl_writeEnable);
reg32 reg7(q7, data_writeReg, ~clock, enable7, ctrl_reset);
triStateBuffer tri7A(data_readRegA, regA[7], q7);
triStateBuffer tri7B(data_readRegB, regB[7], q7);

and r8(enable8, register[8], ctrl_writeEnable);
reg32 reg8(q8, data_writeReg, ~clock, enable8, ctrl_reset);
triStateBuffer tri8A(data_readRegA, regA[8], q8);
triStateBuffer tri8B(data_readRegB, regB[8], q8);

and r9(enable9, register[9], ctrl_writeEnable);
reg32 reg9(q9, data_writeReg, ~clock, enable9, ctrl_reset);
triStateBuffer tri9A(data_readRegA, regA[9], q9);
triStateBuffer tri9B(data_readRegB, regB[9], q9);

and r10(enable10, register[10], ctrl_writeEnable);
reg32 reg10(q10, data_writeReg, ~clock, enable10, ctrl_reset);
triStateBuffer tri10A(data_readRegA, regA[10], q10);
triStateBuffer tri10B(data_readRegB, regB[10], q10);

and r11(enable11, register[11], ctrl_writeEnable);
reg32 reg11(q11, data_writeReg, ~clock, enable11, ctrl_reset);
triStateBuffer tri11A(data_readRegA, regA[11], q11);
triStateBuffer tri11B(data_readRegB, regB[11], q11);

and r12(enable12, register[12], ctrl_writeEnable);
reg32 reg12(q12, data_writeReg, ~clock, enable12, ctrl_reset);
triStateBuffer tri12A(data_readRegA, regA[12], q12);
triStateBuffer tri12B(data_readRegB, regB[12], q12);

and r13(enable13, register[13], ctrl_writeEnable);
reg32 reg13(q13, data_writeReg, ~clock, enable13, ctrl_reset);
triStateBuffer tri13A(data_readRegA, regA[13], q13);
triStateBuffer tri13B(data_readRegB, regB[13], q13);

and r14(enable14, register[14], ctrl_writeEnable);
reg32 reg14(q14, data_writeReg, ~clock, enable14, ctrl_reset);
triStateBuffer tri14A(data_readRegA, regA[14], q14);
triStateBuffer tri14B(data_readRegB, regB[14], q14);

and r15(enable15, register[15], ctrl_writeEnable);
reg32 reg15(q15, data_writeReg, ~clock, enable15, ctrl_reset);
triStateBuffer tri15A(data_readRegA, regA[15], q15);
triStateBuffer tri15B(data_readRegB, regB[15], q15);

and r16(enable16, register[16], ctrl_writeEnable);
reg32 reg16(q16, data_writeReg, ~clock, enable16, ctrl_reset);
triStateBuffer tri16A(data_readRegA, regA[16], q16);
triStateBuffer tri16B(data_readRegB, regB[16], q16);

and r17(enable17, register[17], ctrl_writeEnable);
reg32 reg17(q17, data_writeReg, ~clock, enable17, ctrl_reset);
triStateBuffer tri17A(data_readRegA, regA[17], q17);
triStateBuffer tri17B(data_readRegB, regB[17], q17);

and r18(enable18, register[18], ctrl_writeEnable);
reg32 reg18(q18, data_writeReg, clock, enable18, ctrl_reset);
triStateBuffer tri18A(data_readRegA, regA[18], q18);
triStateBuffer tri18B(data_readRegB, regB[18], q18);

and r19(enable19, register[19], ctrl_writeEnable);
reg32 reg19(q19, data_writeReg, ~clock, enable19, ctrl_reset);
triStateBuffer tri19A(data_readRegA, regA[19], q19);
triStateBuffer tri19B(data_readRegB, regB[19], q19);

and r20(enable20, register[20], ctrl_writeEnable);
reg32 reg20(q20, data_writeReg, ~clock, enable20, ctrl_reset);
triStateBuffer tri20A(data_readRegA, regA[20], q20);
triStateBuffer tri20B(data_readRegB, regB[20], q20);

and r21(enable21, register[21], ctrl_writeEnable);
reg32 reg21(q21, data_writeReg, ~clock, enable21, ctrl_reset);
triStateBuffer tri21A(data_readRegA, regA[21], q21);
triStateBuffer tri21B(data_readRegB, regB[21], q21);

and r22(enable22, register[22], ctrl_writeEnable);
reg32 reg22(q22, data_writeReg, ~clock, enable22, ctrl_reset);
triStateBuffer tri22A(data_readRegA, regA[22], q22);
triStateBuffer tri22B(data_readRegB, regB[22], q22);

and r23(enable23, register[23], ctrl_writeEnable);
reg32 reg23(q23, data_writeReg, ~clock, enable23, ctrl_reset);
triStateBuffer tri23A(data_readRegA, regA[23], q23);
triStateBuffer tri23B(data_readRegB, regB[23], q23);

and r24(enable24, register[24], ctrl_writeEnable);
reg32 reg24(q24, data_writeReg, ~clock, enable24, ctrl_reset);
triStateBuffer tri24A(data_readRegA, regA[24], q24);
triStateBuffer tri24B(data_readRegB, regB[24], q24);

and r25(enable25, register[25], ctrl_writeEnable);
reg32 reg25(q25, data_writeReg, ~clock, enable25, ctrl_reset);
triStateBuffer tri25A(data_readRegA, regA[25], q25);
triStateBuffer tri25B(data_readRegB, regB[25], q25);

and r26(enable26, register[26], ctrl_writeEnable);
reg32 reg26(q26, data_writeReg, ~clock, enable26, ctrl_reset);
triStateBuffer tri26A(data_readRegA, regA[26], q26);
triStateBuffer tri26B(data_readRegB, regB[26], q26);

and r27(enable27, register[27], ctrl_writeEnable);
reg32 reg27(q27, data_writeReg, ~clock, enable27, ctrl_reset);
triStateBuffer tri27A(data_readRegA, regA[27], q27);
triStateBuffer tri27B(data_readRegB, regB[27], q27);

and r28(enable28, register[28], ctrl_writeEnable);
reg32 reg28(q28, data_writeReg, ~clock, enable28, ctrl_reset);
triStateBuffer tri28A(data_readRegA, regA[28], q28);
triStateBuffer tri28B(data_readRegB, regB[28], q28);

and r29(enable29, register[29], ctrl_writeEnable);
reg32 reg29(q29, data_writeReg, ~clock, enable29, ctrl_reset);
triStateBuffer tri29A(data_readRegA, regA[29], q29);
triStateBuffer tri29B(data_readRegB, regB[29], q29);

and r30(enable30, register[30], ctrl_writeEnable);
reg32 reg30(q30, data_writeReg, ~clock, enable30, ctrl_reset);
triStateBuffer tri30A(data_readRegA, regA[30], q30);
triStateBuffer tri30B(data_readRegB, regB[30], q30);

and r31(enable31, register[31], ctrl_writeEnable);
reg32 reg31(q31, data_writeReg, ~clock, enable31, ctrl_reset);
triStateBuffer tri31A(data_readRegA, regA[31], q31);
triStateBuffer tri31B(data_readRegB, regB[31], q31);

endmodule