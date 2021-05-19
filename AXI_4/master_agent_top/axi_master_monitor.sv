class axi_master_monitor extends uvm_monitor;

`uvm_component_utils(axi_master_monitor)

//declaration of virtual interface handle
virtual axi_if.M_MON_MP vif;

//declare handlee forr agt config
axi_master_agent_config m_cfg;

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
extern function new(string name="axi_master_monitor", uvm_component parent);
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
function axi_master_monitor::new(string name="axi_master_monitor", uvm_component parent);
super.new(name, parent);
monitor_port=new("monitor_port",this);
endfunction

//Build phase method
function void axi_master_monitor::build_phase(uvm_phase phase);
super.build_phase(phase);

if(!uvm_config_db #(axi_master_agent_config)::get(this,"","axi_master_agent_config",m_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
	
endfunction


//connect phase method
function void axi_master_monitor::connect_phase(uvm_phase phase);
super.connect_phase(phase);
    vif = m_cfg.vif;

endfunction


task axi_master_monitor::run_phase(uvm_phase phase);

xtn = axi_xtn::type_id::create("xtn");

forever
collect_data();
endtask


task axi_master_monitor::collect_data();

axi_xtn xtn;
xtn = axi_xtn::type_id::create("xtn");

q1.push_back(xtn);
q2.push_back(xtn);
q3.push_back(xtn);
q4.push_back(xtn);
q5.push_back(xtn);


fork
begin

collect_awaddr(q1.pop_front); //20 ns
//$display("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");

sem.put(2);
end
//$display("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");


begin
sem.get(2);
//sem2.get(1); //old logic

collect_wdata(q2.pop_front); //180 ns
//sem2.put(1); //old logic
sem1.put(2);
end



begin
sem1.get(2);

collect_bresp(q3.pop_front);  //20 
sem2.put(2); ///new logic
end

begin
sem2.get(2); //new logic

collect_araddr(q4.pop_front); //#####  PENDING  #########
sem3.put(2);
$display("DDDDDDDDDDDDDDDD");

end

begin
sem3.get(2);
$display("DDDDDDDDDDDDDDDD");
//sem4.get(1);
collect_rdata(q5.pop_front); //#####  PENDING  #########
//sem4.put(1);

end

join_any

`uvm_info("axi_master_monitor",$sformatf("printing from MASTER MONITOR write data \n %s",xtn.sprint()),UVM_LOW)

monitor_port.write(xtn);

endtask


task axi_master_monitor::collect_awaddr(axi_xtn xtn);

@(vif.m_monitor_cb);
wait(vif.m_monitor_cb.awvalid && vif.m_monitor_cb.awready)

w_len.push_back(vif.m_monitor_cb.awlen);
xtn.awlen = vif.m_monitor_cb.awlen;
xtn.awaddr = vif.m_monitor_cb.awaddr;
xtn.awsize = vif.m_monitor_cb.awsize;
xtn.awburst = vif.m_monitor_cb.awburst;

repeat(($random)%5) @(vif.m_monitor_cb);

endtask


task axi_master_monitor::collect_wdata(axi_xtn xtn);

int burst_len;
burst_len = w_len.pop_front +1;
xtn.wdata = new[burst_len];
xtn.wstrb = new[burst_len];
//$display("=================master write data");

//@(vif.m_monitor_cb);
//$display($time,,,,,"burst_length = ",burst_len,,,,xtn.wstrb.size);



foreach(xtn.wdata[i]) begin
wait(vif.m_monitor_cb.wready && vif.m_monitor_cb.wvalid)
@(vif.m_monitor_cb);
xtn.wstrb[i] = vif.m_monitor_cb.wstrb;
xtn.wdata[i] = vif.m_monitor_cb.wdata;
$display("%d %d",i,xtn.wdata[i]);
/*
$display("MASTER MONITOR____________WREADY = %0b, WVALID = %0b", vif.m_monitor_cb.wready, vif.m_monitor_cb.wvalid);

xtn.wstrb[i] = vif.m_monitor_cb.wstrb;
$display(xtn.wstrb[i]);

xtn.wdata[i] = vif.m_monitor_cb.wdata;
$display(xtn.wdata[i]);
*/

/*

if(xtn.wstrb[i] == 4'b0001)
xtn.wdata[i] = vif.m_monitor_cb.wdata[7:0];

if(xtn.wstrb[i] == 4'b0010)
xtn.wdata[i] = vif.m_monitor_cb.wdata[15:8];

if(xtn.wstrb[i] == 4'b0100)
xtn.wdata[i] = vif.m_monitor_cb.wdata[23:16];

if(xtn.wstrb[i] == 4'b1000)
xtn.wdata[i] = vif.m_monitor_cb.wdata[31:24];

if(xtn.wstrb[i]==4'b0011)
xtn.wdata[i] = vif.m_monitor_cb.wdata;

if(xtn.wstrb[i]==4'b1100)
xtn.wdata[i] = vif.m_monitor_cb.wdata;

if(xtn.wstrb[i]==4'b1111)
xtn.wdata[i] = vif.m_monitor_cb.wdata;

*/

//repeat(3) 
@(vif.m_monitor_cb);   //Keeping the delay of 3ns prints the uvm_info for wdata. DONT change it until enitrely sure about the reason.
end

`uvm_info("axi_master_monitor",$sformatf("printing from MASTER MONITOR write data \n %s",xtn.sprint()),UVM_LOW)
endtask



//response task pending 

task axi_master_monitor::collect_bresp(axi_xtn xtn);
$display("Response");
wait(vif.m_monitor_cb.bvalid && vif.m_monitor_cb.bready)

//@(vif.m_monitor_cb);
//xtn.bresp = vif.m_monitor_cb.bresp;
//@(vif.m_monitor_cb);

repeat(7) @(vif.m_monitor_cb);
 xtn.bresp = vif.m_monitor_cb.bresp;
$display(xtn.bresp);
endtask



task axi_master_monitor::collect_araddr(axi_xtn xtn);

@(vif.m_monitor_cb);
wait(vif.m_monitor_cb.arvalid && vif.m_monitor_cb.arready)
$display("############******#################*##########*#");
xtn.arlen = vif.m_monitor_cb.arlen;
r_len.push_back(vif.m_monitor_cb.arlen);

xtn.araddr = vif.m_monitor_cb.araddr;
xtn.arsize = vif.m_monitor_cb.arsize;
xtn.arburst = vif.m_monitor_cb.arburst;

repeat(($random)%2) @(vif.m_monitor_cb);

endtask


task axi_master_monitor::collect_rdata(axi_xtn xtn);
int j;
int burst_len;
$display("CCCCCCCCCCCCCCCCCCCCCCCC");

burst_len = r_len.pop_front +1;
xtn.rdata = new[burst_len];
$display("CCCCCCCCCCCCCCCCCCCCCCCC");

foreach(xtn.rdata[i])begin
wait(vif.m_monitor_cb.rready && vif.m_monitor_cb.rvalid)
xtn.rdata[i] = vif.m_monitor_cb.rdata;
$display("CCCCCCCCCCCCCCCCCCCCCCCC");
$display(xtn.rdata[i]);
xtn.rresp = vif.m_monitor_cb.rresp;

repeat(($random)%3) @(vif.m_monitor_cb);
end

endtask
