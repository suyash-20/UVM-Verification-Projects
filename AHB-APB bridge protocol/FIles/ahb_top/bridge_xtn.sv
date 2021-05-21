class bridge_xtn extends uvm_sequence_item;

`uvm_object_utils(bridge_xtn)

rand logic[31:0]Haddr;
rand logic[2:0]Hsize;
rand logic[2:0]Hburst;
rand logic Hwrite, Hreadyin;
rand logic[3:0]length;
rand logic[31:0]Hwdata, Hrdata;
rand logic[1:0]Htrans;

constraint hwrite_value{Hwrite dist {0:/50, 1:/50};}
constraint valid_size{Hsize inside {[0:2]};}
constraint valid_length{2^^Hsize*length<=1024;}
constraint valid_Haddr{Hsize == 1 -> Haddr%2==0;
                        Hsize ==2 -> Haddr%4==0; }

constraint valid_Haddr_1{Haddr inside {[32'h8000_0000:32'h8000_03ff], [32'h8400_0000:32'h8400_03ff], [32'h8800_0000:32'h8800_03ff], [32'h8c00_0000:32'h8c00_03ff]};}

extern function void do_print(uvm_printer printer);

endclass


function void bridge_xtn::do_print(uvm_printer printer);

printer.print_field("Haddr",		this.Haddr,	    	32,		UVM_DEC);
printer.print_field("Hsize",		this.Hsize,	    	3,		UVM_DEC);
printer.print_field("Hburst",		this.Hburst,		3,		UVM_DEC);
printer.print_field("Length",		this.length,		4,		UVM_DEC);
printer.print_field("Hreadyin",		this.Hreadyin,		1,		UVM_BIN);
printer.print_field("Hwrite",		this.Hwrite,		1,		UVM_BIN);
printer.print_field("Hwdata",		this.Hwdata,		32,		UVM_DEC);
printer.print_field("Hrdata",		this.Hrdata,		32,		UVM_DEC);
printer.print_field("Htrans",		this.Htrans,		2,		UVM_BIN);

endfunction

