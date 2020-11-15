module saturating_counter(saturated, prev_signals, signal, clock);
    output reg saturated;
    output reg [2:0] prev_signals = 3'b0;

    input signal, clock;

    

    always @(posedge clock) begin
        prev_signals[2] <= prev_signals[1];
        prev_signals[1] <= prev_signals[0];
        prev_signals[0] <= signal;

        saturated <= prev_signals[2] & prev_signals[1] & prev_signals[0] & signal;
    end

endmodule