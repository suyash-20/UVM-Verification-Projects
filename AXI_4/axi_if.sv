`define DATA_WIDTH 32
`define ADDR_WIDTH 32

interface axi_if(input bit clock);

logic aresetn;
logic [`ADDR_WIDTH-1 : 0] awaddr;
logic[3:0]awlen;
logic[1:0]awburst;
logic[2:0]awsize;
logic awvalid;
logic awready;
logic [2:0]	awprot;
logic[3:0]awid;

logic [`DATA_WIDTH-1 : 0] wdata;
logic[3:0]wstrb;
logic wlast;
logic[3:0]wid;
logic wvalid;
logic wready;

logic[3:0]bid;
logic[1:0]bresp;
logic bvalid;
logic bready;

logic [`ADDR_WIDTH-1 : 0] araddr;
logic[3:0]arlen;
logic[2:0]arsize;
logic[1:0]arburst;
logic[3:0]arid;
logic arvalid;
logic arready;
logic [2:0]arprot;

logic [`DATA_WIDTH-1 : 0] rdata;
logic[3:0]rid;
logic rlast;
logic rvalid;
logic rready;
logic[1:0]rresp;





//-------------CLOCKING BLOCK-----------//

//*******MASTER DRIVER*******//
clocking m_driver_cb@(posedge clock);

default input #1 output #0;

input aresetn;
output awaddr;
output awlen;
output awsize;
output awburst;
output awprot;
output awvalid;
input awready;
output wdata;
output wstrb;
output wlast;
output wvalid;
input wready;
input bvalid;
output bready;
input bresp;

output araddr;
output arlen;
output arsize;
output arburst;
output arprot;
output arvalid;
input arready;
input rdata;
input rlast;
input rvalid;
output rready;


endclocking


//*******MASTER MONITOR*******//

clocking m_monitor_cb@(posedge clock);

default input #1 output #0;

input aresetn;
input awlen;
input awaddr;
input awsize;
input awburst;
input awprot;
input awvalid;
input awready;
input wdata;
input wstrb;
input wlast;
input wvalid;
input wready;
input bvalid;
input bready;
input bresp;

input araddr;
input arlen;
input arsize;
input arburst;
input arprot;
input arvalid;
input arready;
input rdata;
input rlast;
input rvalid;
input rready;
input rresp;

endclocking



//*******SLAVE DRIVER*******//

clocking s_driver_cb@(posedge clock);

default input #1 output #0;

input aresetn;
input awid;
input awaddr;
input awlen;
input awsize;
input awburst;
input awprot;
input awvalid;
output awready;
input wdata;
input wstrb;
input wlast;
input wvalid;
output wready;
output bvalid;
input bready;
output bid;
output bresp;

input araddr;
input arid;
input arlen;
input arsize;
input arburst;
input arprot;
input arvalid;
output arready;
output rdata;
output rlast;
output rvalid;
input rready;
output rresp;
output rid;

endclocking


//*******SLAVE MONITOR*******//

clocking s_monitor_cb@(posedge clock);

default input #1 output #0;

input aresetn;
input awid;
input awaddr;
input awlen;
input awsize;
input awburst;
input awprot;
input awvalid;
input awready;
input wdata;
input wstrb;
input wlast;
input wvalid;
input wready;
input bvalid;
input bready;
input bid;
input bresp;

input araddr;
input arid;
input arlen;
input arsize;
input arburst;
input arprot;
input arvalid;
input arready;
input rdata;
input rlast;
input rvalid;
input rready;
input rid;
input rresp;

endclocking


//-------------MODPORTS---------------//

modport M_DRV_MP(clocking m_driver_cb);

modport M_MON_MP(clocking m_monitor_cb);

modport S_DRV_MP(clocking s_driver_cb);

modport S_MON_MP(clocking s_monitor_cb);


endinterface



