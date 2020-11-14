/*
 * 32 bit bit carry select adder
 */
module adder(A, B, Cin, S, Cout);

    input [31:0] A, B;
    input Cin;

    output [31:0] S;
    output Cout;
    
    wire [31:0] p, g;
    and gen [31:0] (g, A, B);
    or prop [31:0] (p, A, B);

    // Speculate cin bits
    assign spec_low = 0;
    assign spec_high = 1;

    // First carry look ahead block
    wire P0, G0, P1, G1, P2, G2, P3, G3;
    carry_look_ahead_block block0(A[7:0], B[7:0], Cin, p[7:0], g[7:0], S[7:0], P0, G0);

    // Second carry look ahead block
    wire P1_low, P1_high, G0_low, G0_high;
    wire [7:0] S1_low, S1_high;
    
    carry_look_ahead_block block1_low(A[15:8], B[15:8], spec_low, p[15:8], g[15:8], S1_low, P1_low, G1_low);
    carry_look_ahead_block block1_high(A[15:8], B[15:8], spec_high, p[15:8], g[15:8], S1_high, P1_high, G1_high);
    

    // Third carry look ahead block
    wire P2_low, P2_high, G2_low, G2_high;
    wire [7:0] S2_low, S2_high;

    carry_look_ahead_block block2_low(A[23:16], B[23:16], spec_low, p[23:16], g[23:16], S2_low, P2_low, G2_low);
    carry_look_ahead_block block2_high(A[23:16], B[23:16], spec_high, p[23:16], g[23:16], S2_high, P2_high, G2_high);
    

    // Fourth carry look ahead block
    wire P3_low, P3_high, G3_low, G3_high;
    wire [7:0] S3_low, S3_high;

    carry_look_ahead_block block3_low(A[31:24], B[31:24], spec_low, p[31:24], g[31:24], S3_low, P3_low, G3_low);
    carry_look_ahead_block block3_high(A[31:24], B[31:24], spec_high, p[31:24], g[31:24], S3_high, P3_high, G3_high);
    
    /*
    * Compute carries for carry look ahead blocks
    */

    // Compute c8
    wire c8, c8w0;

    and     c8_a0(c8w0, P0, Cin);
    or      c8_o0(c8, G0, c8w0);

    // Compute c16
    wire c16, c16w0, c16w1;

    and     c16_a0(c16w0, P1, P0, Cin);
    and     c16_a1(c16w1, P1, G0);
    or      c16_o0(c16, G1, c16w0, c16w1);

    // Compute c24
    wire c24, c24w0, c24w1, c24w2;

    and     c24_a0(c24w0, P2, P1, P0, Cin);
    and     c24_a1(c24w1, P2, P1, G0);
    and     c24_a2(c24w2, P2, G1);
    or      c24_o0(c24, G2, c24w0, c24w1, c24w2);

    // Compute c32
    wire c32w0, c32w1, c32w2, c32w3;

    and     c32_a0(c32w0, P3, P2, P1, P0, Cin);
    and     c32_a1(c32w1, P3, P2, P1, G0);
    and     c32_a2(c32w2, P3, P2, G1);
    and     c32_a3(c32w3, P3, G2);
    or      c32_o0(Cout, G3, c32w0, c32w1, c32w2, c32w3);


    /*
    * Multiplexers
    */

    assign S[15:8] = c8 ? S1_high : S1_low;
    assign P1 = c8 ? P1_high : P1_low;
    assign G1 = c8 ? G1_high : G1_low;

    assign S[23:16] = c16 ? S2_high : S2_low;
    assign P2 = c16 ? P2_high : P2_low;
    assign G2 = c16 ? G2_high : G2_low;


    assign S[31:24] = c24 ? S3_high : S3_low;
    assign P3 = c24 ? P3_high : P3_low;
    assign G3 = c24 ? G3_high : G3_low;


endmodule

/*
 *  Eight bit carry look ahead adder block
 */
module carry_look_ahead_block(A, B, Cin, p, g, S, P, G);
    
    input [7:0] A, B, p, g;
    input Cin;

    output [7:0] S;
    output P, G;

    wire [7:0] c;
    assign c[0] = Cin;

    /*
     * Half adder cells
     */
    xor adder_cell [7:0] (S, A, B, c);

    /*
     * Carry bit(s) logic
     */
    //c1
    wire    c1w0;
    and     c1_a(c1w0, p[0], Cin);
    or      c1_o(c[1], g[0], c1w0);
    
    //c2
    wire    c2w0, c2w1;
    and     c2_a0(c2w0, p[1], p[0], Cin);
    and     c2_a1(c2w1, p[1], g[0]);
    or      c2_o(c[2], g[1], c2w0, c2w1);

    //c3
    wire    c3w0, c3w1, c3w2;
    and     c3_a0(c3w0, p[2], p[1], p[0], Cin);
    and     c3_a1(c3w1, p[2], p[1], g[0]);
    and     c3_a2(c3w2, p[2], g[1]);
    or      c3_o(c[3], g[2], c3w0, c3w1, c3w2);

    //c4
    wire    c4w0, c4w1, c4w2, c4w3;
    and     c4_a0(c4w0, p[3], p[2], p[1], p[0], Cin);
    and     c4_a1(c4w1, p[3], p[2], p[1], g[0]);
    and     c4_a2(c4w2, p[3], p[2], g[1]);
    and     c4_a3(c4w3, p[3], g[2]);
    or      c4_o(c[4], g[3], c4w0, c4w1, c4w2, c4w3);

    //c5
    wire    c5w0, c5w1, c5w2, c5w3, c5w4;
    and     c5_a0(c5w0, p[4], p[3], p[2], p[1], p[0], Cin);
    and     c5_a1(c5w1, p[4], p[3], p[2], p[1], g[0]);
    and     c5_a2(c5w2, p[4], p[3], p[2], g[1]);
    and     c5_a3(c5w3, p[4], p[3], g[2]);
    and     c5_a4(c5w4, p[4], g[3]);
    or      c5_o(c[5], g[4], c5w0, c5w1, c5w2, c5w3, c5w4);

    //c6
    wire    c6w0, c6w1, c6w2, c6w3, c6w4, c6w5;
    and     c6_a0(c6w0, p[5], p[4], p[3], p[2], p[1], p[0], Cin);
    and     c6_a1(c6w1, p[5], p[4], p[3], p[2], p[1], g[0]);
    and     c6_a2(c6w2, p[5], p[4], p[3], p[2], g[1]);
    and     c6_a3(c6w3, p[5], p[4], p[3], g[2]);
    and     c6_a4(c6w4, p[5], p[4], g[3]);
    and     c6_a5(c6w5, p[5], g[4]);
    or      c6_o(c[6], g[5], c6w0, c6w1, c6w2, c6w3, c6w4, c6w5);

    //c7
    wire    c7w0, c7w1, c7w2, c7w3, c7w4, c7w5, c7w6;
    and     c7_a0(c7w0, p[6], p[5], p[4], p[3], p[2], p[1], p[0], Cin);
    and     c7_a1(c7w1, p[6], p[5], p[4], p[3], p[2], p[1], g[0]);
    and     c7_a2(c7w2, p[6], p[5], p[4], p[3], p[2], g[1]);
    and     c7_a3(c7w3, p[6], p[5], p[4], p[3], g[2]);
    and     c7_a4(c7w4, p[6], p[5], p[4], g[3]);
    and     c7_a5(c7w5, p[6], p[5], g[4]);
    and     c7_a6(c7w6, p[6], g[5]);
    or      c7_o(c[7], g[6], c7w0, c7w1, c7w2, c7w3, c7w4, c7w5, c7w6);

    //c8 -- only used for the generate out
    wire    c8w1, c8w2, c8w3, c8w4, c8w5, c8w6, c8w7;
    and     c8_a1(c8w1, p[7], p[6], p[5], p[4], p[3], p[2], p[1], g[0]);
    and     c8_a2(c8w2, p[7], p[6], p[5], p[4], p[3], p[2], g[1]);
    and     c8_a3(c8w3, p[7], p[6], p[5], p[4], p[3], g[2]);
    and     c8_a4(c8w4, p[7], p[6], p[5], p[4], g[3]);
    and     c8_a5(c8w5, p[7], p[6], p[5], g[4]);
    and     c8_a6(c8w6, p[7], p[6], g[5]);
    and     c8_a7(c8w7, p[7], g[6]);

    /*
     * Generate & Propagate output
     */
    and prop(P, p[7], p[6], p[5], p[4], p[3], p[2], p[1], p[0]);
    or  gen(G, g[7], c8w1, c8w2, c8w3, c8w4, c8w5, c8w6, c8w7);

endmodule