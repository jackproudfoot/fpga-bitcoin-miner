`timescale 1ns/10ps
 
module uart_echo(fpga_clock, reset, txd, rxd, datasent, transmit);

    input fpga_clock, reset, rxd;
    output txd, transmit;

    output reg datasent;

    reg clock = 0;
    // create 50Mhz clock from 100 MHz
    always @(posedge fpga_clock) begin
        clock <= ~clock;
    end

    reg led_clock = 0;
    integer led_counter = 0;
    always @(posedge fpga_clock) begin
        if (led_counter == 49999999) begin
            led_counter = 0;
            led_clock = !led_clock;
        end else begin
            led_counter = led_counter + 1;
        end
    end

    always @(posedge led_clock or negedge led_clock) begin
        datasent <= led_clock;
    end

    wire frmero, rxce, bsy;

    reg txce;

    reg [7:0] tx;
    wire [7:0] rx;

    // tiny_uart uart_core(reset, clock, txd, rxd, frmero, rx, rxce, tx, txmty, txce, bsy);
    uart uart_core(clock, reset, rxd, txd, txce, tx, rxce, rx, bsy, transmit, frmero);


    integer cooldown = 0;
    integer sent = 0;

    initial begin
            tx <= 8'ha7;
    end

    always @(posedge led_clock) begin
        if (cooldown == 4) begin
            cooldown <= 0;
            sent <= 0;
        end else begin
            cooldown <= cooldown + 1;
        end
    end

    always @(posedge clock) begin
        if (sent == 0) begin
            sent <= 1;
            txce <= 1'b1;
        end else begin
            txce <= 1'b0;
        end

    end
   
endmodule