class seq_agt_top extends uvm_env;

`uvm_component_utils(seq_agt_top)

seq_agent agent;

//---------handles for agent config (FOR MULTIPLE AGENTS)


//=====================================================
//methods
//=====================================================

extern function new(string name = "seq_agt_top", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass


//=====================================================
//Function new
//=====================================================

function seq_agt_top::new(string name = "seq_agt_top", uvm_component parent);
super.new(name, parent);
endfunction

//=====================================================
//Build phase
//=====================================================

function void seq_agt_top::build_phase(uvm_phase phase);
super.build_phase(phase);

//get the config from env 
// `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it")
agent = seq_agent::type_id::create("agent",this);

endfunction


//=====================================================
//Run phase
//=====================================================

task seq_agt_top::run_phase(uvm_phase phase);
uvm_top.print_topology;

endtask