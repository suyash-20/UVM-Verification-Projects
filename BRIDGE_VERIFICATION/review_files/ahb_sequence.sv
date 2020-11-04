class ahb_sequence extends uvm_sequence#(bridge_xtn);

`uvm_object_utils(ahb_sequence)

extern function new(string name = "ahb_sequence");

endclass


function ahb_sequence::new(string name = "ahb_sequence");
super.new(name);

endfunction



class master_sequence extends ahb_sequence;

`uvm_object_utils(master_sequence)

bit[31:0]Haddr_temp;
bit[2:0]Hsize_temp;

extern function new(string name="master_sequence");
extern task body();

endclass

function master_sequence::new(string name="master_sequence");
super.new(name);

endfunction

task master_sequence::body();

req = bridge_xtn::type_id::create("req");

start_item(req);
assert(req.randomize() with {Haddr==32'h8000_0000; Htrans==2'b10; Hreadyin==1'b1; Hwrite==1'b1; Hsize==2;});
Haddr_temp = req.Haddr;
Hsize_temp = req.Hsize;

finish_item(req);

case(req.Hburst)


//--------------------------------------------SINGLE TRANSFER--------------------------------------------//

3'b001: begin
    start_item(req);
    $display("_______SINGLE_TRANSFER_______");
    assert(req.randomize() with {Haddr==Haddr_temp; Htrans==2'b00/*doubt->10?*/; Hreadyin==1'b1; Hwrite==1'b1; Hsize==Hsize_temp;}); 
    finish_item(req);
end


//--------------------------------------------NON-SEQUENTIAL TRANSFER--------------------------------------------//

3'b010: begin

    $display("_______NON_SEQUENTIAL_TRANSFER_______");
    
    
        if(req.Hsize==2'b00) begin
            for(int i=0; i<req.length; i++) begin

                start_item(req);
                assert(req.randomize() with {Haddr==Haddr_temp+1; Htrans==2'b11; Hreadyin==1'b1; Hwrite==1'b1; Hsize==Hsize_temp;});
                finish_item(req);
            end

            start_item(req);
            assert(req.randomize() with {Haddr==Haddr_temp+1; Htrans==2'b00; Hreadyin==1'b1; ; Hwrite==1'b1; Hsize==Hize_temp;});
            finish_item(req);
        end


        if(req.Hsize==2'b01)begin
            for(int i=0; i<req.length; i++)begin
                start_item(req);
                assert(req.randomize() with {Haddr==Haddr_temp+2; Htrans==2'b11; Hreadyin==1'b1; Hwrite==1'b1; Hsize==Hsize_temp;});
                finish_item(req);
            end

            start_item(req);
            assert(req.randomize() with {Haddr==Haddr_temp+2; Htrans==2'b00; Hreadyin==1'b1; Hwrite==1'b1; Hsize==Hsize_temp;});
            finish_item(req);
        end

        if(req.Hsize==2'b10)begin
            for(int i=0; i<req.length; i++)begin
                start_item(req);
                assert(req.randomize() with {Haddr==Haddr_temp+4; Htrans==2'b11; Hreadyin==1'b1; Hwrite==1'b1; Hsize==Hsize_temp;});
                finish_item(req);
            end

            start_item(req);
            assert(req.randomize() with {Haddr==Haddr_temp+4; Htrans==2'b00; Hreadyin==1'b1; Hwrite==1'b1; Hsize==Hsize_temp;});
            finish_item(req);
        end
end


//--------------------------------------------INCREMENT 4 TRANSFER--------------------------------------------//

3'b011: begin

    $display("_______INCR_4_______");
    
    if(req.Hsize==2'b00)begin
        for(int i=0;i<3;i++)begin
            start_item(req);
            assert(req.randomize() with {Haddr==Haddr_temp+1; Htrans==2'b11; Hreadyin==1'b1; Hwrite==1'b1; Hsize==Hsize_temp;}); 
            finish_item(req);
        end
    end

    if(req.Hsize==2'b01)begin
        for(int i=0;i<3;i++)begin
            start_item(req);
            assert(req.randomize() with {Haddr==Haddr_temp+2; Htrans==2'b11; Hreadyin==1'b1; Hsize==Hsize_temp;});
            finish_item(req);
        end
    end


    if(req.Hsize==2'b10)begin
        for(int i=0;i<3;i++)begin
            start_item(req);
            assert(req.randomize() with {Haddr==Haddr_temp+2; Htrans==2'b11; Hreadyin==1'b1; Hsize==Hsize_temp;});
            finish_item(req);
        end
    end

end


//--------------------------------------------INCREMENT 8 TRANSFER--------------------------------------------//


3'b101: begin

    $display("_______INCR_8_______");
    
    if(req.Hsize==2'b00)begin
        for(int i=0;i<7;i++)begin
            start_item(req);
            assert(req.randomize() with {Haddr==Haddr_temp+1; Htrans==2'b11; Hreadyin==1'b1; Hwrite==1'b1; Hsize==Hsize_temp;}); 
            finish_item(req);
        end
    end

    if(req.Hsize==2'b01)begin
        for(int i=0;i<7;i++)begin
            start_item(req);
            assert(req.randomize() with {Haddr==Haddr_temp+2; Htrans==2'b11; Hreadyin==1'b1; Hsize==Hsize_temp;});
            finish_item(req);
        end
    end


    if(req.Hsize==2'b10)begin
        for(int i=0;i<7;i++)begin
            start_item(req);
            assert(req.randomize() with {Haddr==Haddr_temp+2; Htrans==2'b11; Hreadyin==1'b1; Hsize==Hsize_temp;});
            finish_item(req);
        end
    end

end


//--------------------------------------------INCREMENT 16 TRANSFER--------------------------------------------//


3'b111: begin

    $display("_______INCR_16_______");
    
    if(req.Hsize==2'b00)begin
        for(int i=0;i<15;i++)begin
            start_item(req);
            assert(req.randomize() with {Haddr==Haddr_temp+1; Htrans==2'b11; Hreadyin==1'b1; Hwrite==1'b1; Hsize==Hsize_temp;}); 
            finish_item(req);
        end
    end

    if(req.Hsize==2'b01)begin
        for(int i=0;i<15;i++)begin
            start_item(req);
            assert(req.randomize() with {Haddr==Haddr_temp+2; Htrans==2'b11; Hreadyin==1'b1; Hsize==Hsize_temp;});
            finish_item(req);
        end
    end


    if(req.Hsize==2'b10)begin
        for(int i=0;i<15;i++)begin
            start_item(req);
            assert(req.randomize() with {Haddr==Haddr_temp+2; Htrans==2'b11; Hreadyin==1'b1; Hsize==Hsize_temp;});
            finish_item(req);
        end
    end

end
    
endcase

endtask

