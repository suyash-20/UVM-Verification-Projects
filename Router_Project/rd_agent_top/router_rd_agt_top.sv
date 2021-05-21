//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

class router_rd_agt_top extends uvm_env;

`uvm_component_utils(router_rd_agt_top)
 
	
router_rd_agent agnth[];
router_env_config m_cfg;
router_rd_agent_config m_rd_cfg;

//------------------------------------------
// Methods
//------------------------------------------
extern function new(string name = "router_rd_agt_top" , uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass

// constructor new method
   // Define Constructor new() function
   	function router_rd_agt_top::new(string name = "router_rd_agt_top" , uvm_component parent);
		
	super.new(name, parent);
	endfunction

    
//-----------------  build() phase method 
       	function void router_rd_agt_top::build_phase(uvm_phase phase);
     		super.build_phase(phase);
	
 if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",m_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")


agnth = new[m_cfg.no_of_read_agents];
foreach(agnth[i]) begin
if(!uvm_config_db#(router_rd_agent_config)::get(this,$sformatf("agnth[%0d]*",i),"router_rd_agent_config",m_cfg.m_rd_cfg[i]))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")

agnth[i] = router_rd_agent :: type_id :: create($sformatf("agnth[%0d]",i), this);
end
	endfunction


//-----------------  run() phase method
      	task router_rd_agt_top::run_phase(uvm_phase phase);

	
	uvm_top.print_topology();
	
	endtask 
