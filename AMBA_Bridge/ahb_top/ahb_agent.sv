class ahb_agent extends uvm_agent;

`uvm_component_utils(ahb_agent)

//handles for driver, monitor and sequencer
ahb_driver driver;
ahb_monitor monitor;
ahb_sequencer sequencer;

//handle for agent config
ahb_agent_config ahb_cfg;


//=====================================================
//Standard methods
//=====================================================

extern function new(string name="ahb_agent", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass


//=====================================================
//Function new
//=====================================================

function ahb_agent::new(string name = "ahb_agent", uvm_component parent);
super.new(name, parent);

endfunction


//=====================================================
//Build phase
//=====================================================

function void ahb_agent::build_phase(uvm_phase phase);

    super.build_phase(phase);

        if(!uvm_config_db#(ahb_agent_config)::get(this,"","ahb_agent_config",ahb_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
	  monitor = ahb_monitor::type_id::create("monitor",this);

	    if(ahb_cfg.is_active==UVM_ACTIVE) begin

	       driver = ahb_driver::type_id::create("driver",this);
	        sequencer = ahb_sequencer::type_id::create("sequencer",this);
	    end

    endfunction


					    //=====================================================
					    //Connect phase
					    //=====================================================

					    function void ahb_agent::connect_phase(uvm_phase phase);
					        super.connect_phase(phase);

						    if(ahb_cfg.is_active==UVM_ACTIVE) begin
						            driver.seq_item_port.connect(sequencer.seq_item_export);
							        end

								endfunction
