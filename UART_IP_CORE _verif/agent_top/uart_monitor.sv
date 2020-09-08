class monitor extends uvm_monitor;
`uvm_component_utils(monitor);

virtual uart_if.MON_MP vif;

agt_config m_cfg;

uvm_analysis_port #(trans_xtn) monitor_port;

trans_xtn x;

//=====================================================
//methods
//=====================================================

extern function new(string name="monitor",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_data();
endclass

//=====================================================
//function new
//=====================================================

function monitor::new(string name="monitor",uvm_component parent);
        super.new(name,parent);
        monitor_port=new("monitor_port",this);
endfunction

//=====================================================
//Build phase
//=====================================================

function void monitor::build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(agt_config)::get(this,"","agt_config",m_cfg))
        `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
endfunction

//=====================================================
//Connect phase
//=====================================================

function void monitor::connect_phase(uvm_phase phase);
          vif = m_cfg.vif;
endfunction

task monitor::run_phase(uvm_phase phase);
        x=trans_xtn::type_id::create("x");

        forever
        collect_data();
endtask

//=====================================================
//Collect data task
//=====================================================

task monitor::collect_data();
        @(vif.monitor_cb);
        wait(vif.monitor_cb.wb_ack_o)
		
        if(vif.monitor_cb.wb_adr_i==3 && vif.monitor_cb.wb_we_i)
        x.LCR=vif.monitor_cb.wb_dat_i;
        
		if(x.LCR[7]==1 && vif.monitor_cb.wb_adr_i==1 && vif.monitor_cb.wb_we_i)
        x.DLMSB=vif.monitor_cb.wb_dat_i;
        
		if(x.LCR[7]==1 && vif.monitor_cb.wb_adr_i==0 && vif.monitor_cb.wb_we_i)
        x.DLLSB=vif.monitor_cb.wb_dat_i;
        
		if(vif.monitor_cb.wb_adr_i==1 && vif.monitor_cb.wb_we_i)
        x.IER=vif.monitor_cb.wb_dat_i;
        
		if(vif.monitor_cb.wb_adr_i==2 && vif.monitor_cb.wb_we_i)
        x.FCR=vif.monitor_cb.wb_dat_i;
        
		if(x.LCR[7]==0 && vif.monitor_cb.wb_adr_i==0 && vif.monitor_cb.wb_we_i==1)
        x.THR.push_back(vif.monitor_cb.wb_dat_i);
       // x.THR=vif.monitor_cb.wb_dat_i;

		
		if(vif.monitor_cb.wb_adr_i==2 && vif.monitor_cb.wb_we_i==0)
        	 begin
           	wait(vif.monitor_cb.int_o)
        	@(vif.monitor_cb);
		$display($time);

        	x.IIR=vif.monitor_cb.wb_dat_o;
           	end


        if(x.LCR[7]==0 && vif.monitor_cb.wb_adr_i==0 && vif.monitor_cb.wb_we_i==0)//&& x.IIR[3:1]==2)
        x.RB.push_back(vif.monitor_cb.wb_dat_o);
//	x.RB=vif.monitor_cb.wb_dat_i;

        if(x.LCR[7]==0 && vif.monitor_cb.wb_adr_i==5 && vif.monitor_cb.wb_we_i==0)//&& x.IIR[3:1]==3)
	   begin
	     //  @(vif.monitor_cb);
       	       x.LSR=vif.monitor_cb.wb_dat_o;
           end

	if( vif.monitor_cb.wb_adr_i==0)
    	
        `uvm_info("monitor",$sformatf("printing from monitor \n %s",x.sprint()),UVM_LOW);
        monitor_port.write(x);
endtask

