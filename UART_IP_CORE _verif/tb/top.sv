`include "../uart_rtl/timescale.v"

module top;
    //---------import uart_test_pkg
       import uart_test_pkg::*;
    
    //---------import uvm_pkg.sv
	import uvm_pkg::*;
    
    wire a;
    wire b;
    bit clk1;
    bit clk2;

    //---------Generate clock signal  
	always 
	#10 clk1= !clk1;
	
	always
	#5 clk2= !clk2;

   //---------Instantiate uart_if with clock as input
	uart_if in0(clk1);
	uart_if in1(clk2);

       
   //---------Instantiate rtl uart_chip and pass the interface instance as argument
   uart_top DUT1 (.wb_clk_i(clk1), .wb_rst_i(in0.wb_rst_i), .wb_adr_i(in0.wb_adr_i), .wb_sel_i(in0.wb_sel_i), .wb_dat_i(in0.wb_dat_i), .wb_dat_o(in0.wb_dat_o), .wb_we_i(in0.wb_we_i),.wb_stb_i(in0.wb_stb_i), .wb_cyc_i(in0.wb_cyc_i), .wb_ack_o(in0.wb_ack_o), .int_o(in0.int_o), .baud_o(in0.baud_o),.stx_pad_o(a), .srx_pad_i(b));

uart_top DUT2 (.wb_clk_i(clk2), .wb_rst_i(in1.wb_rst_i), .wb_adr_i(in1.wb_adr_i), .wb_sel_i(in1.wb_sel_i), .wb_dat_i(in1.wb_dat_i), .wb_dat_o(in1.wb_dat_o), .wb_we_i(in1.wb_we_i), .wb_stb_i(in1.wb_stb_i), .wb_cyc_i(in1.wb_cyc_i), .wb_ack_o(in1.wb_ack_o), .int_o(in1.int_o), .baud_o(in1.baud_o), .stx_pad_o(b), .srx_pad_i(a));

   //---------initial block
       	initial begin
   //---------set the virtual interface using the uvm_config_db
	uvm_config_db #(virtual uart_if)::set(null,"*","vif_0",in0);
   	uvm_config_db #(virtual uart_if)::set(null,"*","vif_1",in1);

	run_test();
	end

endmodule
