class agent extends uvm_agent;
`uvm_component_utils(agent)

sequencer m_sequencer;
driver drvh;
monitor monh;
agt_config m_cfg;

//=====================================================
//methods
//=====================================================

extern function new(string name="agent",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
endclass


//=====================================================
//Function new
//=====================================================

function agent::new(string name="agent",uvm_component parent);
        super.new(name,parent);
endfunction

function void agent::build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(agt_config)::get(this,"","agt_config",m_cfg))
        `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")

        monh=monitor::type_id::create("monh",this);
        if(m_cfg.is_active==UVM_ACTIVE)
        begin
        drvh=driver::type_id::create("drvh",this);
        m_sequencer=sequencer::type_id::create("m_sequencer",this);
        end
endfunction


//=====================================================
//Connect phase
//=====================================================

function void agent::connect_phase(uvm_phase phase);
        if(m_cfg.is_active==UVM_ACTIVE)
        begin
        drvh.seq_item_port.connect(m_sequencer.seq_item_export);
        end
endfunction
