class seq_agent extends uvm_agent;

`uvm_component_utils(seq_agent)

seq_driver driver;
driver_callback drv_clb;  //CALLBACK LOGIC

seq_monitor monitor;
seq_sequencer sequencer;

//---------handle for configuration
seq_agent_config m_cfg;

//=====================================================
//methods
//=====================================================

extern function new(string name="seq_agent",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass


//=====================================================
//Function new
//=====================================================

function seq_agent::new(string name="seq_agent",uvm_component parent);
super.new(name, parent);
endfunction


//=====================================================
//Build phase
//=====================================================

function void seq_agent::build_phase(uvm_phase phase);
super.build_phase(phase);
//get the config from env config
if(!uvm_config_db#(seq_agent_config)::get(this,"","agt_config",m_cfg))
`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
//$display("%p",m_cfg);

monitor = seq_monitor::type_id::create("monitor",this);
//$display("%p",monitor);


if(m_cfg.is_active==UVM_ACTIVE)

	begin
	driver = seq_driver::type_id::create("driver",this);

	drv_clb = driver_callback::type_id::create("drv_clb");  //CALLBACK LOGIC
	$display("%p",drv_clb);
		
	sequencer = seq_sequencer::type_id::create("sequencer",this);
	end

endfunction


//=====================================================
//Connect phase
//=====================================================

function void seq_agent::connect_phase(uvm_phase phase);
super.connect_phase(phase);
if(m_cfg.is_active==UVM_ACTIVE)
driver.seq_item_port.connect(sequencer.seq_item_export);

endfunction

