//extending from uvm_driver

class router_wr_driver extends uvm_driver#(write_xtn);

    `uvm_component_utils(router_wr_driver)

    virtual router_if.WDR_MP vif;
    router_wr_agent_config m_cfg;


    extern function new(string name = "router_wr_driver",uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern task send_to_dut(write_xtn xtn);

endclass



function router_wr_driver::new(string name="router_wr_driver",uvm_component parent);
    super.new(name,parent);
endfunction



//BUILD PHASE

function void router_wr_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);

	if(!uvm_config_db #(router_wr_agent_config)::get(this,"","router_wr_agent_config",m_cfg))
	    `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 

endfunction



//CONNECT PHASE

function void router_wr_driver::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif = m_cfg.vif;
endfunction


//RUN_PHASE

task router_wr_driver:: run_phase(uvm_phase phase);

    super.run_phase(phase);

    @(vif.write_driver_cb);
    vif.write_driver_cb.resetn <= 1'b0;
    @(vif.write_driver_cb);
    vif.write_driver_cb.resetn <= 1'b1;

    forever begin
        seq_item_port.get_next_item(req);
        send_to_dut(req);
        seq_item_port.item_done();
    end
endtask


task router_wr_driver::send_to_dut(write_xtn xtn);

    @(vif.write_driver_cb);
    wait(~vif.write_driver_cb.busy)
    vif.write_driver_cb.pkt_valid <= 1'b1;
    vif.write_driver_cb.data_in <= xtn.header;

    @(vif.write_driver_cb);
    foreach(xtn.payload[i]) begin
        wait(~vif.write_driver_cb.busy)
        vif.write_driver_cb.data_in <= xtn.payload[i];

        @(vif.write_driver_cb);
    end
    
    wait(~vif.write_driver_cb.busy)

    vif.write_driver_cb.pkt_valid <= 1'b0;
    vif.write_driver_cb.data_in <= xtn.parity;
    //@(vif.write_driver_cb);
    `uvm_info("ROUTER_WR_DRIVER",$sformatf("printing from Write Driver \n %s", xtn.sprint()),UVM_LOW) 

endtask

