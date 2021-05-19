class axi_slave_sequencer extends uvm_sequencer#(axi_xtn);

`uvm_component_utils(axi_slave_sequencer)

//Standard methods
extern function new(string name="axi_slave_sequencer", uvm_component parent);

endclass
//new() constructor method
function axi_slave_sequencer::new(string name="axi_slave_sequencer", uvm_component parent);

super.new(name, parent);

endfunction

