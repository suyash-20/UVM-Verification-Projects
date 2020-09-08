class trans_xtn extends uvm_sequence_item;

`uvm_object_utils(trans_xtn)

rand bit[2:0]wb_adr_i;
rand bit[7:0]wb_dat_i;
rand bit wb_we_i;
bit[7:0]LCR;
bit[7:0]RB[$];
bit[7:0]IER;
bit[7:0]IIR;
bit[7:0]FCR;
bit[7:0]LSR;
bit[7:0]DLLSB;
bit[7:0]THR[$];
bit[7:0]DLMSB;

bit[7:0]wb_dat_o;

int i =17;

//=====================================================
//methods
//=====================================================

extern function void do_print(uvm_printer printer);

endclass

//=====================================================
//do print method
//=====================================================

function void trans_xtn::do_print(uvm_printer printer);

printer.print_field("wb_dat_i",		this.wb_dat_i,		8,		UVM_DEC);

printer.print_field("wb_dat_o",		this.wb_dat_o,		8,		UVM_DEC);

printer.print_field("LCR",		this.LCR,		8,		UVM_BIN);

printer.print_field("DLLSB",		this.DLLSB,		8,		UVM_BIN);

printer.print_field("DLMSB",		this.DLMSB,		8,		UVM_BIN);

printer.print_field("LSR",		this.LSR,		8,		UVM_BIN);

printer.print_field("FCR",		this.FCR,		8,		UVM_BIN);

printer.print_field("IIR",		this.IIR,		8,		UVM_BIN);

printer.print_field("IER",		this.IER,		8,		UVM_BIN);

foreach(THR[i])
printer.print_field($sformatf("THR[%0d]",i),		this.THR[i],		8,		UVM_DEC);

//printer.print_field("THR",		this.THR,		8,		UVM_DEC);

foreach(THR[i])
printer.print_field($sformatf("RB[%0d]",i),		this.RB[i],		8,		UVM_DEC);

//printer.print_field("RB",		this.RB,		8,		UVM_DEC);

endfunction