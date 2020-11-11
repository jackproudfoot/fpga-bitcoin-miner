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

    always @(posedge led_clock) begin
        datasent <= ~datasent;
    end

    wire frmero, rxce, sending, bsy;

    reg txce;

    reg [7:0] tx;
    wire [7:0] rx;

    uart uart_core(clock, reset, rxd, txd, txce, tx, rxce, rx, bsy, transmit, frmero);

    wire [15:0] regdata;
    wire shift;
    assign shift = 1'b0;

    shift_reg datareg(regdata, rx, clock, rxce, shift, reset);


    initial begin
        tx <= regdata[15:8];
    end

    integer sent = 0;
    always @(posedge clock) begin
        if (sent == 99999999) begin
            sent = 0;
            txce <= 1'b1;
        end else begin
            txce <= 1'b0;
            sent = sent + 1;
        end
    end
   
endmodule

module shift_reg(q, d, clock, enable, shift, reset);

    input clock, enable, shift, reset;
    input [7:0] d;
    output reg [15:0] q;

    initial begin
        q <= 16'b0;
    end

    always @(posedge clock) begin
        if (reset) begin
            q <= 16'b0;
        end else begin
            if (enable) begin
                q <= { q[7:0], d };
            end else if (shift) begin
                q <= { q[7:0], 8'b0};
            end
        end
    end


endmodule