module testbench_lab6();

timeunit 10ns;

timeprecision 1ns;

logic Clk = 0;

logic [15:0] S;
logic Reset, Run, Continue;
logic [11:0] LED;
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
logic CE, UB, LB, OE, WE;
logic [19:0] ADDR;
wire [15:0] Data;

lab6_toplevel lab6_toplevel0(.*);

always begin : CLOCK_GENERATION

#1 Clk = ~Clk;
end

initial begin : CLOCK_INITIALIZATION

   Clk = 0;
	
	end
	
initial begin : TEST_VECTORS

     Reset_h = 1;

#2   Reset_h =0;

#2   Reset_h = 1;

#2   Run = 1;

#2   Run = 0;
#2   Run = 1;
 end
 
endmodule 


