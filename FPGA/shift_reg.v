module shift_reg #(parameter INPUT_WIDTH=8, DATA_WIDTH=16) (q, d, clock, enable, shift, reset);

    input clock, enable, shift, reset;
    input [INPUT_WIDTH-1:0] d;
    
    output reg [DATA_WIDTH-1:0] q;

    initial begin
        q <= {DATA_WIDTH{1'b0}};
    end

    always @(posedge clock) begin
        if (reset) begin
            q <= {DATA_WIDTH{1'b0}};
        end else begin
            if (enable) begin
                q <= { q[DATA_WIDTH-INPUT_WIDTH:0], d };
            end else if (shift) begin
                q <= { q[DATA_WIDTH-8:0], 8'b0};
            end
        end
    end


endmodule