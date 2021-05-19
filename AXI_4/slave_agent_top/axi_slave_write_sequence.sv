class axi_slave_write_sequence extends uvm_sequence#(axi_xtn);

`uvm_object_utils(axi_slave_write_sequence)

extern function new(string name = "axi_slave_write_sequence");

endclass


function axi_slave_write_sequence::new(string name = "axi_slave_write_sequence");
super.new(name);

endfunction


//-------------AXI_SEQUENCE_01___FIXED BURST TYPE

class axi_swrite_sequence_01 extends axi_slave_write_sequence;

`uvm_object_utils(axi_swrite_sequence_01)

extern function new(string name = "axi_swrite_sequence_01");
extern task body();

endclass

function axi_swrite_sequence_01::new(string name = "axi_swrite_sequence_01");
super.new(name);

endfunction

task axi_swrite_sequence_01::body();
begin

req =axi_xtn::type_id::create("req");
start_item(req);

`uvm_info("AXI_SLAVE_WRITE_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 

finish_item(req); 
end
endtask

/*
//-------------AXI_SEQUENCE_02___INCR BURST TYPE

class axi_swrite_sequence_02 extends axi_master_write_sequence;

`uvm_object_utils(axi_swrite_sequence_02)

extern function new(string name = "axi_swrite_sequence_02");
extern task body();

endclass

function axi_swrite_sequence_02::new(string name = "axi_swrite_sequence_02");
super.new(name);

endfunction

task axi_swrite_sequence_02::body();
begin

req =axi_xtn::type_id::create("req");
start_item(req);

assert(req.randomize with {awburst inside {1}; wdata inside {[0:71]};awsize inside {[0:7]};});
//assert(req.randomize with {wstrb inside {4'b0001, 4'b0010, 4'b0100, 4'b1000};});
//assert(req.randomize with {awsize inside {[0:7]};})

`uvm_info("AXI_SLAVE_WRITE_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 

finish_item(req); 
end
endtask


//-------------AXI_SEQUENCE_03___WRAP BURST TYPE

class axi_swrite_sequence_03 extends axi_master_write_sequence;

`uvm_object_utils(axi_swrite_sequence_03)

extern function new(string name = "axi_swrite_sequence_03");
extern task body();

endclass

function axi_swrite_sequence_03::new(string name = "axi_swrite_sequence_03");
super.new(name);

endfunction

task axi_swrite_sequence_03::body();
begin

req =axi_xtn::type_id::create("req");
start_item(req);

assert(req.randomize with {awburst inside {2}; wdata inside {[0:71]};awsize inside {[0:7]};});
//assert(req.randomize with {wstrb inside {4'b0001, 4'b0010, 4'b0100, 4'b1000};});
//assert(req.randomize with {awsize inside {[0:7]};})

`uvm_info("AXI_SLAVE_WRITE_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 

finish_item(req); 
end
endtask
*/
