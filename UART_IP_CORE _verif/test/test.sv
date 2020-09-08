class base_test extends uvm_test;

env envh;

//---------handles for config classes
agt_config m_agt_cfg[];
env_config m_cfg;


int no_of_agents = 2;
int has_agent =1;

`uvm_component_utils(base_test)


//=====================================================
//methods
//=====================================================

extern function new(string name = "base_test", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
endclass


//=====================================================
//Function new
//=====================================================

function base_test::new(string name = "base_test", uvm_component parent);

super.new(name, parent);
`uvm_info("TEST","THIS IS TEST", UVM_MEDIUM)

endfunction

//=====================================================
//Build phase
//=====================================================

function void base_test::build_phase(uvm_phase phase);


m_cfg= env_config::type_id::create("m_cfg");


m_cfg.m_agt_cfg = new[no_of_agents];

if(has_agent) begin


m_agt_cfg = new[no_of_agents];

foreach(m_agt_cfg[i])
begin
m_agt_cfg[i]= agt_config::type_id::create($sformatf("m_agt_cfg[%0d]",i));


//---------getting virtual interface from top.sv into agt_config handle, here use foreach
	  if(!uvm_config_db #(virtual uart_if)::get(this,"", $sformatf("vif_%0d",i),m_agt_cfg[i].vif))
		`uvm_fatal("VIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?") 



m_agt_cfg[i].is_active = UVM_ACTIVE;

m_cfg.m_agt_cfg[i] = m_agt_cfg[i];

end
end

m_cfg.no_of_agents = no_of_agents;
m_cfg.has_agent = has_agent;


uvm_config_db #(env_config)::set(this,"*","env_config",m_cfg);


super.build_phase(phase);

envh = env::type_id::create("envh",this);


endfunction

//=====================================================
//Connect phase
//=====================================================

function void base_test::connect_phase(uvm_phase phase);

super.connect_phase(phase);

endfunction



//--------------------------Extended test 01--------------------------//

	class uart_first_test extends base_test;

  	`uvm_component_utils(uart_first_test)

     uart_seq01_vseq uart_seq01;

//------------------------------------------
// METHODS
//------------------------------------------

 	extern function new(string name = "uart_first_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//=====================================================
//Function new
//=====================================================

   	function uart_first_test::new(string name = "uart_first_test" , uvm_component parent);
		super.new(name,parent);
	endfunction

//=====================================================
//Build phase
//=====================================================            

	function void uart_first_test::build_phase(uvm_phase phase);
            super.build_phase(phase);
	endfunction


//=====================================================
//Run phase
//=====================================================

      	task uart_first_test::run_phase(uvm_phase phase);

          phase.raise_objection(this);
          uart_seq01=uart_seq01_vseq::type_id::create("uart_seq01");
          uart_seq01.start(envh.vseqrh);
	  	  #100;
          phase.drop_objection(this);

	endtask 



//----------------------------EXTENDED TEST 02----------------------------//

	class uart_second_test extends base_test;

  	`uvm_component_utils(uart_second_test)

         uart_seq02_vseq uart_seq02;

//------------------------------------------
// METHODS
//------------------------------------------

 	extern function new(string name = "uart_second_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//=====================================================
//Function new
//=====================================================

   	function uart_second_test::new(string name = "uart_second_test" , uvm_component parent);
		super.new(name,parent);
	endfunction

//=====================================================
//Build phase
//=====================================================

	function void uart_second_test::build_phase(uvm_phase phase);
            super.build_phase(phase);
	endfunction


//=====================================================
//Build phase
//=====================================================

      	task uart_second_test::run_phase(uvm_phase phase);
         
		 phase.raise_objection(this);
         uart_seq02=uart_seq02_vseq::type_id::create("uart_seq02");
	     uart_seq02.start(envh.vseqrh);
	  	 #2200;
         phase.drop_objection(this);
	endtask 



//----------------------------EXTENDED TEST 03----------------------------//

	class uart_third_test extends base_test;

  	`uvm_component_utils(uart_third_test)
   
   uart_seq03_vseq uart_seq03;

//=====================================================
//methods
//=====================================================

 	extern function new(string name = "uart_third_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//=====================================================
//Function new
//=====================================================

   	function uart_third_test::new(string name = "uart_third_test" , uvm_component parent);
		super.new(name,parent);
	endfunction


//=====================================================
//Build phase
//=====================================================

	function void uart_third_test::build_phase(uvm_phase phase);
            super.build_phase(phase);
	endfunction


//=====================================================
//Run phase
//=====================================================

      	task uart_third_test::run_phase(uvm_phase phase);
         
		  phase.raise_objection(this);
         uart_seq03=uart_seq03_vseq::type_id::create("uart_seq03");
         uart_seq03.start(envh.vseqrh);
	  #2200;
         phase.drop_objection(this);
	endtask 



//----------------------------EXTENDED TEST 04----------------------------//

	class uart_fourth_test extends base_test;  
   
	`uvm_component_utils(uart_fourth_test)

   uart_seq04_vseq uart_seq04;

//=====================================================
//methods
//=====================================================

 	extern function new(string name = "uart_fourth_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//=====================================================
//Function new
//=====================================================

   	function uart_fourth_test::new(string name = "uart_fourth_test" , uvm_component parent);
		super.new(name,parent);
	endfunction


//=====================================================
//Build phase
//=====================================================
            
	function void uart_fourth_test::build_phase(uvm_phase phase);
        super.build_phase(phase);
	endfunction


//=====================================================
//Run phase
//=====================================================

   	task uart_fourth_test::run_phase(uvm_phase phase);
  
         phase.raise_objection(this);
         uart_seq04=uart_seq04_vseq::type_id::create("uart_seq04");  
         uart_seq04.start(envh.vseqrh);
	  #2200;
         phase.drop_objection(this);
	
	endtask



//----------------------------EXTENDED TEST 05----------------------------//

	class uart_fifth_test extends base_test;

  	`uvm_component_utils(uart_fifth_test)

   uart_seq05_vseq uart_seq05;

//=====================================================
//methods
//=====================================================

	extern function new(string name = "uart_fifth_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//=====================================================
//Function new
//=====================================================

   	function uart_fifth_test::new(string name = "uart_fifth_test" , uvm_component parent);
		super.new(name,parent);
	endfunction


//=====================================================
//Build phase
//=====================================================
            
	function void uart_fifth_test::build_phase(uvm_phase phase);
            super.build_phase(phase);
	endfunction


//=====================================================
//Run phase
//=====================================================

      	task uart_fifth_test::run_phase(uvm_phase phase);
         
		 phase.raise_objection(this);
         uart_seq05 = uart_seq05_vseq::type_id::create("uart_seq05");
         uart_seq05.start(envh.vseqrh);
	     #2200;
         
		 phase.drop_objection(this);
	endtask



//----------------------------EXTENDED TEST 06----------------------------//

	class uart_sixth_test extends base_test;  

	`uvm_component_utils(uart_sixth_test)

   uart_seq06_vseq uart_seq06;

//=====================================================
//methods
//=====================================================

 	extern function new(string name = "uart_sixth_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//=====================================================
//Function new
//=====================================================

   	function uart_sixth_test::new(string name = "uart_sixth_test" , uvm_component parent);
		super.new(name,parent);
	endfunction

//=====================================================
//Build phase
//=====================================================

	function void uart_sixth_test::build_phase(uvm_phase phase);
      super.build_phase(phase);
	endfunction


//=====================================================
//Run phase
//=====================================================
      	task uart_sixth_test::run_phase(uvm_phase phase);

         phase.raise_objection(this);
         uart_seq06 = uart_seq06_vseq::type_id::create("uart_seq06");
         uart_seq06.start(envh.vseqrh);
	  #20000;
         phase.drop_objection(this);

	endtask



//----------------------------EXTENDED TEST 07----------------------------//

  // Extend uart_seventh_test from base_test

	class uart_seventh_test extends base_test;

	`uvm_component_utils(uart_seventh_test)

   uart_seq07_vseq uart_seq07;

//=====================================================
//methods
//=====================================================

 	extern function new(string name = "uart_seventh_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//=====================================================
//Function new
//=====================================================

   	function uart_seventh_test::new(string name = "uart_seventh_test" , uvm_component parent);
		super.new(name,parent);
	endfunction


//=====================================================
//Build phase
//=====================================================

	function void uart_seventh_test::build_phase(uvm_phase phase);
       super.build_phase(phase);
	endfunction


//=====================================================
//Run phase
//=====================================================

   	task uart_seventh_test::run_phase(uvm_phase phase);
   
         phase.raise_objection(this);
         uart_seq07 = uart_seq07_vseq::type_id::create("uart_seq07");
         uart_seq07.start(envh.vseqrh);
	     #200000;
         phase.drop_objection(this);

	endtask



//----------------------------EXTENDED TEST 08----------------------------//

	class uart_eighth_test extends base_test;

  	`uvm_component_utils(uart_eighth_test)

   uart_seq08_vseq uart_seq08;

//=====================================================
//methods
//=====================================================

 	extern function new(string name = "uart_eighth_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//=====================================================
//Function new
//=====================================================

   	function uart_eighth_test::new(string name = "uart_eighth_test" , uvm_component parent);
		super.new(name,parent);
	endfunction


//=====================================================
//Build phase
//=====================================================

	function void uart_eighth_test::build_phase(uvm_phase phase);
      super.build_phase(phase);
	endfunction


//=====================================================
//Run Phase
//=====================================================

      	task uart_eighth_test::run_phase(uvm_phase phase);
         
		 phase.raise_objection(this);
         uart_seq08 = uart_seq08_vseq::type_id::create("uart_seq08");
         uart_seq08.start(envh.vseqrh);
	  #150000;
         
		 phase.drop_objection(this);
	endtask


