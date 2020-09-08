class sequencer extends uvm_sequencer#(trans_xtn);
`uvm_component_utils(sequencer)

//=====================================================
//methods
//=====================================================

extern function new(string name="sequencer",uvm_component parent);
endclass

//=====================================================
//function new
//=====================================================

function sequencer::new(string name="sequencer",uvm_component parent);
        super.new(name,parent);
endfunction
