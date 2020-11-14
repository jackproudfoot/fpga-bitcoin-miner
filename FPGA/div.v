module div(true_dividend, true_divisor, ctrl_DIV, clock, result, exception, resultRDY);

    input [31:0] true_dividend, true_divisor;
    input ctrl_DIV, clock;

    output [31:0] result;
    output exception, resultRDY;
    
    wire ctrl_write_reg, ctrl_shift, ctrl_sign, ctrl_incl;

    // Ensure dividend and divisor are unsigned
    wire [32:0] dividend, divisor; 
    wire [31:0] true_divisor_inv, neg_true_divisor, true_dividend_inv, neg_true_dividend;
    wire ig0, ig1;
    assign true_dividend_inv = ~true_dividend;
    assign true_divisor_inv = ~true_divisor;
    
    adder neg_dividend(true_dividend_inv, 32'b0, 1'b1, neg_true_dividend, ig0);
    adder neg_divisor(true_divisor_inv, 32'b0, 1'b1, neg_true_divisor, ig1);

    assign dividend[32] = 1'b0;
    assign dividend[31:0] = true_dividend[31] ? neg_true_dividend : true_dividend;

    assign divisor[32] = 1'b0;
    assign divisor = true_divisor[31] ? neg_true_divisor : true_divisor;


    // Create inverted divisor
    wire [32:0] inv_divisor;
    assign inv_divisor =~ divisor;

    // Setup AQ register
    wire [65:0] AQ, reg_in;
    div_register div_reg(AQ, reg_in, clock, ctrl_write_reg, ctrl_DIV);
    assign ctrl_write_reg = ~resultRDY;

    // Counter
    wire [5:0] count_val;
    counter count(ctrl_DIV, clock, count_val);
    
    wire ctrl_firstOp_temp, ctrl_firstOp, ctrl_lastOp;
    assign ctrl_firstOp_temp =| count_val;
    not ctrl_firstOp_inverter(ctrl_firstOp, ctrl_firstOp_temp);
    assign ctrl_lastOp = count_val[5] & count_val[0];

    // Left Shift AQ
    wire [65:0] AQ_shift;
    assign AQ_shift[65:33] = ctrl_firstOp ? 33'b0 : AQ[64:32];
    assign AQ_shift[32:1] = ctrl_firstOp ? dividend : AQ[31:0];
    assign AQ_shift[0] = 1'b0;


    // Remainder Adder
    wire [32:0] remainder, divisor_sel;
    wire adder_cout;

    assign ctrl_sign =~ AQ_shift[65];
    assign divisor_sel = ctrl_sign ? inv_divisor : (ctrl_lastOp ? 33'b0 : divisor);
    
    adder div_adder(AQ_shift[64:33], divisor_sel[31:0], ctrl_sign, remainder[31:0], adder_cout);
    xor upper_bit(remainder[32], AQ_shift[65], divisor_sel[32], adder_cout);

    // Load Register
    assign reg_in[65:33] = remainder;
    assign reg_in[32:1] = AQ_shift[32:1];
    assign reg_in[0] = ctrl_lastOp ? 1'b0 : ~remainder[31];

    wire [32:0] reg_in_A;
    wire [32:0] reg_in_Q;
    assign reg_in_A = reg_in[65:33];
    assign reg_in_Q = reg_in[32:0];

    wire [32:0] reg_A;
    wire [32:0] reg_Q;
    assign reg_A = AQ[65:33];
    assign reg_Q = AQ[32:0];

    // Result
    wire [31:0] unsigned_result, pos_result, neg_result, pos_result_inv;
    assign unsigned_result = exception ? 32'b0 : AQ[31:0];

    assign pos_result[31] = 0;
    assign pos_result[30:0] = unsigned_result[30:0];

    assign pos_result_inv = ~pos_result;
    
    wire ig2;
    adder neg_result_adder(pos_result_inv, 32'b0, 1'b1, neg_result, ig2);

    wire result_sign;
    xor check_result_sign(result_sign, true_dividend[31], true_divisor[31]);

    assign result = result_sign ? neg_result : pos_result;

    // Exception
    wire divisor_zero;
    assign divisor_zero =| divisor;
    assign exception = ~divisor_zero;

    //assign resultRDY = (count_val[5] & ~count_val[4] & ~count_val[3] & ~count_val[2] & ~count_val[1] & count_val[0]) | exception;
    assign resultRDY = (count_val[5] & ~count_val[4] & ~count_val[3] & ~count_val[2] & ~count_val[1] & count_val[0]);

endmodule


module div_register(out, d, clk, wr_en, clr);
    input [65:0] d;
    input clk, clr, wr_en;

    output [65:0] out;
    
    dffe_ref dff_0(out[0], d[0], clk, wr_en, clr);
    dffe_ref dff_1(out[1], d[1], clk, wr_en, clr);
    dffe_ref dff_2(out[2], d[2], clk, wr_en, clr);
    dffe_ref dff_3(out[3], d[3], clk, wr_en, clr);
    dffe_ref dff_4(out[4], d[4], clk, wr_en, clr);
    dffe_ref dff_5(out[5], d[5], clk, wr_en, clr);
    dffe_ref dff_6(out[6], d[6], clk, wr_en, clr);
    dffe_ref dff_7(out[7], d[7], clk, wr_en, clr);
    dffe_ref dff_8(out[8], d[8], clk, wr_en, clr);
    dffe_ref dff_9(out[9], d[9], clk, wr_en, clr);
    dffe_ref dff_10(out[10], d[10], clk, wr_en, clr);
    dffe_ref dff_11(out[11], d[11], clk, wr_en, clr);
    dffe_ref dff_12(out[12], d[12], clk, wr_en, clr);
    dffe_ref dff_13(out[13], d[13], clk, wr_en, clr);
    dffe_ref dff_14(out[14], d[14], clk, wr_en, clr);
    dffe_ref dff_15(out[15], d[15], clk, wr_en, clr);
    dffe_ref dff_16(out[16], d[16], clk, wr_en, clr);
    dffe_ref dff_17(out[17], d[17], clk, wr_en, clr);
    dffe_ref dff_18(out[18], d[18], clk, wr_en, clr);
    dffe_ref dff_19(out[19], d[19], clk, wr_en, clr);
    dffe_ref dff_20(out[20], d[20], clk, wr_en, clr);
    dffe_ref dff_21(out[21], d[21], clk, wr_en, clr);
    dffe_ref dff_22(out[22], d[22], clk, wr_en, clr);
    dffe_ref dff_23(out[23], d[23], clk, wr_en, clr);
    dffe_ref dff_24(out[24], d[24], clk, wr_en, clr);
    dffe_ref dff_25(out[25], d[25], clk, wr_en, clr);
    dffe_ref dff_26(out[26], d[26], clk, wr_en, clr);
    dffe_ref dff_27(out[27], d[27], clk, wr_en, clr);
    dffe_ref dff_28(out[28], d[28], clk, wr_en, clr);
    dffe_ref dff_29(out[29], d[29], clk, wr_en, clr);
    dffe_ref dff_30(out[30], d[30], clk, wr_en, clr);
    dffe_ref dff_31(out[31], d[31], clk, wr_en, clr);
    dffe_ref dff_32(out[32], d[32], clk, wr_en, clr);
    dffe_ref dff_33(out[33], d[33], clk, wr_en, clr);
    dffe_ref dff_34(out[34], d[34], clk, wr_en, clr);
    dffe_ref dff_35(out[35], d[35], clk, wr_en, clr);
    dffe_ref dff_36(out[36], d[36], clk, wr_en, clr);
    dffe_ref dff_37(out[37], d[37], clk, wr_en, clr);
    dffe_ref dff_38(out[38], d[38], clk, wr_en, clr);
    dffe_ref dff_39(out[39], d[39], clk, wr_en, clr);
    dffe_ref dff_40(out[40], d[40], clk, wr_en, clr);
    dffe_ref dff_41(out[41], d[41], clk, wr_en, clr);
    dffe_ref dff_42(out[42], d[42], clk, wr_en, clr);
    dffe_ref dff_43(out[43], d[43], clk, wr_en, clr);
    dffe_ref dff_44(out[44], d[44], clk, wr_en, clr);
    dffe_ref dff_45(out[45], d[45], clk, wr_en, clr);
    dffe_ref dff_46(out[46], d[46], clk, wr_en, clr);
    dffe_ref dff_47(out[47], d[47], clk, wr_en, clr);
    dffe_ref dff_48(out[48], d[48], clk, wr_en, clr);
    dffe_ref dff_49(out[49], d[49], clk, wr_en, clr);
    dffe_ref dff_50(out[50], d[50], clk, wr_en, clr);
    dffe_ref dff_51(out[51], d[51], clk, wr_en, clr);
    dffe_ref dff_52(out[52], d[52], clk, wr_en, clr);
    dffe_ref dff_53(out[53], d[53], clk, wr_en, clr);
    dffe_ref dff_54(out[54], d[54], clk, wr_en, clr);
    dffe_ref dff_55(out[55], d[55], clk, wr_en, clr);
    dffe_ref dff_56(out[56], d[56], clk, wr_en, clr);
    dffe_ref dff_57(out[57], d[57], clk, wr_en, clr);
    dffe_ref dff_58(out[58], d[58], clk, wr_en, clr);
    dffe_ref dff_59(out[59], d[59], clk, wr_en, clr);
    dffe_ref dff_60(out[60], d[60], clk, wr_en, clr);
    dffe_ref dff_61(out[61], d[61], clk, wr_en, clr);
    dffe_ref dff_62(out[62], d[62], clk, wr_en, clr);
    dffe_ref dff_63(out[63], d[63], clk, wr_en, clr);
    dffe_ref dff_64(out[64], d[64], clk, wr_en, clr);
    dffe_ref dff_65(out[65], d[65], clk, wr_en, clr);
    
endmodule