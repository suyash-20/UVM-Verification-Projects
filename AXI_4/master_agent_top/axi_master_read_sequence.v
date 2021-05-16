class axi_master_read_sequence extends uvm_sequence#(axi_xtn);

`uvm_object_utils(axi_master_read_sequence)

extern function new(string name = "axi_master_read_sequence");

endclass


function axi_master_read_sequence::new(string name = "axi_master_read_sequence");
super.new(name);

endfunction


//-------------AXI_SEQUENCE_01___FIXED BURST TYPE

class axi_mread_sequence_01 extends axi_master_read_sequence;

`uvm_object_utils(axi_mread_sequence_01)

extern function new(string name = "axi_mread_sequence_01");
extern task body();

endclass

function axi_mread_sequence_01::new(string name = "axi_mread_sequence_01");
super.new(name);

endfunction

task axi_mread_sequence_01::body();
begin

req =axi_xtn::type_id::create("req");
start_item(req);

assert(req.randomize with {arburst==2'd0; arsize inside {[0:7]};});

`uvm_info("AXIMASTER_READ_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 

finish_item(req); 
end
endtask

//-------------AXI_SEQUENCE_02___INCR BURST TYPE

class axi_mread_sequence_02 extends axi_master_read_sequence;

`uvm_object_utils(axi_mread_sequence_02)

extern function new(string name = "axi_mread_sequence_02");
extern task body();

endclass

function axi_mread_sequence_02::new(string name = "axi_mread_sequence_02");
super.new(name);

endfunction

task axi_mread_sequence_02::body();
begin

req =axi_xtn::type_id::create("req");
start_item(req);

assert(req.randomize with {arburst ==2'd1; arsize inside {[0:7]};});

`uvm_info("AXIMASTER_READ_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 

finish_item(req); 
end
endtask


//-------------AXI_SEQUENCE_03___WRAP BURST TYPE

class axi_mread_sequence_03 extends axi_master_read_sequence;

`uvm_object_utils(axi_mread_sequence_03)

extern function new(string name = "axi_mread_sequence_03");
extern task body();

endclass

function axi_mread_sequence_03::new(string name = "axi_mread_sequence_03");
super.new(name);

endfunction

task axi_mread_sequence_03::body();
begin

req =axi_xtn::type_id::create("req");
start_item(req);

assert(req.randomize with {arburst == 2'd2; arsize inside {[0:7]};});
//assert(req.randomize with {wstrb inside {4'b0001, 4'b0010, 4'b0100, 4'b1000};});
//assert(req.randomize with {awsize inside {[0:7]};})

`uvm_info("AXIMASTER_READ_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 

finish_item(req); 
end
endtask
