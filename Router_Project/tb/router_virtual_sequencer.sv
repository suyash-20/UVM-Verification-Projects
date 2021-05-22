//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------
class router_virtual_sequencer extends uvm_sequencer #(uvm_sequence_item) ;
   
	`uvm_component_utils(router_virtual_sequencer)

	router_wr_sequencer wr_seqrh;
	router_rd_sequencer rd_seqrh[];

  	router_env_config m_cfg;

//------------------------------------------
// Methods
//------------------------------------------
 	extern function new(string name = "router_virtual_sequencer",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
endclass

//-----------------  constructor new method  -------------------//
function router_virtual_sequencer::new(string name="router_virtual_sequencer",uvm_component parent);
	super.new(name,parent);
endfunction


//--------------------build phase----------------//
function void router_virtual_sequencer::build_phase(uvm_phase phase);

	// get the config object router_env_config using uvm_config_db 
    if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",m_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")

    super.build_phase(phase);

	rd_seqrh = new[m_cfg.no_of_read_agents];
endfunction


