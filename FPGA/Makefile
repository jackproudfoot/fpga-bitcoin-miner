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

module:
	@ls *?.v > module.txt