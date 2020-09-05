class seq_sequence extends uvm_sequence#(trans_xtn);

`uvm_object_utils(seq_sequence)

//=====================================================
//methods
//=====================================================

extern function new(string name="seq_sequence");
endclass

//=====================================================
//Function new
//=====================================================

function seq_sequence::new(string name="seq_sequence");
super.new(name);
endfunction

//----------------SEQUENCE #1

class seq_sequence_1 extends seq_sequence;

`uvm_object_utils(seq_sequence_1)

//=====================================================
//methods
//=====================================================

extern function new(string name = "seq_sequence_1");
extern task body();

endclass

//=====================================================
//Function new
//=====================================================

function seq_sequence_1::new(string name = "seq_sequence_1");
super.new(name);

endfunction

//=====================================================
//Task body
//=====================================================
task seq_sequence_1::body();
begin

req =trans_xtn::type_id::create("req");
start_item(req);

repeat(4) begin
//assert(req.randomize());
//assert(req.randomize with {din dist {0:/50, 1:/50};});
end

`uvm_info("SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
finish_item(req); 

end
endtask

//ALTERNATE LOGICS FOR GENERATING SEQUENCE ITEM
/*
//----------------SEQUENCE #1

class seq_sequence_1 extends seq_sequence;

`uvm_object_utils(seq_sequence_1)

//=====================================================
//methods
//=====================================================

extern function new(string name = "seq_sequence_1");
extern task body();

endclass

//=====================================================
//Function new
//=====================================================

function seq_sequence_1::new(string name = "seq_sequence_1");
super.new(name);

endfunction

//=====================================================
//Task body
//=====================================================

task seq_sequence_1::body();
begin

req =trans_xtn::type_id::create("req");
start_item(req);

	assert (req.randomize() with { din == 1'b1;})

	finish_item(req);



	start_item(req);

	assert (req.randomize() with { din ==1'b0;})

	finish_item(req);



	start_item(req);

	assert (req.randomize() with { din == 1'b1;})

	finish_item(req);



	start_item(req);

	assert (req.randomize() with { din ==1'b0;})

	finish_item(req);

end
endtask



/*
class seq_sequence_1 extends seq_sequence;

`uvm_object_utils(seq_sequence_1)

//=====================================================
//methods
//=====================================================

extern function new(string name = "seq_sequence_1");
extern task body();

endclass

//=====================================================
//Function new
//=====================================================

function seq_sequence_1::new(string name = "seq_sequence_1");
super.new(name);

endfunction

//=====================================================
//Task body
//=====================================================

task seq_sequence_1::body();
begin

req =trans_xtn::type_id::create("req");
start_item(req);

repeat(4) begin
//assert(req.randomize());
//assert(req.randomize with {din dist {0:/50, 1:/50};});
end

`uvm_info("SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
finish_item(req); 

end
endtask

*/