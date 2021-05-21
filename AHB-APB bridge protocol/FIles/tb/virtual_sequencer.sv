class virtual_sequencer extends uvm_sequencer#(uvm_sequence_item);

`uvm_component_utils(virtual_sequencer)

ahb_sequencer ahb_seqr;
apb_sequencer apb_seqr;

bridge_env_config m_cfg;

//=====================================================
//Methods
//=====================================================

extern function new(string name = "virtual_sequencer", uvm_component parent);

endclass

//=====================================================
//Function new
//=====================================================

function virtual_sequencer::new(string name="virtual_sequencer", uvm_component parent);

super.new(name, parent);
endfunction


