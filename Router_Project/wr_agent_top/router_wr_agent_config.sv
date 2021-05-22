//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

class router_wr_agent_config extends uvm_object;

    `uvm_object_utils(router_wr_agent_config)

    virtual router_if vif;

//------------------------------------------
// Data Members
//------------------------------------------
    uvm_active_passive_enum is_active = UVM_ACTIVE;
    static int mon_rcvd_xtn_cnt = 0;
    static int drv_data_sent_cnt = 0;


//------------------------------------------
// Methods
//------------------------------------------
    extern function new(string name = "router_wr_agent_config");

endclass

//-----------------  constructor new method  -------------------//
function router_wr_agent_config::new(string name = "router_wr_agent_config");
  super.new(name);
endfunction

 


