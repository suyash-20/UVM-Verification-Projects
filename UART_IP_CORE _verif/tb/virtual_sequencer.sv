class virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);

`uvm_component_utils(virtual_sequencer)

sequencer seqrh[];
env_config m_cfg;

//=====================================================
//Function new
//=====================================================

extern function new(string name ="virtual_sequencer", uvm_component parent);
extern function void build_phase(uvm_phase phase);

endclass

//=====================================================
//Function new
//=====================================================

function virtual_sequencer::new(string name = "virtual_sequencer", uvm_component parent);

super.new(name, parent);

endfunction

//=====================================================
//Build phase
//=====================================================

function void virtual_sequencer::build_phase(uvm_phase phase);

  if(!uvm_config_db #(env_config)::get(this,"","env_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")

super.build_phase(phase);

seqrh = new[m_cfg.no_of_agents];

endfunction