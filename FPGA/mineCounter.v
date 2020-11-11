module mineCounter(q, clock, reset);
    input clock, reset;

    output[1:0] q;
    reg [1:0] q;
    
    initial begin
        q <= 0;
    end

    always @(posedge clock) begin
        if(~reset) begin
            q <= q + 1;
        end else begin
            q <= 0;
        end
    end
   
endmodule