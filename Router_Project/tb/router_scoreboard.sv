//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

class router_scoreboard extends uvm_scoreboard;

`uvm_component_utils(router_scoreboard)

//TLM analysis port handles
uvm_tlm_analysis_fifo#(read_xtn)fifo_rdh[];
uvm_tlm_analysis_fifo#(write_xtn)fifo_wrh;

//ENV config handle
router_env_config m_cfg;

//declaring variables for scoreboard operations
int wr_xtns, rd_xtns, xtns_compared, xtns_dropped;

//declaring an associative array for reference model
//logic[63:0]ref_packet[int];

//declaring handles for read_xtn and write)xtn classes to store the fifo data
write_xtn wr_data;
read_xtn rd_data;


//handle declaration for coverage models
write_xtn wr_cov;
read_xtn rd_cov;

//------------------------ covergroup logic --------------------//
covergroup router_wcov with function sample(bit[7:0] payload);
option.per_instance = 1;


//-----------------WRITE OPERATION COVERAGE SECTION

//HEADER
HEADER: coverpoint wr_cov.header[1:0]{
	bins low = {0};
	bins mid2 = {1};
	bins mid1 = {2};
}

HEADER1: coverpoint wr_cov.header[7:2]{
	bins low = {[0:20]}; 
	bins mid1 = {[21:40]};
	bins mid2 = {[41:50]};
	bins high = {[51:63]};
}

//PAYLOAD 
PAYLOAD : coverpoint payload{
	bins low = {[0:50]};
	bins mid2 = {[101:150]};
	bins mid1 = {[51:100]};
	bins mid3 = {[151:200]};
	bins high ={[201:255]};
	}
endgroup


//------------------READ OPERATION COVERAGE SECTION

covergroup router_rcov with function sample(bit[7:0] payload);
option.per_instance = 1;

//HEADER
HEADER: coverpoint rd_cov.header[1:0]{
	bins low = {0};
	bins mid2 = {1};
	bins mid1 = {2};

	}
HEADER1: coverpoint rd_cov.header[7:2]{
	bins low = {[0:63]}; 
	bins mid1 = {[21:40]};
	bins mid2 = {[41:50]};
	bins high = {[51:63]};
}


//PAYLOAD 
PAYLOAD : coverpoint payload{
	bins low = {[0:50]};
	bins mid2 = {[101:150]};
	bins mid1 = {[51:100]};
	bins mid3 = {[151:200]};
	bins high ={[201:255]};
	}

//READ_ENB SIGNAL
READ_ENB : coverpoint rd_cov.read_enb{
bins read_bin = {1};
}	

endgroup


//------------------------------------------
// Methods
//------------------------------------------

extern function new(string name, uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
//extern function void packet_write(write_xtn wr);
//extern function bit packet_read(ref read_xtn rd);
extern task check_data(write_xtn wr, read_xtn rd);
extern function void check_phase(uvm_phase phase);

endclass


//-----------------  constructor new method  -------------------//

function router_scoreboard::new(string name, uvm_component parent);
super.new(name, parent);

//creating instance for coverage paramters
router_wcov = new();
router_rcov = new();

endfunction

//-----------------  build() phase method  -------------------//

function void router_scoreboard::build_phase(uvm_phase phase);
super.build_phase(phase);
//getting the config info of router_env_config from TEST for dynamic declaration of read fifo

if(!uvm_config_db#(router_env_config)::get(this,"","router_env_config",m_cfg))
`uvm_fatal("ROUTER_SCOREBOARD","cannot get the config, have you set it -__-")

fifo_wrh=new("fifo_wrh",this);

fifo_rdh = new[m_cfg.no_of_read_agents];

foreach(fifo_rdh[i])
fifo_rdh[i]= new($sformatf("fifo_rdh[%0d]",i),this);

endfunction


//-----------------  Run phase method  -------------------//

task router_scoreboard::run_phase(uvm_phase phase);
forever
begin
fork
 fifo_wrh.get(wr_data);
 begin
 fork
 fifo_rdh[0].get(rd_data);
 fifo_rdh[1].get(rd_data);
 fifo_rdh[2].get(rd_data);
 join_any
disable fork;
end
join

// check_data(wr_data, rd_data);

wr_cov = wr_data;
rd_cov = rd_data;

foreach(wr_cov.payload[i]) begin   //FOR DYNAMIC VARIABLE COVEARGE
router_wcov.sample(wr_cov.payload[i]);
 router_rcov.sample(rd_cov.payload[i]);
end
end

endtask


//-----------------  check_data task  -------------------//

task router_scoreboard::check_data(write_xtn wr, read_xtn rd);

if(wr.header == rd.header)
	begin
		`uvm_info("ROUTER_SCOREBOARD","HEADER MATCH IS SUCCESSFUL",UVM_MEDIUM)
		foreach(wr.payload[i])
			begin
				if(wr.payload[i] == rd.payload[i])
					`uvm_info("ROUTER_SCOREBOARD","PAYLOAD MATCH SUCCESSFUL",UVM_MEDIUM)
				else
					`uvm_fatal("ROUTER_SCOREBOARD","PAYLOAD MISMATCH")

			end

			if(wr.parity == rd.parity)
				`uvm_info("ROUTER_SCOREBOARD","PARITY MATCH SUCCESSFUL",UVM_MEDIUM)
			else
				`uvm_fatal("ROUTER_SCOREBOARD","PARITY MISMATCH")
	end

else
`uvm_fatal("ROUTER_SCOREBOARD","HEADER MSIMATCH")

endtask


//-----------------  Check phase method  -------------------//

function void router_scoreboard::check_phase(uvm_phase phase);
super.check_phase(phase);

if(rd_data != null)
begin
	if(wr_data.header == rd_data.header)
		begin
		`uvm_info("ROUTER_SCOREBOARD","HEADER MATCH IS SUCCESSFUL",UVM_MEDIUM)
		foreach(wr_data.payload[i])
			begin
				if(wr_data.payload[i] == rd_data.payload[i])
					`uvm_info("ROUTER_SCOREBOARD","PAYLOAD MATCH SUCCESSFUL",UVM_MEDIUM)
				else
					`uvm_fatal("ROUTER_SCOREBOARD","PAYLOAD MISMATCH")

			end

			if(wr_data.parity == rd_data.parity)
				`uvm_info("ROUTER_SCOREBOARD","PARITY MATCH SUCCESSFUL",UVM_MEDIUM)
			else
				`uvm_fatal("ROUTER_SCOREBOARD","PARITY MISMATCH")
	end

	else
	`uvm_fatal("ROUTER_SCOREBOARD","HEADER MSIMATCH")
end

else
`uvm_fatal("SCOREBOARD","TIME OUT CONDITION _________________________-")


endfunction
