//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

class router_env_config extends uvm_object;

//------------------------------------------
// Data Members
//------------------------------------------
    bit has_wagent = 1;
    bit has_ragent = 1;
    bit has_virtual_sequencer = 1;
    bit has_scoreboard = 1;
    router_wr_agent_config m_wr_cfg;
    router_rd_agent_config m_rd_cfg[];
    int no_of_read_agents = 3;

    `uvm_object_utils(router_env_config)

//------------------------------------------
// Methods
//------------------------------------------
    extern function new(string name = "router_env_config");

endclass

//-----------------  constructor new method  -------------------//

function router_env_config::new(string name = "router_env_config");
  super.new(name);
endfunction




