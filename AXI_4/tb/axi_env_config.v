class axi_env_config extends uvm_object;

`uvm_object_utils(axi_env_config)

//DATA MEMBERS

bit has_virtual_sequencer = 1;
bit has_scoreboard = 0;

axi_master_agent_config m_ms_cfg;
axi_slave_agent_config m_sl_cfg;

//Standard Functions
extern function new(string name="axi_env_config");

endclass


//new() constructor method

function axi_env_config::new(string name="axi_env_config");
super.new(name);
endfunction

