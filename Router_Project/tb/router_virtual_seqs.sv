//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

class router_vbase_seq extends uvm_sequence#(uvm_sequence_item);

    `uvm_object_utils(router_vbase_seq)


    router_wr_sequencer wr_seqrh;
    router_rd_sequencer rd_seqrh[];


    //Declare handle for Virtual Sequencer

    router_virtual_sequencer vsqrh;

    //Declare handles for all sequences from wr_seqs
    //SEQUENCE SET 01
    router_packet_wseq01 wseq_01;
    router_packet_rseq01 rseq_01[];

    //SEQUENCE SET 02
    router_packet_wseq02 wseq_02;
    router_packet_rseq02 rseq_02[];

    //SEQUENCE SET 03
    router_packet_wseq03 wseq_03;
    router_packet_rseq03 rseq_03[];

    router_env_config m_cfg;

//------------------------------------------
// Methods
//------------------------------------------
    extern function new(string name = "router_vbase_seq");
    extern task body();

endclass

//-----------------  constructor new method  -------------------//

function router_vbase_seq::new(string name ="router_vbase_seq");
	super.new(name);
endfunction

//-----------------  task body method  -------------------//

task router_vbase_seq::body();

    if(!uvm_config_db#(router_env_config)::get(null, get_full_name(),"router_env_config",m_cfg))
        `uvm_fatal("CONFIG","Cannot get config from uvm_config")

    rd_seqrh = new[m_cfg.no_of_read_agents];

    assert($cast(vsqrh,m_sequencer))
    else
        `uvm_error("BODY","Error in casting")

    wr_seqrh = vsqrh.wr_seqrh;

    foreach(rd_seqrh[i])
        rd_seqrh[i]= vsqrh.rd_seqrh[i];

endtask



//--------------SEQUENCE 01--------------//

//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

class router_seq01_vseq extends router_vbase_seq;

     // Define Constructor new() function
	`uvm_object_utils(router_seq01_vseq)

//------------------------------------------
// METHODS
//------------------------------------------
 	extern function new(string name = "router_seq01_vseq");
	extern task body();

endclass

//-----------------  constructor new method  -------------------//

function router_seq01_vseq::new(string name ="router_seq01_vseq");
	super.new(name);
endfunction


//-----------------  task body() method  -------------------//

task router_seq01_vseq::body();
    super.body();
    wseq_01 = router_packet_wseq01::type_id::create("wseq_01");
	rseq_01 = new[m_cfg.no_of_read_agents];
	
    foreach(rseq_01[i])
	rseq_01[i]= router_packet_rseq01::type_id::create($sformatf("rseq_01[%d]",i));

	fork
        begin
            if(m_cfg.has_wagent) begin  
                wseq_01.start(wr_seqrh);
		    end
		end
        
        begin
            if(m_cfg.has_ragent) begin	
                fork        
                    rseq_01[0].start(rd_seqrh[0]);
                    rseq_01[1].start(rd_seqrh[1]);
                    rseq_01[2].start(rd_seqrh[2]);
                join_any
            end
		end
		join
endtask


//----------------- SEQUENCE 02 -----------------//

class router_seq02_vseq extends router_vbase_seq;

    `uvm_object_utils(router_seq02_vseq)


//------------------------------------------
// Methods
//------------------------------------------
    extern function new(string name="router_seq02_vseq");
    extern task body();

endclass

//-----------------  constructor new method  -------------------//

function router_seq02_vseq::new(string name ="router_seq02_vseq");
    super.new(name);

endfunction

//-----------------  task body method  -------------------//

task router_seq02_vseq::body();

    super.body();

    wseq_02 = router_packet_wseq02::type_id::create("wseq_02");
    rseq_02 = new[m_cfg.no_of_read_agents];

    foreach(rseq_02[i])
    rseq_02[i] = router_packet_rseq02::type_id::create($sformatf("rseq_02[%0d]",i));

    
    fork
        begin
            if(m_cfg.has_wagent) begin
                wseq_02.start(wr_seqrh);
            end
        end

        begin
            if(m_cfg.has_ragent) begin            
                fork  
                    rseq_02[0].start(rd_seqrh[0]);
                    rseq_02[1].start(rd_seqrh[1]);
                    rseq_02[2].start(rd_seqrh[2]);
                join_any
            end
        end
    join
endtask



//----------------- SEQUENCE 03 -----------------//

//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

class router_seq03_vseq extends router_vbase_seq;

    `uvm_object_utils(router_seq03_vseq)


//------------------------------------------
// Methods
//------------------------------------------
    extern function new(string name="router_seq03_vseq");
    extern task body();

endclass

//-----------------  constructor new method  -------------------//
function router_seq03_vseq::new(string name ="router_seq03_vseq");
    super.new(name);

endfunction


//-----------------  task body method  -------------------//

task router_seq03_vseq::body();

    super.body();

    wseq_03 = router_packet_wseq03::type_id::create("wseq_03");
    rseq_03 = new[m_cfg.no_of_read_agents];

    foreach(rseq_03[i])
    rseq_03[i] = router_packet_rseq03::type_id::create($sformatf("rseq_03[%0d]",i));

    fork
        begin
            if(m_cfg.has_wagent) begin
                wseq_03.start(wr_seqrh);
            end
        end

        begin
            if(m_cfg.has_ragent) begin
                fork            
                    rseq_03[0].start(rd_seqrh[0]);
                    rseq_03[1].start(rd_seqrh[1]);
                    rseq_03[2].start(rd_seqrh[2]);
                join_any
            end
        end
    join
endtask

