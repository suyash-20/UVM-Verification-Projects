class base_test extends uvm_test;

bridge_env envh;

//handles for agent config and env config
bridge_env_config m_cfg;
ahb_agent_config ahb_cfg;
apb_agent_config apb_cfg;

//has_ variables
int has_ahb_agent=1;
int has_apb_agent=1; 

`uvm_component_utils(base_test)

//=====================================================
//methods
//=====================================================

extern function new(string name="base_test",uvm_component parent);
extern function void build_phase(uvm_phase phase);
//extern function void connect_phase(uvm_phase phase);

endclass

//=====================================================
//Function new
//=====================================================

function base_test::new(string name="base_test", uvm_component parent);
	super.new(name, parent);

endfunction

//=====================================================
//Build phase
//=====================================================

function void base_test::build_phase(uvm_phase phase);

	//object creation for env config
	m_cfg = bridge_env_config::type_id::create("m_cfg");


	if(has_ahb_agent) begin
				
	//object creation for agent config
	ahb_cfg = ahb_agent_config::type_id::create("ahb_cfg");
	//getting the virtual config from top
	if(!uvm_config_db#(virtual bridge_if)::get(this,"","vif",ahb_cfg.vif))
	`uvm_fatal("interface","cant get virtual interface in test from top")

	ahb_cfg.is_active=UVM_ACTIVE;
	m_cfg.ahb_cfg=ahb_cfg;
	end

	if(has_apb_agent) begin
																						
	//object creation for agent config
	apb_cfg = apb_agent_config::type_id::create("apb_cfg");
	//getting the virtual config from top
	if(!uvm_config_db#(virtual bridge_if)::get(this,"","vif",apb_cfg.vif))
	`uvm_fatal("interface","cant get virtual interface in test from top")

	apb_cfg.is_active=UVM_ACTIVE;
	m_cfg.apb_cfg=apb_cfg;

	end

	uvm_config_db#(bridge_env_config)::set(this,"*","bridge_env_config",m_cfg);

	envh = bridge_env::type_id::create("env",this);

endfunction


class bridge_first_test extends base_test;

`uvm_component_utils(bridge_first_test)

seq01_vseq seq01;

extern function new(string name="bridge_first_test", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass



function bridge_first_test::new(string name="bridge_first_test", uvm_component parent);
super.new(name, parent);

endfunction

function void bridge_first_test::build_phase(uvm_phase phase);
super.build_phase(phase);

endfunction


task bridge_first_test::run_phase(uvm_phase phase);
super.run_phase(phase);

phase.raise_objection(this);

seq01=seq01_vseq::type_id::create("seq01");

//---------start the sequence on virtual sequencer
seq01.start(envh.vsqrh);
#100;
phase.drop_objection(this);

endtask
