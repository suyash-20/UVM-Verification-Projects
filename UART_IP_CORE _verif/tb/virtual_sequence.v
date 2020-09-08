class vbase_seq extends uvm_sequence#(uvm_sequence_item);

`uvm_object_utils(vbase_seq)

sequencer seqrh[];

virtual_sequencer vsqrh;


//declare handles for all sequences

uart_seq01 seq01;
uart_seq02 seq02;
uart_seq03 seq03;
uart_seq04 seq04;
uart_seq05 seq05;
uart_seq06 seq06;
uart_seq07 seq07;
uart_seq08 seq08;
uart_seq09 seq09;
uart_seq10 seq10;
uart_seq11 seq11;
uart_seq12 seq12;
uart_seq13 seq13;
uart_seq14 seq14;
uart_seq15 seq15;


//declare handle for env_config handle

env_config m_cfg;




//Standard Methods

	extern function new(string name = "vbase_seq");
	extern task body();

endclass

//Constructor Methods
	function vbase_seq::new(string name ="vbase_seq");
		super.new(name);

	endfunction


task vbase_seq::body();

if(!uvm_config_db#(env_config)::get(null, get_full_name(),"env_config",m_cfg))

`uvm_fatal("CONFIG","Cannot get config from uvm_config")


seqrh = new[m_cfg.no_of_agents];


assert($cast(vsqrh,m_sequencer))
else
`uvm_error("BODY","Error in casting")

foreach(seqrh[i]) begin
seqrh[i]= vsqrh.seqrh[i];
$display("%p",seqrh[i]);
end
endtask


//---------------SEQUENCE 01

class uart_seq01_vseq extends vbase_seq;

`uvm_object_utils(uart_seq01_vseq)

// Standard UVM Methods:
 	extern function new(string name = "router_seq01_vseq");
	extern task body();
	endclass  

//-----------------  constructor new method  -------------------//

// Add constructor 
	function uart_seq01_vseq::new(string name ="router_seq01_vseq");
		super.new(name);
	endfunction

//-------------task body()------------//

task uart_seq01_vseq::body();

super.body();

seq01 = uart_seq01::type_id::create("seq01");
seq02 = uart_seq02::type_id::create("seq02");


if(m_cfg.has_agent) begin


fork 
seq01.start(seqrh[0]);
seq02.start(seqrh[1]);

join

end

endtask



//------------------SEWUENCE 02



class uart_seq02_vseq extends vbase_seq;

`uvm_object_utils(uart_seq02_vseq)

// Standard UVM Methods:
 	extern function new(string name = "router_seq02_vseq");
	extern task body();
	endclass  

//-----------------  constructor new method  -------------------//

// Add constructor 
	function uart_seq02_vseq::new(string name ="router_seq02_vseq");
		super.new(name);
	endfunction

//-------------task body()------------//

task uart_seq02_vseq::body();

super.body();

seq03 = uart_seq03::type_id::create("seq03");


if(m_cfg.has_agent) begin


fork 
seq03.start(seqrh[0]);

join

end

endtask




//------------------SEWUENCE 03


class uart_seq03_vseq extends vbase_seq;

`uvm_object_utils(uart_seq03_vseq)

// Standard UVM Methods:
 	extern function new(string name = "router_seq03_vseq");
	extern task body();
	endclass  

//-----------------  constructor new method  -------------------//

// Add constructor 
	function uart_seq03_vseq::new(string name ="router_seq03_vseq");
		super.new(name);
	endfunction

//-------------task body()------------//

task uart_seq03_vseq::body();

super.body();

seq04 = uart_seq04::type_id::create("seq04");
seq05 = uart_seq05::type_id::create("seq05");

if(m_cfg.has_agent) begin


fork 
seq04.start(seqrh[0]);
seq05.start(seqrh[1]);
join

end

endtask




//------------------SEWUENCE 04

class uart_seq04_vseq extends vbase_seq;

`uvm_object_utils(uart_seq04_vseq)

// Standard UVM Methods:
 	extern function new(string name = "uart_seq04_vseq");
	extern task body();
	endclass  

//-----------------  constructor new method  -------------------//

// Add constructor 
	function uart_seq04_vseq::new(string name ="uart_seq04_vseq");
		super.new(name);
	endfunction

//-------------task body()------------//

task uart_seq04_vseq::body();

super.body();

seq06 = uart_seq06::type_id::create("seq06");
seq07 = uart_seq07::type_id::create("seq07");

if(m_cfg.has_agent) begin


fork 
seq06.start(seqrh[0]);
seq07.start(seqrh[1]);
join

end

endtask



//------------------SEQUENCE 05



class uart_seq05_vseq extends vbase_seq;

`uvm_object_utils(uart_seq05_vseq)

// Standard UVM Methods:
 	extern function new(string name = "uart_seq05_vseq");
	extern task body();
	endclass  

//-----------------  constructor new method  -------------------//

// Add constructor 
	function uart_seq05_vseq::new(string name ="uart_seq05_vseq");
		super.new(name);
	endfunction

//-------------task body()------------//

task uart_seq05_vseq::body();

super.body();

seq08 = uart_seq08::type_id::create("seq08");
seq09 = uart_seq09::type_id::create("seq09");

if(m_cfg.has_agent) begin


fork 
seq08.start(seqrh[0]);
seq09.start(seqrh[1]);
join

end

endtask




//---------------SEQUENCE 06

class uart_seq06_vseq extends vbase_seq;

`uvm_object_utils(uart_seq06_vseq)

// Standard UVM Methods:
 	extern function new(string name = "uart_seq06_vseq");
	extern task body();
	endclass  

//-----------------  constructor new method  -------------------//

// Add constructor 
	function uart_seq06_vseq::new(string name ="uart_seq06_vseq");
		super.new(name);
	endfunction

//-------------task body()------------//

task uart_seq06_vseq::body();

super.body();

seq10 = uart_seq10::type_id::create("seq10");
seq11 = uart_seq11::type_id::create("seq11");


if(m_cfg.has_agent) begin


fork 
seq10.start(seqrh[0]);
seq11.start(seqrh[1]);

join

end

endtask







//---------------SEQUENCE 07

class uart_seq07_vseq extends vbase_seq;

`uvm_object_utils(uart_seq07_vseq)

// Standard UVM Methods:
 	extern function new(string name = "uart_seq07_vseq");
	extern task body();
	endclass  

//-----------------  constructor new method  -------------------//

// Add constructor 
	function uart_seq07_vseq::new(string name ="uart_seq07_vseq");
		super.new(name);
	endfunction

//-------------task body()------------//

task uart_seq07_vseq::body();

super.body();

seq12 = uart_seq12::type_id::create("seq12");
seq13 = uart_seq13::type_id::create("seq13");


if(m_cfg.has_agent) begin


fork 
seq12.start(seqrh[0]);
seq13.start(seqrh[1]);

join

end

endtask



//---------------SEQUENCE 08

class uart_seq08_vseq extends vbase_seq;

`uvm_object_utils(uart_seq08_vseq)

// Standard UVM Methods:
 	extern function new(string name = "uart_seq08_vseq");
	extern task body();
	endclass  

//-----------------  constructor new method  -------------------//

// Add constructor 
	function uart_seq08_vseq::new(string name ="uart_seq08_vseq");
		super.new(name);
	endfunction

//-------------task body()------------//

task uart_seq08_vseq::body();

super.body();

seq14 = uart_seq14::type_id::create("seq14");
seq15 = uart_seq15::type_id::create("seq15");


if(m_cfg.has_agent) begin


fork 
seq14.start(seqrh[0]);
seq15.start(seqrh[1]);

join

end

endtask

