//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

class router_rbase_seq extends uvm_sequence#(read_xtn);

//factory registration
`uvm_object_utils(router_rbase_seq)

//------------------------------------------
// Methods
//------------------------------------------
extern function new(string name = "router_rbase_seq");

endclass

//-----------------  constructor new method  -------------------//

function router_rbase_seq ::new(string name = "router_rbase_seq");
	super.new(name);
endfunction


//---------------ROUTER SEQUENCE 01-----------//

//class extension

class router_packet_rseq01 extends router_rbase_seq;

//factory registration
 
 `uvm_object_utils(router_packet_rseq01)
 
 //Standard Methods 
 extern function new(string name = "router_packet_rseq01");
 extern task body();
 
 endclass

 
//------------constructor new method-------------//
 
 function router_packet_rseq01::new(string name = "router_packet_rseq01");
	super.new(name);
	
endfunction

//-------------task body()--------------//

task router_packet_rseq01::body();

req = read_xtn::type_id::create("req");

start_item(req);
assert(req.randomize with {no_of_cycles == 25;});

finish_item(req);

endtask

//-----------------ROUTER SEQUENCE 02-------------//

class router_packet_rseq02 extends router_rbase_seq;

`uvm_object_utils(router_packet_rseq02)

//Standard methods 
extern function new(string name = "router_packet_rseq02");
extern task body();

endclass

//------------constructor new method-------------//

function router_packet_rseq02::new(string name="router_packet_rseq02");

super.new(name);

endfunction

//-------------task body()--------------//

task router_packet_rseq02::body();

req = read_xtn::type_id::create("req");
start_item(req);
assert(req.randomize with {no_of_cycles == 131;});
finish_item(req);

endtask


//-------------------SEQUENCE 03 (TIME_OUT)-------------------//

class router_packet_rseq03 extends router_rbase_seq;

`uvm_object_utils(router_packet_rseq03)

//Standard methods
extern function new(string name = "router_packet_rseq03");
extern task body();

endclass

//------------constructor new method-------------//

function router_packet_rseq03::new(string name = "router_packet_rseq03");
super.new(name);
endfunction

//-------------task body()--------------//

task router_packet_rseq03::body();

req = read_xtn::type_id::create("req");

start_item(req);
assert(req.randomize with {no_of_cycles<=21;});
finish_item(req);

endtask



