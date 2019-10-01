module datapath (	
					input logic 		GateMARMUX, GateMDR, GateALU, GatePC,
					input logic 		LD_REG, LD_BEN, LD_CC, LD_IR, LD_MAR, LD_MDR, LD_PC, LD_LED,
					input logic 		MARMUX, SR1MUX, ADDR1MUX, SR2MUX, MIO_EN, 
					input logic  [1 :0]	PCMUX, DRMUX, ADDR2MUX, ALUK, 
					input logic  [15:0]	MDR_in,
					output logic [15:0]	MDR_out, MAR_out, IR_out,
					output logic 		BEN,
					output logic [11:0] LED,
				);

	logic 	[15:0] 	BUS,
					IR_out_wire,
					MDR_out_wire,
					MAR_out_wire, 
					PC_out_wire,
					marmux_out, 
					mdrmux_out,
					addr1mux_out, 
					pcmux_out, 
					addr2mux_out;

	mux_21_dynamic marmux(
						.sel(MARMUX), 
						.d0({{7{1'b0}}, IR_out_wire[7:0]}), 
						.d1(addr2mux_out + addr1mux_out), 
						.out(marmux_out)
						);

	mux_21_dynamic mdrmux(
						.sel(MIO_EN), 
						.d0(BUS), 
						.d1(), 
						.out(mdrmux_out)
						);

	mux_21_dynamic addr1mux(
							.sel(ADDR1MUX), 
							.d0(PC_out_wire), 
							.d1(), 
							.out(addr1mux_out)
							);

	mux_41_dynamic pcmux(
						.sel(PCMUX), 
						.d0(PC_out_wire + 1'b1), 
						.d1(BUS), 
						.d2(addr2mux_out + addr1mux_out), 
						.d3(), 
						.out(pcmux_out)
						);

	mux_41_dynamic addr2mux(
							.sel(ADDR2MUX), 
							.d0(16'h0000), 
							.d1({{10{IR_out_wire[5]}}, IR_out_wire[5:0]}), 
							.d2({{7{IR_out_wire[8]}}, IR_out_wire[8:0]}), 
							.d3({{5{IR_out_wire[10]}}, IR_out_wire[10:0]}), 
							.out(addr2mux_out)
							);

	/*
		0	: 	GateMARMUX
		1	: 	GatePC
		2	: 	GateALU
		3	: 	GateMDR
	*/
	tristate_mux41 tristategate(
								.sel({GateMDR, GateALU, GatePC, GateMARMUX}), 
								.d0(MAR_out_wire), 
								.d1(PC_out_wire), 
								.d2(), 
								.d3(MDR_out_wire), 
								.out(BUS)
								);

	reg_16  IR(
				.*, 
				.load(LD_IR), 
				.din(BUS), 
				.dout(IR_out_wire)
				);

	reg_16  MDR(
				.*, 
				.load(LD_MDR), 
				.din(mdrmux_out), 
				.dout(MDR_out_wire)
				);

	reg_16  MAR(
				.*, 
				.load(LD_MAR), 
				.din(BUS), 
				.dout(MAR_out_wire)
				);

	reg_16  PC(
				.*, 
				.load(LD_PC), 
				.din(pcmux_out), 
				.dout(PC_out_wire)
				);

endmodule 