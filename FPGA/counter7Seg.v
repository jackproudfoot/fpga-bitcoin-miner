module counter7Seg #(parameter SIZE=2) (q, clock, reset);
    input clock, reset;

    output[SIZE-1:0] q;
    reg [SIZE-1:0] q;

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