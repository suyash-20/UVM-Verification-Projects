class virtual_sequence extends uvm_sequence#(uvm_sequence_item);

`uvm_object_utils(virtual_sequence)

virtual_sequencer vsqrh;

ahb_sequencer ahb_seqr;
apb_sequencer apb_seqr;

bridge_env_config m_cfg;

//----------------HANDLES FOR SEQUENCES
master_sequence m_seq01;

//=====================================================
//Methods
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
//Task Body
//=====================================================

task virtual_sequence::body();

if(!uvm_config_db#(bridge_env_config)::get(null, get_full_name(),"bridge_env_config",m_cfg))
`uvm_fatal("CONFIG","Cannot get config from uvm_config")

assert($cast(vsqrh, m_sequencer))
else 
`uvm_error("TASK BODY","ERROR IN CASTING")

ahb_seqr = vsqrh.ahb_seqr;
apb_seqr = vsqrh.apb_seqr;

endtask


//=====================================================
//Extended Virtual Sequences
//=====================================================


//-----------------SEQUENCE 01

class seq01_vseq extends virtual_sequence;

`uvm_object_utils(seq01_vseq)


//=====================================================
//Methods
//=====================================================

extern function new(string name="seq01_vseq");
extern task body();
endclass

//=====================================================
//Function new
//=====================================================

function seq01_vseq::new(string name="seq01_vseq");
super.new(name);

endfunction


//=====================================================
//Task Body
//=====================================================

task seq01_vseq::body();
super.body();

m_seq01 = master_sequence::type_id::create("m_seq01");

//s_seq01 = slave_sequence::type_id::create("s_seq01");

fork

begin
m_seq01.start(ahb_seqr);
end

/*
begin
s_seq01.start(apb_seqr);
end
*/

join

endtask


