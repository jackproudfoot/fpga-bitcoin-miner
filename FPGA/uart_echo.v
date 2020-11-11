`timescale 1ns/10ps
 
module uart_echo(fpga_clock, reset, txd, rxd);

    input fpga_clock, reset, rxd;
    output txd;

    reg clock = 0;

    // create 50Mhz clock from 100 MHz
    always @(posedge fpga_clock) begin
        clock <= ~clock;
    end

    wire frmero, rxce, txmty, bsy;

    reg txce;

    reg [7:0] tx;
    wire [7:0] rx;

    // tiny_uart uart_core(reset, clock, txd, rxd, frmero, rx, rxce, tx, txmty, txce, bsy);
    uart uart_core(clock, reset, rxd, txd, txce, tx, rxce, rx, bsy, txmty, frmero);


    integer cooldown = 0;
    integer count = 0;

    initial begin
            tx <= 8'ha7;
    end

    always @(posedge clock) begin
        if (cooldown == 1000) begin
            cooldown <= 0;
            count <= count + 1;

            txce <= 1'b1;
        end else begin
            cooldown <= cooldown + 1;
            txce <= 1'b0;
        end
    end
   
endmodule