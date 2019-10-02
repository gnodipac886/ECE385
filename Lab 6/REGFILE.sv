module REGFILE(
				input logic 	CLK, LDREG, Reset,
				input logic		[15:0] 	bus,
				input logic 	[2:0]	DR, SR1, SR2,
				output logic 	[15:0]	SR1_OUT, SR2_OUT
				);

	logic [7:0][15:0] outreg;
	logic ld_reg0, 

	always_ff @(posedge CLK) begin
		if(Reset) begin
			 outreg[0] 	<=	16'h0000;
			 outreg[1] 	<=	16'h0000;
			 outreg[2] 	<=	16'h0000;
			 outreg[3] 	<=	16'h0000;
			 outreg[4] 	<=	16'h0000;
			 outreg[5] 	<=	16'h0000;
			 outreg[6] 	<=	16'h0000;
			 outreg[7] 	<=	16'h0000;
		end
		else if(LDREG) begin
			case (DR)
				3'b000	:	outreg[0] <= bus;
				3'b001	:	outreg[1] <= bus;
				3'b010	:	outreg[2] <= bus;
				3'b011	:	outreg[3] <= bus;
				3'b100	:	outreg[4] <= bus;
				3'b101	:	outreg[5] <= bus;
				3'b110	:	outreg[6] <= bus;
				3'b111	:	outreg[7] <= bus;
			endcase
		end
	end

	always_comb begin
		case (SR1)
			3'b000	:	SR1_OUT = outreg[0];
			3'b001	:	SR1_OUT = outreg[1];
			3'b010	:	SR1_OUT = outreg[2];
			3'b011	:	SR1_OUT = outreg[3];
			3'b100	:	SR1_OUT = outreg[4];
			3'b101	:	SR1_OUT = outreg[5];
			3'b110	:	SR1_OUT = outreg[6];
			3'b111	:	SR1_OUT = outreg[7];
		endcase

		case (SR2)
			3'b000	:	SR2_OUT = outreg[0];
			3'b001	:	SR2_OUT = outreg[1];
			3'b010	:	SR2_OUT = outreg[2];
			3'b011	:	SR2_OUT = outreg[3];
			3'b100	:	SR2_OUT = outreg[4];
			3'b101	:	SR2_OUT = outreg[5];
			3'b110	:	SR2_OUT = outreg[6];
			3'b111	:	SR2_OUT = outreg[7];
		endcase
	end
endmodule