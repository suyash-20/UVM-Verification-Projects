class uart_seqs extends uvm_sequence#(trans_xtn);

`uvm_object_utils(uart_seqs)

//=====================================================
//methods
//=====================================================

extern function new(string name = "uart_seqs");

endclass

//=====================================================
//Function new
//=====================================================

function uart_seqs::new(string name = "uart_seqs");
super.new(name);
endfunction


//--------------------------------------------------------FULL_DUPLEX/ HALF DUPLEX--------------------------------------------------------//
//----------------------------SEQ 01 / SEQ 02

class uart_seq01 extends uart_seqs;

`uvm_object_utils(uart_seq01)

//stndard method

extern function new(string name = "uart_seq01");
extern task body();

endclass


function uart_seq01::new(string name = "uart_seq01");

super.new(name);

endfunction

//TASK  BODY();

task uart_seq01::body();

begin

	req = trans_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd128; wb_we_i==1;});
	finish_item(req);

	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd0; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd27; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd3; wb_we_i==1;}); //wb_dat_i indicates the number of select bits
	finish_item(req);
	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd1; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_dat_i==8'd6; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd10; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_we_i==0;});
	finish_item(req);

	get_response(req);


//	if(req.IIR[3:1]==3'b011)

	if(req.IIR[3:1]==3'b010)


	//	repeat(4)
		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==0; wb_we_i==0;})
		finish_item(req);
		end
	
//	if(req.IIR[3:1]==3'b010)

	if(req.IIR[3:1]==3'b011)

		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==5; wb_we_i==0;})
		finish_item(req);
		end


end
endtask





//------------UART SEQUENCE 02

class uart_seq02 extends uart_seqs;

`uvm_object_utils(uart_seq02)

//stndard method

extern function new(string name = "uart_seq02");
extern task body();

endclass


function uart_seq02::new(string name = "uart_seq02");

super.new(name);

endfunction

//TASK  BODY();

task uart_seq02::body();

begin
	req = trans_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd128; wb_we_i==1;});
	finish_item(req);

	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd0; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd54; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd3; wb_we_i==1;});//wb_dat_i indicates the number of select bits
	finish_item(req);
	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd1; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_dat_i==8'd6; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd35; wb_we_i==1;});
	finish_item(req);
	

	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_we_i==0;});
	finish_item(req);

	get_response(req);


//	if(req.IIR[3:1]==3'b011)

	if(req.IIR[3:1]==3'b010)

	//	repeat(4)
		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==0; wb_we_i==0;})
		finish_item(req);
		end
	
//	if(req.IIR[3:1]==3'b010)

	if(req.wb_dat_o[3:1]==3'b011)

		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==5 ; wb_we_i==0;})
		finish_item(req);
		end
		
end
endtask




//--------------------------------------LOOPBACK TESTCASE--------------------------------------------------------//

//----------------------------SEQ03

class uart_seq03 extends uart_seqs;

`uvm_object_utils(uart_seq03)

//stndard method

extern function new(string name = "uart_seq03");
extern task body();

endclass


function uart_seq03::new(string name = "uart_seq03");

super.new(name);

endfunction




task uart_seq03::body();

begin
	req = trans_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd128; wb_we_i==1;});
	finish_item(req);

	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd0; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd54; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd3; wb_we_i==1;});
	finish_item(req);
	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd1; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_dat_i==8'd6; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 4; wb_dat_i==8'd16; wb_we_i==1;});
	finish_item(req);


	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd20; wb_we_i==1;});
	finish_item(req);
	

	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_we_i==0;});
	finish_item(req);

	get_response(req);


	if(req.IIR[3:1]==3'b010)
//	if(req.wb_dat_o[3:1]==3'b011)

	//	repeat(4)
		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==0; wb_we_i==0;})
		finish_item(req);
		end
	
	if(req.IIR[3:1]==3'b011)
//	if(req.wb_dat_o[3:1]==3'b010)

		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==5 ; wb_we_i==0;})
		finish_item(req);
		end
		
end
endtask




//------------------------------------------UART SEQ04/05--------------------------------------------------------//

//----------------------------PARITY ERROR TEST CASE_HALF DUPLEX



class uart_seq04 extends uart_seqs;

`uvm_object_utils(uart_seq04)

extern function new(string name = "uart_seq04");
extern task body();

endclass


function uart_seq04::new(string name="uart_seq04");
super.new(name);

endfunction



task uart_seq04::body();

begin

req = trans_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd128; wb_we_i==1;});
	finish_item(req);

	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd0; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd27; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd11; wb_we_i==1;}); //LCR_3 is kept high to enable parity, LCR_4 is 0 for odd parity
	finish_item(req);
	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd4; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_dat_i==8'd6; wb_we_i==1;});
	finish_item(req);

/*	start_item(req);
	assert(req.randomize with {wb_adr_i == 4; wb_dat_i==8'd16; wb_we_i==1;});
	finish_item(req);
*/

	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd4; wb_we_i==1;});
	finish_item(req);
	

	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_we_i==0;});
	finish_item(req);

	get_response(req);

	if(req.IIR[3:1]==3'b011)
//	if(req.wb_dat_o[3:1]==3'b011)

	//	repeat(4)
		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==5; wb_we_i==0;})
		finish_item(req);
		end
	
	if(req.IIR[3:1]==3'b010)

//	if(req.wb_dat_o[3:1]==3'b010)

		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==0 ; wb_we_i==0;})
		finish_item(req);
		end


end

endtask




//------------UART SEQ 5

class uart_seq05 extends uart_seqs;

`uvm_object_utils(uart_seq05)

extern function new(string name = "uart_seq05");
extern task body();

endclass


function uart_seq05::new(string name="uart_seq05");
super.new(name);

endfunction



task uart_seq05::body();

begin

req = trans_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd128; wb_we_i==1;});
	finish_item(req);

	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd0; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd54; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd27; wb_we_i==1;}); //LCR_3 is kept high to enable parity, LCR_4 is 1 for even parity
	finish_item(req);
	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd4; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_dat_i==8'd6; wb_we_i==1;});
	finish_item(req);

/*	start_item(req);
	assert(req.randomize with {wb_adr_i == 4; wb_dat_i==8'd16; wb_we_i==1;});
	finish_item(req);
*/

	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd20; wb_we_i==1;});
	finish_item(req);
	

	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_we_i==0;});
	finish_item(req);

	get_response(req);


	if(req.IIR[3:1]==3'b011)
//	if(req.wb_dat_o[3:1]==3'b011)

	//	repeat(4)
		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==5; wb_we_i==0;})
		finish_item(req);
		end
	
	if(req.IIR[3:1]==3'b010)

//	if(req.wb_dat_o[3:1]==3'b010)

		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==0 ; wb_we_i==0;})
		finish_item(req);
		end
		
end
endtask




//------------------------------------------UART SEQ06/07--------------------------------------------------------//

//----------------------------BREAK INTERRUPT TEST CASE SEQ 



class uart_seq06 extends uart_seqs;

`uvm_object_utils(uart_seq06)

extern function new(string name = "uart_seq06");
extern task body();

endclass


function uart_seq06::new(string name="uart_seq06");
super.new(name);

endfunction



task uart_seq06::body();

begin

req = trans_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd128; wb_we_i==1;});
	finish_item(req);

	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd0; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd27; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd67; wb_we_i==1;}); //LCR_6 is kept high to enable break
	finish_item(req);
	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd4; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_dat_i==8'd6; wb_we_i==1;});
	finish_item(req);

/*	start_item(req);
	assert(req.randomize with {wb_adr_i == 4; wb_dat_i==8'd16; wb_we_i==1;});
	finish_item(req);
*/
	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd4; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_we_i==0;});
	finish_item(req);

	get_response(req);

	if(req.IIR[3:1]==3'b011)
//	if(req.wb_dat_o[3:1]==3'b011)

	//	repeat(4)
		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==5; wb_we_i==0;})
		finish_item(req);
		end
	
	if(req.IIR[3:1]==3'b010)

//	if(req.wb_dat_o[3:1]==3'b010)

		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==0 ; wb_we_i==0;})
		finish_item(req);
		end


end

endtask




//------------UART SEQ 7

class uart_seq07 extends uart_seqs;

`uvm_object_utils(uart_seq07)

extern function new(string name = "uart_seq07");
extern task body();

endclass


function uart_seq07::new(string name="uart_seq07");
super.new(name);

endfunction



task uart_seq07::body();

begin

req = trans_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd128; wb_we_i==1;});
	finish_item(req);

	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd0; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd54; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd67; wb_we_i==1;}); //LCR_6 is kept high to enable break
	finish_item(req);
	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd4; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_dat_i==8'd6; wb_we_i==1;});  
	finish_item(req);

/*	start_item(req);
	assert(req.randomize with {wb_adr_i == 4; wb_dat_i==8'd16; wb_we_i==1;});
	finish_item(req);
*/

	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd20; wb_we_i==1;});
	finish_item(req);
	

	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_we_i==0;});
	finish_item(req);

	get_response(req);


	if(req.IIR[3:1]==3'b011)
//	if(req.wb_dat_o[3:1]==3'b011)

	//	repeat(4)
		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==5; wb_we_i==0;})
		finish_item(req);
		end
	
	if(req.IIR[3:1]==3'b010)

//	if(req.wb_dat_o[3:1]==3'b010)

		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==0 ; wb_we_i==0;})
		finish_item(req);
		end
		
end
endtask





//------------------------------------------UART SEQ08/09--------------------------------------------------------//

//----------------------------OVERRUN INTERRUPT TEST CASE SEQ 



class uart_seq08 extends uart_seqs;

`uvm_object_utils(uart_seq08)

extern function new(string name = "uart_seq08");
extern task body();

endclass


function uart_seq08::new(string name="uart_seq08");
super.new(name);

endfunction



task uart_seq08::body();

begin

req = trans_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd128; wb_we_i==1;});
	finish_item(req);

	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd0; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd27; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd3; wb_we_i==1;}); 
	finish_item(req);
	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd1; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_dat_i==8'd6; wb_we_i==1;});
	finish_item(req);

/*	start_item(req);
	assert(req.randomize with {wb_adr_i == 4; wb_dat_i==8'd16; wb_we_i==1;});
	finish_item(req);
*/


repeat(17)
begin
	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd12; wb_we_i==1;});  //repeat for overrun
	finish_item(req);
end

	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_we_i==0;});
	finish_item(req);

	get_response(req);

	if(req.IIR[3:1]==3'b011)
//	if(req.wb_dat_o[3:1]==3'b011)

	//	repeat(4)
		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==5; wb_we_i==0;})
		finish_item(req);
		end
	
	if(req.IIR[3:1]==3'b010)

//	if(req.wb_dat_o[3:1]==3'b010)

		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==0 ; wb_we_i==0;})
		finish_item(req);
		end


end

endtask




//------------UART SEQ 9

class uart_seq09 extends uart_seqs;

`uvm_object_utils(uart_seq09)

extern function new(string name = "uart_seq09");
extern task body();

endclass


function uart_seq09::new(string name="uart_seq09");
super.new(name);

endfunction



task uart_seq09::body();

begin

req = trans_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd128; wb_we_i==1;});
	finish_item(req);

	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd0; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd54; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd3; wb_we_i==1;}); 
	finish_item(req);
	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd4; wb_we_i==1;});  //try 4 and 5 since received data is valid but about to be overwritten
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_dat_i==8'd198; wb_we_i==1;});  //fcr value set to enable interrupt for everytime 14 bytes are received
	finish_item(req);

/*	start_item(req);
	assert(req.randomize with {wb_adr_i == 4; wb_dat_i==8'd16; wb_we_i==1;});
	finish_item(req);
*/

	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd20; wb_we_i==1;});
	finish_item(req);
	

	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_we_i==0;});
	finish_item(req);

	get_response(req);


	if(req.IIR[3:1]==3'b011)
//	if(req.wb_dat_o[3:1]==3'b011)

	//	repeat(4)
		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==5; wb_we_i==0;})
		finish_item(req);
		end
	
	if(req.IIR[3:1]==3'b010)

//	if(req.wb_dat_o[3:1]==3'b010)

		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==0 ; wb_we_i==0;})
		finish_item(req);
		end
		
end
endtask




//------------------------------------------UART SEQ10/11--------------------------------------------------------//

//----------------------------FRAMING INTERRUPT TEST CASE SEQ 



class uart_seq10 extends uart_seqs;

`uvm_object_utils(uart_seq10)

extern function new(string name = "uart_seq10");
extern task body();

endclass


function uart_seq10::new(string name="uart_seq10");
super.new(name);

endfunction



task uart_seq10::body();

begin

req = trans_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd128; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd0; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd27; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'b0000_0100; wb_we_i==1;}); //LCR[1:0] set to 00 for 5 bits each character
	finish_item(req);
	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd4; wb_we_i==1;}); //IER set to 4
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_dat_i==8'd6; wb_we_i==1;});
	finish_item(req);

/*	start_item(req);
	assert(req.randomize with {wb_adr_i == 4; wb_dat_i==8'd16; wb_we_i==1;});
	finish_item(req);
*/

	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd2; wb_we_i==1;}); 
	finish_item(req);
	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_we_i==0;});
	finish_item(req);

	get_response(req);

	if(req.IIR[3:1]==3'b011)
//	if(req.wb_dat_o[3:1]==3'b011)

	//	repeat(4)
		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==5; wb_we_i==0;})
		finish_item(req);
		end
	
	if(req.IIR[3:1]==3'b010)

//	if(req.wb_dat_o[3:1]==3'b010)

		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==0 ; wb_we_i==0;})
		finish_item(req);
		end


end

endtask




//------------UART SEQ 11

class uart_seq11 extends uart_seqs;

`uvm_object_utils(uart_seq11)

extern function new(string name = "uart_seq11");
extern task body();

endclass


function uart_seq11::new(string name="uart_seq11");
super.new(name);

endfunction



task uart_seq11::body();

begin

req = trans_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd128; wb_we_i==1;});
	finish_item(req);

	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd0; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd54; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'b0000_0111; wb_we_i==1;}); //LCR [1:0] set for 11 for 8 bits each character
	finish_item(req);
	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd3; wb_we_i==1;});  
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_dat_i==8'd6; wb_we_i==1;});  
	finish_item(req);

/*	start_item(req);
	assert(req.randomize with {wb_adr_i == 4; wb_dat_i==8'd16; wb_we_i==1;});
	finish_item(req);
*/

	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd8; wb_we_i==1;});  //THR[6] set to logic  '0'
	finish_item(req);
	

	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_we_i==0;});
	finish_item(req);

	get_response(req);


	if(req.IIR[3:1]==3'b011)
//	if(req.wb_dat_o[3:1]==3'b011)

	//	repeat(4)
		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==5; wb_we_i==0;})
		finish_item(req);
		end
	
	if(req.IIR[3:1]==3'b010)

//	if(req.wb_dat_o[3:1]==3'b010)

		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==0 ; wb_we_i==0;})
		finish_item(req);
		end
		
end
endtask


//--------------------------------------------------------UART SEQ12/13--------------------------------------------------------//

//--------------TIMEOUT INTERRUPT TEST CASE SEQ 



class uart_seq12 extends uart_seqs;

`uvm_object_utils(uart_seq12)

extern function new(string name = "uart_seq12");
extern task body();

endclass


function uart_seq12::new(string name="uart_seq12");
super.new(name);

endfunction



task uart_seq12::body();

begin

req = trans_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd128; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd0; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd27; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd3; wb_we_i==1;}); 
	finish_item(req);
	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd1; wb_we_i==1;});// IER
	finish_item(req);

	start_item(req);
        assert(req.randomize with {wb_adr_i == 2; wb_dat_i==8'b0000_0110; wb_we_i==1;});
	finish_item(req);

	
	repeat(3) 
	begin
	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i ==8'd5; wb_we_i==1;}); 
	finish_item(req);
	end
	
	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_we_i==0;});
	finish_item(req);

	get_response(req);

	
	
	if(req.IIR[3:1]==3'b010)


		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==0 ; wb_we_i==0;})
		finish_item(req);
		end
end

endtask




//------------UART SEQ 13

class uart_seq13 extends uart_seqs;

`uvm_object_utils(uart_seq13)

extern function new(string name = "uart_seq13");
extern task body();

endclass


function uart_seq13::new(string name="uart_seq13");
super.new(name);

endfunction



task uart_seq13::body();

begin

req = trans_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd128; wb_we_i==1;});
	finish_item(req);

	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd0; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd54; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd3; wb_we_i==1;}); 
	finish_item(req);
	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd5; wb_we_i==1;}); // IER
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_dat_i==8'b0100_0110; wb_we_i==1;}); //fcr set for 4 bytes inerrupt
	finish_item(req);


	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd2; wb_we_i==1;});  
	finish_item(req);
	

	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_we_i==0;});
	finish_item(req);

	get_response(req);


	
	if(req.IIR[3:1]==3'b110)

		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==0 ; wb_we_i==0;})
		finish_item(req);
		end
	
end
endtask



//--------------------------------------------------------UART SEQ14/15--------------------------------------------------------//

//--------------THR EMPTY INTERRUPT TEST CASE SEQ 



class uart_seq14 extends uart_seqs;

`uvm_object_utils(uart_seq14)

extern function new(string name = "uart_seq14");
extern task body();

endclass


function uart_seq14::new(string name="uart_seq14");
super.new(name);

endfunction



task uart_seq14::body();

begin

req = trans_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd128; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd0; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd54; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd3; wb_we_i==1;}); 
	finish_item(req);
	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd2; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_dat_i==8'd6; wb_we_i==1;});//FCR
	finish_item(req);

/*	start_item(req);
	assert(req.randomize with {wb_adr_i == 4; wb_dat_i==8'd16; wb_we_i==1;});
	finish_item(req);
*/
	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==12; wb_we_i==1;}); 
	finish_item(req);
	
	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_we_i==0;});
	finish_item(req);

	get_response(req);

	if(req.IIR[3:1]==3'b010)
//	if(req.wb_dat_o[3:1]==3'b011)

	//	repeat(4)
		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==0; wb_we_i==0;})
		finish_item(req);
		end
	
//	if(req.IIR[3:1]==3'b010)
else
//	if(req.wb_dat_o[3:1]==3'b010)

		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==5 ; wb_we_i==0;})
		finish_item(req);
		end


end

endtask




//------------UART SEQ 15

class uart_seq15 extends uart_seqs;

`uvm_object_utils(uart_seq15)

extern function new(string name = "uart_seq15");
extern task body();

endclass


function uart_seq15::new(string name="uart_seq15");
super.new(name);

endfunction



task uart_seq15::body();

begin

req = trans_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd128; wb_we_i==1;});
	finish_item(req);

	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd0; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd54; wb_we_i==1;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 3; wb_dat_i==8'd3; wb_we_i==1;}); 
	finish_item(req);
	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 1; wb_dat_i==8'd2; wb_we_i==1;}); 
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_dat_i==8'd6; wb_we_i==1;});  //FCR
	finish_item(req);

/*	start_item(req);
	assert(req.randomize with {wb_adr_i == 4; wb_dat_i==8'd16; wb_we_i==1;});
	finish_item(req);
*/

	start_item(req);
	assert(req.randomize with {wb_adr_i == 0; wb_dat_i==8'd20; wb_we_i==1;});  
	finish_item(req);
	

	start_item(req);
	assert(req.randomize with {wb_adr_i == 2; wb_we_i==0;});
	finish_item(req);

	get_response(req);


	if(req.IIR[3:1]==3'b010)
//	if(req.wb_dat_o[3:1]==3'b011)

	//	repeat(4)
		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==0; wb_we_i==0;})
		finish_item(req);
		end
	
	if(req.IIR[3:1]==3'b001)
//else
//	if(req.wb_dat_o[3:1]==3'b010)

		begin
		start_item(req);
		assert(req.randomize with {wb_adr_i==5 ; wb_we_i==0;})
		finish_item(req);
		end
		
end
endtask
