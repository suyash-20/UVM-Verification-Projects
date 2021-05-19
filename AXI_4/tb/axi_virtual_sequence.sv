class axi_virtual_sequence extends uvm_sequence#(uvm_sequence_item);

`uvm_object_utils(axi_virtual_sequence)

axi_master_sequencer ms_seqrh;
axi_slave_sequencer sl_seqrh;

axi_virtual_sequencer vseqrh;

//handles for sequence instances

//handles for master_write
axi_mwrite_sequence_01 mw01;
axi_mwrite_sequence_02 mw02;
axi_mwrite_sequence_03 mw03;

//handles for master read
axi_mread_sequence_01 mr01;
axi_mread_sequence_02 mr02;
axi_mread_sequence_03 mr03;

//handles for slave write
axi_swrite_sequence_01 sw01;

//handles for slave read
axi_sread_sequence_01 sr01;

extern function new(string name = "axi_virtual_sequence");
extern task body();

endclass


function axi_virtual_sequence::new(string name = "axi_virtual_sequence");
super.new(name);

endfunction


task axi_virtual_sequence::body();

assert($cast(vseqrh, m_sequencer))
else
`uvm_error("VIRTUAL_SEQUENCE","Error in Casting")

ms_seqrh = vseqrh.ms_seqrh;
$display("%p",ms_seqrh);

sl_seqrh = vseqrh.sl_seqrh;
$display("%p",sl_seqrh);

endtask


//virtual sequences

//FIXED BURST TYPE

class axi_seq01_vseq extends axi_virtual_sequence;
`uvm_object_utils(axi_seq01_vseq)

extern function new(string name = "axi_seq01_vseq");
extern task body();

endclass


function axi_seq01_vseq::new(string name = "axi_seq01_vseq");
super.new(name);

endfunction


task axi_seq01_vseq::body();
begin

super.body();

mw01 = axi_mwrite_sequence_01::type_id::create("mw01");
mr01 = axi_mread_sequence_01::type_id::create("mr01");

sw01 = axi_swrite_sequence_01::type_id::create("sw01");
sr01 = axi_sread_sequence_01::type_id::create("sr01");

fork 
mw01.start(ms_seqrh);
//mr01.start(ms_seqrh);

sw01.start(sl_seqrh);
//sr01.start(sl_seqrh);
join

end

endtask


//INCR BURST TYPE

class axi_seq02_vseq extends axi_virtual_sequence;
`uvm_object_utils(axi_seq02_vseq)

extern function new(string name = "axi_seq02_vseq");
extern task body();

endclass


function axi_seq02_vseq::new(string name = "axi_seq02_vseq");
super.new(name);

endfunction


task axi_seq02_vseq::body();
begin

super.body();

mw02 = axi_mwrite_sequence_02::type_id::create("mw02");
mr02 = axi_mread_sequence_02::type_id::create("mr02");

sw01 = axi_swrite_sequence_01::type_id::create("sw01");
sr01 = axi_sread_sequence_01::type_id::create("sr01");

fork
begin
mw02.start(ms_seqrh);
mr02.start(ms_seqrh);
end
begin
sw01.start(sl_seqrh);
sr01.start(sl_seqrh);
end
join

end

endtask


//WRAPPING BURST TYPE


class axi_seq03_vseq extends axi_virtual_sequence;
`uvm_object_utils(axi_seq03_vseq)

extern function new(string name = "axi_seq03_vseq");
extern task body();

endclass


function axi_seq03_vseq::new(string name = "axi_seq03_vseq");
super.new(name);

endfunction


task axi_seq03_vseq::body();
begin

super.body();

mw03 = axi_mwrite_sequence_03::type_id::create("mw03");
mr03 = axi_mread_sequence_03::type_id::create("mr03");

sw01 = axi_swrite_sequence_01::type_id::create("sw01");
sr01 = axi_sread_sequence_01::type_id::create("sr01");

fork 
mw03.start(ms_seqrh);
mr03.start(ms_seqrh);

sw01.start(sl_seqrh);
sr01.start(sl_seqrh);
join

end

endtask
