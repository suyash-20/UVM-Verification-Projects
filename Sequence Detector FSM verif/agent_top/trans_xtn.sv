class trans_xtn extends uvm_sequence_item;

`uvm_object_utils(trans_xtn)

bit reset;
bit din;
bit dout;
//lol that's it?

//=====================================================
//methods
//=====================================================

extern function new(string name="trans_xtn");
extern function void do_print(uvm_printer printer);

//constraint d_input{din dist {0:/50, 1:/50};}

endclass

//=====================================================
//Function new
//=====================================================

function trans_xtn::new(string name="trans_xtn");
super.new();
endfunction

//=====================================================
//Function do_print
//=====================================================

function void trans_xtn::do_print(uvm_printer printer);

printer.print_field("din", this.din, 1, UVM_BIN);
endfunction




