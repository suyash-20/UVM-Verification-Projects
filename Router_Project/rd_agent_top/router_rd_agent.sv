//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

   // Extend router_rd_agent from uvm_agent
class router_rd_agent extends uvm_agent;

   // Factory Registration
`uvm_component_utils(router_rd_agent)

   // Declare handle for configuration object as m_cfg 
       router_rd_agent_config m_cfg;

   // Declare handles of router_rd_monitor,router_rd_sequencer and router_rd_driver

router_rd_monitor monitor;
router_rd_sequencer m_sequencer;
router_rd_driver driver;


//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
  extern function new(string name = "router_rd_agent", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);

//Add endclass : router_rd_agent

endclass

//-----------------  constructor new method  -------------------//

       function router_rd_agent::new(string name = "router_rd_agent", uvm_component parent = null);
        
super.new(name,parent);
       endfunction
     
  
//-----------------  build() phase method  -------------------//
        function void router_rd_agent::build_phase(uvm_phase phase);
 	
//get configuration object from the database using uvm_config_db


// Call parent build phase               
 super.build_phase(phase);

  if(!uvm_config_db #(router_rd_agent_config)::get(this,"","router_rd_agent_config",m_cfg))  //from router_rd_agent_config
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
		
 // Create router_rd_monitor instance
 monitor= router_rd_monitor :: type_id :: create("monitor",this);

 // If config paroutereter is_active=UVM_ACTIVE, create router_rd_driver and router_rd_sequencer instances

if(m_cfg.is_active==UVM_ACTIVE) begin

driver = router_rd_driver :: type_id :: create("driver", this);

m_sequencer= router_rd_sequencer :: type_id :: create("m_sequencer", this);
end

	endfunction

      
//-----------------  connect() phase method  -------------------//
	function void router_rd_agent::connect_phase(uvm_phase phase);
	
	//If config parameter is_active=UVM_ACTIVE, 
        //connect driver(TLM seq_item_port) and m_sequencer(TLM seq_item_export)

super.connect_phase(phase);

driver.seq_item_port.connect(m_sequencer.seq_item_export);


	endfunction
   

