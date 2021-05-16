class axi_xtn extends uvm_sequence_item;

`uvm_object_utils(axi_xtn)

bit aresetn;

//address signals-32 bits
rand bit[31:0]awaddr;
rand bit[31:0]araddr;

//burst length signals-4 bits
rand bit[3:0]awlen;
rand bit[3:0]arlen;

//busrt size signals 3 bits
rand bit[2:0]awsize;
rand bit[2:0]arsize;

//burst type signals 2 bits
rand bit[1:0]awburst;
rand bit[1:0]arburst;

//write data 32 bits
rand bit[31:0]wdata[];

//read data 32 bits
rand bit[31:0]rdata[];

//write strobe
rand bit[3:0]wstrb[];

//ID signals
rand bit[3:0]awid;
rand bit[3:0]arid;

//ID tag signals
rand bit[3:0]wid;
rand bit[3:0]rid;
rand bit[3:0]bid;

//response signals
rand bit[1:0]bresp;
rand bit[1:0]rresp;
rand bit bready;
rand bit bvalid;

rand bit awready;
rand bit wready;
rand bit wvalid;
rand bit awvalid; 

//write last signal
bit wlast;

//read last signal
bit rlast;
/*

int Start_Address = awaddr;
int Number_Bytes = 2^awsize;
int Burst_Length = awlen+1;
int Aligned_Address;// = (int'(Start_Address / Number_Bytes) ) x Number_Bytes;
int Address_1;// = Start_address;
int Wrap_Boundary;
int Lower_Byte_Lane_0, Upper_Byte_Lane_0;
int Lower_Byte_Lane, Upper_Byte_Lane;
int Data_Bus_Bytes = 4;
*/
bit[31:0]addr[];




constraint c1{wdata.size == awlen+1'd1; rdata.size == awlen+1'd1;}

//constraint c2{wstrb.size == wdata.size;}

constraint c2{/*wstrb.size == awlen+1'd1;*/awsize==arsize;}
//constraint c6{wstrb inside{1,2,4,8}; }

constraint c3{awburst inside {[0:2]};}//3 is reserved 

constraint c4{if(awburst==2)  awlen inside{1,3,7,15};}

constraint ADDR_LIMIT {awaddr inside {[1:100]};}

constraint c5{if(awburst==2)  {if (awsize==1) (awaddr%2==0);
				if (awsize==2) (awaddr%4==0);
				if (awsize==3) (awaddr%8==0);
				if (awsize==4) (awaddr%16==0);
				if (awsize==5) (awaddr%32==0);
				if (awsize==6) (awaddr%64==0);
				if (awsize==7) (awaddr%128==0);}}

constraint c6{if(arburst==2)  {if (arsize==1) (araddr%2==0);
				if (arsize==2) (araddr%4==0);
				if (arsize==3) (araddr%8==0);
				if (arsize==4) (araddr%16==0);
				if (arsize==5) (araddr%32==0);
				if (arsize==6) (araddr%64==0);
				if (arsize==7) (araddr%128==0);}}




extern function new(string name = "axi_xtn");
extern function void do_print(uvm_printer printer);
//extern function next_address();
//extern function strb_calculation();
extern function void post_randomize();

endclass



//new() constructor

function axi_xtn::new(string name="axi_xtn");
super.new();
endfunction



//print function
function void axi_xtn::do_print(uvm_printer printer);

printer.print_field("awaddr",	this.awaddr,	32,		UVM_DEC);
printer.print_field("araddr",	this.araddr,	32,		UVM_DEC);
printer.print_field("awsize",	this.awsize,	3,		UVM_DEC);
printer.print_field("arsize",	this.arsize,	3,		UVM_DEC);
printer.print_field("awlen",	this.awlen,		4,		UVM_DEC);
printer.print_field("arlen",	this.arlen,		4,		UVM_DEC);
printer.print_field("awburst",	this.awburst,	2,		UVM_DEC);
printer.print_field("arburst",	this.arburst,	2,		UVM_DEC);

foreach(wdata[i])
printer.print_field($sformatf("wdata[%0d]",i),	this.wdata[i],		32,		UVM_DEC);

foreach(rdata[i])
printer.print_field($sformatf("rdata[%0d]",i),	this.rdata[i],		32,		UVM_DEC);

foreach(wstrb[i])
printer.print_field($sformatf("wstrb[%0d]",i),	this.wstrb[i],		4,		UVM_DEC);

printer.print_field("bresp",	this.bresp,	2,		UVM_DEC);

endfunction


function void axi_xtn::post_randomize();


integer Start_Address = awaddr;
integer Number_Bytes = 2**awsize;
integer Burst_Length = awlen+ 1'b1;
integer Aligned_Address = (int'(Start_Address / Number_Bytes))*Number_Bytes;
integer Address_1;// = Start_address;
integer Wrap_Boundary;
integer Lower_Byte_Lane_0, Upper_Byte_Lane_0;
integer Lower_Byte_Lane, Upper_Byte_Lane;
integer Data_Bus_Bytes = 4;

bit[31:0]addr[];

//next_address function

//function axi_xtn::next_address(Burst_Length, Number_Bytes,awburst, Start_Address);
//function axi_xtn::next_address();

bit k;
addr= new[awlen+1];
wstrb = new[awlen+1];
Wrap_Boundary = (int'(Start_Address / (Number_Bytes * Burst_Length)))*(Number_Bytes * Burst_Length);
addr[0]= Start_Address; 

for(int i=2;i<=(awlen+1);i++)
begin

	if(awburst == 0)  //fixed burst for entire burst address will be same
		addr[i-1] = Start_Address;

	else if(awburst == 1) //increment type burst
	begin
//	$display(";akfjkadj;kja;kfj;kadjvkladnv 'vlkakd;la ",,,i);
	addr[i-1] = Aligned_Address + (i-2) * Number_Bytes;
	end
	else if (awburst == 2)
	begin//wrapping burst
	if(k==0)
		begin 
			addr[i-1] = Aligned_Address + (i-1) * Number_Bytes;   

			if(addr[i-1] == Wrap_Boundary + (Number_Bytes * Burst_Length)) //checking the current address with the upper wrap boundary
			begin
			addr[i-1] = Wrap_Boundary; //maybe /maybe not?
			k++;
			end
		end
		end
	else
	addr[i-1] = Start_Address + ((i-1) * Number_Bytes)-(Number_Bytes * Burst_Length); //formula for calculating next address once the current address becomes equal to the Wrap bounday
end

//endfunction





//strobe calculation function

//strb is based on the address and Number_Bytes
//strobe is different for each data
//strobe will be a dynamic array
//strobe size will be equal to data array which will be equal to BURST LENGTH

//function axi_xtn::strb_calculation();

Lower_Byte_Lane_0 = Start_Address-((int'(Start_Address / Data_Bus_Bytes)) * Data_Bus_Bytes);
Upper_Byte_Lane_0 = Aligned_Address + (Number_Bytes-1)-((int'(Start_Address / Data_Bus_Bytes)) * Data_Bus_Bytes);
//$display("S_A ",,Start_Address,,,"A_A ",,Aligned_Address,,,"L_B_L ",,Lower_Byte_Lane_0,,,"U_B_L ",,Upper_Byte_Lane_0);			
for(int j = Lower_Byte_Lane_0; j<=Upper_Byte_Lane_0;j++) //Actual strobe calculation
begin
wstrb[0][j]= 1; //here j will go from 0 to 3
//$display("strobe %p",wstrb);
end

//Lower_Byte_Lane = Address_N  (INT(Address_N / Data_Bus_Bytes)) * Data_Bus_Bytes;
//Upper_Byte_Lane = Lower_Byte_Lane + Number_Bytes  1;

		
for(int i=1;i<wstrb.size;i++)
begin
	Lower_Byte_Lane = addr[i]-((int'(addr[i]/ Data_Bus_Bytes)) * Data_Bus_Bytes);
	Upper_Byte_Lane = Lower_Byte_Lane + Number_Bytes-1'd1;
//$display("S_A ",,Start_Address,,,"A_A ",,Aligned_Address,,,"L_B_L ",,Lower_Byte_Lane,,,"U_B_L ",,Upper_Byte_Lane);			
	for(int j= Lower_Byte_Lane;j<=Upper_Byte_Lane;j++)
	begin
	wstrb[i][j]=1;
//	$display(i,,,"strobe %p",wstrb[i]);
	end
end

endfunction


