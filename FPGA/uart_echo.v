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

    wire [7:0] regdata;
    wire shift;
    assign shift = 1'b0;

    shift_reg datareg(regdata, rx, clock, rxce, shift, reset);


    initial begin
        tx <= 8'b0;
    end

    integer sent = 0;
    always @(posedge clock) begin
        if (sent == 99999999) begin
            sent = 0;
            tx <= regdata;
            txce <= 1'b1;
        end else begin
            txce <= 1'b0;
            sent = sent + 1;
        end
    end
   
endmodule


// module bcd(data);

//     input [31:0] data;

//     reg [3:0] nibble;
    
//     reg [3:0] char = 4'h11;

//     always @(*) begin
//         case (nibble)

//         endcase
//     end

// endmodule