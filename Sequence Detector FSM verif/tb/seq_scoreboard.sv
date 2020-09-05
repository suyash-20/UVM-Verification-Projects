class seq_scoreboard extends uvm_scoreboard;

`uvm_component_utils(seq_scoreboard)

//---------TLM analysis fifo port handles
uvm_tlm_analysis_fifo#(trans_xtn)fifo_cmp;

//---------ENV config handle
seq_env_config m_cfg;

//---------declaring handles for xtn classes to store the fifo data
trans_xtn xtn;

logic[3:0]ref_dout; //first logic

//---------handle declaration for coverage models
trans_xtn s_cov;

//=====================================================
//Covergroups
//=====================================================

covergroup seq_cov;

option.per_instance = 1;

DIN: coverpoint s_cov.din{bins din_1 = {1'b1};
			  bins din_2 = {1'b0};}

endgroup

//=====================================================
//methods
//=====================================================

extern function new(string name="seq_scoreboard", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task reg_write(trans_xtn wr);

endclass


//=====================================================
//Function new
//=====================================================

function seq_scoreboard::new(string name="seq_scoreboard", uvm_component parent);
super.new(name, parent);

//creating instance for coverage paramters
seq_cov = new();

endfunction


//=====================================================
//Build phase
//=====================================================

function void seq_scoreboard::build_phase(uvm_phase phase);
super.build_phase(phase);
//get the config if there are multiple analysis fifos

fifo_cmp = new("fifo_cmp", this);
xtn = trans_xtn::type_id::create("xtn");

endfunction


//=====================================================
//Run phase
//=====================================================

task seq_scoreboard::run_phase(uvm_phase phase);
forever
begin
fifo_cmp.get(xtn);
reg_write(xtn);

//---------handle assignment for covearge handle and xtn handle
s_cov = xtn;

//---------sample the coverage
seq_cov.sample();

end
endtask


//=====================================================
//reg_write
//=====================================================

task seq_scoreboard::reg_write(trans_xtn wr);

ref_dout = {ref_dout[2:0],wr.din};

$display("------------------------------------------------------------------------------------");

$display("________________FROM SCOREBOARD_________________");

$display($time,"SEQUENCE ACQUIRED TILL NOW IN REFERENCE REGISTER %b",ref_dout);

$display("DIN VALUE IS %b", wr.din);
if(ref_dout==4'b1010) 
begin
`uvm_info("Scoreboard","SEQUENCE MATCH",UVM_MEDIUM)
end
else
`uvm_info("Scoreboard","SEQUENCE MISMATCH",UVM_MEDIUM)

endtask



