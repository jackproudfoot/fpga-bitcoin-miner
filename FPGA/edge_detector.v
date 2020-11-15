module edge_detector #(parameter EDGE = 0) (clock, signal, change);
    input clock, signal;

    output reg change = 0;

    reg prev_signal = 0;

    always @(posedge clock) begin
        if ((prev_signal != signal) && (prev_signal == EDGE)) begin
            change <= 1'b1;
        end else begin
            change <= 1'b0;
        end
        
        prev_signal <= signal;
    end
endmodule