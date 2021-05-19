package axi_package;


import uvm_pkg::*;

`include "uvm_macros.svh"

	`include "axi_xtn.sv"
	`include "axi_master_agent_config.sv"
	`include "axi_slave_agent_config.sv"

	`include "axi_env_config.sv"

	`include "axi_master_driver.sv"
	`include "axi_master_monitor.sv"
	`include "axi_master_sequencer.sv"
	`include "axi_master_agent.sv"
	`include "axi_master_agt_top.sv"
	`include "axi_master_write_sequence.sv"
	`include "axi_master_read_sequence.sv"

//	`include "slave_trans.sv"

	`include "axi_slave_driver.sv"
	`include "axi_slave_monitor.sv"
	`include "axi_slave_sequencer.sv"
	`include "axi_slave_agent.sv"
	`include "axi_slave_agt_top.sv"
	`include "axi_slave_write_sequence.sv"
	`include "axi_slave_read_sequence.sv"


	`include "axi_virtual_sequencer.sv"
	`include "axi_virtual_sequence.sv"
	`include "axi_scoreboard.sv"

	
	`include "axi_tb.sv"
	`include "axi_base_test.sv"

endpackage
