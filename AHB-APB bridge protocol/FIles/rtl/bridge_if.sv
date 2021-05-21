`include "definitions.v"

interface bridge_if(input bit clock);

logic [`WIDTH-1:0]Hwdata, Hrdata, Haddr, Paddr, Pwdata, Prdata;
logic [1:0]Htrans, Hresp;
logic [2:0]Hsize, Hburst;
logic Hwrite;
logic Hresetn;
logic Hreadyin, Hreadyout, Pwrite, Penable;
logic [`SLAVES-1:0]Pselx;

clocking ahb_driver_cb@(posedge clock);
default input #1 output #0;

input Hreadyout;
input Hrdata;
input Hresp;
output Haddr;
output Hwdata;
output Hwrite;
output Hresetn;
output Hreadyin;
output Htrans;
output Hsize;
output Hburst;

endclocking


clocking ahb_monitor_cb@(posedge clock);
default input #1 output #0;

input Hreadyout;
input Hrdata;
input Hresp;
input Haddr;
input Hwdata;
input Hwrite;
input Hresetn;
input Hreadyin;
input Htrans;
input Hsize;
input Hburst;

endclocking


clocking apb_driver_cb@(posedge clock);
default input #1 output #0;

input Pwdata;
input Paddr;
input Pwrite;
input Penable;
input Pselx;
output Prdata; 

endclocking


clocking apb_monitor_cb@(posedge clock);
default input #1 output #0;

input Pwdata;
input Paddr;
input Haddr;
input Pwrite;
input Penable;
input Pselx;
input Prdata;

endclocking

modport AHB_DRV_MP(clocking ahb_driver_cb);
modport AHB_MON_MP(clocking ahb_monitor_cb);
modport APB_DRV_MP(clocking apb_driver_cb);
modport APB_MON_MP(clocking apb_monitor_cb);

endinterface

