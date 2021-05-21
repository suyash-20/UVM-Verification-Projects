vlib work 
vmap work work
vlog -work work ../rtl/* +incdir+../tb +incdir+../test +incdir+../ahb_top +incdir+../apb_top +define+UVM_LOG +define+WRAPPING_INCR +define+WIDTH_32 ../tb/bridge_package.sv ../tb/top.sv


#vsim -cvgperinstance -vopt -voptargs=+acc -coverage -sva -c -do  " log -r/* ;
#coverage save -onexit mem_cov1;run -all" -wlf wave_file1.wlf -l test1.log  -sv_seed random  work.top +UVM_TESTNAME=base_test 
#vcover report  -cvg  -details -html mem_cov1


vsim -cvgperinstance -vopt -voptargs=+acc -coverage -sva -c -do  " log -r/* ;
coverage save -onexit mem_cov2;run -all" -wlf wave_file2.wlf -l test2.log -sv_seed random work.top +UVM_TESTNAME=bridge_first_test
vcover report  -cvg  -details -html mem_cov2
