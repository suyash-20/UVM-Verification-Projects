class env extends uvm_env;

agt_top top;

//---------handle for env_config

env_config m_cfg;
scoreboard sb;
virtual_sequencer vseqrh;
agt_config m_agt_cfg[];


`uvm_component_utils(env)


//=====================================================
//methods
//=====================================================

extern function new(string name = "env", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
endclass


//=====================================================
//Function new
//=====================================================

function env::new(string name = "env", uvm_component parent);

super.new(name, parent);
`uvm_info("ENV","THIS IS ENV", UVM_MEDIUM)

endfunction

//=====================================================
//Build phase
//=====================================================

function void env::build_phase(uvm_phase phase);
if(!uvm_config_db #(env_config)::get(this,"","env_config",m_cfg))

`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")

if(m_cfg.has_agent)

	foreach(m_cfg.m_agt_cfg[i])begin	
	uvm_config_db#(agt_config)::set(this,$sformatf("top.agnth[%0d]*",i),"agt_config",m_cfg.m_agt_cfg[i]);
end

top = agt_top::type_id::create("top",this);


super.build_phase(phase);


//---------has_virtual_sequencer

if(m_cfg.has_virtual_sequencer)
begin

vseqrh=virtual_sequencer::type_id::create("vseqrh",this);

end



//---------has_scoreboard
if(m_cfg.has_scoreboard) begin

sb = scoreboard::type_id::create("sb",this);
end



endfunction

//=====================================================
//Connect phase
//=====================================================

function void env::connect_phase(uvm_phase phase);

super.connect_phase(phase);

if(m_cfg.has_virtual_sequencer) begin

foreach(top.agnth[i])
//foreach(m_cfg.m_agt_cfg[i])
begin
vseqrh.seqrh[i]=top.agnth[i].m_sequencer;
$display("%p",top.agnth[i]);
end

end


if(m_cfg.has_scoreboard) begin

foreach(top.agnth[i])
top.agnth[i].monh.monitor_port.connect(sb.fifo_cmp[i].analysis_export);

end

endfunction

