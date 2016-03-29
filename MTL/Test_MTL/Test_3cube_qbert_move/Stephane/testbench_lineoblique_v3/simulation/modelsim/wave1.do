onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /lineoblique_testbench/clk
add wave -noupdate -radix decimal /lineoblique_testbench/reset
add wave -noupdate -radix decimal /lineoblique_testbench/x_offset
add wave -noupdate -radix decimal /lineoblique_testbench/x_final
add wave -noupdate -radix decimal /lineoblique_testbench/y_offset
add wave -noupdate -radix decimal /lineoblique_testbench/y_final
add wave -noupdate -radix decimal /lineoblique_testbench/Xcount
add wave -noupdate -radix decimal /lineoblique_testbench/Xline
add wave -noupdate -radix decimal /lineoblique_testbench/Ycount
add wave -noupdate -radix decimal /lineoblique_testbench/Yline
add wave -noupdate -radix decimal /lineoblique_testbench/x_step
add wave -noupdate -radix decimal /lineoblique_testbench/x_step_next
add wave -noupdate -radix decimal /lineoblique_testbench/y_step
add wave -noupdate -radix decimal /lineoblique_testbench/y_step_next
add wave -noupdate -radix decimal /lineoblique_testbench/error
add wave -noupdate -radix decimal /lineoblique_testbench/error2
add wave -noupdate -radix decimal /lineoblique_testbench/x_period
add wave -noupdate -radix decimal /lineoblique_testbench/y_period
add wave -noupdate -radix decimal /lineoblique_testbench/start_mark
add wave -noupdate -radix decimal /lineoblique_testbench/done_mark
add wave -noupdate -radix decimal /lineoblique_testbench/curseur
add wave -noupdate -radix decimal /lineoblique_testbench/delta_x
add wave -noupdate -radix decimal /lineoblique_testbench/delta_y
add wave -noupdate -radix decimal /lineoblique_testbench/droit
add wave -noupdate -radix decimal /lineoblique_testbench/bas
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {304030710 ps} {336675830 ps}
