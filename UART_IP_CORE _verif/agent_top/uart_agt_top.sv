class agt_top extends uvm_env;
`uvm_component_utils(agt_top)

agent agnth[];
env_config m_cfg;

//=====================================================
//methods
//=====================================================

extern function new(string name="agt_top",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
endclass

//=====================================================
//Function new
//=====================================================

function agt_top::new(string name="agt_top",uvm_component parent);
        super.new(name,parent);
endfunction

//=====================================================
//Build phase
//=====================================================

function void agt_top::build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(env_config)::get(this,"","env_config",m_cfg))
        `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it")
        agnth=new[m_cfg.no_of_agents];
        foreach(agnth[i])begin
        agnth[i]=agent::type_id::create($sformatf("agnth[%0d]",i) ,this);
        if(!uvm_config_db #(agt_config)::get(this,$sformatf("agnth[%0d]*",i),"agt_config", m_cfg.m_agt_cfg[i]))
        `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it")

                end
endfunction

//=====================================================
//Run phase
//=====================================================

task agt_top::run_phase(uvm_phase phase);
        uvm_top.print_topology;
endtask