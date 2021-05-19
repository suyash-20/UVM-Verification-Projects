class axi_scoreboard extends uvm_scoreboard;

`uvm_component_utils(axi_scoreboard)


axi_env_config m_cfg;

axi_xtn m_xtn, s_xtn;

uvm_tlm_analysis_fifo#(axi_xtn)m_fifo;
uvm_tlm_analysis_fifo#(axi_xtn)s_fifo;

//transaction handles for coverage instances
axi_xtn acov1, acov2;

//AXI COVERAGE COVERGROUP

covergroup axi_cov;

option.per_instance = 1;

//WRITE_STRB COVERPOINTS

//wstrb_c: coverpoint acov1.wstrb

//AWBURST COVERPOINTS

awburst_c: coverpoint acov1.awburst[1:0]
{
bins FIXED = {2'b00};
bins INCR = {2'b01};
bins WRAP = {2'b10};
}

arburst_c: coverpoint acov1.arburst[1:0]
{
bins FIXED = {2'b00};
bins INCR = {2'b01};
bins WRAP = {2'b10};
}

awsize_c: coverpoint acov1.awsize[2:0]
{
bins BYTES_1 = {[0:7]};
}

arsize_c: coverpoint acov1.arsize[2:0]
{
bins BYTES_1 = {[0:7]};
}

awlen_c: coverpoint acov1.awlen[3:0]
{
bins AWLEN_1 = {[1:15]};
//bins AWLEN_2 = {[17:255]};

}

arlen_c: coverpoint acov1.arlen[3:0]
{
bins ARLEN_1 = {[1:15]};
//bins ARLEN_2 = {[17:255]};

}






endgroup


//standard functions
extern function new(string name = "axi_scoreboard", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern function void check_phase(uvm_phase phase);

endclass


function axi_scoreboard::new(string name = "axi_scoreboard", uvm_component parent);
super.new(name, parent);
axi_cov = new();
m_fifo = new("m_fifo",this);
s_fifo = new("s_fifo",this);

endfunction

function void axi_scoreboard::build_phase(uvm_phase phase);

super.build_phase(phase);

//tlm fifo instance creation

m_xtn = axi_xtn::type_id::create("m_xtn");
s_xtn = axi_xtn::type_id::create("s_xtn");
endfunction


task axi_scoreboard::run_phase(uvm_phase phase);

forever begin
fork

begin
m_fifo.get(m_xtn);
m_xtn.print;
end

begin
s_fifo.get(s_xtn);
s_xtn.print;
end
join
acov1 = m_xtn;

axi_cov.sample();

end
endtask

function void axi_scoreboard::check_phase(uvm_phase phase);

super.check_phase(phase);

if(m_xtn.wdata == s_xtn.wdata)
`uvm_info( "AXI_SCOREBOARD","DATA MATCHED SUCCESSFULLY", UVM_LOW)
else
`uvm_info( "AXI_SCOREBOARD","DATA MISMATCHED", UVM_LOW)

if(m_xtn.rdata == s_xtn.rdata)
`uvm_info( "AXI_SCOREBOARD","DATA MATCHED SUCCESSFULLY", UVM_LOW)
else
`uvm_info( "AXI_SCOREBOARD","DATA MISMATCHED", UVM_LOW)


endfunction
