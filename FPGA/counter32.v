module counter32(q, clock, reset);
    input clock, reset;

    output[5:0] q;

    wire w0, w1, w2, w3, w4;

    t_flip_flop t0(q[0], 1'b1, clock, reset);
    and w01(w0, 1'b1, q[0]);

    t_flip_flop t1(q[1], w0, clock, reset);
    and w11(w1, w0, q[1]);

    t_flip_flop t2(q[2], w1, clock, reset);
    and w21(w2, w1, q[2]);

    t_flip_flop t3(q[3], w2, clock, reset);
    and w31(w3, w2, q[3]);

    t_flip_flop t4(q[4], w3, clock, reset);
    and w41(w4, w3, q[4]);
    
    t_flip_flop t5(q[5], w4, clock, reset);


endmodule