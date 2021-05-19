class axi_slave_agent extends uvm_agent;

`uvm_component_utils(axi_slave_agent)

//Handles for driver, monitor and sequencer
axi_slave_driver driver;
axi_slave_monitor monitor;
axi_slave_sequencer sequencer;

//handle for configuration
axi_slave_agent_config m_cfg;


//Standard methods

extern function new(string name="axi_slave_agent", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass

//new() constructor method 
function axi_slave_agent::new(string name="axi_slave_agent", uvm_component parent);

super.new(name, parent);

endfunction

//build_phase method

function void axi_slave_agent::build_phase(uvm_phase phase);
super.build_phase(phase);

//get the configuration

if(!uvm_config_db #(axi_slave_agent_config)::get(this,"","axi_slave_agent_config",m_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
monitor = axi_slave_monitor::type_id::create("monitor",this);

//if loop for is_active is ACTIVE
if(m_cfg.is_active==UVM_ACTIVE)

	begin
		driver = axi_slave_driver::type_id::create("driver",this);
		sequencer = axi_slave_sequencer::type_id::create("sequencer",this);
	end
endfunction

//connect phase method
 
function void axi_slave_agent::connect_phase(uvm_phase phase);

super.connect_phase(phase);

//if loop for is_active= ACTIVE
if(m_cfg.is_active==UVM_ACTIVE)
	driver.seq_item_port.connect(sequencer.seq_item_export);

endfunction


