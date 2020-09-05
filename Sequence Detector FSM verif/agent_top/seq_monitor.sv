class seq_monitor extends uvm_monitor;
`uvm_component_utils(seq_monitor)

//---------vif handle declaration
virtual seq_if.MON_MP vif;

//---------agt config handle
seq_agent_config m_agt_cfg;
trans_xtn xtn;

uvm_analysis_port#(trans_xtn)monitor_port;


//=====================================================
//methods
//=====================================================

extern function new(string name = "seq_monitor", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_data();

endclass


//=====================================================
//Function new
//=====================================================

function seq_monitor::new(string name="seq_monitor", uvm_component parent);
super.new(name, parent);

monitor_port = new("monitor_port", this);

endfunction


//=====================================================
//Build phase
//=====================================================

function void seq_monitor::build_phase(uvm_phase phase);
super.build_phase(phase);

//get the config from agt config
if(!uvm_config_db#(seq_agent_config)::get(this,"","agt_config", m_agt_cfg))
`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
//$display("%p",m_agt_cfg);
endfunction


//=====================================================
//Connect phase
//=====================================================

function void seq_monitor::connect_phase(uvm_phase phase);
super.connect_phase(phase);
vif = m_agt_cfg.vif;
endfunction


//=====================================================
//Run phase
//=====================================================

task seq_monitor::run_phase(uvm_phase phase);
xtn = trans_xtn::type_id::create("xtn");

forever begin
    collect_data();    
end

endtask

task seq_monitor::collect_data();
@(vif.monitor_cb);

xtn.din = vif.monitor_cb.din;
//@(vif.monitor_cb);
xtn.dout = vif.monitor_cb.dout;
//$display("*******************************************************************  %b",vif.monitor_cb.din);

$display("DOUT VALUE MONITORED IS %b",xtn.dout);
//`uvm_info("MONITOR", $sformatf("PRINTING FROM MONITOR\n %s", xtn.sprint()), UVM_LOW);

monitor_port.write(xtn);
//$display("%p", monitor_port);
endtask
