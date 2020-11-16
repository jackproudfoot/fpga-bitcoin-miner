set_property PACKAGE_PIN E3 [get_ports clock]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clock}];
set_property PACKAGE_PIN N17 [get_ports reset]
set_property PACKAGE_PIN R12 [get_ports led]
set_property IOSTANDARD LVCMOS33 [get_ports clock]
set_property IOSTANDARD LVCMOS33 [get_ports led]
set_property IOSTANDARD LVCMOS33 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports {ca[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ca[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ca[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ca[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ca[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ca[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ca[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ca[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]
set_property PACKAGE_PIN J17 [get_ports {an[0]}]
set_property PACKAGE_PIN J18 [get_ports {an[1]}]
set_property PACKAGE_PIN T9 [get_ports {an[2]}]
set_property PACKAGE_PIN J14 [get_ports {an[3]}]
set_property PACKAGE_PIN P14 [get_ports {an[4]}]
set_property PACKAGE_PIN T14 [get_ports {an[5]}]
set_property PACKAGE_PIN K2 [get_ports {an[6]}]
set_property PACKAGE_PIN U13 [get_ports {an[7]}]
set_property PACKAGE_PIN H15 [get_ports {ca[7]}]
set_property PACKAGE_PIN L18 [get_ports {ca[6]}]
set_property PACKAGE_PIN T11 [get_ports {ca[5]}]
set_property PACKAGE_PIN P15 [get_ports {ca[4]}]
set_property PACKAGE_PIN K13 [get_ports {ca[3]}]
set_property PACKAGE_PIN K16 [get_ports {ca[2]}]
set_property PACKAGE_PIN R10 [get_ports {ca[1]}]
set_property PACKAGE_PIN T10 [get_ports {ca[0]}]