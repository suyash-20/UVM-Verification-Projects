class virtual_sequence extends uvm_sequence#(uvm_sequence_item);
`uvm_object_utils(virtual_sequence)

seq_sequencer s_seqrh;
virtual_sequencer vseqrh;
seq_env_config m_cfg;

//---------handles for sequences
seq_sequence_1 seq01;

//=====================================================
//methods
//=====================================================

extern function new(string name = "virtual_sequence");
extern task body();
endclass

//=====================================================
//Function new
//=====================================================

function virtual_sequence::new(string name = "virtual_sequence");
super.new(name);
endfunction

//=====================================================
//Task body
//=====================================================

task virtual_sequence::body();

if(!uvm_config_db#(seq_env_config)::get(null, get_full_name(),"env_config",m_cfg))
`uvm_fatal("CONFIG","Cannot get config from uvm_config")

assert($cast(vseqrh, m_sequencer))
else
`uvm_error("Virtual Sequence","Error in casting");

s_seqrh = vseqrh.s_seqr;

endtask

//=====================================================
//Extended Virtual Sequences
//=====================================================


//---------------SEQUENCE 01

class seq01_vseq extends virtual_sequence;

`uvm_object_utils(seq01_vseq)

//=====================================================
//methods
//=====================================================

 	extern function new(string name = "seq01_vseq");
	extern task body();
	endclass  

//=====================================================
//Function new
//=====================================================

	function seq01_vseq::new(string name ="seq01_vseq");
		super.new(name);
	endfunction

//=====================================================
//Task body
//=====================================================

task seq01_vseq::body();

super.body();

seq01 = seq_sequence_1::type_id::create("seq01");

if(m_cfg.has_agent) begin

seq01.start(s_seqrh);

end

endtask
