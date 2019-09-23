module multiplier(input logic [7:0] mand, 
				  input logic Clk, Reset, Execute, ClearA_loadB,
				  output logic [6:0] AhexU, AhexL, BhexU, BhexL, 
				  output logic [7:0] Aval, Bval, 
				  output logic X);
	logic shoutA;
	logic [8:0] doutA, sumA;
	logic [7:0] doutB;

	control ctr(.clearA_loadB(ClearA_loadB), 
				.reset(Reset), 
				.execute(Execute), 
				.clk(Clk), 
				.bout(), 
				.Shift_en(), 
				.Sub_en(), 
				.clr_ld()
				);

	carry_select_addsub_9bit adder1(.A({, mand}), 
								   .B(), //the value in register A
								   .Sum(.sumA), 
								   .CO());

	shift_reg_9bit regA(
						.clk(Clk), 
						.reset(resetA), 
						.load(loadA), 
						.shift_en(Shift_en), 
						.shift_in(), 
						.din(sumA), 
						.shift_out(shoutA), 
						.dout(doutA)
						); 
						//what do we do with this empty connection?

	shift_reg_8bit regB(
						.clk(Clk), 
						.reset(resetB), 
						.load(ClearA_loadB), 
						.shift_en(Shift_en), 
						.shift_in(shoutA), 
						.din(mand), 
						.shift_out(bout), 
						.dout(doutB)
						); //^^^^^^
endmodule