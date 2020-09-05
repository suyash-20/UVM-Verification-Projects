interface seq_if(input bit clock);

logic reset;
logic din;
logic dout;

//-------CLOCKING BLOCK

clocking driver_cb@(posedge clock);

default input#1 output #0;

output reset;
output din;

endclocking


clocking monitor_cb@(posedge clock);

default input #1 output #0;

input reset;
input din;
input dout;

endclocking

//-------MODPORTS


modport DRV_MP(clocking driver_cb);
modport MON_MP(clocking monitor_cb);

endinterface
