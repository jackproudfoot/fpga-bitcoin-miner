`timescale 1ns / 1ps

module uart_wrapper(fpga_clock, reset, rxd, txd, ca, an, display_toggle);
    input fpga_clock, reset;
    input [3:0] display_toggle;

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

    wire [31:0] byteCount;

    uart_core serial_core(clock, reset, rxd, txd, nonce_input, transmit_data, header_data, rxce, byteCount);


    wire [255:0] satisfactoryHash;
    wire hashSuccess;

    minerControl miner(header_data, satisfactoryHash, clock, header_data[31:0], hashSuccess, reset);


    wire [31:0] display_data;
    assign display_data = display_toggle[0] ? header_data[31:0] : display_toggle[1] ? header_data[639:608] : nonce_input;

    seven_segment display(ca, an, display_data, fpga_clock);


endmodule