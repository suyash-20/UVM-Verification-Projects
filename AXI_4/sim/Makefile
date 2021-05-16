#Makefile for UVM Testbench
RTL= ../axi_rtl/*
work= work #library name
SVTB1= ../tb/top.sv
INC = +incdir+../tb +incdir+../test +incdir+../master_agent_top +incdir+../slave_agent_top
SVTB2 = ../tb/axi_package.sv
VSIMOPT= -vopt -voptargs=+acc 
VSIMCOV= -coverage -sva 
VSIMBATCH1= -c -do  " log -r /* ;coverage save -onexit mem_cov1;run -all; exit"
VSIMBATCH2= -c -do  " log -r /* ;coverage save -onexit mem_cov2;run -all; exit"
VSIMBATCH3= -c -do  " log -r /* ;coverage save -onexit mem_cov3;run -all; exit"

sv_cmp:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(RTL) $(INC) $(SVTB2) $(SVTB1) 	
	
run_test:sv_cmp
	vsim $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave_file1.wlf -l test1.log  -sv_seed random  work.top +UVM_TESTNAME=axi_base_test  
	
run_test1:sv_cmp
	vsim $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave_file1.wlf -l test1.log  -sv_seed random  work.top +UVM_TESTNAME=axi_first_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov1
	
run_test2:sv_cmp
	vsim $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH2)  -wlf wave_file2.wlf -l test2.log  -sv_seed random  work.top +UVM_TESTNAME=axi_second_test 
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov2
	
run_test3:sv_cmp
	vsim $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH3)  -wlf wave_file3.wlf -l test3.log  -sv_seed random  work.top +UVM_TESTNAME=axi_third_test 
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov3

run_test4:sv_cmp
	vsim $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave_file4.wlf -l test5.log  -sv_seed random  work.top +UVM_TESTNAME=axi_fourth_test 
	
run_test5:sv_cmp
	vsim $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave_file5.wlf -l test6.log  -sv_seed random  work.top +UVM_TESTNAME=axi_fifth_test 
gui:
	vsim -view wave_file4.wlf

report:
	vcover merge mem_cov mem_cov1 mem_cov2 mem_cov3 
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov
	
clean:
	rm -rf transcript* *log* work *wlf fcover* covhtml* mem_cov* 
	clear
regress: run_test run_test1 run_test2 run_test3 report

cov: 
	firefox covhtmlreport/index.html &

