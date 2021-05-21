//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

class router_rd_driver extends uvm_driver#(read_xtn);

//factory registration
`uvm_component_utils(router_rd_driver)

virtual router_if.RDR_MP vif;
router_rd_agent_config m_cfg;

//------------------------------------------
// Methods
//------------------------------------------

extern function new(string name = "router_rd_driver",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task send_to_dut(read_xtn xtn);

endclass


//-----------------  constructor new method  -------------------//

function router_rd_driver::new(string name="router_rd_driver",uvm_component parent);

super.new(name,parent);

endfunction

//----------------- BUILD PHASE  -------------------//

function void router_rd_driver::build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db#(router_rd_agent_config)::get(this,"","router_rd_agent_config",m_cfg))
`uvm_fatal("RD_DRIVER","Cannot get the config from uvm-config-db, have yu set it")
		//	$display("gggggggggggggggggggggggggggggggggggggggggggggggg %p",m_cfg);

endfunction


//----------------- CONNECT PHASE  -------------------//

function void router_rd_driver::connect_phase(uvm_phase phase);
super.connect_phase(phase);

vif = m_cfg.vif;
$display("%p",vif);

endfunction


//----------------- RUN_PHASE  -------------------//

task router_rd_driver::run_phase(uvm_phase phase);
forever begin
seq_item_port.get_next_item(req);
//$display("&&&&&&&&&&&&&&&&&&&&&46545455545454554&&&&&&&&&&&&");

send_to_dut(req);
seq_item_port.item_done();
end

endtask


//----------------- SEND TO DUT TASK  -------------------//

task router_rd_driver :: send_to_dut(read_xtn xtn);

fork

begin
@(vif.read_driver_cb);

wait(vif.read_driver_cb.vld_out)
//$display("vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv%p",xtn.no_of_cycles);

repeat(xtn.no_of_cycles) @(vif.read_driver_cb);
vif.read_driver_cb.read_enb <= 1'd1;

wait(~vif.read_driver_cb.vld_out)
vif.read_driver_cb.read_enb <= 1'd0;
//`uvm_info("ROUTER_RD_MONITOR",$sformatf("printing from Read Driver\n %s", xtn.sprint()),UVM_LOW)
xtn.print();
end

//WATCH DOG TIMER
begin
repeat(100) @(vif.read_driver_cb);
end

join_any
disable fork;
endtask
