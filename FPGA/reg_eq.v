module reg_eq(out, A, B);
    input [4:0] A, B;
    output out;

    wire c0, c1, c2, c3, c4;

    bit_eq comp0(c0, A[0], B[0]);
    bit_eq comp1(c1, A[1], B[1]);
    bit_eq comp2(c2, A[2], B[2]);
    bit_eq comp3(c3, A[3], B[3]);
    bit_eq comp4(c4, A[4], B[4]);

    assign out = c0 & c1 & c2 & c3 & c4;
endmodule

module bit_eq(out, A, B);

    input A, B;
    output out;

    wire c0, c1;

    assign c0 = ~A & B;
    assign c1 = A & ~B;
    assign out = ~(A + B);

endmodule