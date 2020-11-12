module shift_reg #(parameter OUTPUT_WIDTH=8, INPUT_WIDTH=8, DATA_WIDTH=16) (q, d, clock, enable, shift, reset);

    input clock, enable, shift, reset;
    input [INPUT_WIDTH-1:0] d;
    output reg [OUTPUT_WIDTH-1:0] q;

    reg [DATA_WIDTH-1:0] data;

    initial begin
        data <= {DATA_WIDTH{1'b0}};
        q <= {OUTPUT_WIDTH{1'b0}};
    end

    always @(posedge clock) begin
        if (reset) begin
            data <= {DATA_WIDTH{1'b0}};
        end else begin
            if (enable) begin
                data <= { data[DATA_WIDTH-INPUT_WIDTH:0], d };

                q <= data[DATA_WIDTH-INPUT_WIDTH:DATA_WIDTH-INPUT_WIDTH-OUTPUT_WIDTH];
            end else if (shift) begin
                data <= { data[DATA_WIDTH-OUTPUT_WIDTH:0], {OUTPUT_WIDTH{1'b0}}};

                q <= data[DATA_WIDTH-OUTPUT_WIDTH:DATA_WIDTH-OUTPUT_WIDTH-OUTPUT_WIDTH];
            end else begin
                q <= data[DATA_WIDTH-1:DATA_WIDTH-OUTPUT_WIDTH];
            end
        end

        
    end


endmodule