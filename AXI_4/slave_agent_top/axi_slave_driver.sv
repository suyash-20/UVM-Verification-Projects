class axi_slave_driver extends uvm_driver#(axi_xtn);

`uvm_component_utils(axi_slave_driver)

//handle for virtual interface
virtual axi_if.S_DRV_MP vif; //virtual declaration IS PENDING | RE-CONFIRM CLOCKING BLOCK NAME
   
//handle for config
axi_slave_agent_config m_cfg;

semaphore sem = new();
semaphore sem1 = new();
semaphore sem2 = new();
semaphore sem3 = new();
semaphore sem4 = new();

//Slave will have queues so as to store awlen, awsize and burst for next address calculation
int w_size[$],burst[$], s_addr[$];

int w_len[$], r_len[$];

axi_xtn q1[$],q2[$], q3[$], q4[$], q5[$]; //, q[$]; for maybe address channel of slave

int mem[int];
int addr[];

//wdata variables
/*
int burst_len;
int burst_size;
int burst_type;
int first_addr;
*/

//Standard Method Declaration
extern function new(string name="axi_slave_driver", uvm_component parent);
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
function axi_slave_driver::new(string name="axi_slave_driver", uvm_component parent);
super.new(name, parent);

endfunction


//build phase method

function void axi_slave_driver::build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db #(axi_slave_agent_config)::get(this,"","axi_slave_agent_config",m_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
	
endfunction


//connect phase method

function void axi_slave_driver::connect_phase(uvm_phase phase);
super.connect_phase(phase);
//assigning local virtual interface handdle to the virtual interface handle from the configuration
vif = m_cfg.vif;

endfunction


task axi_slave_driver::run_phase(uvm_phase phase);

forever begin
seq_item_port.get_next_item(req);  //req = x, req = y
drive_task(req);
#1000;
seq_item_port.item_done();

end

endtask


task axi_slave_driver::drive_task(axi_xtn xtn);

q1.push_back(xtn);
q2.push_back(xtn);
q3.push_back(xtn);
q4.push_back(xtn);
q5.push_back(xtn);

fork

begin
drive_awaddr(q1.pop_back);
sem.put(2);
end

begin
sem.get(2);
//sem2.get(1);
drive_wdata(q2.pop_back);
//sem2.put(1);
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
`uvm_info("axi_slave_driver",$sformatf("printing from Slave Driver \n %s",xtn.sprint()),UVM_LOW);

endtask


task axi_slave_driver::drive_awaddr(axi_xtn xtn);

repeat(($random)%7)@(vif.s_driver_cb);

vif.s_driver_cb.awready <= 1'b1;
@(vif.s_driver_cb);

wait(vif.s_driver_cb.awvalid)
w_len.push_back(vif.s_driver_cb.awlen); // similarly for burst, size and first address
w_size.push_back(vif.s_driver_cb.awsize);
burst.push_back(vif.s_driver_cb.awburst);
s_addr.push_back(vif.s_driver_cb.awaddr); //is the arguement correct?

vif.s_driver_cb.awready <= 1'b0;

endtask


task axi_slave_driver::drive_wdata(axi_xtn xtn);

int burst_len;
int burst_size;
int burst_type;
int first_addr;

burst_len = w_len.pop_front +1;
burst_size = w_size.pop_front +1;
burst_type = burst.pop_front +1;
first_addr = s_addr.pop_front +1;

xtn.wdata = new[burst_len];
//xtn.wstrb = new[burst_len];

addr = new[burst_len];

/*
foreach(addr[i]) begin
addr[i] <= xtn.next_address(burst_len, burst_size, burst_type, first_addr);  //task/function from transaction class to calculate next address
end
*/

foreach(xtn.wdata[i]) begin

//repeat(($random)%2)
repeat(2)@(vif.s_driver_cb);
vif.s_driver_cb.wready<= 1'b1;
wait(vif.s_driver_cb.wvalid)
//$display("SLAVE DRIVER_______WREADY = %0b, WVALID = %0b", vif.s_driver_cb.wready, vif.s_driver_cb.wvalid);

/*
if(wstrb == 4'b0001)
mem[addr[i]] <= vif.s_driver_cb.wdata[7:0];

if(wstrb == 4'b0010)
mem[addr[i]] <= vif.s_driver_cb.wdata[15:8];

if(wstrb == 4'b0100)
mem[addr[i]] <= vif.s_driver_cb.wdata[23:16];

if(wstrb == 4'b1000)
mem[addr[i]] <= vif.s_driver_cb.wdata[31:24];
*/
vif.s_driver_cb.wready<= 1'b0;

end

endtask


//*************TASK RESP SLAVE
task axi_slave_driver::drive_bresp(axi_xtn xtn);

vif.s_driver_cb.bvalid<= 1'b1;
vif.s_driver_cb.bid<= xtn.bid;
vif.s_driver_cb.bresp<=  2'b00; //BRESP == OKAY
@(vif.s_driver_cb); //PENDING 
wait(vif.s_driver_cb.bready)
vif.s_driver_cb.bvalid <= 1'b0;
 
 repeat(($random)%7) @(vif.s_driver_cb);
 
endtask



task axi_slave_driver::drive_araddr(axi_xtn xtn);
`uvm_info("AXI Master","Slave addr",UVM_MEDIUM)
//repeat(($random)%4)@(vif.s_driver_cb);
repeat(3)
vif.s_driver_cb.arready <= 1'b1;
@(vif.s_driver_cb);

wait(vif.s_driver_cb.arvalid)
r_len.push_back(vif.s_driver_cb.arlen);
vif.s_driver_cb.arready <= 1'b0;

endtask


task axi_slave_driver::drive_rdata(axi_xtn xtn);

int j;
int burst_len;

burst_len = r_len.pop_front +1;

for(int i =0; i<burst_len+1;i++) begin

repeat(3)
@(vif.s_driver_cb);
vif.s_driver_cb.rvalid<= 1'b1;
vif.s_driver_cb.rdata <= $random;

vif.s_driver_cb.rresp<= 2'b00; //RRESP == OKAY
vif.s_driver_cb.rlast <= (j == burst_len)? 1'b1:1'b0;

@(vif.s_driver_cb);
wait(vif.s_driver_cb.rready)
vif.s_driver_cb.rvalid<= 1'b0;
vif.s_driver_cb.rlast <= 1'b0;
end
endtask
