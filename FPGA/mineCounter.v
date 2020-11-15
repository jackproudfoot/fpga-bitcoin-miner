module mineCounter #(parameter SIZE= 2) (q, clock, reset);
    input clock, reset;

    output reg [SIZE-1:0] q = 0;

    always @(posedge clock or posedge reset) begin
        if(~reset) begin
            q <= q+1;
        end else begin
            q <= 0;
        end
    end
endmodule