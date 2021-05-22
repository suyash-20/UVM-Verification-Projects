//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

class router_wr_agent extends uvm_agent;

    `uvm_component_utils(router_wr_agent)

    router_wr_agent_config m_cfg;

    router_wr_monitor monitor;
    router_wr_sequencer m_sequencer;
    router_wr_driver driver;


//------------------------------------------
// METHODS
//------------------------------------------

  extern function new(string name = "router_wr_agent", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);

endclass

//-----------------  constructor new method  -------------------//

function router_wr_agent::new(string name = "router_wr_agent", uvm_component parent = null);   
    super.new(name,parent);
endfunction
     
  
//-----------------  build() phase method  -------------------//
function void router_wr_agent::build_phase(uvm_phase phase);
 	

    super.build_phase(phase);

    if(!uvm_config_db #(router_wr_agent_config)::get(this,"","router_wr_agent_config",m_cfg))
        `uvm_fatal("CONFIG","!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!cannot get() m_cfg from uvm_config_db. Have you set() it?") 

    monitor= router_wr_monitor :: type_id :: create("monitor",this);

    if(m_cfg.is_active==UVM_ACTIVE) begin
        driver = router_wr_driver :: type_id :: create("driver", this);
        m_sequencer= router_wr_sequencer :: type_id :: create("m_sequencer", this);
    end

endfunction

      
//-----------------  connect() phase method  -------------------//
function void router_wr_agent::connect_phase(uvm_phase phase);
	

    super.connect_phase(phase);
        if(m_cfg.is_active==UVM_ACTIVE) begin
            driver.seq_item_port.connect(m_sequencer.seq_item_export);
        end

endfunction
   

   




