class apb_monitor extends uvm_monitor;

`uvm_component_utils(apb_monitor)

apb_xtn xtn;

//handle for apb config
apb_agent_config apb_cfg;

//handle for virtual interface
virtual bridge_if.APB_MON_MP vif;

uvm_analysis_port #(apb_xtn)monitor_port;

//Standard Methods
extern function new(string name = "apb_monitor", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_data();
    
    endclass


    function apb_monitor::new(string name = "apb_monitor", uvm_component parent);
    super.new(name, parent);
        monitor_port=new("monitor_port",this);

    endfunction


    function void apb_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(apb_agent_config)::get(this,"","apb_agent_config",apb_cfg))
            `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
	    
	    endfunction

	    function void apb_monitor::connect_phase(uvm_phase phase);
	    super.connect_phase(phase);
	    vif = apb_cfg.vif;

	    endfunction

	    task apb_monitor::run_phase(uvm_phase phase);
	    super.run_phase(phase);
	    
        xtn = apb_xtn::type_id::create("xtn");

        forever begin
            collect_data();
        end

	    endtask 


    task apb_monitor::collect_data();

        @(vif.apb_monitor_cb);
        if(vif.apb_monitor_cb.Pwrite==0) begin
           // xtn.Haddr = vif.apb_monitor_cb.Haddr;
            xtn.Paddr = vif.apb_monitor_cb.Paddr;
            xtn.Pwdata = vif.apb_monitor_cb.Pwdata;
            end
        else
            xtn.Prdata = vif.apb_monitor_cb.Prdata;

    //`uvm_info("APB_MONITOR",$sformatf("Printing from the APB_MONITOR \n %s",xtn.sprint()),UVM_LOW);
    monitor_port.write(xtn);
    endtask

        