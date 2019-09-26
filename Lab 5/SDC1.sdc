create_clock -name {Clk} -period 20ns -waveform {0.000 5.000} [get_ports {Clk}]

set_input_delay -clock {Clk} -max 3 [all_inputs]
set_input_delay -clock {Clk} -min 2 [all_inputs]

set_output_delay -clock {Clk} 2 [all_outputs]