module seven_segment(ca, an, data, clock);

    output [7:0] ca, an;

    input [31:0] data;
    input clock;

    reg display_clock = 0;

    // Clock Divider    100 Mhz -> 500 Hz
    integer clock_divider_counter = 0;
    always @(posedge clock) begin
        if (clock_divider_counter == 99999) begin
            clock_divider_counter = 0;
            display_clock = !display_clock;
        end
        else begin
            clock_divider_counter = clock_divider_counter + 1;
        end
    end

    wire [2:0] digit_index;

    localparam COUNTER_SIZE = 3;
    counter #( .SIZE(COUNTER_SIZE)) digit_counter (digit_index, display_clock, 1'b0);

    reg [3:0] nibble = 4'b0;


    always @(posedge display_clock) begin
        case (digit_index)
            3'b000  : nibble <= data[3:0];
            3'b001  : nibble <= data[7:4];
            3'b010  : nibble <= data[11:8];
            3'b011  : nibble <= data[15:12];
            3'b100  : nibble <= data[19:16];
            3'b101  : nibble <= data[23:20];
            3'b110  : nibble <= data[27:24];
            3'b111  : nibble <= data[31:28];
            default : nibble <= 4'b0;
        endcase
    end

    converter char_converter(ca, nibble);
    
    wire [7:0] an;

    assign an[0] = digit_index[2] | digit_index[1] | digit_index[0];
    assign an[1] = digit_index[2] | digit_index[1] | ~digit_index[0];
    assign an[2] = digit_index[2] | ~digit_index[1] | digit_index[0];
    assign an[3] = digit_index[2] | ~digit_index[1] | ~digit_index[0];
    assign an[4] = ~digit_index[2] | digit_index[1] | digit_index[0];
    assign an[5] = ~digit_index[2] | digit_index[1] | ~digit_index[0];
    assign an[6] = ~digit_index[2] | ~digit_index[1] | digit_index[0];
    assign an[7] = ~digit_index[2] | ~digit_index[1] | ~digit_index[0];


endmodule

module converter(char_code, nibble);
    input [3:0] nibble;

    output reg [7:0] char_code;

    // Character Assignment
    always @(*) begin
        case (nibble)
            4'h1    : char_code <= 8'b11111001;
            4'h2    : char_code <= 8'b10100100;
            4'h3    : char_code <= 8'b10110000;
            4'h4    : char_code <= 8'b10011001;
            4'h5    : char_code <= 8'b10010010;
            4'h6    : char_code <= 8'b10000010;
            4'h7    : char_code <= 8'b11111000;
            4'h8    : char_code <= 8'b10000000;
            4'h9    : char_code <= 8'b10010000;
            default : char_code <= 8'b11111111;
        endcase
    end

endmodule