`timescale 1ns/10ps
 
module uart_core(fpga_clock, reset, txd, rxd, ca, an, nonce_we, transmit_data, display_toggle);

    //input [31:0] nonce_input;
    input nonce_we, transmit_data;

    input display_toggle;

    input fpga_clock, reset, rxd;
    output txd;

    output [7:0] ca, an;

    reg clock = 0;
    // create 50Mhz clock from 100 MHz
    always @(posedge fpga_clock) begin
        clock <= ~clock;
    end

    wire rxce, is_transmitting;

    reg txce;

    reg [7:0] tx;
    wire [7:0] rx;

    initial begin
        tx <= 8'b0;
    end

    reg rdy_clr = 0;

    uart uart_module(.din(tx),
	       .wr_en(txce),
	       .clk_50m(clock),
	       .tx(txd),
	       .tx_busy(is_transmitting),
	       .rx(rxd),
	       .rdy(rxce),
	       .rdy_clr(rdy_clr),
	       .dout(rx));

    always @(posedge clock) begin
        if (rxce) begin
            rdy_clr <= 1'b1;
        end
        else begin
            rdy_clr <= 1'b0;
        end
    end
   
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

    


    reg transmit_clock = 0;
    always @(posedge clock) begin
        transmit_clock = ~transmit_clock;
    end

    localparam NONCE_REG_INPUT_WIDTH = 32;
    localparam NONCE_REG_DATA_WIDTH = 32;
    shift_reg #(
        .INPUT_WIDTH(NONCE_REG_INPUT_WIDTH),
        .DATA_WIDTH(NONCE_REG_DATA_WIDTH)
    ) nonce_reg (nonce_data, nonce_input, transmit_clock, nonce_we, shift_nonce, reset);


    wire transmit;
    edge_detector transmit_edge_detector(transmit_clock, transmit_data, transmit);

    
    integer bytesToSend = 0;
    reg trans_ongoing = 0;

    initial begin
        tx <= nonce_data[31:24];
        txce <= 0;
        shift_nonce <= 0;
    end

    always @(posedge transmit_clock) begin
        if (!trans_ongoing) begin
            if (transmit) begin
                bytesToSend = 3;
                trans_ongoing <= 1'b1;

                txce <= 1'b1;
                tx <= nonce_data[31:24];
            end
            else begin
                txce <= 1'b0;
                shift_nonce <= 1'b0;
            end
        end else if (!is_transmitting) begin
            if (bytesToSend > 0) begin
                txce <= 1'b1;
                tx <= nonce_data[23:16];


                shift_nonce <= 1'b1;

                bytesToSend = bytesToSend - 1;
            end
            else if (bytesToSend == 0) begin
                txce <= 1'b0;
                shift_nonce <= 1'b0;
                trans_ongoing <= 1'b0;
            end
        end
        else begin
            txce <= 1'b0;
            shift_nonce <= 1'b0;
        end

        
    end
    



    wire [31:0] display_data;
    assign display_data = display_toggle ? header_data[639:608] : nonce_data[31:0];

    seven_segment display(ca, an, display_data, fpga_clock);

endmodule


module edge_detector #(parameter EDGE = 0) (clock, signal, change);
    input clock, signal;

    output reg change = 0;

    reg prev_signal = 0;

    always @(posedge clock) begin
        if ((prev_signal != signal) && (prev_signal == EDGE)) begin
            change <= 1'b1;
        end else begin
            change <= 1'b0;
        end
        
        prev_signal <= signal;
    end
endmodule