transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/Stephane/testbench_lineoblique_v3 {C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/Stephane/testbench_lineoblique_v3/LineCUBE.sv}
vlog -sv -work work +incdir+C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/Stephane/testbench_lineoblique_v3 {C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/Stephane/testbench_lineoblique_v3/XYcount.sv}
vlog -sv -work work +incdir+C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/Stephane/testbench_lineoblique_v3 {C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/Stephane/testbench_lineoblique_v3/lineoblique.sv}

vlog -sv -work work +incdir+C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/Stephane/testbench_lineoblique_v3 {C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/Stephane/testbench_lineoblique_v3/lineoblique_testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  lineoblique_testbench

add wave *
view structure
view signals
run 400 us
