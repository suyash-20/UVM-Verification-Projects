module top;

import bridge_package::*;
import uvm_pkg::*;

`include "uvm_macros.svh"

//clock generation logic
bit clock;
always
#10 clock = !clock;


//instantiation of seq_interface
bridge_if in0(clock);


rtl_top DUV (.Hclk(clock),
		.Hresetn(in0.Hresetn),
		.Htrans(in0.Htrans), 
		.Hsize(in0.Hsize), 
		.Hreadyin(in0.Hreadyin), 
		.Hwdata(in0.Hwdata), 
		.Haddr(in0.Haddr), 
		.Hwrite(in0.Hwrite), 
		.Prdata(in0.Prdata), 
		.Hrdata(in0.Hrdata), 
		.Hresp(in0.Hresp), 
		.Hreadyout(in0.Hreadyout), 
		.Pselx(in0.Pselx), 
		.Pwrite(in0.Pwrite),
		.Penable(in0.Penable), 
		.Paddr(in0.Paddr), 
		.Pwdata(in0.Pwdata));


initial
begin

 //setting the virtual interface 
 uvm_config_db#(virtual bridge_if)::set(null,"*","vif",in0);
 run_test();

end

endmodule


