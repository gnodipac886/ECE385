module REGFILE(
				input logic		[15:0] 	bus,
				input logic 	[2:0]	DR, SR1, SR2,
				input logic 			LDREG,
				output logic 	[15:0]	SR1_OUT, SR2_OUT
				);
	reg_16bit reg0(
					.clk(),
					.reset(),
					.load(),
					.din(),
					.dout(),
					);
	
endmodule