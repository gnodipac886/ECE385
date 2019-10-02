module datapath (	
					input logic 		GateMARMUX, GateMDR, GateALU, GatePC, Clk, Reset,
					input logic 		LD_REG, LD_BEN, LD_CC, LD_IR, LD_MAR, LD_MDR, LD_PC, LD_LED,
					input logic 		ADDR1MUX, SR2MUX, MIO_EN, 
					input logic  [1 :0]	PCMUX, DRMUX, ADDR2MUX, SR1MUX, ALUK, 
					input logic  [15:0]	MDR_in,
					output logic [15:0]	MDR_out, MAR_out, IR_out, PC_out //,
//					output logic 		BEN,
//					output logic [11:0] LED
				);
				

	logic 	[15:0] 	BUS,
					SR1OUT,
					SR2OUT,
					IR_out_wire,
					MDR_out_wire,
					MAR_out_wire, 
					PC_out_wire, 
					mdrmux_out,
					sr2mux_out,
					addr1mux_out, 
					pcmux_out, 
					drmux_out,
					addr2mux_out,
					reg_file_sr1_in,
					ALU_out;



	mux_21_dynamic mdrmux(
						.sel(MIO_EN), 
						.d0(BUS), 
						.d1(MDR_in), 
						.out(mdrmux_out)
						);

	mux_21_dynamic addr1mux(
							.sel(ADDR1MUX), 
							.d0(PC_out_wire), 
							.d1(SR1OUT), 
							.out(addr1mux_out)
							);

	mux_21_dynamic sr2mux(
							.sel(IR_out_wire[5]), 
							.d0(SR2OUT), 
							.d1({{11{IR_out_wire[4]}}, IR_out_wire[4:0]}),//'
							.out(sr2mux_out)
							);//sel could be SR2MUX

	mux_41_dynamic sr1mux(
						.sel(SR1MUX), 
						.d0(IR_out_wire[11:9]), 
						.d1(IR_out_wire[8:6]), 
						.d2(3'b110), 
						.d3(), 
						.out(reg_file_sr1_in)
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

	mux_41_dynamic #(3) drmux(
						.sel(DRMUX), 
						.d0(IR_out_wire[11:9]), 
						.d1(3'b111), 
						.d2(3'b110), 
						.d3(), 
						.out(drmux_out)
						);

	/*
		0	: 	GateMARMUX
		1	: 	GatePC
		2	: 	GateALU
		3	: 	GateMDR
	*/
	tristate_mux41 tristategate(
								.sel({GateMDR, GateALU, GatePC, GateMARMUX}), 
								.d0(addr2mux_out + addr1mux_out), 
								.d1(PC_out_wire), 
								.d2(ALU_out), 
								.d3(MDR_out_wire), 
								.out(BUS)
								);

	REGFILE reg_file(
					.bus(BUS), 
					.DR(drmux_out),
					.SR1(reg_file_sr1_in),
					.SR2(IR_out_wire[2:0]),
					.LDREG(LD_REG),
					.SR1_OUT(SR1OUT),
					.SR2_OUT(SR2OUT)
					);

	reg_16bit  IR(
				.clk(Clk),
				.reset(Reset),	
				.load(LD_IR), 
				.din(BUS), 
				.dout(IR_out_wire)
				);

	reg_16bit  MDR(
				.clk(Clk),
				.reset(Reset), 
				.load(LD_MDR), 
				.din(mdrmux_out), 
				.dout(MDR_out_wire)
				);

	reg_16bit  MAR(
				.clk(Clk),
				.reset(Reset),	 
				.load(LD_MAR), 
				.din(BUS), 
				.dout(MAR_out_wire)
				);

	reg_16bit  PC(
				.clk(Clk),
				.reset(Reset),	 
				.load(LD_PC), 
				.din(pcmux_out), 
				.dout(PC_out_wire)
				);

	ALU myALU(
				.A(SR1OUT),
				.B(sr2mux_out),
				.aluk(ALUK),
				.ans(ALU_out)
			  );

	always_comb begin
		MDR_out = MDR_out_wire;
		MAR_out = MAR_out_wire;
		IR_out = IR_out_wire;
		PC_out = PC_out_wire;
	end 
endmodule 