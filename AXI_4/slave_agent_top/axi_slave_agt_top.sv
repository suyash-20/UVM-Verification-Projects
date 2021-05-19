class axi_slave_agt_top extends uvm_env;

`uvm_component_utils(axi_slave_agt_top)

axi_slave_agent agent;
//haandles for agent config
axi_env_config m_cfg;


//Standard methods
extern function new(string name="axi_slave_agt_top",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass

//new() constructor method

function axi_slave_agt_top::new(string name="axi_slave_agt_top",uvm_component parent);

super.new(name, parent);
endfunction

//build_phase method
function void axi_slave_agt_top::build_phase(uvm_phase phase);

//for multiple agents
//get the config from the env_config for no of agents

agent = axi_slave_agent::type_id::create("agent", this);

//if(!uvm_config_db#(axi_env_config)::get(this,"","axi_env_config",m_cfg.m_sl_cfg))
//`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it")

endfunction

task axi_slave_agt_top::run_phase(uvm_phase phase);

uvm_top.print_topology();
endtask




