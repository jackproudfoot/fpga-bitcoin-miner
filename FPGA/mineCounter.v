module mineCounter(q, clock, reset);
    input clock, reset;

    output reg [1:0] q = 0;

    // initial begin
    //     q <= 2'b0;
    // end

    always @(posedge clock or posedge reset) begin
        if(~reset) begin
            q <= q+1;
        end else begin
            q <= 0;
        end
    end

    // always @(posedge clock) begin
    //     q[0] <= (~q[1] & ~q[0] & clock) | (~q[1] & q[0] & ~clock & ~reset);
    //     q[1] <= (~q[1] & ~q[0] & reset) | (~q[1] & q[0] & clock);
    // end
endmodule