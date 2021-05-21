//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

// extend router_rd_agent_config fro uvm_object
class router_rd_agent_config extends uvm_object;


  // UVM Factory Registration Macro
  `uvm_object_utils(router_rd_agent_config)

  // Declare the virtual interface handle "vif"
  virtual router_if vif;

  //------------------------------------------
  // Data Members
  //------------------------------------------
  // Is the agent active or passive
  uvm_active_passive_enum is_active = UVM_ACTIVE;

  // Declare the mon_rcvd_xtn_cnt as static int and initialize it to zero  
  static int mon_rcvd_xtn_cnt = 0;

  // Declare the drv_data_sent_cnt as static int and initialize it to zero 
  static int drv_data_sent_cnt = 0;


  //------------------------------------------
  // Methods
  //------------------------------------------

  extern function new(string name = "router_rd_agent_config");
endclass

function router_rd_agent_config::new(string name = "router_rd_agent_config");
  super.new(name);
endfunction



