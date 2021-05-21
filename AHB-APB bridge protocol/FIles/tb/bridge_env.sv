class bridge_env extends uvm_env;

`uvm_component_utils(bridge_env)

//handle for env config
bridge_env_config m_cfg;
ahb_agent_config ahb_cfg;
apb_agent_config apb_cfg;


ahb_agt_top ahb_top;
apb_agt_top apb_top;

//handle for scoreboard
scoreboard sb;

//handle for virtual sequencer
virtual_sequencer vsqrh;

//=====================================================
//methods
//=====================================================
extern function new(string name="bridge_env", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass

//=====================================================
//Function new
//=====================================================
function bridge_env::new(string name="bridge_env",uvm_component parent);
super.new(name, parent);

endfunction

//=====================================================
//Build phase
//=====================================================

function void bridge_env::build_phase(uvm_phase phase);
super.build_phase(phase);

if(!uvm_config_db#(bridge_env_config)::get(this,"","bridge_env_config",m_cfg))
`uvm_fatal("TB_CONFIG","CAnnot get the config_db from TEST, have you set it?")

uvm_config_db#(ahb_agent_config)::set(this,"*","ahb_agent_config",m_cfg.ahb_cfg);
ahb_top = ahb_agt_top::type_id::create("ahb_top",this);


uvm_config_db#(apb_agent_config)::set(this,"*","apb_agent_config",m_cfg.apb_cfg);
apb_top = apb_agt_top::type_id::create("apb_top",this);

if(m_cfg.has_virtual_sequencer)
//virtual sequencer object creation
vsqrh = virtual_sequencer::type_id::create("vsqrh",this);

if(m_cfg.has_scoreboard)
//scoreboard object creation
sb = scoreboard::type_id::create("sb", this);

endfunction


//=====================================================
//Connect phase
//=====================================================

function void bridge_env::connect_phase(uvm_phase phase);
super.connect_phase(phase);

if(m_cfg.has_virtual_sequencer)

//connecting sequencer to the virtual sequencer
vsqrh.ahb_seqr = ahb_top.agent.sequencer;

if(m_cfg.has_scoreboard)
//connecting the moitor_port to the analysis export
ahb_top.agent.monitor.monitor_port.connect(sb.fifo_ahb.analysis_export);
apb_top.agent.monitor.monitor_port.connect(sb.fifo_apb.analysis_export);

endfunction


