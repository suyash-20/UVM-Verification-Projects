class axi_tb extends uvm_env;
 
 `uvm_component_utils(axi_tb)
 
 axi_master_agt_top master_top;
 axi_slave_agt_top slave_top; 
 
axi_scoreboard sb;
  
 //handle for virtual sequencer
axi_virtual_sequencer v_sequencer;
 
 //handle for env config
axi_env_config m_cfg; 

 
 //Standard functions
 
 extern function new(string name="axi_tb",uvm_component parent);
 extern function void build_phase(uvm_phase phase);
 extern function void connect_phase(uvm_phase phase);
 
 endclass
 
 
 //new() constructor method
 
 function axi_tb::new(string name="axi_tb",uvm_component parent);
	super.new(name, parent);
endfunction

//build_phase method

function void axi_tb::build_phase(uvm_phase phase);

//getting the env config from test
if(!uvm_config_db#(axi_env_config)::get(this,"","axi_env_config",m_cfg))
`uvm_fatal("TB_CONFIG","CAnnot get the config_db from TEST, have you set it?")

//if(m_cfg.has_master_agent) begin
//setting the config in m_cfg.master config handle

uvm_config_db#(axi_master_agent_config)::set(this,"*","axi_master_agent_config",m_cfg.m_ms_cfg);

master_top = axi_master_agt_top::type_id::create("master_top",this);


//if(m_cfg.has_slave_agent) begin
//setting the config in m_cfg.slave config handle
uvm_config_db#(axi_slave_agent_config)::set(this,"*","axi_slave_agent_config",m_cfg.m_sl_cfg);

slave_top = axi_slave_agt_top::type_id::create("slave_top",this);

super.build_phase(phase);

if(m_cfg.has_virtual_sequencer)
	begin
		v_sequencer= axi_virtual_sequencer::type_id::create("v_sequencer",this);

	end


//scoreboard instance 

if(m_cfg.has_scoreboard) 
	begin
		sb = axi_scoreboard::type_id::create("sb",this);
	end

endfunction	



function void axi_tb::connect_phase(uvm_phase phase);

super.connect_phase(phase);

//logic for connecting virtual sequencer to master sequencer ans slave sequencer
if(m_cfg.has_virtual_sequencer) begin
v_sequencer.ms_seqrh = master_top.agent.sequencer;
v_sequencer.sl_seqrh = slave_top.agent.sequencer;
end


//Logic for SCOREBOARD connection with master and slave monitor 

if(m_cfg.has_scoreboard) begin
master_top.agent.monitor.monitor_port.connect(sb.m_fifo.analysis_export);
slave_top.agent.monitor.monitor_port.connect(sb.s_fifo.analysis_export);
end

endfunction
