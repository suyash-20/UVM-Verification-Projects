class router_wbase_seq extends uvm_sequence #(write_xtn);  
	
    `uvm_object_utils(router_wbase_seq)

    extern function new(string name ="router_wbase_seq");

endclass

//-----------------  constructor new method 
function router_wbase_seq::new(string name ="router_wbase_seq");
	super.new(name);

endfunction


//----------ROUTER SEQUENCE NUMBER 01---------------//

class router_packet_wseq01 extends router_wbase_seq;

// Factory registration using `uvm_object_utils
  	`uvm_object_utils(router_packet_wseq01)

// Standard UVM Methods:
    extern function new(string name ="router_packet_wseq01");
    extern task body();
endclass

//-----------------  constructor new method  -------------------//
function router_packet_wseq01::new(string name = "router_packet_wseq01");
	super.new(name);
endfunction

	  
//-----------------  task body method

task router_packet_wseq01::body();
    begin
        req=write_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize with {header[1:0] == 2'b10;payload.size ==17;});

            `uvm_info("RAM_WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
        finish_item(req); 
    end

endtask


//-----------------ROUTER SEQUENCE 02-------------------//

class router_packet_wseq02 extends router_wbase_seq;

    `uvm_object_utils(router_packet_wseq02)


    //STANDARD METHODS
    extern function new(string name = "router_packet_wseq02");
    extern task body();
endclass

//-----------constructornew method------------//
function router_packet_wseq02::new(string name="router_packet_wseq02");

    super.new(name);
endfunction

//--------------task body()-----------------//

task router_packet_wseq02::body();
    begin
    req = write_xtn::type_id::create("req");
    start_item(req);
    assert(req.randomize with {header[1:0]==2'b01; payload.size==14;});

        `uvm_info("RAM_WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
    finish_item(req); 
    end

endtask


//-----------------ROUTER SEQUENCE 03-------------------//

class router_packet_wseq03 extends router_wbase_seq;

    `uvm_object_utils(router_packet_wseq03)


    //STANDARD METHODS
    extern function new(string name = "router_packet_wseq03");
    extern task body();
endclass

//-----------constructornew method------------//
function router_packet_wseq03::new(string name="router_packet_wseq03");

    super.new(name);
endfunction

//--------------task body()-----------------//

task router_packet_wseq03::body();
    begin
    req = write_xtn::type_id::create("req");
    start_item(req);
    assert(req.randomize with {header[1:0]==2'b00; payload.size==14;});

        `uvm_info("RAM_WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
    finish_item(req); 
    end

endtask

