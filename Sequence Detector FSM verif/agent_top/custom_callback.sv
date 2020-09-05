class custom_callback extends driver_callback;

`uvm_object_utils(custom_callback)

//---------virtual interface declaration
//virtual seq_if.DRV_MP vif;

//---------agent config handle
//seq_agent_config m_cfg;
//seq_env_config env_cfg;

//=====================================================
//methods
//=====================================================

extern function new(string name = "custom_callback");
//extern function void build_phase(uvm_phase phase);
//extern function void connect_phase(uvm_phase phase);


virtual task pre_send();

/*repeat(4) begin
@(vif.driver_cb);
vif.driver_cb.reset <= 1'b1;
@(vif.driver_cb);
vif.driver_cb.reset <= 1'b0;
end */

#10;
$display("_________________CALLBACK CALLED___________________");
endtask

virtual task post_send();

$display("_________________CALLBACK HAPPENED SUCESSFULLY___________________");

endtask

endclass

//=====================================================
//Function new
//=====================================================

function custom_callback:: new(string name="custom_callback");
super.new(name);
/*
//m_cfg = new("m_cfg");
//$display("%p", m_cfg);
if(!uvm_config_db#(seq_agent_config)::get(this,"","agt_config",env_cfg.m_agt_cfg))
`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
*/
endfunction


//=====================================================
//Build phase
//=====================================================

//function void custom_callback::build_phase(uvm_phase phase);
//super.build_phase(phase);

//get the config into agt config
//if(!uvm_config_db#(seq_agent_config)::get(this,"","agt_config",m_cfg))
//`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")

//endfunction


//=====================================================
//Connect phase
//=====================================================

/*function void custom_callback::connect_phase(uvm_phase phase);
super.connect_phase(phase);

vif = m_cfg.vif;

endfunction
*/
