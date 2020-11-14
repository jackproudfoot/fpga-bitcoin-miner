`timescale 1ns/10ps
 
module uart_core(fpga_clock, reset, txd, rxd, ca, an, nonce_we, transmit_data, display_toggle, error);

    //input [31:0] nonce_input;
    input nonce_we, transmit_data;

    input display_toggle;

    input fpga_clock, reset, rxd;
    output txd, error;

    output [7:0] ca, an;

    reg clock = 0;
    // create 50Mhz clock from 100 MHz
    always @(posedge fpga_clock) begin
        clock <= ~clock;
    end

    wire rxce, is_transmitting, is_receiving;

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
    ) header_reg (header_data, rx, rxce, rxce, 1'b0, reset);



    wire [31:0] nonce_data;
    reg shift_nonce = 0;

    wire [31:0] nonce_input;
    assign nonce_input = 32'h12345678;

    localparam NONCE_REG_INPUT_WIDTH = 32;
    localparam NONCE_REG_DATA_WIDTH = 32;
    shift_reg #(
        .INPUT_WIDTH(NONCE_REG_INPUT_WIDTH),
        .DATA_WIDTH(NONCE_REG_DATA_WIDTH)
    ) nonce_reg (nonce_data, nonce_input, ~clock, nonce_we, shift_nonce, reset);


    reg done_transmitting = 0;

    wire transmit;

    localparam TRANSMIT_REG_DATA_WIDTH = 1;
    register #(
        .DATA_WIDTH(TRANSMIT_REG_DATA_WIDTH)
    ) transmit_status_reg (transmit, transmit_data, clock, transmit_data, (reset | done_transmitting));

    integer bytesToSend = 4;

    integer debounce = 0;

    always @(posedge clock) begin
        if (debounce == 99999999) begin
            if (transmit && ~is_receiving) begin
                if (bytesToSend > 0) begin
                    if (~is_transmitting) begin
                        tx <= nonce_data[31:24];
                        txce <= 1'b1;

                        shift_nonce <= 1'b1;

                        bytesToSend = bytesToSend - 1;
                    end else begin
                        txce <= 1'b0;

                        shift_nonce <= 1'b0;
                    end
                end
                else if (bytesToSend == 0) begin
                    done_transmitting <= 1'b1;
                    txce <= 1'b0;

                    bytesToSend = 4;

                    shift_nonce <= 1'b0;
                end
            end else begin
                txce <= 1'b0;
                done_transmitting <= 1'b0;
                debounce = 0;
                shift_nonce <= 1'b0;
            end
            
        end else if (debounce < 99999999) begin
            debounce = debounce + 1;
        end
    end

    


    wire [31:0] display_data;
    assign display_data = display_toggle ? header_data[639:608] : nonce_data[31:0];

    seven_segment display(ca, an, display_data, fpga_clock);

endmodule

module register #(parameter DATA_WIDTH=32) (q, d, clock, en, reset);

    output reg [DATA_WIDTH-1:0] q;

    input [DATA_WIDTH-1:0] d;
    input clock, en, reset;

    initial begin
        q <= { DATA_WIDTH{1'b0}};
    end

    always @(posedge clock) begin
        if (reset) begin
            q <= { DATA_WIDTH{1'b0}};
        end else begin
            if (en) begin
                q <= d;
            end
        end
    end

endmodule