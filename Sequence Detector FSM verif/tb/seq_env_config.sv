class seq_env_config extends uvm_object;

`uvm_object_utils(seq_env_config)

bit has_virtual_sequencer = 1;
bit has_scoreboard = 1;
bit has_agent = 1;

//---------handle for seq_agent config
seq_agent_config m_agt_cfg;

//=====================================================
//methods
//=====================================================

extern function new(string name="seq_env_config");

endclass

//=====================================================
//Function new
//=====================================================

function seq_env_config::new(string name="seq_env_config");
super.new(name);
endfunction
