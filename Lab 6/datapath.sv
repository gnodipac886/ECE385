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



endmodule 