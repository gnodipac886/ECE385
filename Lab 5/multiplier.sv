module multiplier();
	logic shoutA;
	logic [8:0] doutA, sumA;
	logic [7:0] doutB;

	control ctr(.clearA_loadB(), 
				.reset(), 
				.execute(), 
				.Clk(), 
				.bout(), 
				.mand(), 
				.Shift_en(), 
				.resetA(), 
				.resetB()
				.loadA(), 
				.loadB()
				);

	carry_select_adder_9bit adder1(.A(mand), 
								   .B(), 
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
						.load(loadB), 
						.shift_en(Shift_en), 
						.shift_in(shoutA), 
						.din(), 
						.shift_out(bout), 
						.dout(doutB)
						); //^^^^^^
endmodule