.DEFAULT_GOAL := sha

miner: module
	@iverilog -o miner -c module.txt -s minerControl_tb
	@vvp miner

sha: module
	@iverilog -o sha -c module.txt -s SHA256_tb
	@vvp sha

module:
	@ls *?.v > module.txt