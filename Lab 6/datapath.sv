module datapath (	
					input logic 		GateMARMUX, GateMDR, GateALU, GatePC, GateALU,
					input logic 		LD_REG, LD_BEN, LD_CC, LD_IR, LD_MAR, LD_LDR, LD_PC, LD_LED,
					input logic 		MARMUX, SR1MUX, ADDR1MUX, SR2MUX, MIO_EN, 
					input logic  [1 :0]	PCMUX, DRMUX, ADDR2MUX, ALUK, 
					input logic  [15:0]	MDR_in,
					output logic [15:0]	MDR_out, MAR_out, IR_out,
					output logic 		BEN,
					output logic [11:0] LED,
				);

	//logic SR2;
	//logic [15:0] sext5out, sext6out, sext9out, sext11out;

	// SEXT5 ext5(.in(IR_out[4:0]), .out(sext5out));
	// SEXT5 ext6(.in(IR_out[5:0]), .out(sext6out));
	// SEXT5 ext9(.in(IR_out[8:0]), .out(sext9out));
	// SEXT5 ext11(.in(IR_out[10:0]), .out(sext11out));



	// always_comb begin
	// 	SR2 = IR_out[2:0];
	// end 

	mux_21_dynamic marmux(.sel(), .d0(), .d1(), .out());
	mux_21_dynamic addr1mux(.sel(), .d0(), .d1(), .out());
	mux_41_dynamic pcmux(.sel(), .d0(), .d1(), .d2(), .d3() .out());
	mux_41_dynamic addr2mux(.sel(), .d0(), .d1(), .d2(), .d3() .out());

	


endmodule 