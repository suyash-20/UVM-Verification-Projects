class ahb_monitor extends uvm_monitor;

`uvm_component_utils(ahb_monitor)

bridge_xtn xtn;

//handle for ahb config
ahb_agent_config ahb_cfg;

//handle for virtual interface
virtual bridge_if.AHB_MON_MP vif;

uvm_analysis_port #(bridge_xtn)monitor_port;


//=====================================================
//Standard methods
//=====================================================
extern function new(string name = "ahb_monitor", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_data();
    
    endclass


    //=====================================================
    //Function new
    //=====================================================

    function ahb_monitor::new(string name = "ahb_monitor", uvm_component parent);
    super.new(name, parent);
            monitor_port=new("monitor_port",this);

	    endfunction


	    //=====================================================
	    //Build phase
	    //=====================================================

	    function void ahb_monitor::build_phase(uvm_phase phase);
	    super.build_phase(phase);
	    if(!uvm_config_db #(ahb_agent_config)::get(this,"","ahb_agent_config",ahb_cfg))
	            `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
		    endfunction


		    //=====================================================
		    //Connect phase
		    //=====================================================

		    function void ahb_monitor::connect_phase(uvm_phase phase);
		    super.connect_phase(phase);

		    vif = ahb_cfg.vif;

		    endfunction


		    //=====================================================
		    //Run phase
		    //=====================================================

		    task ahb_monitor::run_phase(uvm_phase phase);
		    super.run_phase(phase);

		    xtn = bridge_xtn::type_id::create("xtn");

		    forever begin
		    collect_data();
		    end

		    endtask 


		    //=====================================================
		    //Collect data task
		    //=====================================================

		    task ahb_monitor::collect_data();

		    @(vif.ahb_monitor_cb);
		    
			wait(vif.ahb_monitor_cb.Hreadyout&&(vif.ahb_monitor_cb.Htrans==2'b10 || vif.ahb_monitor_cb.Htrans==2'b11))
			xtn.Haddr = vif.ahb_monitor_cb.Haddr;
		    xtn.Hwrite = vif.ahb_monitor_cb.Hwrite;
		    xtn.Hsize = vif.ahb_monitor_cb.Hsize;
			//xtn.Htrans = vif.ahb_monitor_cb.Htrans;
			//xtn.Hburst = vif.ahb_monitor_cb.Hburst;
			
			@(vif.ahb_monitor_cb);
		    wait(vif.ahb_monitor_cb.Hreadyout)
			//if(xtn.Hwrite==1) 
		    xtn.Hwdata = vif.ahb_monitor_cb.Hwdata;
			//else
		   // xtn.Hrdata = vif.ahb_monitor_cb.Hrdata;

		   //`uvm_info("AHB_MONITOR",$sformatf("Printing from the AHB_MONITOR \n %s",xtn.sprint()),UVM_LOW);
			monitor_port.write(xtn);
			    endtask

