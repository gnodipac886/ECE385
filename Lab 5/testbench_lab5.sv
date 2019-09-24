module testbench_lab5();

timeunit 10ns;

timeprecision 1ns;

logic Clk = 0;

logic Reset, Execute, ClearA_loadB;

logic [7:0] mand;

logic [7:0] Aval, Bval;

logic X; //

logic [6:0] AhexU, AhexL, BhexU, BhexL;


logic [15:0] expec;  // expected value use to check

integer erroc = 0;

multiplier multiplier0(.*);

always begin : CLOCK_GENERATION

#1 Clk = ~Clk;
end

initial begin : CLOCK_INITIALIZATION

   Clk = 0;
	
	end
	
initial begin : TEST_VECTORS

     Reset = 0;

#2   Reset =1;

#2   mand = 8'h7;

#2   ClearA_loadB = 0;

#2   ClearA_loadB = 1;

#2   mand = 8'hFFC5;

#2   Execute = 0;

#2   Execute = 1;

#60  expec = (8'hFFC5 * 8'h7);
			if ({Aval, Bval} != expec)
					erroc++;
					
#2   Reset = 0;

#2   Reset = 1;

 end
 
endmodule 


