module top;

import axi_package::*;

import uvm_pkg::*;

//`include "uvm_macros.svh"

bit clock;

//clock generation logic
always
#10 clock = !clock;


//instantiation of axi_interface
	axi_if in(clock);


//DUV instantiation


initial
begin

//setting the virtual interface 
uvm_config_db #(virtual axi_if)::set(null,"*","vif",in);

run_test();

end

endmodule


//ASSERTIONS FOR AXI

