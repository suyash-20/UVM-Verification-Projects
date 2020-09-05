class seq_tb extends uvm_env;
`uvm_component_utils(seq_tb)

//---------handle for env config
seq_env_config m_cfg;

//---------virtual sequencer handle
virtual_sequencer vseqrh;

//---------agt config handle
seq_agent_config m_agt_cfg;

seq_agt_top top;
seq_scoreboard sb;


//=====================================================
//methods
//=====================================================

extern function new(string name="seq_tb", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass


//=====================================================
//Function new
//=====================================================

function seq_tb::new(string name="seq_tb", uvm_component parent);
super.new(name, parent);
endfunction

//=====================================================
//Build phase
//=====================================================

function void seq_tb::build_phase(uvm_phase phase);
super.build_phase(phase);

//---------get the env config
if(!uvm_config_db#(seq_env_config)::get(this,"","env_config",m_cfg))
`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")

//---------has_agent
if(m_cfg.has_agent)

//---------set the config for agt config inside env config
uvm_config_db#(seq_agent_config)::set(this,"*","agt_config", m_cfg.m_agt_cfg);

top = seq_agt_top::type_id::create("top",this);
$display("%p",top);

//---------has virtual sequencer 
if(m_cfg.has_virtual_sequencer)

//---------object for virtual sequencer
vseqrh = virtual_sequencer::type_id::create("vseqrh", this);

//---------has scoreboard
if(m_cfg.has_scoreboard)
sb = seq_scoreboard::type_id::create("sb",this);

endfunction


//=====================================================
//Connect phase
//=====================================================

function void seq_tb::connect_phase(uvm_phase phase);
super.connect_phase(phase);

//---------has virtual sequencer
if(m_cfg.has_virtual_sequencer)

//---------connect virtual sequencer with the physical sequencer
vseqrh.s_seqr=top.agent.sequencer;

//---------has scoreboard
if(m_cfg.has_scoreboard)

//---------connect the analysis port of monitor with the analysis export of the sequencer
top.agent.monitor.monitor_port.connect(sb.fifo_cmp.analysis_export);

endfunction
