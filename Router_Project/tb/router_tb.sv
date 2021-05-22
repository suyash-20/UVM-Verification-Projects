//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

class router_tb extends uvm_env;

    `uvm_component_utils(router_tb)

	router_wr_agt_top wagt_top;
	router_rd_agt_top ragt_top;

	router_virtual_sequencer v_sequencer;
	router_scoreboard sb;
    
    router_env_config m_cfg;

//------------------------------------------
// Methods
//------------------------------------------
    extern function new(string name = "router_tb", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);

endclass
	
//-----------------  constructor new method  -------------------//

function router_tb::new(string name = "router_tb", uvm_component parent);
    super.new(name,parent);
endfunction


//-----------------  build phase method  -------------------//

function void router_tb::build_phase(uvm_phase phase);

    if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",m_cfg)) //getting from test
	    `uvm_fatal("CONFIG","!!!!!!!!!!cannot get() m_cfg from uvm_config_db. Have you set() it?")
        //$display("tb_config    %P",m_cfg);   
	
    if(m_cfg.has_wagent) begin
        uvm_config_db #(router_wr_agent_config)::set(this,"*","router_wr_agent_config", m_cfg.m_wr_cfg);
        wagt_top=router_wr_agt_top::type_id::create("wagt_top",this);
    end


    if(m_cfg.has_ragent == 1) begin
        //m_cfg.m_rd_cfg = new[m_cfg.no_of_read_agents];

        foreach(m_cfg.m_rd_cfg[i])begin	
            uvm_config_db#(router_rd_agent_config)::set(this,$sformatf("ragt_top.agnth[%0d]*",i),"router_rd_agent_config",m_cfg.m_rd_cfg[i]);
            //$display("%P",m_cfg.m_rd_cfg[i]);
        end

        ragt_top = router_rd_agt_top::type_id::create("ragt_top",this);          
	end

	super.build_phase(phase);
    if(m_cfg.has_virtual_sequencer)begin
		v_sequencer=router_virtual_sequencer::type_id::create("v_sequencer",this);
    end

    if(m_cfg.has_scoreboard) begin
        sb = router_scoreboard::type_id::create("sb",this);
    end

endfunction

//-----------------  connect phase method  -------------------//

function void router_tb::connect_phase(uvm_phase phase);
    if(m_cfg.has_virtual_sequencer) begin
        if(m_cfg.has_wagent)
		v_sequencer.wr_seqrh = wagt_top.agnth.m_sequencer;
        
        if(m_cfg.has_ragent) begin
            foreach(ragt_top.agnth[i])
			v_sequencer.rd_seqrh[i] = ragt_top.agnth[i].m_sequencer;
        end
    end

	//SCOREBOARD CONNECTION TO WRITE AND READ MONITORS
			
   	if(m_cfg.has_scoreboard)begin
        wagt_top.agnth.monitor.monitor_port.connect(sb.fifo_wrh.analysis_export);
        //ragt_top.agnth=new[m_cfg.no_of_read_agents];
		
		foreach(ragt_top.agnth[i])
        ragt_top.agnth[i].monitor.monitor_port.connect(sb.fifo_rdh[i].analysis_export);
	end

endfunction
