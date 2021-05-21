class ahb_agt_top extends uvm_env;

`uvm_component_utils(ahb_agt_top)

ahb_agent agent;

//handle for agent config


//=====================================================
//Standard methods
//=====================================================

extern function new(string name="ahb_agt_top", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass


//=====================================================
//Function new
//=====================================================
function ahb_agt_top::new(string name="ahb_agt_top", uvm_component parent);
super.new(name, parent);

endfunction

//=====================================================
//Build phase
//=====================================================

function void ahb_agt_top::build_phase(uvm_phase phase);
super.build_phase(phase);

//if(!uvm_config_db#(ahb_agt_config)::get(this,"","ahb_agt_config",m_cfg.__________))
//`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it")

agent = ahb_agent::type_id::create("agent", this);
endfunction

task ahb_agt_top::run_phase(uvm_phase phase);
super.run_phase(phase);

uvm_top.print_topology();

endtask

