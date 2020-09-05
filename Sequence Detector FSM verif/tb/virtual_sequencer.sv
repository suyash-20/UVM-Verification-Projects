class virtual_sequencer extends uvm_sequencer#(uvm_sequence_item);

`uvm_component_utils(virtual_sequencer)

seq_sequencer s_seqr;
seq_env_config m_cfg;

//=====================================================
//methods
//=====================================================
extern function new(string name = "virtual_sequencer", uvm_component parent);

endclass

//=====================================================
//Function new
//=====================================================

function virtual_sequencer::new(string name = "virtual_sequencer", uvm_component parent);
 super.new(name, parent);
endfunction



