class apb_driver extends uvm_driver#(apb_xtn);

`uvm_component_utils(apb_driver)

apb_xtn xtn;

//handle for apb config
apb_agent_config apb_cfg;

//handle for virtual interface
virtual bridge_if.APB_DRV_MP vif;

//=====================================================
//Standard methods
//=====================================================

extern function new(string name = "apb_driver", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task drive_task(apb_xtn xtn);
    
    endclass

    //=====================================================
    //Function new
    //=====================================================

    function apb_driver::new(string name = "apb_driver", uvm_component parent);
    super.new(name, parent);

    endfunction

    //=====================================================
    //Build phase
    //=====================================================

    function void apb_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(apb_agent_config)::get(this,"","apb_agent_config",apb_cfg))
            `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
	    endfunction

	    //=====================================================
	    //Connect phase
	    //=====================================================

	    function void apb_driver::connect_phase(uvm_phase phase);
	    super.connect_phase(phase);
	    vif = apb_cfg.vif;

	    endfunction


	    //=====================================================
	    //Run phase
	    //=====================================================

	    task apb_driver::run_phase(uvm_phase phase);
	    super.run_phase(phase);
	    
	    forever begin
	    seq_item_port.get_next_item(req);
		$display("INSIDE FOREVER");
	    drive_task(req);
		$display("AFTER DRIVE TASK");
	    seq_item_port.item_done();
	    end

	    endtask

//=====================================================
//Drive Task
//=====================================================

task apb_driver::drive_task(apb_xtn xtn);
int temp_data;

@(vif.apb_driver_cb);

wait(vif.apb_driver_cb.Pselx!=0)

if(vif.apb_driver_cb.Pwrite==0)
vif.apb_driver_cb.Prdata <= $urandom;
temp_data = vif.apb_driver_cb.Prdata;
$display("================================================================ VALUE OF PRDATA IS: %d ================================================================", temp_data);
//wait(vif.apb_driver_cb.Penable)

`uvm_info("APB_DRIVER",$sformatf("Printing from the APB_DRIVER \n %s",xtn.sprint()),UVM_LOW);

endtask

