//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

class read_xtn extends uvm_sequence_item;

`uvm_object_utils(read_xtn)

//------------------------------------------
// Data Members
//------------------------------------------

bit[7:0] header;
bit[7:0] payload[];
bit[7:0] parity;

bit read_enb = 1'd1;
rand bit[7:0] no_of_cycles;

//Constraints for rand variables
constraint c1{soft no_of_cycles<30;}

//------------------------------------------
// Methods
//------------------------------------------
extern function new(string name = "read_xtn");
extern function void do_print(uvm_printer printer);

endclass

//-----------------  constructor new method  -------------------//

function read_xtn:: new(string name = "read_xtn");
super.new(name);
endfunction


  //-----------------  do_print method  -------------------//

// follow the order : string name ==> bitstream value ==> size ==> radix type

function void read_xtn::do_print(uvm_printer printer);
super.do_print(printer);
printer.print_field("header", this.header, 8, UVM_DEC);

foreach(payload[i])
printer.print_field($sformatf("payload[%0d]",i), this.payload[i], 8, UVM_DEC);

printer.print_field("parity", this.parity, 8, UVM_DEC);
printer.print_field("no_of_cycles", this.no_of_cycles, 8, UVM_DEC);

endfunction
