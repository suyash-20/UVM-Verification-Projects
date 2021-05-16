class axi_master_sequencer extends uvm_sequencer#(axi_xtn);

`uvm_component_utils(axi_master_sequencer)

//Standard methods
extern function new(string name="axi_master_sequencer", uvm_component parent);

endclass
//new() constructor method
function axi_master_sequencer::new(string name="axi_master_sequencer", uvm_component parent);

super.new(name, parent);

endfunction
