module SEXT5(input 	logic 	[4:0] 	in, 
			 output logic 	[15:0]	out);

	always_comb begin
		out = {{10{in[4]}}, in};

endmodule 

module SEXT6(input 	logic 	[5:0] 	in, 
			 output logic 	[15:0]	out);

	always_comb begin
		out = {{9{in[4]}}, in};

endmodule 

module SEXT9(input 	logic 	[8:0] 	in, 
			 output logic 	[15:0]	out);

	always_comb begin
		out = {{6{in[4]}}, in};

endmodule 

module SEXT11(input logic 	[10:0] 	in, 
			 output logic 	[15:0]	out);

	always_comb begin
		out = {{4{in[4]}}, in};

endmodule 