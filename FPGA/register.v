module register(outA, outB, d, clk, clr, wr_en, reA_en, reB_en);
    input [31:0] d;
    input clk, clr, wr_en, reA_en, reB_en;

    output [31:0] outA, outB;

    wire [31:0] out;
    
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
    
    assign outA = reA_en ? out : 32'bz;
    assign outB = reB_en ? out : 32'bz;

endmodule