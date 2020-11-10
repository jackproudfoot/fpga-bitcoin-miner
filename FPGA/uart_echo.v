`timescale 1ns/10ps
 
module uart_echo(fpga_clock);

    input fpga_clock;

    wire clock;

    // create 10Mhz clock from 100 MHz
    integer clock_cnt;
    always @(posedge clock) begin
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

    reg r_Tx_DV = 0;
    wire w_Tx_Done;
    reg [7:0] r_Tx_Byte = 0;
    reg r_Rx_Serial = 1;
    wire [7:0] w_Rx_Byte;

    uart_rx #(.CLKS_PER_BIT(c_CLKS_PER_BIT)) UART_RX_INST
    (.i_Clock(clock),
        .i_Rx_Serial(r_Rx_Serial),
        .o_Rx_DV(),
        .o_Rx_Byte(w_Rx_Byte)
        );

    uart_tx #(.CLKS_PER_BIT(c_CLKS_PER_BIT)) UART_TX_INST
    (.i_Clock(clock),
        .i_Tx_DV(r_Tx_DV),
        .i_Tx_Byte(r_Tx_Byte),
        .o_Tx_Active(),
        .o_Tx_Serial(),
        .o_Tx_Done(w_Tx_Done)
        );


    integer cooldown = 0;
    byte count = 0;

    always @(posedge clock) begin
        if (cooldown == 1000) begin
            cooldown <= 0;
            count <= count + 1;

            r_Tx_DV <= 1'b1;
            r_Tx_Byte <= count;
        end else begin
            cooldown <= cooldown + 1;
            r_Tx_DV <= 1'b0;
        end
    end
   
endmodule