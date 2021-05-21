class bridge_env_config extends uvm_object;

`uvm_object_utils(bridge_env_config)

//DATA MEMBERS

bit has_virtual_sequencer = 1;
bit has_scoreboard = 1;

ahb_agent_config ahb_cfg;
apb_agent_config apb_cfg;

function new(string name="bridge_env_config");
super.new(name);

endfunction 

endclass

