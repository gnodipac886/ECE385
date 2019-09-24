module multiplier(input logic [7:0] mand, 
				  input logic Clk, Reset, Execute, ClearA_loadB,
				  output logic [6:0] AhexU, AhexL, BhexU, BhexL, 
				  output logic [7:0] Aval, Bval, 
				  output logic X);
	logic shoutA, shoutB, XtoA, addsub_en, subtraction_en, clear_load;
	logic shft_en;
	logic [8:0] sumA;
	logic [7:0] doutA, doutB;

	control ctr(
				.clearA_loadB(ClearA_loadB), 
				.reset(Reset), 
				.execute(Execute), 
				.clk(Clk), 
				.bout(shoutB),

				.Shift_en(shft_en), 
				.Sub_en(subtraction_en), 
				.clr_ld(clear_load),
				.addsub(addsub_en)
				);

	carry_select_addsub_9bit adder1(
									.sub_en(subtraction_en),
									.A({mand[7], mand}), 
								   	.B({doutA[7], doutA}), //the value in register A
								   	.Sum(sumA), 
								   	.CO()
								   	);

	flip_flop_mod X(
					.clk(Clk), 
					.din(sumA[8]),
					.load(addsub_en),
					.reset(clear_load | Reset),
					.dout(XtoA)
					);

	shift_reg_8bit regA(
						.clk(Clk), 
						.reset(clear_load | Reset), 
						.load(addsub_en), 
						.shift_en(shft_en), 
						.shift_in(XtoA), 
						.din(sumA[7:0]), 
						.shift_out(shoutA), 
						.dout(doutA[7:0])
						); 

	shift_reg_8bit regB(
						.clk(Clk), 
						.reset(Reset), 
						.load(clear_load), 
						.shift_en(shft_en), 
						.shift_in(shoutA), 
						.din(mand), 
						.shift_out(shoutB), 
						.dout(doutB)
						); 
endmodule