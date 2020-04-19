# STEP#1: define the output directory area.
#
set outputDir C:/Users/Derek/Desktop/Personal_projects/PIANO_PROJECT/vivado/project_dir/
set fpga_part xc7z010clg400-3
#
# STEP#2: setup design sources and constraints
#
read_vhdl C:/Users/Derek/Desktop/Personal_projects/PIANO_PROJECT/vivado/vhdl/PIANO_ZYBO.vhd
read_xdc C:/Users/Derek/Desktop/Personal_projects/PIANO_PROJECT/vivado/constraints/zybo_top_level.xdc
#
# STEP#3: run synthesis, write design checkpoint, report timing,
# and utilization estimates
#
synth_design -top PIANO_ZYBO -part $fpga_part
write_checkpoint -force $outputDir/post_synth.dcp
report_timing_summary -file $outputDir/post_synth_timing_summary.rpt
report_utilization -file $outputDir/post_synth_util.rpt
#
# STEP#4: run logic optimization, placement and physical logic optimization,
# write design checkpoint, report utilization and timing estimates
#
opt_design
place_design
report_clock_utilization -file $outputDir/clock_util.rpt
#
# Optionally run optimization if there are timing violations after placement
if {[get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 -setup]] < 0} {
 puts "Found setup timing violations => running physical optimization"
 phys_opt_design
}
write_checkpoint -force $outputDir/post_place.dcp
report_utilization -file $outputDir/post_place_util.rpt
report_timing_summary -file $outputDir/post_place_timing_summary.rpt
#
# STEP#5: run the router, write the post-route design checkpoint, report the routing
# status, report timing, power, and DRC, and finally save the Verilog netlist.
#
route_design
write_checkpoint -force $outputDir/post_route.dcp
report_route_status -file $outputDir/post_route_status.rpt
report_timing_summary -file $outputDir/post_route_timing_summary.rpt
report_power -file $outputDir/post_route_power.rpt
report_drc -file $outputDir/post_imp_drc.rpt
#
# STEP#6: generate a bitstream
#
write_bitstream -force $outputDir/../image/PIANO_ZYBO.bit