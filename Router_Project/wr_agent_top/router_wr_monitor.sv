class router_wr_monitor extends uvm_monitor;

    `uvm_component_utils(router_wr_monitor)

    virtual router_if.WMON_MP vif;
    router_wr_agent_config m_cfg;
    
    uvm_analysis_port #(write_xtn) monitor_port;

    extern function new(string name = "router_wr_monitor", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern task collect_data();

endclass


//-----------------  constructor new method  -------------------//
function router_wr_monitor::new(string name = "router_wr_monitor", uvm_component parent);
    super.new(name, parent);	
    monitor_port = new("monitor_port",this);
endfunction

//-----------------  build() phase method  -------------------//
function void router_wr_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db #(router_wr_agent_config)::get(this,"","router_wr_agent_config",m_cfg))
        `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
endfunction
	

//-----------------  connect() phase method  -------------------//

function void router_wr_monitor::connect_phase(uvm_phase phase);
    super.connect_phase(phase);	  
	vif = m_cfg.vif;
endfunction


//-----------------  run() phase method  -------------------//
task router_wr_monitor::run_phase(uvm_phase phase);
	forever
    	collect_data();
endtask


//---------------collect_data task()------------------//

task router_wr_monitor::collect_data();
	write_xtn xtn;

	xtn = write_xtn::type_id::create("xtn");
	@(vif.write_monitor_cb);
	wait(~vif.write_monitor_cb.busy && vif.write_monitor_cb.pkt_valid)
	xtn.header = vif.write_monitor_cb.data_in;
	
	//PAYLOAD IS DYNAMIC ARRAY

	xtn.payload = new[xtn.header[7:2]];

	@(vif.write_monitor_cb);

	foreach(xtn.payload[i])
	begin
	wait(~vif.write_monitor_cb.busy)

	xtn.payload[i] = vif.write_monitor_cb.data_in;
	@(vif.write_monitor_cb);
	end
	wait(~vif.write_monitor_cb.busy && ~vif.write_monitor_cb.pkt_valid)

	xtn.parity = vif.write_monitor_cb.data_in;
    //@(vif.write_monitor_cb);
    `uvm_info("ROUTER_WR_MONITOR",$sformatf("printing from Write Monitor \n %s", xtn.sprint()),UVM_LOW)

    //sending write packet to the scoreboard
    monitor_port.write(xtn);

endtask
