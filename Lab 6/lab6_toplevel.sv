//-------------------------------------------------------------------------
//      lab6_toplevel.sv                                                 --
//                                                                       --
//      Created 10-19-2017 by Po-Han Huang                               --
//                        Spring 2018 Distribution                       --
//                                                                       --
//      For use with ECE 385 Experment 6                                 --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------
module lab6_toplevel( input logic [15:0] S,
                      input logic Clk, Reset, Run, Continue,
                      output logic [11:0] LED,
                      output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
                      output logic CE, UB, LB, OE, WE,
                      output logic [19:0] ADDR,
                      inout wire [15:0] Data);

slc3 my_slc(.*);
// Even though test memory is instantiated here, it will be synthesized into 
// a blank module, and will not interfere with the actual SRAM.
// Test memory is to play the role of physical SRAM in simulation.
datapath mydatapath(	
					.GateMARMUX(), .GateMDR(), .GateALU(), .GatePC(),
					.LD_REG(), .LD_BEN(), .LD_CC(), .LD_IR(), .LD_MAR(), .LD_MDR(), .LD_PC(), .LD_LED(),
					.MARMUX(), .ADDR1MUX(), .SR2MUX(), .MIO_EN(), 
					.PCMUX(), .DRMUX(), .ADDR2MUX(), .SR1MUX(), .ALUK(), 
					.MDR_in(),
					.MDR_out(), .MAR_out(), .IR_out() //,
//					output logic 		BEN,
//					output logic [11:0] LED
				);
test_memory my_test_memory(.Reset(~Reset), .I_O(Data), .A(ADDR), .*);

endmodule