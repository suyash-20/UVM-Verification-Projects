//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

class router_base_test extends uvm_test;

`uvm_component_utils(router_base_test)
  
	router_tb router_envh;
	router_env_config m_tb_cfg;

	router_wr_agent_config m_wr_cfg;
	router_rd_agent_config m_rd_cfg[];

	int no_of_read_agents = 3;
	int has_ragent = 1;
	int has_wagent = 1;

//------------------------------------------
// METHODS
//------------------------------------------

	extern function new(string name = "router_base_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	//extern task run_phase(uvm_phase phase);
	extern function void config_router();
endclass 


//-----------------  constructor new method  -------------------//
function router_base_test::new(string name = "router_base_test" , uvm_component parent);	
    super.new(name, parent);

endfunction

//---------------------function config_router() -----------------------//

function void router_base_test::config_router();

if(has_wagent) begin

m_wr_cfg = router_wr_agent_config::type_id::create("m_wr_cfg");


if(!uvm_config_db#(virtual router_if)::get(this,"","vif",m_wr_cfg.vif))
`uvm_fatal("VIF_CONFIG","cannot get the interface vif from uvm_config_db")

m_wr_cfg.is_active = UVM_ACTIVE;
m_tb_cfg.m_wr_cfg = m_wr_cfg;

end



if (has_ragent) begin
    m_rd_cfg = new[no_of_read_agents];

	foreach(m_rd_cfg[i]) begin
        m_rd_cfg[i] = router_rd_agent_config::type_id::create($sformatf("m_rd_cfg[%0d]",i));
		
        if(!uvm_config_db#(virtual router_if)::get(this,"",$sformatf("vif_%0d",i),m_rd_cfg[i].vif))
			`uvm_fatal("VIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?")
		m_rd_cfg[i].is_active = UVM_ACTIVE;
		m_tb_cfg.m_rd_cfg[i] = m_rd_cfg[i];               
    end
end
m_tb_cfg.no_of_read_agents = no_of_read_agents;
m_tb_cfg.has_ragent = has_ragent;
m_tb_cfg.has_wagent = has_wagent;
  
endfunction


//-------------build phase method--------------//

function void router_base_test::build_phase(uvm_phase phase);
    m_tb_cfg=router_env_config::type_id::create("m_tb_cfg");
    
    if(has_ragent)
        m_tb_cfg.m_rd_cfg = new[no_of_read_agents];
                
    config_router(); 
	uvm_config_db #(router_env_config)::set(this,"*","router_env_config",m_tb_cfg);
    
    super.build();
	router_envh=router_tb::type_id::create("router_envh", this);
	
endfunction


//-------------Extended test 01

   // Extend router_first_test from  router_base_test
	class router_first_test extends router_base_test;

   // Factory Registration
	`uvm_component_utils(router_first_test)

   // Declare the handle for  router_single_vseq virtual sequence
    router_seq01_vseq router_seq01;

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
 	extern function new(string name = "router_first_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//-----------------  constructor new method  -------------------//

 // Define Constructor new() function
   	function router_first_test::new(string name = "router_first_test" , uvm_component parent);
		super.new(name,parent);
	endfunction


//-----------------  build() phase method  -------------------//
            
	function void router_first_test::build_phase(uvm_phase phase);
            super.build_phase(phase);
	endfunction


//-----------------  run() phase method  -------------------//
      	task router_first_test::run_phase(uvm_phase phase);
 //raise objection
         phase.raise_objection(this);
 //create instance for sequence
          router_seq01=router_seq01_vseq::type_id::create("router_seq01");
 //start the sequence wrt virtual sequencer
 $display("%P",router_envh.v_sequencer);
          router_seq01.start(router_envh.v_sequencer);
	  #2200;
 //drop objection
         phase.drop_objection(this);
	endtask   



//---------------ROUTER TEST 02 -------------------//


class router_second_test extends router_base_test;

`uvm_component_utils(router_second_test)

router_seq02_vseq router_seq02;


//Standard Methods
extern function new(string name= "router_second_test", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass

//constructor new method

function router_second_test::new(string name= "router_second_test", uvm_component parent);

super.new(name, parent);
endfunction


//build_phase

function void router_second_test::build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction


//run_phase

task router_second_test::run_phase(uvm_phase phase);

//raise objections
phase.raise_objection(this);

//start the sequence
router_seq02=router_seq02_vseq::type_id::create("router_seq02");

router_seq02.start(router_envh.v_sequencer);
#1000;

//drop the objections
phase.drop_objection(this);

endtask


//---------------ROUTER TEST 03 -------------------//


class router_timeout_test extends router_base_test;

`uvm_component_utils(router_timeout_test)

router_seq03_vseq router_seq03;


//Standard Methods
extern function new(string name= "router_timeout_test", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass

//constructor new method

function router_timeout_test::new(string name= "router_timeout_test", uvm_component parent);

super.new(name, parent);
endfunction


//build_phase

function void router_timeout_test::build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction


//run_phase

task router_timeout_test::run_phase(uvm_phase phase);

//raise objections
phase.raise_objection(this);

//start the sequence
router_seq03=router_seq03_vseq::type_id::create("router_seq03");

router_seq03.start(router_envh.v_sequencer);
#1000;

//drop the objections
phase.drop_objection(this);

endtask
