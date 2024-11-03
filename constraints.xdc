# Clock
set_property PACKAGE_PIN Y9 [get_ports clk]
create_clock -period 100.000 -name CLK -waveform {0.000 50.000} [get_ports clk]

# OLED display
set_property PACKAGE_PIN U10 [get_ports oled_dc]
set_property PACKAGE_PIN U9 [get_ports oled_res]
set_property PACKAGE_PIN AB12 [get_ports oled_sclk]
set_property PACKAGE_PIN AA12 [get_ports {oled_sdin}];  # "OLED-SDIN"
set_property PACKAGE_PIN U11 [get_ports oled_vbat]
set_property PACKAGE_PIN U12 [get_ports oled_vdd]

# Reset
set_property PACKAGE_PIN P16 [get_ports rst]

#set_property PACKAGE_PIN R16 [get_ports W]

# Voltage settings
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 34]]
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]]

# for the adder
set_property IOSTANDARD LVTTL [get_ports {LED[7]}]
set_property IOSTANDARD LVTTL [get_ports {LED[6]}]
set_property IOSTANDARD LVTTL [get_ports {LED[5]}]
set_property IOSTANDARD LVTTL [get_ports {LED[4]}]
set_property IOSTANDARD LVTTL [get_ports {LED[3]}]
set_property IOSTANDARD LVTTL [get_ports {LED[2]}]
set_property IOSTANDARD LVTTL [get_ports {LED[1]}]
set_property IOSTANDARD LVTTL [get_ports {LED[0]}]
set_property IOSTANDARD LVTTL [get_ports {SW[7]}]
set_property IOSTANDARD LVTTL [get_ports {SW[6]}]
set_property IOSTANDARD LVTTL [get_ports {SW[5]}]
set_property IOSTANDARD LVTTL [get_ports {SW[4]}]
set_property IOSTANDARD LVTTL [get_ports {SW[3]}]
set_property IOSTANDARD LVTTL [get_ports {SW[2]}]
set_property IOSTANDARD LVTTL [get_ports {SW[1]}]
set_property IOSTANDARD LVTTL [get_ports {SW[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports E]
set_property IOSTANDARD LVCMOS33 [get_ports N]
set_property IOSTANDARD LVCMOS33 [get_ports S]
set_property IOSTANDARD LVCMOS33 [get_ports W]

set_property PACKAGE_PIN R18 [get_ports E]
set_property PACKAGE_PIN T18 [get_ports N]
set_property PACKAGE_PIN R16 [get_ports S]
set_property PACKAGE_PIN N15 [get_ports W]

set_property PACKAGE_PIN M15 [get_ports {SW[7]}]
set_property PACKAGE_PIN H17 [get_ports {SW[6]}]
set_property PACKAGE_PIN H18 [get_ports {SW[5]}]
set_property PACKAGE_PIN H19 [get_ports {SW[4]}]
set_property PACKAGE_PIN F21 [get_ports {SW[3]}]
set_property PACKAGE_PIN H22 [get_ports {SW[2]}]
set_property PACKAGE_PIN G22 [get_ports {SW[1]}]
set_property PACKAGE_PIN F22 [get_ports {SW[0]}]
set_property PACKAGE_PIN U14 [get_ports {LED[7]}]
set_property PACKAGE_PIN U19 [get_ports {LED[6]}]
set_property PACKAGE_PIN W22 [get_ports {LED[5]}]
set_property PACKAGE_PIN V22 [get_ports {LED[4]}]
set_property PACKAGE_PIN U21 [get_ports {LED[3]}]
set_property PACKAGE_PIN U22 [get_ports {LED[2]}]
set_property PACKAGE_PIN T21 [get_ports {LED[1]}]
set_property PACKAGE_PIN T22 [get_ports {LED[0]}]