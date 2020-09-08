class driver extends uvm_driver#(trans_xtn);
`uvm_component_utils(driver);

virtual uart_if.DRV_MP vif;

agt_config m_cfg;

//=====================================================
//methods
//=====================================================

extern function new(string name="driver",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task send_to_dut(trans_xtn x);
endclass

//=====================================================
//Function new
//=====================================================

function driver::new(string name="driver",uvm_component parent);
        super.new(name,parent);
endfunction

//=====================================================
//Build phase
//=====================================================

function void driver::build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(agt_config)::get(this,"","agt_config",m_cfg))
        `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")

endfunction

//=====================================================
//Connect phase
//=====================================================

function void driver::connect_phase(uvm_phase phase);
          vif = m_cfg.vif;

endfunction

//=====================================================
//Run phase
//=====================================================

task driver::run_phase(uvm_phase phase);
        @(vif.driver_cb);
        vif.driver_cb.wb_rst_i<=1'b1;
        @(vif.driver_cb);
        vif.driver_cb.wb_rst_i<=1'b0;
                forever begin
                seq_item_port.get_next_item(req);
                send_to_dut(req);
                seq_item_port.item_done();
                end
endtask

//=====================================================
//Send to DUT task
//=====================================================

task driver::send_to_dut(trans_xtn x);
        @(vif.driver_cb);
        vif.driver_cb.wb_adr_i<=x.wb_adr_i;
        vif.driver_cb.wb_dat_i<=x.wb_dat_i;
        vif.driver_cb.wb_we_i<=x.wb_we_i;
        vif.driver_cb.wb_sel_i<=4'b0001;
        vif.driver_cb.wb_stb_i<=1'b1;
        vif.driver_cb.wb_cyc_i<=1'b1;

        wait(vif.driver_cb.wb_ack_o)
        vif.driver_cb.wb_stb_i<=1'b0;
        vif.driver_cb.wb_cyc_i<=1'b0;

        if(x.wb_adr_i==2 & x.wb_we_i==0)
        begin
        wait(vif.driver_cb.int_o)
        begin

        @(vif.driver_cb);
        x.IIR=vif.driver_cb.wb_dat_o;
	$display("%m,,,,,value of iir in driv",,,,x.IIR);
        seq_item_port.put_response(x);
      end
        end
        `uvm_info("driver",$sformatf("printing from driver \n %s",x.sprint()),UVM_LOW);
endtask

