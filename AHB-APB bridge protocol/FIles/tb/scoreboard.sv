class scoreboard extends uvm_scoreboard;

`uvm_component_utils(scoreboard)

uvm_tlm_analysis_fifo #(bridge_xtn) fifo_ahb;
uvm_tlm_analysis_fifo #(apb_xtn) fifo_apb;

bridge_xtn m_xtn;
apb_xtn s_xtn;

bridge_xtn m_cov;
apb_xtn s_cov;


//covergroup ahb_cov;

//endcovergroup


//covergroup apb_cov;

//endcovergroup


extern function new(string name = "scoreboard", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern function void check_phase(uvm_phase phase);

endclass

function scoreboard::new(string name = "scoreboard", uvm_component parent);
super.new(name, parent);

//covergroup object creation

endfunction



function void scoreboard::build_phase(uvm_phase phase);

super.build_phase(phase);

fifo_ahb=new("fifo_ahb", this);
fifo_apb=new("fifo_apb", this);
m_xtn = bridge_xtn::type_id::create("m_xtn");

s_xtn = apb_xtn::type_id::create("s_xtn");

endfunction



task scoreboard::run_phase(uvm_phase phase);

forever begin
    fork
            fifo_ahb.get(m_xtn);

	            fifo_apb.get(s_xtn);

		        join
			end

			endtask


			function void scoreboard::check_phase(uvm_phase phase);

			if(m_xtn.Hwrite == s_xtn.Pwrite)
			    `uvm_info(get_type_name,"HWRITE and PWRITE matched sucessfully",UVM_LOW)
			    else
			        `uvm_info(get_type_name,"HWRITE and PWRITE did not match",UVM_LOW)


				if(m_xtn.Haddr == s_xtn.Paddr)
				    `uvm_info(get_type_name,"HADDR and PADDR matched sucessfully",UVM_LOW)
				    else
				        `uvm_info(get_type_name,"HADDR and PADDR did not match",UVM_LOW)

					if(m_xtn.Hwrite==1) begin
					    
					    if(m_xtn.Hsize==0) begin
						        
						    if(m_xtn.Haddr[1:0]==0) begin

						        if(m_xtn.Hwdata[7:0] == s_xtn.Pwdata)
						            `uvm_info(get_type_name,"DATA for Size 0 and OFFSET 0 matched sucessfully",UVM_LOW)
						        else
									`uvm_info(get_type_name(), $sformatf(" SiZE 0 Offset 0 Comparision failed\nAHB:\n%p\nAPB:\n%p", m_xtn.sprint, s_xtn.sprint), UVM_LOW)
						    end

						    else if(m_xtn.Haddr[1:0] == 1) begin
																			           
						        if(m_xtn.Hwdata[15:8] == s_xtn.Pwdata)
						            `uvm_info(get_type_name,"DATA for Size 0 and OFFSET 1 matched sucessfully",UVM_LOW)
						        else
									`uvm_info(get_type_name(), $sformatf(" SiZE 0 Offset 1 Comparision failed\nAHB:\n%p\nAPB:\n%p", m_xtn.sprint, s_xtn.sprint), UVM_LOW)
							end


							else if(m_xtn.Haddr[1:0] == 2) begin
																															           
							    if(m_xtn.Hwdata[23:16] == s_xtn.Pwdata)
							        `uvm_info(get_type_name,"DATA for Size 0 and OFFSET 2 matched sucessfully",UVM_LOW)
							    else
									`uvm_info(get_type_name(), $sformatf(" SiZE 0 Offset 2 Comparision failed\nAHB:\n%p\nAPB:\n%p", m_xtn.sprint, s_xtn.sprint), UVM_LOW)
								end

							end

						    else if(m_xtn.Hsize==1) begin
							               
							    if(m_xtn.Haddr[1:0]==0) begin
				                   if(m_xtn.Hwdata[15:0] == s_xtn.Pwdata)
					                   `uvm_info(get_type_name,"DATA for Size 1 and OFFSET 0 matched sucessfully",UVM_LOW)
					               else
					       				`uvm_info(get_type_name(), $sformatf(" SiZE 1 Offset 0 Comparision failed\nAHB:\n%p\nAPB:\n%p", m_xtn.sprint, s_xtn.sprint), UVM_LOW)
						    end

					        else if(m_xtn.Haddr[1:0] == 2) begin
				               if(m_xtn.Hwdata[31:16] == s_xtn.Pwdata)
			                       `uvm_info(get_type_name,"DATA for Size 1 and OFFSET 1 matched sucessfully",UVM_LOW)
			                   else
					   				`uvm_info(get_type_name(), $sformatf(" SiZE 1 Offset 2 Comparision failed\nAHB:\n%p\nAPB:\n%p", m_xtn.sprint, s_xtn.sprint), UVM_LOW)
					        end
						    end

					        else if(m_xtn.Hsize==2) begin
																																																																			        
							    if(m_xtn.Hwdata == s_xtn.Pwdata)
							        `uvm_info(get_type_name,"DATA for Size 2 matched sucessfully",UVM_LOW)
							    else
								    `uvm_info(get_type_name(), $sformatf(" SiZE 2  Comparision failed\nAHB:\n%p\nAPB:\n%p", m_xtn.sprint, s_xtn.sprint), UVM_LOW)
							end
																																																																										    end
						else
					//	    `uvm_info(get_type_name(), $sformatf(" ADDRESS DID NOT MATCH-- Comparision failed\nAHB:\n%p\nAPB:\n%p", m_xtn.sprint,s_xtn.sprint),UVM_LOW)

					//if(s_xtn.Pwrite==0) begin
																																																																											    
					    if(m_xtn.Hsize == 0) begin
					    
						   if(m_xtn.Haddr[1:0]==0) begin
					            if(s_xtn.Prdata[7:0] == m_xtn.Hrdata)
						            `uvm_info(get_type_name(), "SIZE 0 OFFSET 0 matched Sucessfully",UVM_LOW)
						        else
						            `uvm_info(get_type_name(), $sformatf(" SIZE 0 OFFSET 0 Comparision failed\nAHB:\n%p\nAPB:\n%p", m_xtn.sprint, s_xtn.sprint), UVM_LOW)
						    end

							else if(m_xtn.Haddr[1:0]==1) begin
								if(s_xtn.Prdata[15:8] == m_xtn.Hrdata)
									`uvm_info(get_type_name(), "SIZE 0 OFFSET 1 matched Sucessfully",UVM_LOW)
								else
									`uvm_info(get_type_name(), $sformatf(" SIZE 0 OFFSET 1 Comparision failed\nAHB:\n%p\nAPB:\n%p", m_xtn.sprint, s_xtn.sprint), UVM_LOW)
							end

							else if(m_xtn.Haddr[1:0]==2) begin
								if(s_xtn.Prdata[31:16] == m_xtn.Hrdata)
									`uvm_info(get_type_name(), "SIZE 0 OFFSET 2 matched Sucessfully",UVM_LOW)
								else
									`uvm_info(get_type_name(), $sformatf(" SIZE 0 OFFSET 2 Comparision failed\nAHB:\n%p\nAPB:\n%p", m_xtn.sprint, s_xtn.sprint), UVM_LOW)
							end
																																																																																																											     
						end

						if(m_xtn.Hsize == 1) begin
						
						    if(m_xtn.Haddr[1:0]==0) begin
						        if(s_xtn.Prdata[15:0] == m_xtn.Hrdata)
						            `uvm_info(get_type_name(), "SIZE 1 OFFSET 0 matched Sucessfully",UVM_LOW)
						        else
						            `uvm_info(get_type_name(), $sformatf(" SIZE 1 OFFSET 0 Comparision failed\nAHB:\n%p\nAPB:\n%p", m_xtn.sprint, s_xtn.sprint), UVM_LOW)
						    end
				            
							else if(m_xtn.Haddr[1:0]==2) begin
							    if(s_xtn.Prdata[31:16] == m_xtn.Hrdata)
							        `uvm_info(get_type_name(), "SIZE 1 OFFSET 2 matched Sucessfully",UVM_LOW)
							    else
							        `uvm_info(get_type_name(), $sformatf(" SIZE 1 OFFSET 2 Comparision failed\nAHB:\n%p\nAPB:\n%p", m_xtn.sprint, s_xtn.sprint), UVM_LOW)
							end
																																																																																																																																		          
						end

						if(m_xtn.Hsize == 2) begin
																																																																																																																																				          
						    if(s_xtn.Prdata == m_xtn.Hrdata)
						        `uvm_info(get_type_name(), "SIZE 2 matched Sucessfully",UVM_LOW)
						    else
						        `uvm_info(get_type_name(), $sformatf(" SIZE 2 Comparision failed\nAHB:\n%p\nAPB:\n%p", m_xtn.sprint, s_xtn.sprint), UVM_LOW)
						end
			      	//end

endfunction
