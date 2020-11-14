`timescale 1ns / 1ps

module uart_wrapper(fpga_clock, reset, rxd, txd, ca, an, transmit_data, display_toggle);
    input fpga_clock, reset, transmit_data, display_toggle;

    input rxd;
    output txd;

    output [7:0] ca, an;

    
    reg clock = 0;
    // create 50Mhz clock from 100 MHz
    always @(posedge fpga_clock) begin
        clock <= ~clock;
    end


    wire [31:0] nonce_input;
    assign nonce_input = 32'h12345678;

    wire [639:0] header_data;
    wire rxce;

    uart_core serial_core(clock, reset, rxd, txd, nonce_input, transmit_data, header_data, rxce);


    wire [31:0] display_data;
    assign display_data = display_toggle ? header_data[639:608] : header_data[31:0];

    seven_segment display(ca, an, display_data, fpga_clock);


endmodule
