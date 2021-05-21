class apb_agent extends uvm_agent;

`uvm_component_utils(apb_agent)

//handles for driver, monitor and sequencer

apb_driver driver;
apb_monitor monitor;
apb_sequencer sequencer;

//handle for agent config
apb_agent_config apb_cfg;


//=====================================================
//Standard methods
//=====================================================

extern function new(string name="apb_agent", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass


//=====================================================
//Function new
//=====================================================

function apb_agent::new(string name = "apb_agent", uvm_component parent);
super.new(name, parent);

endfunction


//=====================================================
//Build phase
//=====================================================

function void apb_agent::build_phase(uvm_phase phase);

    super.build_phase(phase);

        if(!uvm_config_db#(apb_agent_config)::get(this,"","apb_agent_config",apb_cfg))
	        `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")

		    monitor = apb_monitor::type_id::create("monitor",this);
		        if(apb_cfg.is_active==UVM_ACTIVE) begin
			    
			            driver = apb_driver::type_id::create("driver",this);
				            sequencer = apb_sequencer::type_id::create("sequencer",this);
					        
						    end
						    endfunction


						    //=====================================================
						    //Connect phase
						    //=====================================================

						    function void apb_agent::connect_phase(uvm_phase phase);

						        super.connect_phase(phase);
							    if(apb_cfg.is_active==UVM_ACTIVE) begin
							            driver.seq_item_port.connect(sequencer.seq_item_export);
								        end

									endfunction
