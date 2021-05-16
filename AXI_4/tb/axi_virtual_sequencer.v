class axi_virtual_sequencer extends uvm_sequencer#(uvm_sequence_item);

`uvm_component_utils(axi_virtual_sequencer)

axi_master_sequencer ms_seqrh;
axi_slave_sequencer sl_seqrh;

axi_env_config m_cfg;

extern function new(string name="axi_virtual_sequencer", uvm_component parent);
extern function void build_phase(uvm_phase phase);

endclass


function axi_virtual_sequencer::new(string name="axi_virtual_sequencer", uvm_component parent);

super.new(name, parent);

endfunction


function void axi_virtual_sequencer::build_phase(uvm_phase phase);

super.build_phase(phase);

endfunction
