module t_flip_flop(q, t, clk, clr);

    input t, clk, clr;

    output q;

    wire tNot, q, qNot, d, w1, w2;

    not not_t(tNot, t);
    not not_q(qNot, q);

    and and_1(w1, q, tNot);
    and and_2(w2, t, qNot);
    or or_1(d, w1, w2);

    dffe_ref dff(q, d, clk, 1'b1, clr);

endmodule