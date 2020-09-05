class seq_agent_config extends uvm_object;

`uvm_object_utils(seq_agent_config)

virtual seq_if vif;

uvm_active_passive_enum is_active = UVM_ACTIVE;

//=====================================================
//methods
//=====================================================

extern function new(string name="seq_agent_config");
endclass

//=====================================================
//Function new
//=====================================================

function seq_agent_config::new(string name="seq_agent_config");
super.new(name);
endfunction
