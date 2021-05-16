class axi_slave_monitor extends uvm_monitor;

`uvm_component_utils(axi_slave_monitor)

//declaration of virtual interface handle
virtual axi_if.S_MON_MP vif;

//declare handlee forr agt config
axi_slave_agent_config m_cfg;

//declaration of TLM port for connecting with scoreboard
uvm_analysis_port #(axi_xtn)monitor_port;

axi_xtn xtn;

int w_len[$], r_len[$];

semaphore sem = new();
semaphore sem1 = new();
semaphore sem2 = new();
semaphore sem3 = new();
semaphore sem4 = new();

axi_xtn q1[$], q2[$], q3[$], q4[$], q5[$];

//Standard method declaration
extern function new(string name="axi_slave_monitor", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_data();
extern task collect_awaddr(axi_xtn xtn);
extern task collect_wdata(axi_xtn xtn);
extern task collect_bresp(axi_xtn xtn);
extern task collect_araddr(axi_xtn xtn);
extern task collect_rdata(axi_xtn xtn);

endclass


//new() constructor method
function axi_slave_monitor::new(string name="axi_slave_monitor", uvm_component parent);
super.new(name, parent);
monitor_port=new("monitor_port",this);
endfunction

//Build phase method
function void axi_slave_monitor::build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db #(axi_slave_agent_config)::get(this,"","axi_slave_agent_config",m_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")

endfunction


//connect phase method
function void axi_slave_monitor::connect_phase(uvm_phase phase);
super.connect_phase(phase);
	vif = m_cfg.vif;
endfunction


task axi_slave_monitor::run_phase(uvm_phase phase);
begin
xtn = axi_xtn::type_id::create("xtn");


//forever
//	collect_data();
end
endtask


task axi_slave_monitor::collect_data();

//axi_xtn xtn;

xtn = axi_xtn::type_id::create("xtn");

q1.push_back(xtn);
q2.push_back(xtn);
q3.push_back(xtn);
q4.push_back(xtn);
q5.push_back(xtn);

fork


begin

collect_awaddr(q1.pop_front); //20 ns

sem.put(2);
end


begin
sem.get(2);
//sem2.get(1);

collect_wdata(q2.pop_front); //180 ns

//sem2.put(1);
sem1.put(2);
end



begin
sem1.get(2);

collect_bresp(q3.pop_front);  //20 
sem2.put(2);
end


begin
sem2.get(2);
collect_araddr(q4.pop_front); //#####  PENDING  #########
sem3.put(2);

end

begin
sem3.get(2);
//sem4.get(1);
collect_rdata(q5.pop_front); //#####  PENDING  #########
//sem4.put(1);

end

join_any


`uvm_info("axi_slave_monitor",$sformatf("printing from Slave monitor \n %s",xtn.sprint()),UVM_LOW);
monitor_port.write(xtn);

endtask


task axi_slave_monitor::collect_awaddr(axi_xtn xtn);

@(vif.s_monitor_cb);
wait(vif.s_monitor_cb.awvalid && vif.s_monitor_cb.awready)

w_len.push_back(vif.s_monitor_cb.awlen);
xtn.awlen = vif.s_monitor_cb.awlen;
xtn.awaddr = vif.s_monitor_cb.awaddr;
xtn.awsize = vif.s_monitor_cb.awsize;
xtn.awburst = vif.s_monitor_cb.awburst;

repeat(($random)%5) @(vif.s_monitor_cb);

endtask


task axi_slave_monitor::collect_wdata(axi_xtn xtn);

int burst_len;

burst_len = w_len.pop_front +1;
//xtn.wdata = new[burst_len];
xtn.wstrb = new[burst_len];

foreach(xtn.wdata[i]) begin

wait(vif.s_monitor_cb.wready && vif.s_monitor_cb.wvalid)
xtn.wstrb[i] = vif.s_monitor_cb.wstrb;
 
 if(xtn.wstrb[i] == 4'b0001)
xtn.wdata[i] = vif.s_monitor_cb.wdata[7:0];

if(xtn.wstrb[i] == 4'b0010)
xtn.wdata[i] = vif.s_monitor_cb.wdata[15:8];

if(xtn.wstrb[i] == 4'b0100)
xtn.wdata[i] = vif.s_monitor_cb.wdata[23:16];

if(xtn.wstrb[i] == 4'b1000)
xtn.wdata[i] = vif.s_monitor_cb.wdata[31:24];

repeat(($random)%3) @(vif.s_monitor_cb);
xtn.print();
//`uvm_info(get_type_name, $sformatf("PRinting from SLAVE MONITOR WDATA TASK \n %s",xtn.print()),UVM_LOW)
//$display("WDATA VALUES: %0d",xtn.wdata[i]);
end

endtask


//response task pending 

task axi_slave_monitor::collect_bresp(axi_xtn xtn);

wait(vif.s_monitor_cb.bvalid && vif.s_monitor_cb.bready)
//if(vif.s_monitor_cb.bid)
xtn.bresp = vif.s_monitor_cb.bresp;
@(vif.s_monitor_cb);

repeat(($random)%7) @(vif.s_monitor_cb);
 
endtask



task axi_slave_monitor::collect_araddr(axi_xtn xtn);

@(vif.s_monitor_cb);
wait(vif.s_monitor_cb.arvalid && vif.s_monitor_cb.arready)

xtn.arlen = vif.s_monitor_cb.arlen;
r_len.push_back(vif.s_monitor_cb.arlen);

xtn.araddr = vif.s_monitor_cb.araddr;
xtn.arsize = vif.s_monitor_cb.arsize;
xtn.arburst = vif.s_monitor_cb.arburst;

repeat(($random)%5) @(vif.s_monitor_cb);

endtask


task axi_slave_monitor::collect_rdata(axi_xtn xtn);
int j;
int burst_len;

burst_len = r_len.pop_front +1;
xtn.rdata = new[burst_len];

foreach(xtn.rdata[i])begin
wait(vif.s_monitor_cb.rready && vif.s_monitor_cb.rvalid)
xtn.rdata[i] = vif.s_monitor_cb.rdata;
xtn.rresp = vif.s_monitor_cb.rresp;

repeat(($random)%3) @(vif.s_monitor_cb);

end

endtask
