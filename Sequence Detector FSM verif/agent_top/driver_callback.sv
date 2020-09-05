class driver_callback extends uvm_callback;

`uvm_object_utils(driver_callback)

//---------virtual interface declaration
//virtual seq_if.DRV_MP vif;

//---------agent config handle
//seq_agent_config m_cfg;

//=====================================================
//methods
//=====================================================

extern function new(string name = "driver_callback");
//extern function void build_phase(uvm_phase phase);
//extern function void connect_phase(uvm_phase phase);
virtual task pre_send(); endtask
virtual task post_send(); endtask

endclass


//=====================================================
//Function new
//=====================================================

function driver_callback:: new(string name="driver_callback");
super.new(name);
endfunction

//=====================================================
//Build phase
//=====================================================

/*function void driver_callback::build_phase(uvm_phase phase);
super.build_phase(phase);

//get the config into agt config
//if(!uvm_config_db#(seq_agent_config)::get(this,"","agt_config",m_cfg))
//`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")

endfunction


//=====================================================
//Connect phase
//=====================================================

/*function void seq_driver::connect_phase(uvm_phase phase);
super.connect_phase(phase);

vif = m_cfg.vif;

endfunction


//=====================================================
//Run phase
//=====================================================

task seq_driver::run_phase(uvm_phase phase);
forever begin
    seq_item_port.get_next_item(req);
    send_to_dut(req);
    seq_item_port.item_done();
end
endtask

task seq_driver::send_to_dut(trans_xtn xtn);

repeat(4) begin
@(vif.driver_cb);
//vif.driver_cb.din <= xtn.din;
vif.driver_cb.din <= 1'b1;
@(vif.driver_cb);
vif.driver_cb.din <= 1'b0;
@(vif.driver_cb);
vif.driver_cb.din <= 1'b1;
@(vif.driver_cb);
vif.driver_cb.din <= 1'b0;
end

repeat(2)begin
vif.driver_cb.din <= 1'b1;
@(vif.driver_cb);
vif.driver_cb.din <= 1'b1;
end

repeat(2)begin
vif.driver_cb.din <= 1'b1;
@(vif.driver_cb);
vif.driver_cb.din <= 1'b0;
@(vif.driver_cb);
vif.driver_cb.din <= 1'b0;
@(vif.driver_cb);
vif.driver_cb.din <= 1'b1;
@(vif.driver_cb);
vif.driver_cb.din <= 1'b0;
@(vif.driver_cb);
vif.driver_cb.din <= 1'b0;


vif.driver_cb.din <= xtn.din;

end


@(vif.driver_cb);

seq_item_port.put_response(xtn);

`uvm_info("DRIVER",$sformatf("printing from driver\n%s",xtn.sprint()),UVM_LOW);
endtask
*/

