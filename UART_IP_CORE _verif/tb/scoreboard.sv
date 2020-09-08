class scoreboard extends uvm_scoreboard;

`uvm_component_utils(scoreboard)

//---------TLM analysis port handles
uvm_tlm_analysis_fifo#(trans_xtn)fifo_cmp[];

env_config m_cfg;

trans_xtn xtn[];

trans_xtn ucov_1, ucov_2;

//=====================================================
//UART REGISTER COVERAGE OPERATIONS
//=====================================================

covergroup uart_cov;

option.per_instance = 1;

//---------LCR coverpoints

LCR_1_0: coverpoint ucov_1.LCR[1:0]
	{
		bins L1 = {2'b10};
		bins L2 = {2'b11};
	}

LCR_DLR: coverpoint ucov_1.LCR[7]
	{
		bins LD = {1'b1};
	}

LCR_PAR: coverpoint ucov_1.LCR[3]
	{
		bins LP  = {1'b1};
	}

LCR_PAR_ENB: coverpoint ucov_1.LCR[4]
	{
		bins LPE  = {1'b1};
	}

//---------FCR coverpoints

FCR_TRIG_LEVEL: coverpoint ucov_1.FCR[7:6]
	{
		bins F1 = {2'b00};
	//	bins F2 = {2'b01};
		bins F3 = {2'b11};
	}

FCR_TSR_RSR: coverpoint ucov_1.FCR[2:1]
	{
		bins F4 = {2'b11};
	}

//---------IER coverpoints

IER2_0: coverpoint ucov_1.IER[2:0]
	{
		bins I1 = {3'b001};
		bins I2 = {3'b011};
		bins I3 = {3'b100};
	//	bins I4 = {3'b110};
	}

//---------IIR coverpoints

IIR3_1: coverpoint ucov_1.IIR[3:1]
	{
		bins I1 = {3'b001};
		bins I2 = {3'b011};
		bins I3 = {3'b010};
		bins I4 = {3'b110};
	}
endgroup


//=====================================================
//methods
//=====================================================

extern function new(string name = "scoreboard", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern function void check_phase(uvm_phase phase);
 
endclass


//=====================================================
//Function new
//=====================================================

function scoreboard::new(string name = "scoreboard", uvm_component parent);
super.new(name, parent);
uart_cov = new();

endfunction

//=====================================================
//Build phase
//=====================================================

function void scoreboard::build_phase(uvm_phase phase);

super.build_phase(phase);

if(!uvm_config_db#(env_config)::get(this,"","env_config",m_cfg))
`uvm_fatal("CANNOT GET THE CONFIG","HAVE YOU SET IT?")

xtn = new[m_cfg.no_of_agents];
fifo_cmp = new[m_cfg.no_of_agents];

foreach(fifo_cmp[i])
begin
fifo_cmp[i]= new($sformatf("fifo_cmp[%d]",i),this);
end

foreach(xtn[i])
begin
xtn[i] = trans_xtn::type_id::create($sformatf("xtn[%d]",i));
end

endfunction


//=====================================================
//Run phase
//=====================================================


task scoreboard::run_phase(uvm_phase phase);

forever
begin

fork

begin
fifo_cmp[0].get(xtn[0]);
xtn[0].print;
end

begin
fifo_cmp[1].get(xtn[1]);
xtn[1].print;
end

join

ucov_1 = xtn[0];
uart_cov.sample();

end

endtask


//=====================================================
//Check phase
//=====================================================


function void scoreboard::check_phase(uvm_phase phase);

super.check_phase(phase);


if(xtn[0]!=null && xtn[1]!=null)
begin

if((xtn[0].THR == xtn[1].RB))// && (xtn[0].RB == xtn[1].THR))
`uvm_info("SCOREBOARD","DATA MATCHED SUCCESSFULLY FOR UART_1", UVM_LOW)

else
`uvm_info("SCOREBOARD","DATA MISMATCH",UVM_LOW)

if((xtn[0].RB == xtn[1].THR))
`uvm_info("SCOREBOARD","DATA MATCHED SUCCESSFULLY FOR UART_2", UVM_LOW)

else
`uvm_info("SCOREBOARD","DATA MISMATCH",UVM_LOW)

end

if(xtn[0]!=null && xtn[1]!=null)
begin


if(xtn[0].THR==xtn[0].RB)
`uvm_info("SCOREBOARD","DATA MATCHED SUCCESSFULLY IN LOOP BACK MODE FOR UART_1",UVM_LOW)

else
`uvm_info("SCOREBOARD","DATA MISMATCHED IN LOOP BACK MODE IN UART_1",UVM_LOW)

end

endfunction








