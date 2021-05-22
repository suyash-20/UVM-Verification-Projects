module top;
  
    //import router_pkg.sv
    import router_package::*;
    
    // import the UVM package
  	import uvm_pkg::*; 

    `include "uvm_macros.svh"
    
    bit clock;
    always
      #10 clock = !clock;

    //Instantiating the router interface

    router_if in(clock);
    router_if in0(clock);
    router_if in1(clock);
    router_if in2(clock);

	//Instantiating the Router DUV with the interfaces
	router_top DUV(.clock(clock),.resetn(in.resetn), .data_in(in.data_in), .pkt_valid(in.pkt_valid),.err(in.err), .busy(in.busy), .vld_out_0(in0.vld_out), .read_enb_0(in0.read_enb), .data_out_0(in0.data_out),  .vld_out_1(in1.vld_out), .read_enb_1(in1.read_enb), .data_out_1(in1.data_out),  .vld_out_2(in2.vld_out), .read_enb_2(in2.read_enb), .data_out_2(in2.data_out));

	initial begin
        uvm_config_db#(virtual router_if)::set(null,"*","vif",in);
        uvm_config_db#(virtual router_if)::set(null,"*","vif_0",in0);
        uvm_config_db#(virtual router_if)::set(null,"*","vif_1",in1);
        uvm_config_db#(virtual router_if)::set(null,"*","vif_2",in2);

        run_test("router_first_test");
	end


//-----------------  ASSERTIONS  -------------------//

sequence s1;
    (DUV.busy ##1 (DUV.data_in==$past(DUV.data_in,1)));
endsequence

property p1;
    @(posedge clock) $rose(DUV.pkt_valid) |=> s1;
endproperty

ASSERT_1 : assert property(p1)
    $info("ASSERTION A1 PASS", $time);


property p2;
    @(posedge clock) $rose(in0.vld_out || in1.vld_out || in2.vld_out) |-> ##[1:30](in0.read_enb || in1.read_enb || in2.read_enb);
endproperty

ASSERT_2 : assert property(p2)
    $display("ASSERTION 2 PASSED", $time);

/*
sequence s3;
    (DUV.CHECK_PARITY_ERROR);
endsequence

property p3;
    @(posedge clock) $rose(DUV.pkt_valid)|=> (DUV.pkt_valid) throughout s3;
endproperty

ASSERT_3: assert property(p3)
    $display("ASSERTION 3 PASSED");
*/
  
endmodule

