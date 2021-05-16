class axi_master_driver extends uvm_driver#(axi_xtn);

`uvm_component_utils(axi_master_driver)

//handle for virtual interface
virtual axi_if.M_DRV_MP vif; 

//handle for config
axi_master_agent_config m_cfg;

semaphore sem = new();
semaphore sem1 = new();
semaphore sem2 = new();
semaphore sem3 = new();
semaphore sem4 = new();

//queues for write address, data and response channels and pending read channels
axi_xtn q1[$], q2[$], q3[$], q4[$],  q5[$];

int w_len[$], r_len[$];

//Standard Method Declaration
extern function new(string name="axi_master_driver", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

extern task run_phase(uvm_phase phase);

extern task drive_task(axi_xtn xtn);
extern task drive_awaddr(axi_xtn xtn); 
extern task drive_wdata(axi_xtn xtn);
extern task drive_bresp(axi_xtn xtn);
extern task drive_araddr(axi_xtn xtn);
extern task drive_rdata(axi_xtn xtn);

endclass

//new constructor method
function axi_master_driver::new(string name="axi_master_driver", uvm_component parent);
super.new(name, parent);
endfunction


//build phase method

function void axi_master_driver::build_phase(uvm_phase phase);
super.build_phase(phase);

//get the agent config
if(!uvm_config_db #(axi_master_agent_config)::get(this,"","axi_master_agent_config",m_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")


endfunction


//connect phase method

function void axi_master_driver::connect_phase(uvm_phase phase);

super.connect_phase(phase);

//assigning local virtual interface handdle to the virtual interface handle from the configuration
          vif = m_cfg.vif;

endfunction


//run phase method

task axi_master_driver::run_phase(uvm_phase phase);

forever begin
seq_item_port.get_next_item(req);  //req = x, req = y
drive_task(req);
#100;
seq_item_port.item_done();

end

endtask



//-----------DRIVE_TASK------------//


task axi_master_driver::drive_task(axi_xtn xtn);

q1.push_back(xtn);
q2.push_back(xtn);
q3.push_back(xtn);
q4.push_back(xtn);
q5.push_back(xtn);

fork

begin

drive_awaddr(q1.pop_front); //20 ns

sem.put(2);
end


begin
sem.get(2);
//sem4.get(1);

drive_wdata(q2.pop_back); //180 ns

//sem4.put(1);
sem1.put(2);
end


begin
sem1.get(2);

drive_bresp(q3.pop_back);  //20 
sem2.put(2);
end

begin
sem2.get(2);
drive_araddr(q4.pop_front); //#####  PENDING  #########
sem3.put(2);
end

begin

sem3.get(2);
//sem4.get(1);

drive_rdata(q5.pop_front); //#####  PENDING  #########
//sem4.put(1);

end


join_any

`uvm_info("axi_master_driver",$sformatf("printing from Master Driver \n %s",xtn.sprint()),UVM_LOW);

endtask



//***********TASK DRIVE_AWADDR();   #1 MASTER WRITE ADDRESS CHANNEL

task axi_master_driver::drive_awaddr(axi_xtn xtn); //drives valid and control information

vif.m_driver_cb.awvalid <= 1'b1;
vif.m_driver_cb.awaddr <= xtn.awaddr;
vif.m_driver_cb.awsize <= xtn.awsize;
//vif.m_driver_cb.awid <= xtn.awid;
vif.m_driver_cb.awlen <= xtn.awlen;
w_len.push_back(xtn.awlen);

vif.m_driver_cb.awburst <= xtn.awburst;

@(vif.m_driver_cb); //PENDING 
wait(vif.m_driver_cb.awready)
vif.m_driver_cb.awvalid <= 1'b0;

repeat(($random)%5) @(vif.m_driver_cb); //this delay is to wait for some delay until we drive new data


endtask

//***********TASK DRIVE_WDATA();   #1  MASTER WRITE DATA CHANNEL 

task axi_master_driver::drive_wdata(axi_xtn xtn);

int burst_len = w_len.pop_front() + 1'b1;

//xtn.wdata = new[burst_len];
//xtn.wstrb = new[burst_len];

foreach(xtn.wdata[i]) begin
repeat(3)@(vif.m_driver_cb);
vif.m_driver_cb.wvalid <= 1'b1;

vif.m_driver_cb.wdata <= xtn.wdata[i];
/*
$display("###############__MARKER__#############");
$display(xtn.wdata[i]);
$display(vif.m_driver_cb.wdata);
*/

vif.m_driver_cb.wstrb <= xtn.wstrb[i];  //strobe size will be equal to data array which will be equal to BURST LENGTH

if(i == xtn.wdata.size - 1)
	vif.m_driver_cb.wlast <= 1'b1;
else
	vif.m_driver_cb.wlast <= 1'b0;
	
@(vif.m_driver_cb);
//$display("WREADY IS ASSERTED MAYBE");
wait(vif.m_driver_cb.wready)
//$display("WREADY IS ASSERTED MAYBE");
vif.m_driver_cb.wvalid <= 1'b0;

repeat(($random)%7)@(vif.m_driver_cb); //this delay is to wait for some delay until we drive new data

end

endtask


//*************TASK RESP MASTER
task axi_master_driver::drive_bresp(axi_xtn xtn);

vif.m_driver_cb.bready<= 1'b1;

@(vif.m_driver_cb); //PENDING 
wait(vif.m_driver_cb.bvalid)
//vif.m_driver_cb.bready <= 1'b0;

xtn.bresp <= vif.m_driver_cb.bresp;
repeat(($random)%7) @(vif.m_driver_cb);
vif.m_driver_cb.bready <= 1'b0;

endtask



//***********TASK DRIVE_ARADDR();   #1 MASTER READ ADDRESS CHANNEL

task axi_master_driver::drive_araddr(axi_xtn xtn); //drives valid and control information

vif.m_driver_cb.arvalid <= 1'b1;
vif.m_driver_cb.arlen <= xtn.arlen;
r_len.push_back(xtn.arlen);

vif.m_driver_cb.araddr <= xtn.araddr;
vif.m_driver_cb.arsize <= xtn.arsize;
vif.m_driver_cb.arburst <= xtn.arburst;

@(vif.m_driver_cb); //PENDING 
wait(vif.m_driver_cb.arready)
vif.m_driver_cb.arvalid <= 1'b0;

repeat(($random)%5) @(vif.m_driver_cb); //this delay is to wait for some delay until we drive new data

endtask


//***********TASK DRIVE_ARDATA();   #1 MASTER READ DATA CHANNEL

task axi_master_driver::drive_rdata(axi_xtn xtn);

int burst_len;

burst_len = r_len.pop_front+1 ;
xtn.rdata = new[burst_len];

//for(int i =0; i<burst_len;i++) begin
foreach(xtn.wdata[i]) begin

repeat(4)
@(vif.m_driver_cb);
vif.m_driver_cb.rready<= 1'b1;
xtn.rdata[i] = vif.m_driver_cb.rdata;  //Non-blocking assignment to elements of dynamic arrays is not currently supported, hence BA

@(vif.m_driver_cb);
wait(vif.m_driver_cb.rvalid)
vif.m_driver_cb.rready<= 1'b0;
end
endtask


