`timescale 1ns/10ps
 
module uart_echo(fpga_clock, reset, txd, rxd);

    input fpga_clock, reset, rxd;
    output txd;

    reg clock;

    // create 10Mhz clock from 100 MHz
    integer clock_cnt;
    always @(posedge fpga_clock) begin
        if (clock_cnt == 9) begin
            clock <= ~clock;
            clock_cnt <= 0;
        end
        else begin
            clock_cnt <= clock_cnt + 1;
        end
    end

    // Want to interface to 115200 baud UART
    // 10000000 / 115200 = 87 Clocks Per Bit.
    parameter c_CLOCK_PERIOD_NS = 100;
    parameter c_CLKS_PER_BIT    = 87;
    parameter c_BIT_PERIOD      = 8600;

    wire frmero, rxce, txmty, bsy;

    reg txce;

    reg [7:0] tx;
    wire [7:0] rx;

    tiny_uart uart_core(reset, clock, txd, rxd, frmero, rx, rxce, tx, txmty, txce, bsy);


    integer cooldown = 0;
    integer count = 0;

    always @(posedge clock) begin
        if (cooldown == 1000) begin
            cooldown <= 0;
            count <= count + 1;

            txce <= 1'b1;
            tx <= 8'ha7;
        end else begin
            cooldown <= cooldown + 1;
            txce <= 1'b0;
        end
    end
   
endmodule