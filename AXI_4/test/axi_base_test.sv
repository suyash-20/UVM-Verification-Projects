class axi_base_test extends uvm_test;

`uvm_component_utils(axi_base_test)

axi_tb envh;
axi_env_config m_cfg;

//handles for master and slave agent config
axi_master_agent_config m_ms_cfg;
axi_slave_agent_config m_sl_cfg;

//declare required variables like has agents and no of agents

//Standard Methods
extern function new(string name="axi_base_test",uvm_component parent);
extern function void build_phase(uvm_phase phase);
//extern config_function??

endclass


//new()constructor method

function axi_base_test::new(string name="axi_base_test",uvm_component parent);
super.new(name,parent);
endfunction

//cofig_function??

//build_phase method
function void axi_base_test::build_phase(uvm_phase phase);


m_cfg = axi_env_config::type_id::create("m_cfg");

//MASTER AGENT CONFIG
m_ms_cfg = axi_master_agent_config::type_id::create("m_ms_cfg");

if(!uvm_config_db#(virtual axi_if)::get(this,"","vif",m_ms_cfg.vif))
`uvm_fatal("VIF_CONFIG","cannot get the interface vif from uvm_config_db")

//is active check
m_ms_cfg.is_active = UVM_ACTIVE;
m_cfg.m_ms_cfg = m_ms_cfg;


//SLAVE AGENT CONFIG

//instance for slave agent config
m_sl_cfg = axi_slave_agent_config::type_id::create("m_sl_cfg");

if(!uvm_config_db#(virtual axi_if)::get(this,"","vif",m_sl_cfg.vif))
`uvm_fatal("VIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?")

m_sl_cfg.is_active = UVM_ACTIVE;
m_cfg.m_sl_cfg = m_sl_cfg;

super.build_phase(phase);


uvm_config_db #(axi_env_config)::set(this,"*","axi_env_config",m_cfg);
envh = axi_tb::type_id::create("envh", this);

endfunction

//EXTENDED TESTS:-


//Extended Test_01

class axi_first_test extends axi_base_test;

`uvm_component_utils(axi_first_test)

axi_seq01_vseq axi_seq01;


extern function new(string name = "axi_first_test", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass


function axi_first_test::new(string name = "axi_first_test",uvm_component parent);
super.new(name, parent);

endfunction


function void axi_first_test::build_phase(uvm_phase phase);
super.build_phase(phase);

endfunction


task axi_first_test::run_phase(uvm_phase phase);
super.run_phase(phase);

phase.raise_objection(this);

axi_seq01 = axi_seq01_vseq::type_id::create("axi_seq01");

axi_seq01.start(envh.v_sequencer);

#100000;

phase.drop_objection(this);

endtask


//Extended Test_02

class axi_second_test extends axi_base_test;

`uvm_component_utils(axi_second_test)

axi_seq02_vseq axi_seq02;


extern function new(string name = "axi_second_test", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass


function axi_second_test::new(string name = "axi_second_test",uvm_component parent);
super.new(name, parent);

endfunction


function void axi_second_test::build_phase(uvm_phase phase);
super.build_phase(phase);

endfunction


task axi_second_test::run_phase(uvm_phase phase);
super.run_phase(phase);

phase.raise_objection(this);

axi_seq02 = axi_seq02_vseq::type_id::create("axi_seq02");

axi_seq02.start(envh.v_sequencer);

#5000000;

phase.drop_objection(this);

endtask


//Extended Test_03

class axi_third_test extends axi_base_test;

`uvm_component_utils(axi_third_test)

axi_seq03_vseq axi_seq03;


extern function new(string name = "axi_third_test", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass


function axi_third_test::new(string name = "axi_third_test",uvm_component parent);
super.new(name, parent);

endfunction


function void axi_third_test::build_phase(uvm_phase phase);
super.build_phase(phase);

endfunction


task axi_third_test::run_phase(uvm_phase phase);
super.run_phase(phase);

phase.raise_objection(this);

axi_seq03 = axi_seq03_vseq::type_id::create("axi_seq03");

axi_seq03.start(envh.v_sequencer);

#60000;

phase.drop_objection(this);

endtask
