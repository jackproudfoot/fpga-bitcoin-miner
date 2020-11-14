module mult(multiplicand, multiplier, ctrl_MULT, clock, result, overflow, resultRDY);

    input [31:0] multiplicand, multiplier;
    input ctrl_MULT, clock;

    output [31:0] result;
    output overflow, resultRDY;
    
    wire ctrl_write_reg, ctrl_shift, ctrl_sign, ctrl_incl;

    // Setup prod register
    wire [64:0] prod, reg_in;
    mult_register prod_reg(prod, reg_in, clock, ctrl_write_reg, ctrl_MULT);
    assign ctrl_write_reg = ~resultRDY;


    // Assign the multiplier pattern
    wire [2:0] pattern, init_pattern, prod_pattern;
    assign init_pattern[2:1] = multiplier[1:0];
    assign init_pattern[0] = 1'b0;
    assign prod_pattern[2:0] = prod[2:0];
    assign pattern = ctrl_firstOp ? init_pattern : prod_pattern;

    // Create mult control module
    mult_control mult_ctrl(pattern, ctrl_shift, ctrl_sign, ctrl_incl);


    // Assign the partial product
    wire [31:0] partial_prod, prev_partial_prod, multiplicand_sel, neg_multiplicand_sel;
    assign prev_partial_prod = ctrl_firstOp ? 32'b0 : prod[64:33];
    assign multiplicand_sel = ctrl_shift ? multiplicand << 1 : multiplicand;
    not multiplicand_inverter [31:0] (neg_multiplicand_sel, multiplicand_sel);


    wire [31:0] adder_multiplicand;
    wire adder_cout;
    assign adder_multiplicand = ctrl_sign ? neg_multiplicand_sel : multiplicand_sel;
    adder mult_adder(prev_partial_prod, adder_multiplicand, ctrl_sign, partial_prod, adder_cout);

    // Write to register
    assign reg_in[64] = ctrl_incl ? partial_prod[31] : prod[64];
    assign reg_in[63] = ctrl_incl ? partial_prod[31] : prod[64];
    assign reg_in[62:31] = ctrl_incl ? partial_prod[31:0] : prod[64:33];
    assign reg_in[30:0] = ctrl_firstOp ? multiplier[31:1] : prod[32:2];

    wire [31:0] reg_in_upper, reg_in_lower;
    wire reg_in_booth;
    assign reg_in_upper = reg_in[64:32];
    assign reg_in_lower = reg_in[32:1];
    assign reg_in_booth = reg_in[0];

    // Counter
    wire [5:0] count_val;
    counter count(ctrl_MULT, clock, count_val);
    
    wire ctrl_firstOp_temp, ctrl_firstOp;
    assign ctrl_firstOp_temp = count_val[4] | count_val[3] | count_val[2] | count_val[1] | count_val[0];
    not ctrl_firstOp_inverter(ctrl_firstOp, ctrl_firstOp_temp);

    // Result
    assign result = prod[32:1];
    assign resultRDY = count_val[4] & (~count_val[3]) & (~count_val[2]) & (~count_val[1]) & (~count_val[0]);
    
    // Determine overflow
    wire [31:0] upper;
    wire o1, o2, o3, o4, o5, o6, o7, o8;
    
    assign o1 =~| prod[64:32];
    assign o2 =& prod[64:32];

    or ovf(o3, o1, o2);

    assign o4 =~& prod[31:1];
    assign o5 =& prod[63:32];
    and spec_case(o6, o4, o5, prod[64], prod[0]);
    assign o7 =~ o3;
    or last_ovf_check(overflow, o7, o6);

endmodule

module mult_control(pattern, ctrl_shift, ctrl_sign, ctrl_incl);

    input [2:0] pattern;

    output ctrl_shift, ctrl_sign, ctrl_incl;


    wire [2:0] pattern_inv;
    not pat_inv2(pattern_inv[2], pattern[2]);
    not pat_inv1(pattern_inv[1], pattern[1]);
    not pat_inv0(pattern_inv[0], pattern[0]);

    assign ctrl_shift = (pattern[2] & pattern_inv[1] & pattern_inv[0]) | (pattern_inv[2] & pattern[1] & pattern[0]);
        
    assign ctrl_sign = (pattern[2] & pattern_inv[1]) | (pattern[2] & pattern[1] & pattern_inv[0]);

    wire ctrl_incl_temp;
    assign ctrl_incl_temp = (pattern[2] & pattern[1] && pattern[0]) | (pattern_inv[2] & pattern_inv[1] & pattern_inv[0]);
    not ctrl_incl_inv(ctrl_incl, ctrl_incl_temp);

endmodule


module mult_register(out, d, clk, wr_en, clr);
    input [64:0] d;
    input clk, clr, wr_en;

    output [64:0] out;
    
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
    
endmodule