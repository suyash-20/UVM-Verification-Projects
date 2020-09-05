class seq_sequencer extends uvm_sequencer#(trans_xtn);

`uvm_component_utils(seq_sequencer)

//=====================================================
//methods
//=====================================================

extern function new(string name="seq_sequencer", uvm_component parent);

endclass

//=====================================================
//Function new
//=====================================================

function seq_sequencer::new(string name="seq_sequencer", uvm_component parent);

super.new(name, parent);

endfunction
