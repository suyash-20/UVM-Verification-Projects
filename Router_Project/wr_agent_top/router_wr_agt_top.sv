//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------
class router_wr_agt_top extends uvm_env;

    `uvm_component_utils(router_wr_agt_top)

    router_wr_agent agnth;

// METHODS
	extern function new(string name = "router_wr_agt_top" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);

endclass

   // Define Constructor new() function
   	function router_wr_agt_top::new(string name = "router_wr_agt_top" , uvm_component parent);
		
	super.new(name, parent);
	endfunction

    
//-----------------  build() phase method 
    function void router_wr_agt_top::build_phase(uvm_phase phase);
     	
         super.build_phase(phase);
        agnth = router_wr_agent :: type_id :: create("agnth", this);

	endfunction


//-----------------  run() phase method
   	task router_wr_agt_top::run_phase(uvm_phase phase);	
	    uvm_top.print_topology();
	
	endtask 
