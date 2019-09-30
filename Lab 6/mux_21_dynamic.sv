module mux_21_dynamic
	#(parameter width = 16)
				(
					input 	logic 	sel, 
			  		input	logic 	[width - 1 : 0] d0, d1,
			  		output 	logic 	[width - 1 : 0]	out
		  		);
	always_comb
	begin
		unique case (sel)
			1'b0 	:	out = d0;
			1'b1	:	out = d1;
		endcase
	end
endmodule 