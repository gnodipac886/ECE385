module testbench_lab5();

timeunit 10ns;

timeprecision 1ns;

logic Clk = 0;

logic Reset_h, Execute_h, ClearA_loadB_h;

logic [7:0] mand;

logic [7:0] Aval, Bval;

logic [6:0] AhexU, AhexL, BhexU, BhexL;

logic X;

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

     Reset_h = 1;

#2   Reset_h =0;

<<<<<<< HEAD
#2   Reset_h = 1;
=======
#2   Execute_h = 1;
>>>>>>> 7b6cac58010d7c905872f5d0dc6c14a1c4a809fe


<<<<<<< HEAD


=======
#2   ClearA_loadB_h = 0;

#2   ClearA_loadB_h = 1;
>>>>>>> 7b6cac58010d7c905872f5d0dc6c14a1c4a809fe

#2   mand = 8'hC5;

<<<<<<< HEAD
#10   ClearA_loadB_h = 1;

#2   ClearA_loadB_h = 0;
#2   ClearA_loadB_h = 1;

#10   mand = 8'h07;

#2   Execute_h = 1;

#2   Execute_h = 0;

#2   Execute_h = 1;
=======
#2   Execute_h = 0;

#2   Execute_h = 1;

//#10  Execute_h = 0;

//#50   Execute_h = 1;
>>>>>>> 7b6cac58010d7c905872f5d0dc6c14a1c4a809fe

#60  expec = (8'h07*8'hC5  );
			if ({Aval, Bval} != expec)
					erroc++;
					

					

 end
 
endmodule 


