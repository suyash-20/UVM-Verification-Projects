class seq_test extends uvm_test;

`uvm_component_utils(seq_test)

//---------handles for config classes
seq_env_config m_cfg;
seq_agent_config m_agt_cfg;

//---------env handle
seq_tb tb;

//=====================================================
//methods
//=====================================================

extern function new(string name = "seq_test", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass


//=====================================================
//Function new
//=====================================================

function seq_test::new(string name = "seq_test", uvm_component parent);
super.new(name, parent);

endfunction


//=====================================================
//Build phase
//=====================================================

function void seq_test::build_phase(uvm_phase phase);

super.build_phase(phase);

m_cfg= seq_env_config::type_id::create("m_cfg");
m_agt_cfg= seq_agent_config::type_id::create("m_agt_cfg");

//---------getting virtual interface from top.sv into agt_config handle, here use foreach
if(!uvm_config_db #(virtual seq_if)::get(this,"", "vif",m_agt_cfg.vif))
`uvm_fatal("VIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?") 

m_agt_cfg.is_active = UVM_ACTIVE;
m_cfg.m_agt_cfg = m_agt_cfg;
//m_cfg.has_agent = has_agent;

uvm_config_db #(seq_env_config)::set(this,"*","env_config",m_cfg);
tb = seq_tb::type_id::create("tb",this);

endfunction


//=====================================================
//Connect phase
//=====================================================

function void seq_test::connect_phase(uvm_phase phase);
super.connect_phase(phase);
endfunction


//=====================================================
//Extended Test cases
//=====================================================

//=====================================================
//Extended test 01
//=====================================================
	class seq_first_test extends seq_test;

	`uvm_component_utils(seq_first_test)

         seq01_vseq seq01;

//=====================================================
//methods
//=====================================================

 	extern function new(string name = "seq_first_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass


//=====================================================
//Function new
//=====================================================

   	function seq_first_test::new(string name = "seq_first_test" , uvm_component parent);
		super.new(name,parent);
	endfunction


//=====================================================
//Build phase
//=====================================================

	function void seq_first_test::build_phase(uvm_phase phase);
            super.build_phase(phase);
	endfunction


//=====================================================
//Run phase
//=====================================================

      	task seq_first_test::run_phase(uvm_phase phase);

         phase.raise_objection(this);

          seq01=seq01_vseq::type_id::create("seq01");
	  
 //---------start the sequence on virtual sequencer
          seq01.start(tb.vseqrh);
	  #500;
         phase.drop_objection(this);
	endtask



//=====================================================
//Extended test 02 (CALLBACK TESTCASE)
//=====================================================

	class seq_callback_test extends seq_test;
	custom_callback clb;

   	`uvm_component_utils(seq_callback_test)

         seq01_vseq seq01;

//=====================================================
//methods
//=====================================================

 	extern function new(string name = "seq_callback_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void end_of_elaboration();
	extern task run_phase(uvm_phase phase);
endclass


//=====================================================
//Function new
//=====================================================

   	function seq_callback_test::new(string name = "seq_callback_test" , uvm_component parent);
		super.new(name,parent);
	endfunction


//=====================================================
//Build phase
//=====================================================

	function void seq_callback_test::build_phase(uvm_phase phase);
            super.build_phase(phase);
			clb = custom_callback::type_id::create("clb", this);
	endfunction

//=====================================================
//End of Elaboration phase
//=====================================================

 function void seq_callback_test::end_of_elaboration();
    uvm_callbacks#(seq_driver,driver_callback)::add(tb.top.agent.driver,clb);
  endfunction : end_of_elaboration

//=====================================================
//Run phase
//=====================================================
      	task seq_callback_test::run_phase(uvm_phase phase);

         phase.raise_objection(this);

          seq01=seq01_vseq::type_id::create("seq01");
	  
 //---------start the sequence on virtual sequencer
          seq01.start(tb.vseqrh);
	  #500;
         phase.drop_objection(this);
	endtask 		
