module top;

import seq_package::*;
import uvm_pkg::*;

`include "uvm_macros.svh"

//clock generation logic
bit clock;
always
#10 clock = !clock;


//instantiation of seq_interface
seq_if in0(clock);

//DUV instantiation
seq_1010 DUV (.clock(clock),
	 .din(in0.din),
	 .reset(in0.reset),
	 .dout(in0.dout));

initial
begin

//setting the virtual interface 
uvm_config_db#(virtual seq_if)::set(null,"*","vif",in0);

run_test();

end

endmodule

