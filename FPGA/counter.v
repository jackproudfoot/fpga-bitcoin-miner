module counter(q, clock, reset);
    input clock, reset;

    output[1:0] q;

    wire w0;

    t_flip_flop t0(q[0], 1'b1, clock, reset);
    and w01(w0, 1'b1, q[0]);

    t_flip_flop t1(q[1], w0, clock, reset);
    

endmodule