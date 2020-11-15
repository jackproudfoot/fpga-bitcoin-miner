module saturating_counter(saturated, signal, clock);
    output reg saturated;

    input signal, clock;

    reg [2:0] prev_signals;

    always @(posedge clock) begin
        prev_signals[2] <= prev_signals[1];
        prev_signals[1] <= prev_signals[0];
        prev_signals[0] <= signal;

        saturated <= prev_signals[2] & prev_signals[1] & prev_signals[0] & signal;
    end

endmodule