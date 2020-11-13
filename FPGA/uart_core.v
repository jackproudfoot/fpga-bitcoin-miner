`timescale 1ns/10ps
 
module uart_core(fpga_clock, reset, txd, rxd, ca, an, display_toggle);

    // input [31:0] nonce;
    // input nonce_we;

    input display_toggle;

    input fpga_clock, reset, rxd;
    output txd;

    output [7:0] ca, an;

    reg clock = 0;
    // create 50Mhz clock from 100 MHz
    always @(posedge fpga_clock) begin
        clock <= ~clock;
    end

    wire rxce, is_transmitting, is_receiving, error;

    reg txce;

    reg [7:0] tx;
    wire [7:0] rx;

    initial begin
        tx <= 8'b0;
    end

    uart serial_module(clock, reset, rxd, txd, txce, tx, rxce, rx, is_receiving, is_transmitting, error);

   
    wire [639:0] header_data;

    localparam HEADER_REG_INPUT_WIDTH = 8;
    localparam HEADER_REG_DATA_WIDTH = 640;
    shift_reg #(
        .INPUT_WIDTH(HEADER_REG_INPUT_WIDTH),
        .DATA_WIDTH(HEADER_REG_DATA_WIDTH)
    ) header_reg (header_data, rx, clock, rxce, 1'b0, reset);


    wire [31:0] nonce_data;
    reg shift_nonce = 0;

    localparam NONCE_REG_INPUT_WIDTH = 8;
    localparam NONCE_REG_DATA_WIDTH = 32;
    shift_reg #(
        .INPUT_WIDTH(NONCE_REG_INPUT_WIDTH),
        .DATA_WIDTH(NONCE_REG_DATA_WIDTH)
    ) nonce_reg (nonce_data, rx, clock, rxce, shift_nonce, reset);
    //) datareg (nonce_data, nonce_input, clock, nonce_we, shift_nonce, reset);



    integer sent = 0;
    always @(posedge clock) begin
        if (sent == 99999999) begin
            sent = 0;
            tx <= header_data[639:608];
            txce <= 1'b1;
        end else begin
            txce <= 1'b0;
            sent = sent + 1;
        end
    end
    


    wire [31:0] display_data;
    assign display_data = display_toggle ? header_data[639:608] : nonce_data[31:0];

    seven_segment display(ca, an, display_data, fpga_clock);

endmodule