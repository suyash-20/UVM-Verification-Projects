class agt_config extends uvm_object;
`uvm_object_utils(agt_config)

virtual uart_if vif;
uvm_active_passive_enum is_active = UVM_ACTIVE;

//=====================================================
//methods
//=====================================================

extern function new(string name="agt_config");
endclass

//=====================================================
//Function new
//=====================================================

function agt_config::new(string name="agt_config");
        super.new(name);
endfunction