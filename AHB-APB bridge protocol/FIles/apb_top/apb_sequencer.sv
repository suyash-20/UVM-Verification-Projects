class apb_sequencer extends uvm_sequencer#(apb_xtn);

`uvm_component_utils(apb_sequencer)

//=====================================================
//Standard methods
//=====================================================

extern function new(string name = "apb_sequencer", uvm_component parent);
extern function void build_phase(uvm_phase phase);
 
endclass


//=====================================================
//Function new
//=====================================================

function apb_sequencer::new(string name = "apb_sequencer", uvm_component parent);
super.new(name, parent);

endfunction


//=====================================================
//Build phase
//=====================================================

function void apb_sequencer::build_phase(uvm_phase phase);
super.build_phase(phase);

endfunction

