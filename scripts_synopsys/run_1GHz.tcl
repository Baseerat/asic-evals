read_file -format verilog {/home/mshahbaz/baseerat/asic-evals/baseerat_mux.v}
compile -exact_map
change_selection [::snpsGuiSyn::get_current_design]
analyze -library WORK -format verilog {/home/mshahbaz/baseerat/asic-evals/baseerat_mux.v}
#elaborate baseerat_mux -architecture verilog -library DEFAULT
elaborate baseerat_mux -architecture verilog -library WORK -update
link

create_clock clk -period 1 -waveform {0 0.5}
set_clock_latency 0.3 clk
set_input_delay 0.25 -clock clk [all_inputs]
set_output_delay 0.165 -clock clk [all_outputs]
set_load 0.1 [all_outputs]
set_max_fanout 1 [all_inputs]
set_fanout_load 8 [all_outputs]

report_port
compile -exact_map
uplevel #0 check_design
uplevel #0 { report_timing -path full -delay max -nworst 1 -max_paths 3 -loops -significant_digits 2 -sort_by group }
uplevel #0 { report_timing -path full -delay max -nworst 1 -max_paths 3 -significant_digits 2 -sort_by group }
