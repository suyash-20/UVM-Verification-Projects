module seq_1010(clock,reset,din,dout);

input clock,reset,din;
output dout;

parameter IDLE = 5'b00001,
          S1 = 5'b00010,
          S10 = 5'b00100,
          S101 = 5'b01000,
          S1010 = 5'b10000;

reg [4:0]next_state, state;

//PRESENT STATE LOGIC
always@(posedge clock) begin
    if(reset)
    state<=IDLE;
    else
    state<=next_state;
end

//NEXT STATE LOGIC

always@(*) begin
    next_state=IDLE;

    case(state)

    IDLE: begin
        if(din==1)
        next_state = S1;
        else
        next_state = IDLE;
    end

    S1: begin
        if(din==0)
        next_state = S10;
        else
        next_state = S1;
    end

    S10: begin
        if(din==1)
        next_state = S101;
        else
        next_state = IDLE;
    end

    S101: begin
        if(din==0)
        next_state = S1010;
        else
        next_state = S1;
    end

    S1010: begin
        if(din==1)
        next_state = S101;
        else
        next_state = IDLE;
    end

    endcase
end

assign dout = (state==S1010)?1:0;



//-------ASSERTIONS

property P1;
@(posedge clock)
((state==IDLE) && din) |=>((state==S1) && (dout==0));
endproperty

ASSERT_1 : assert property(P1)
	   $display("_____________________________________ASSERTION_1 PASSED");

property P2;
@(posedge clock)
((state==IDLE) && ~(din)) |=>((state==IDLE) && (dout==0));
endproperty

ASSERT_2 : assert property(P2)
$display("ASSERTION_2 PASSED");


property P3;
@(posedge clock)
((state==S1) && ~(din)) |=>((state==S10) && (dout==0));
endproperty

ASSERT_3 : assert property(P3)
$display("ASSERTION_3 PASSED");


property P4;
@(posedge clock)
((state==S1) && din) |=>((state==S1) && (dout==0));
endproperty

ASSERT_4 : assert property(P4)
$display("ASSERTION_4 PASSED");


property P5;
@(posedge clock)
((state==S10) && din) |=>((state==S101) && (dout==0));
endproperty

ASSERT_5 : assert property(P5)
$display("ASSERTION_5 PASSED");


property P6;
@(posedge clock)
((state==S10) && ~(din)) |=>((state==IDLE) && (dout==0));
endproperty

ASSERT_6 : assert property(P6)
$display("ASSERTION_6 PASSED");


property P7;
@(posedge clock)
((state==S101) && ~(din)) |=>((state==S1010) && (dout==1));
endproperty

ASSERT_7 : assert property(P7)
$display("ASSERTION_7 PASSED");


property P8;
@(posedge clock)
((state==S101) && din) |=>((state==S1) && (dout==0));
endproperty

ASSERT_8 : assert property(P8)
$display("ASSERTION_8 PASSED");


property P9;
@(posedge clock)
((state==S1010) && ~(din)) |=>((state==IDLE) && (dout==0));
endproperty

ASSERT_9 : assert property(P9)
$display("ASSERTION_9 PASSED");


property P10;
@(posedge clock)
((state==S1010) && din) |=>((state==S101) && (dout==0));
endproperty

ASSERT_10 : assert property(P10)
$display("ASSERTION_10 PASSED");

endmodule
