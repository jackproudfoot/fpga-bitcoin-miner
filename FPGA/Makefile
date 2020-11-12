.DEFAULT_GOAL := uart

miner: module
	@iverilog -o miner -c module.txt -s minerControl_tb
	@vvp miner

sha: module
	@iverilog -o sha -c module.txt -s SHA256_tb
	@vvp sha

uart: module
	@iverilog -o uart -c module.txt -s uart_tb
	@vvp uart

shift_reg: module
	@iverilog -o shift_reg -c module.txt -s shift_reg_tb
	@vvp shift_reg

seven_segment: module
	@iverilog -o seven_segment -c module.txt -s seven_segment_tb
	@vvp seven_segment

module:
	@ls *?.v > module.txt