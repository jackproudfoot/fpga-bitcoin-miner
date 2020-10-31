.DEFAULT_GOAL := miner

miner: module
	@iverilog -o miner -c module.txt -s SHA256_tb
	@vvp miner

module:
	@ls *?.v > module.txt