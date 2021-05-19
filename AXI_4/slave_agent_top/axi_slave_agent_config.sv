class axi_slave_agent_config extends uvm_object;

`uvm_object_utils(axi_slave_agent_config)

//virtual interface handle
virtual axi_if vif;
uvm_active_passive_enum is_active = UVM_ACTIVE;


//Standard methods
extern function new(string name="axi_slave_agent_config");

endclass


//new() constructor method
function axi_slave_agent_config::new(string name="axi_slave_agent_config");
super.new(name);

endfunction

