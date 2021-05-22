class write_xtn extends uvm_sequence_item;

    `uvm_object_utils(write_xtn)


    rand bit [7:0]header;
    rand bit [7:0]payload[];
    bit [7:0]parity;


    //Enumerated data type variable for good tranx and bad tranxs


    constraint c_header{header[1:0]!=3;}
    constraint c_payload{payload.size inside{[1:63]};}
    constraint c{header[7:2]==payload.size;}
    constraint c6{foreach(payload[i])
            payload[i] inside {[5:255]};}


    //UVM METHODS
    extern function new(string name = "write_xtn");
    //extern function void do_copy(uvm_object rhs);
    //extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    extern function void do_print(uvm_printer printer);
    extern function void post_randomize();
endclass

//constructor method

function write_xtn::new(string name = "write_xtn");
    super.new(name);

endfunction



/*
//do_copy method

function void write_xtn::do_copy(uvm_object rhs);

write_xtn rhs_;

if(!$cast(rhs_,rhs))
begin
`uvm_fatal("do_copy","Casting for rhs failed")

end

super.do_copy(rhs);

//copying the data members

header = rhs_.header;
payload = rhs_.payload;
parity = rhs_.parity;

endfunction

//do_compare method


function bit write_xtn::do_compare(uvm_object rhs, uvm_comparer comparer);

write_xtn rhs_;

if(!$cast(rhs_, rhs))
begin
`uvm_fatal("do_compare","casting for rhs failed")
return 0;
end

//compare data

   return super.do_compare(rhs,comparer) &&
    header== rhs_.header &&
    payload== rhs_.payload &&
    parity== rhs_.parity;
    
  endfunction
*/


//do_print method

function void  write_xtn::do_print (uvm_printer printer);
    super.do_print(printer);

    printer.print_field( "header", this.header, 8, UVM_BIN);

    foreach(payload[i])
        printer.print_field( $sformatf("payload[%0d]",i), this.payload[i], 8, UVM_DEC);

	printer.print_field( "parity", this.parity, 8, UVM_DEC);
   
endfunction


//POST_RANDOMIZE

function void write_xtn::post_randomize();

    parity = parity ^ header;

    foreach(payload[i])
    parity = parity^payload[i];

endfunction



