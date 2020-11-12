class ahb_driver extends uvm_driver#(bridge_xtn);

`uvm_component_utils(ahb_driver)

bridge_xtn xtn;

//handle for ahb config
ahb_agent_config ahb_cfg;

//handle for virtual interface
virtual bridge_if.AHB_DRV_MP vif;

//=====================================================
//Standard methods
//=====================================================

extern function new(string name = "ahb_driver", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task drive_task(bridge_xtn xtn);
    
    endclass


    //=====================================================
    //Function new
    //=====================================================

    function ahb_driver::new(string name = "ahb_driver", uvm_component parent);
    super.new(name, parent);

    endfunction


    //=====================================================
    //Build phase
    //=====================================================

    function void ahb_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);
        if(!uvm_config_db #(ahb_agent_config)::get(this,"","ahb_agent_config",ahb_cfg))
	 `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
    endfunction

	//=====================================================
	//Connect phase
	//=====================================================

	function void ahb_driver::connect_phase(uvm_phase phase);
	super.connect_phase(phase);

	vif = ahb_cfg.vif;
	endfunction


	//=====================================================
	//Run phase
	//=====================================================

	task ahb_driver::run_phase(uvm_phase phase);
	super.run_phase(phase);

	@(vif.ahb_driver_cb);
	vif.ahb_driver_cb.Hresetn <= 1'b0;
	@(vif.ahb_driver_cb);
	vif.ahb_driver_cb.Hresetn <= 1'b1;
	$display("AHB DRIVER________________________________________________________________________________-");

	forever begin
	seq_item_port.get_next_item(req);
	drive_task(req);
	seq_item_port.item_done();
	end
	endtask

	 task ahb_driver::drive_task(bridge_xtn xtn);
	//	 @(vif.ahb_driver_cb); //further delay of one cycle, since output skew is already mentioned
												       
		 vif.ahb_driver_cb.Haddr<=xtn.Haddr;
		 vif.ahb_driver_cb.Hreadyin<=1;
		vif.ahb_driver_cb.Htrans<=xtn.Htrans;
		vif.ahb_driver_cb.Hsize<=xtn.Hsize;
		vif.ahb_driver_cb.Hwrite<= xtn.Hwrite;
	     wait(vif.ahb_driver_cb.Hreadyout)
	      vif.ahb_driver_cb.Hwdata<= xtn.Hwdata;

	       `uvm_info("AHB_DRIVER",$sformatf("Printing from the AHB_DRIVER \n %s",xtn.sprint()),UVM_LOW);

	endtask

