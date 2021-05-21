//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

class router_rd_monitor extends uvm_monitor;

`uvm_component_utils(router_rd_monitor)

//virtual interface
virtual router_if.RMON_MP vif;

//m_cfg configuration
router_rd_agent_config m_cfg;

// TLM port
uvm_analysis_port#(read_xtn) monitor_port;

//------------------------------------------
// Methods
//------------------------------------------
extern function new(string name = "router_rd_monitor", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
//extern function void report_phase(uvm_phase phase);
extern task collect_data();

endclass


//-----------------  constructor new method  -------------------//
	function router_rd_monitor::new(string name = "router_rd_monitor", uvm_component parent);
	super.new(name, parent);	
        monitor_port = new("monitor_port", this);
  	endfunction

//-----------------  build() phase method  -------------------//
 	function void router_rd_monitor::build_phase(uvm_phase phase);
	// call super.build_phase(phase);
          super.build_phase(phase);
	
	if(!uvm_config_db#(router_rd_agent_config)::get(this,"","router_rd_agent_config",m_cfg))
	`uvm_fatal("READ MONITOR","Cannot get the config from uvm-config_db, have you set it -_-")

	endfunction
	

//-----------------  connect() phase method  -------------------//
 	function void router_rd_monitor::connect_phase(uvm_phase phase);
          super.connect_phase(phase);
	    
	  vif = m_cfg.vif;
$display("monitor   %p",vif);
        
	endfunction


//-----------------  run() phase method  -------------------//
	task router_rd_monitor::run_phase(uvm_phase phase);
	
	forever begin

	collect_data();


	end
	endtask

//--------------- collect_data() task  -------------------//

task router_rd_monitor::collect_data();

read_xtn xtn;

xtn = read_xtn::type_id::create("xtn");



//@(vif.read_monitor_cb);

wait(vif.read_monitor_cb.read_enb)
@(vif.read_monitor_cb);
$display("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$",,,,,,vif.read_monitor_cb.read_enb);
xtn.header = vif.read_monitor_cb.data_out;

xtn.payload = new[xtn.header[7:2]];
 @(vif.read_monitor_cb);

foreach(xtn.payload[i])
begin
xtn.payload[i] = vif.read_monitor_cb.data_out;
@(vif.read_monitor_cb);
end

xtn.parity = vif.read_monitor_cb.data_out;
if(xtn.payload.size != 0)
begin
`uvm_info("ROUTER_RD_MONITOR",$sformatf("printing from Read Monitor \n %s", xtn.sprint()),UVM_LOW)

//sending read packet to scoreboard
monitor_port.write(xtn);


end

endtask


